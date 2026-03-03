report 51006 "Calculate Inventory_UPG" //790  id changed to 51006
{
    Caption = 'Calculate Inventory';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem8129; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Location Filter", "Bin Filter";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Location Code" = FIELD("Location Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");

                trigger OnAfterGetRecord()
                var
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempVariant: Boolean;
                begin
                    IF ColumnDim <> '' THEN
                        TransferDim("Dimension Set ID");
                    IF NOT "Drop Shipment" THEN BEGIN
                        GetLocation("Location Code");
                        ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                    END;
                    IF NOT SkipCycleSKU("Location Code", "Item No.", "Variant Code") THEN
                        IF ByBin THEN BEGIN
                            IF NOT TempLocation.GET("Location Code") THEN BEGIN
                                TempLocation := Location;
                                TempLocation.INSERT;
                                ExecuteLoop := TRUE;
                            END;
                            IF NOT TempItemVariant.GET("Item No.", "Variant Code") THEN BEGIN
                                InsertTempVariant := FALSE;
                                IF "Variant Code" = '' THEN
                                    InsertTempVariant := TRUE
                                ELSE
                                    IF ItemVariant.GET("Item No.", "Variant Code") THEN
                                        InsertTempVariant := TRUE;
                                IF InsertTempVariant THEN BEGIN
                                    TempItemVariant."Item No." := "Item No.";
                                    TempItemVariant.Code := "Variant Code";
                                    TempItemVariant.INSERT;
                                    ExecuteLoop := TRUE;
                                END;
                            END;
                            IF ExecuteLoop THEN BEGIN
                                WhseEntry.SETRANGE("Item No.", "Item No.");
                                WhseEntry.SETRANGE("Location Code", "Location Code");
                                WhseEntry.SETRANGE("Variant Code", "Variant Code");
                                IF WhseEntry.FIND('-') THEN
                                    IF WhseEntry."Entry No." <> OldWhseEntry."Entry No." THEN BEGIN
                                        OldWhseEntry := WhseEntry;
                                        REPEAT
                                            WhseEntry.SETRANGE("Bin Code", WhseEntry."Bin Code");
                                            IF NOT ItemBinLocationIsCalculated(WhseEntry."Bin Code") THEN BEGIN
                                                WhseEntry.CALCSUMS("Qty. (Base)");
                                                UpdateBuffer(WhseEntry."Bin Code", WhseEntry."Qty. (Base)");
                                            END;
                                            WhseEntry.FIND('+');
                                            Item.COPYFILTER("Bin Filter", WhseEntry."Bin Code");
                                        UNTIL WhseEntry.NEXT = 0;
                                    END;
                            END;
                        END ELSE
                            UpdateBuffer('', Quantity);
                end;

                trigger OnPostDataItem()
                begin
                    QuantityOnHandBuffer.RESET;
                    IF QuantityOnHandBuffer.FIND('-') THEN BEGIN
                        REPEAT
                            PosQty := 0;
                            NegQty := 0;

                            GetLocation(QuantityOnHandBuffer."Location Code");
                            IF Location."Directed Put-away and Pick" THEN
                                CalcWhseQty(Location."Adjustment Bin Code", PosQty, NegQty);

                            IF (NegQty - QuantityOnHandBuffer.Quantity <> QuantityOnHandBuffer.Quantity - PosQty) OR ItemTrackingSplit THEN BEGIN
                                IF PosQty = QuantityOnHandBuffer.Quantity THEN
                                    PosQty := 0;
                                IF (PosQty <> 0) OR AdjustPosQty THEN
                                    InsertItemJnlLine(
                                      QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                                      QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty);

                                IF NegQty = QuantityOnHandBuffer.Quantity THEN
                                    NegQty := 0;
                                IF NegQty <> 0 THEN BEGIN
                                    IF ((PosQty <> 0) OR AdjustPosQty) AND NOT ItemTrackingSplit THEN BEGIN
                                        NegQty := NegQty - QuantityOnHandBuffer.Quantity;
                                        QuantityOnHandBuffer.Quantity := 0;
                                        ZeroQty := TRUE;
                                    END;
                                    IF NegQty = -QuantityOnHandBuffer.Quantity THEN BEGIN
                                        NegQty := 0;
                                        AdjustPosQty := TRUE;
                                    END;
                                    InsertItemJnlLine(
                                      QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                                      QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, NegQty);

                                    ZeroQty := ZeroQtySave;
                                END;
                            END ELSE BEGIN
                                PosQty := 0;
                                NegQty := 0;
                            END;

                            IF (PosQty = 0) AND (NegQty = 0) AND NOT AdjustPosQty THEN
                                InsertItemJnlLine(
                                  QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                                  QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, QuantityOnHandBuffer.Quantity);
                        UNTIL QuantityOnHandBuffer.NEXT = 0;
                        QuantityOnHandBuffer.DELETEALL;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    WhseEntry.SETCURRENTKEY("Item No.", "Bin Code", "Location Code", "Variant Code");
                    Item.COPYFILTER("Bin Filter", WhseEntry."Bin Code");

                    QuantityOnHandBuffer.RESET;
                    QuantityOnHandBuffer.DELETEALL;

                    TempDimBufIn.SETRANGE("Table ID", DATABASE::"Item Ledger Entry");
                    TempDimBufIn.SETRANGE("Entry No.");
                    TempDimBufIn.DELETEALL;

                    DimBufMgt.DeleteAllDimensions;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT HideValidationDialog THEN
                    Window.UPDATE;
                TempLocation.DELETEALL;
                TempItemVariant.DELETEALL;
            end;

            trigger OnPreDataItem()
            var
                ItemJnlTemplate: Record "Item Journal Template";
                ItemJnlBatch: Record "Item Journal Batch";
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text000);

                ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
                IF NextDocNo = '' THEN BEGIN
                    IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                        IF NOT ItemJnlLine.FINDFIRST THEN
                            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, FALSE);
                        ItemJnlLine.INIT;
                    END;
                    IF NextDocNo = '' THEN
                        ERROR(Text001);
                END;

                NextLineNo := 0;

                IF NOT HideValidationDialog THEN
                    Window.OPEN(Text002, "No.");

                IF NOT SkipDim THEN
                    SelectedDim.GetSelectedDim(USERID, 3, REPORT::"Calculate Inventory", '', TempSelectedDim);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate;
                        end;
                    }
                    field(DocumentNo; NextDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                    }
                    field(ItemsNotOnInventory; ZeroQty)
                    {
                        ApplicationArea = All;
                        Caption = 'Items Not on Inventory';
                    }
                    field(ByDimensions; ColumnDim)
                    {
                        ApplicationArea = All;
                        Caption = 'By Dimensions';
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Calculate Inventory", ColumnDim);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PostingDate = 0D THEN
                PostingDate := WORKDATE;
            ValidatePostingDate;
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF SkipDim THEN
            ColumnDim := ''
        ELSE
            DimSelectionBuf.CompareDimText(3, REPORT::"Calculate Inventory", '', ColumnDim, Text003);
        ZeroQtySave := ZeroQty;
    end;

    var
        Text000: Label 'Please enter the posting date.';
        Text001: Label 'Please enter the document no.';
        Text002: Label 'Processing items    #1##########';
        Text003: Label 'Retain Dimensions';
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        WhseEntry: Record "Warehouse Entry";
        QuantityOnHandBuffer: Record "Inventory Buffer" temporary;
        SourceCodeSetup: Record "Source Code Setup";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SelectedDim: Record "Selected Dimension";
        TempSelectedDim: Record "Selected Dimension" temporary;
        TempDimBufIn: Record "Dimension Buffer" temporary;
        TempDimBufOut: Record "Dimension Buffer" temporary;
        DimSelectionBuf: Record "Dimension Selection Buffer";
        Location: Record "Location";
        NoSeriesMgt: Codeunit "No. Series";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        Window: Dialog;
        PostingDate: Date;
        CycleSourceType: Option " ",Item,SKU;
        PhysInvtCountCode: Code[10];
        NextDocNo: Code[20];
        NextLineNo: Integer;
        ZeroQty: Boolean;
        ZeroQtySave: Boolean;
        HideValidationDialog: Boolean;
        AdjustPosQty: Boolean;
        ItemTrackingSplit: Boolean;
        SkipDim: Boolean;
        ColumnDim: Text[250];
        PosQty: Decimal;
        NegQty: Decimal;
        Text004: Label 'You must not filter on dimensions if you calculate locations with %1 is %2.';
        OldWhseEntry: Record "Warehouse Entry";
        TempLocation: Record Location temporary;
        TempItemVariant: Record "Item Variant" temporary;
        Item: RECORD Item;


    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        IF ItemJnlBatch."No. Series" = '' THEN
            NextDocNo := ''
        ELSE BEGIN
            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, FALSE);
            CLEAR(NoSeriesMgt);
        END;
    end;


    procedure InsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        Bin: Record Bin;
        DimValue: Record "Dimension Value";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        DimMgt: Codeunit DimensionManagement;
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
        NoBinExist: Boolean;
        OrderLineNo: Integer;
        ForSubtype: Integer;
        ForID: Code[20];
    begin
        IF NextLineNo = 0 THEN BEGIN
            ItemJnlLine.LOCKTABLE;
            ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            IF ItemJnlLine.FINDLAST THEN
                NextLineNo := ItemJnlLine."Line No.";

            SourceCodeSetup.GET;
        END;
        NextLineNo := NextLineNo + 10000;

        IF (Quantity2 <> 0) OR ZeroQty THEN BEGIN
            IF (Quantity2 = 0) AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick"
            THEN
                IF NOT Bin.GET(Location.Code, BinCode2) THEN
                    NoBinExist := TRUE;

            ItemJnlLine.INIT;
            ItemJnlLine."Line No." := NextLineNo;
            ItemJnlLine.VALIDATE("Posting Date", PostingDate);
            IF PhysInvQuantity >= Quantity2 THEN
                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.")
            ELSE
                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
            ItemJnlLine.VALIDATE("Document No.", NextDocNo);
            ItemJnlLine.VALIDATE("Item No.", ItemNo);
            ItemJnlLine.VALIDATE("Variant Code", VariantCode2);
            ItemJnlLine.VALIDATE("Location Code", Location.Code);
            IF NOT NoBinExist THEN
                ItemJnlLine.VALIDATE("Bin Code", BinCode2)
            ELSE
                ItemJnlLine.VALIDATE("Bin Code", '');
            ItemJnlLine.VALIDATE("Source Code", SourceCodeSetup."Phys. Inventory Journal");
            ItemJnlLine."Qty. (Phys. Inventory)" := PhysInvQuantity;
            ItemJnlLine."Phys. Inventory" := TRUE;
            ItemJnlLine.VALIDATE("Qty. (Calculated)", Quantity2);
            ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
            ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";

            ItemJnlLine."Phys Invt Counting Period Code" := PhysInvtCountCode;
            ItemJnlLine."Phys Invt Counting Period Type" := CycleSourceType;

            ItemJnlLine."Shortcut Dimension 1 Code" := '';
            ItemJnlLine."Shortcut Dimension 2 Code" := '';

            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Item No.");
            ItemLedgEntry.SETRANGE("Item No.", ItemNo);
            IF ItemLedgEntry.FINDLAST THEN
                ItemJnlLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
            ELSE
                ItemJnlLine."Last Item Ledger Entry No." := 0;

            ItemJnlLine.INSERT(TRUE);

            IF Location.Code <> '' THEN
                IF Location."Directed Put-away and Pick" THEN BEGIN
                    WhseEntry.SETCURRENTKEY(
                      "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                      "Lot No.", "Serial No.", "Entry Type");
                    WhseEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
                    WhseEntry.SETRANGE("Bin Code", Location."Adjustment Bin Code");
                    WhseEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
                    WhseEntry.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
                    IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt." THEN
                        EntryType := EntryType::"Negative Adjmt.";
                    IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." THEN
                        EntryType := EntryType::"Positive Adjmt.";
                    WhseEntry.SETRANGE("Entry Type", EntryType);
                    IF WhseEntry.FIND('-') THEN
                        REPEAT
                            WhseEntry.SETRANGE("Lot No.", WhseEntry."Lot No.");
                            WhseEntry.SETRANGE("Serial No.", WhseEntry."Serial No.");
                            WhseEntry.CALCSUMS("Qty. (Base)");

                            WhseEntry2.SETCURRENTKEY(
                              "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                              "Lot No.", "Serial No.", "Entry Type");
                            WhseEntry2.COPYFILTERS(WhseEntry);
                            CASE EntryType OF
                                EntryType::"Positive Adjmt.":
                                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                                EntryType::"Negative Adjmt.":
                                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Positive Adjmt.");
                            END;
                            WhseEntry2.CALCSUMS("Qty. (Base)");
                            IF ABS(WhseEntry2."Qty. (Base)") > ABS(WhseEntry."Qty. (Base)") THEN
                                WhseEntry."Qty. (Base)" := 0
                            ELSE
                                WhseEntry."Qty. (Base)" := WhseEntry."Qty. (Base)" + WhseEntry2."Qty. (Base)";

                            IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                                IF ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production THEN
                                    OrderLineNo := ItemJnlLine."Order Line No.";
                                // CreateReservEntry.CreateReservEntryFor(
                                //   DATABASE::"Item Journal Line",
                                //   "Entry Type",
                                //   "Journal Template Name",
                                //   "Journal Batch Name",
                                //   OrderLineNo,
                                //   "Line No.",
                                //   "Qty. per Unit of Measure",
                                //   ABS(WhseEntry.Quantity),
                                //   ABS(WhseEntry."Qty. (Base)"),
                                //   WhseEntry."Serial No.",
                                //   WhseEntry."Lot No.");//B2BUPG
                                CreateReservEntry.CreateReservEntryFor(
                                          ItemJnlLine."Entry Type".AsInteger(),
                                          ForSubtype,
                                          ForID,
                                          ItemJnlLine."Journal Batch Name",
                                          OrderLineNo,
                                          ItemJnlLine."Line No.",
                                          ItemJnlLine."Qty. per Unit of Measure",
                                          ABS(WhseEntry.Quantity),
                                           ABS(WhseEntry."Qty. (Base)"),
                                          ReservEntry);
                                IF WhseEntry."Qty. (Base)" < 0 THEN             // only Date on positive adjustments
                                    CreateReservEntry.SetDates(WhseEntry."Warranty Date", WhseEntry."Expiration Date");
                                CreateReservEntry.CreateEntry(
                                  ItemJnlLine."Item No.",
                                  ItemJnlLine."Variant Code",
                                  ItemJnlLine."Location Code",
                                  ItemJnlLine.Description,
                                  0D,
                                  0D,
                                  0,
                                  ReservEntry."Reservation Status"::Prospect);
                            END;
                            WhseEntry.FIND('+');
                            WhseEntry.SETRANGE("Lot No.");
                            WhseEntry.SETRANGE("Serial No.");
                        UNTIL WhseEntry.NEXT = 0;
                END;

            IF DimBufMgt.GetDimensions(DimEntryNo2, TempDimBufOut) THEN BEGIN
                TempDimSetEntry.RESET;
                TempDimSetEntry.DELETEALL;
                IF TempDimBufOut.FIND('-') THEN BEGIN
                    REPEAT
                        DimValue.GET(TempDimBufOut."Dimension Code", TempDimBufOut."Dimension Value Code");
                        TempDimSetEntry."Dimension Code" := TempDimBufOut."Dimension Code";
                        TempDimSetEntry."Dimension Value Code" := TempDimBufOut."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        IF TempDimSetEntry.INSERT THEN;
                        ItemJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        DimMgt.UpdateGlobalDimFromDimSetID(ItemJnlLine."Dimension Set ID",
                          ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
                        ItemJnlLine.MODIFY;
                    UNTIL TempDimBufOut.NEXT = 0;
                    TempDimBufOut.DELETEALL;
                END;
            END;
        END;
    end;


    procedure InitializeRequest(NewPostingDate: Date; DocNo: Code[20]; ItemsNotOnInvt: Boolean)
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
        ZeroQty := ItemsNotOnInvt;
        IF NOT SkipDim THEN
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
    end;


    procedure TransferDim(DimSetID: Integer)
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimSetEntry.FIND('-') THEN BEGIN
            REPEAT
                IF TempSelectedDim.GET(
                     USERID, 3, REPORT::"Calculate Inventory", '', DimSetEntry."Dimension Code")
                THEN BEGIN
                    TempDimBufIn.INIT;
                    TempDimBufIn."Table ID" := DATABASE::"Item Ledger Entry";
                    TempDimBufIn."Entry No." := DimSetID;
                    TempDimBufIn."Dimension Code" := DimSetEntry."Dimension Code";
                    TempDimBufIn."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                    IF TempDimBufIn.INSERT THEN;
                END;
            UNTIL DimSetEntry.NEXT = 0;
        END;
    end;

    local procedure CalcWhseQty(AdjmtBin: Code[20]; var PosQuantity: Decimal; var NegQuantity: Decimal)
    var
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseQuantity: Decimal;
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
        NoWhseEntry: Boolean;
        NoWhseEntry2: Boolean;
    begin
        AdjustPosQty := FALSE;
        // ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.",WhseSNRequired,WhseLNRequired,FALSE);//B2BUPG
        ItemTrackingMgt.CheckWhseItemTrkgSetup(QuantityOnHandBuffer."Item No.");
        ItemTrackingSplit := WhseSNRequired OR WhseLNRequired;
        WhseEntry.SETCURRENTKEY(
          "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
          "Lot No.", "Serial No.", "Entry Type");

        WhseEntry.SETRANGE("Item No.", QuantityOnHandBuffer."Item No.");
        WhseEntry.SETRANGE("Location Code", QuantityOnHandBuffer."Location Code");
        WhseEntry.SETRANGE("Variant Code", QuantityOnHandBuffer."Variant Code");
        WhseEntry.CALCSUMS("Qty. (Base)");
        WhseQuantity := WhseEntry."Qty. (Base)";
        WhseEntry.SETRANGE("Bin Code", AdjmtBin);

        IF WhseSNRequired THEN BEGIN
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            WhseEntry.CALCSUMS("Qty. (Base)");
            PosQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Negative Adjmt.");
            WhseEntry.CALCSUMS("Qty. (Base)");
            NegQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::Movement);
            WhseEntry.CALCSUMS("Qty. (Base)");
            IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                IF WhseEntry."Qty. (Base)" > 0 THEN
                    PosQuantity := PosQuantity + WhseQuantity - WhseEntry."Qty. (Base)"
                ELSE
                    NegQuantity := NegQuantity - WhseQuantity - WhseEntry."Qty. (Base)";
            END;

            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            IF WhseEntry.FIND('-') THEN BEGIN
                REPEAT
                    WhseEntry.SETRANGE("Serial No.", WhseEntry."Serial No.");

                    WhseEntry2.RESET;
                    WhseEntry2.SETCURRENTKEY(
                      "Item No.", "Bin Code", "Location Code", "Variant Code",
                      "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");

                    WhseEntry2.COPYFILTERS(WhseEntry);
                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                    WhseEntry2.SETRANGE("Serial No.", WhseEntry."Serial No.");
                    IF WhseEntry2.FIND('-') THEN
                        REPEAT
                            PosQuantity := PosQuantity + 1;
                            NegQuantity := NegQuantity - 1;
                            NoWhseEntry := WhseEntry.NEXT = 0;
                            NoWhseEntry2 := WhseEntry2.NEXT = 0;
                        UNTIL NoWhseEntry2 OR NoWhseEntry
                    ELSE
                        AdjustPosQty := TRUE;

                    IF NOT NoWhseEntry AND NoWhseEntry2 THEN
                        AdjustPosQty := TRUE;

                    WhseEntry.FIND('+');
                    WhseEntry.SETRANGE("Serial No.");
                UNTIL WhseEntry.NEXT = 0;
            END;
        END ELSE BEGIN
            IF WhseEntry.FIND('-') THEN
                REPEAT
                    WhseEntry.SETRANGE("Lot No.", WhseEntry."Lot No.");
                    WhseEntry.CALCSUMS("Qty. (Base)");
                    IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                        IF WhseEntry."Qty. (Base)" > 0 THEN
                            NegQuantity := NegQuantity - WhseEntry."Qty. (Base)"
                        ELSE
                            PosQuantity := PosQuantity + WhseEntry."Qty. (Base)";
                    END;
                    WhseEntry.FIND('+');
                    WhseEntry.SETRANGE("Lot No.");
                UNTIL WhseEntry.NEXT = 0;
            IF PosQuantity <> WhseQuantity THEN
                PosQuantity := WhseQuantity - PosQuantity;
            IF NegQuantity <> -WhseQuantity THEN
                NegQuantity := WhseQuantity + NegQuantity;
        END;
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    procedure InitializePhysInvtCount(PhysInvtCountCode2: Code[10]; CountSourceType2: Option " ",Item,SKU)
    begin
        PhysInvtCountCode := PhysInvtCountCode2;
        CycleSourceType := CountSourceType2;
    end;

    local procedure SkipCycleSKU(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]): Boolean
    var
        SKU: Record "Stockkeeping Unit";
    begin
        IF CycleSourceType = CycleSourceType::Item THEN
            IF SKU.READPERMISSION THEN
                IF SKU.GET(LocationCode, ItemNo, VariantCode) THEN
                    EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure GetLocation(LocationCode: Code[10])


    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                IF Location.GET(LocationCode) THEN
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
                        IF (Item.GETFILTER("Global Dimension 1 Code") <> '') OR
                           (Item.GETFILTER("Global Dimension 2 Code") <> '') OR
                           TempDimBufIn.FINDFIRST
                        THEN
                            ERROR(Text004, Location.FIELDCAPTION("Bin Mandatory"), Location."Bin Mandatory");
                    END;
    end;

    local procedure UpdateBuffer(BinCode: Code[20]; NewQuantity: Decimal)
    var
        DimEntryNo: Integer;
    begin
        IF NOT HasNewQuantity(NewQuantity) THEN
            EXIT;
        IF BinCode = '' THEN BEGIN
            TempDimBufIn.SETRANGE("Entry No.", "Item Ledger Entry"."Dimension Set ID");
            DimEntryNo := DimBufMgt.FindDimensions(TempDimBufIn);
            IF DimEntryNo = 0 THEN
                DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
        END;
        IF RetrieveBuffer(BinCode, DimEntryNo) THEN BEGIN
            QuantityOnHandBuffer.Quantity := QuantityOnHandBuffer.Quantity + NewQuantity;
            QuantityOnHandBuffer.MODIFY;
        END ELSE BEGIN
            QuantityOnHandBuffer.Quantity := NewQuantity;
            QuantityOnHandBuffer.INSERT;
        END;
    end;


    procedure RetrieveBuffer(BinCode: Code[20]; DimEntryNo: Integer): Boolean
    begin
        QuantityOnHandBuffer.RESET;
        QuantityOnHandBuffer."Item No." := "Item Ledger Entry"."Item No.";
        QuantityOnHandBuffer."Variant Code" := "Item Ledger Entry"."Variant Code";
        QuantityOnHandBuffer."Location Code" := "Item Ledger Entry"."Location Code";
        QuantityOnHandBuffer."Dimension Entry No." := DimEntryNo;
        QuantityOnHandBuffer."Bin Code" := BinCode;
        EXIT(QuantityOnHandBuffer.FIND);
    end;


    procedure HasNewQuantity(NewQuantity: Decimal): Boolean
    begin
        EXIT((NewQuantity <> 0) OR ZeroQty);
    end;


    procedure ItemBinLocationIsCalculated(BinCode: Code[20]): Boolean
    begin
        QuantityOnHandBuffer.RESET;
        QuantityOnHandBuffer.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
        QuantityOnHandBuffer.SETRANGE("Variant Code", "Item Ledger Entry"."Variant Code");
        QuantityOnHandBuffer.SETRANGE("Location Code", "Item Ledger Entry"."Location Code");
        QuantityOnHandBuffer.SETRANGE("Bin Code", BinCode);
        EXIT(QuantityOnHandBuffer.FIND('-'));
    end;


    procedure SetSkipDim(NewSkipDim: Boolean)
    begin
        SkipDim := NewSkipDim;
    end;
}

