report 50008 "Calculate Inventory - LW"
{
    // //FP  New globals, New local function, New fields on Request Panel
    //       Additional code below
    // //FP6   Added code on Item Ledger to Calcfields for unit cost calcualtion
    // //FP6.2 Added Location Code for first run to enter opening inventory
    //         Added code below
    //         Added Bin Code for first run to enter opening inventory
    //         Added Code below
    // //FP6.2.03 Added code to break out physical inventory by lot or serial number
    // //FP6.2.06  Added a Validate on Qty. (Phys. Inventory) when it is zeroed out
    // 
    // //FP7.1.14  Added code to set the Location filter on Item OnAfterGetRec
    // LW1.02,02/07/18,SK: Added code in InsertItemJnlLine to update "Qty. On Pick" based on Bin Contents.

    Caption = 'Calculate Inventory';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Location Filter", "Bin Filter", "Date Filter";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");

                trigger OnAfterGetRecord()
                var
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempSKU: Boolean;
                begin
                    // MESSAGE("Item Ledger Entry"."Lot No.");//WLB - At this point, we have the correct Lot Numbers.
                    IF ColumnDim <> '' THEN
                        TransferDim("Dimension Set ID");
                    IF NOT "Drop Shipment" THEN BEGIN
                        GetLocation("Location Code");
                        ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                    END;
                    IF NOT SkipCycleSKU("Location Code", "Item No.", "Variant Code") THEN
                        IF ByBin THEN BEGIN
                            IF NOT TempSKU.GET("Location Code", "Item No.", "Variant Code") THEN BEGIN
                                InsertTempSKU := FALSE;
                                IF "Variant Code" = '' THEN
                                    InsertTempSKU := TRUE
                                ELSE
                                    IF ItemVariant.GET("Item No.", "Variant Code") THEN
                                        InsertTempSKU := TRUE;
                                IF InsertTempSKU THEN BEGIN
                                    TempSKU."Item No." := "Item No.";
                                    TempSKU."Variant Code" := "Variant Code";
                                    TempSKU."Location Code" := "Location Code";
                                    TempSKU.INSERT;
                                    ExecuteLoop := TRUE;
                                END;
                            END;
                            //    IF (ExecuteLoop) THEN BEGIN WLB
                            IF (ExecuteLoop) OR (LastLot <> "Item Ledger Entry"."Lot No.") THEN BEGIN
                                //      MESSAGE('Execute Loop ' + "Item Ledger Entry"."Lot No."); //WLB
                                LastLot := "Item Ledger Entry"."Lot No."; //WLB
                                WhseEntry.SETRANGE("Item No.", "Item No.");
                                WhseEntry.SETRANGE("Location Code", "Location Code");
                                WhseEntry.SETRANGE("Variant Code", "Variant Code");
                                WhseEntry.SETRANGE("Lot No.", "Lot No."); // WLB - Group by Lot.
                                IF WhseEntry.FIND('-') THEN
                                    //        MESSAGE('WhseEntry.Find ' + WhseEntry."Lot No."); // WLB
                                    IF WhseEntry."Entry No." <> OldWhseEntry."Entry No." THEN BEGIN
                                        OldWhseEntry := WhseEntry;
                                        REPEAT
                                            WhseEntry.SETRANGE("Bin Code", WhseEntry."Bin Code");
                                            //WhseEntry.SETRANGE("Lot No.", WhseEntry."Lot No."); //WLB - Group by Lot.
                                            //MESSAGE(WhseEntry."Lot No."); //WLB
                                            //IF NOT ItemBinLocationIsCalculated(WhseEntry."Bin Code") THEN BEGIN --WLB
                                            IF NOT ItemLotBinLocationIsCalculated("Item Ledger Entry"."Lot No.", WhseEntry."Bin Code") THEN BEGIN
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

                    //FP begin (make like Inventory Valuation report
                    AdjustItemLedgEntryToAsOfDate("Item Ledger Entry");

                    RemainingQty := RemainingQty + "Remaining Quantity";
                    //FP6
                    CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
                    IF "Cost Amount (Actual)" <> 0 THEN
                        InventoryValue += "Cost Amount (Actual)"
                    ELSE
                        InventoryValue += "Cost Amount (Expected)";
                    //FP end
                end;

                trigger OnPostDataItem()
                begin
                    //FP begin
                    IF RemainingQty <> 0 THEN
                        UnitCost := InventoryValue / RemainingQty;
                    //FP end
                end;

                trigger OnPreDataItem()
                begin
                    WhseEntry.SETCURRENTKEY("Item No.", "Bin Code", "Location Code", "Variant Code");
                    Item.COPYFILTER("Bin Filter", WhseEntry."Bin Code");

                    TempDimBufIn.SETRANGE("Table ID", DATABASE::"Item Ledger Entry");
                    TempDimBufIn.SETRANGE("Entry No.");
                    TempDimBufIn.DELETEALL;

                    DimBufMgt.DeleteAllDimensions;
                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter");

                trigger OnAfterGetRecord()
                begin
                    IF NOT "Item Ledger Entry".ISEMPTY THEN
                        CurrReport.SKIP;   // Skip if item has any record in Item Ledger Entry.
                    CLEAR(QuantityOnHandBuffer);
                    QuantityOnHandBuffer."Item No." := "Item No.";
                    QuantityOnHandBuffer."Location Code" := "Location Code";
                    QuantityOnHandBuffer."Variant Code" := "Variant Code";

                    GetLocation("Location Code");
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                        QuantityOnHandBuffer."Bin Code" := "Bin Code";
                    IF NOT QuantityOnHandBuffer.FIND THEN
                        QuantityOnHandBuffer.INSERT;   // Insert a zero quantity line.
                end;
            }

            trigger OnAfterGetRecord()
            var
                "-FP-": Integer;
                tmpItemLdgrEntry: Record "Item Ledger Entry";
                dummyCode: Code[20];
                dummyint: Integer;
                dummyDec: Decimal;
            begin
                IF NOT HideValidationDialog THEN
                    Window.UPDATE;
                TempSKU.DELETEALL;

                //FP begin
                // IF IncludeBlockedItems THEN
                //     IF Item.Blocked THEN BEGIN
                //         Item."Temp Blocked" := TRUE;
                //         Item.Blocked := FALSE;
                //         Item.MODIFY;
                //     END;//B2BUPG
                //FP end

                //FP To incude all items in listing even there is no ledger entries
                IF IncludeAllItems THEN BEGIN
                    dummyCode := '';
                    dummyint := 0;
                    dummyDec := 0;
                    tmpItemLdgrEntry.RESET;
                    tmpItemLdgrEntry.SETRANGE(tmpItemLdgrEntry."Item No.", "No.");
                    //FP7.1.14 start
                    tmpItemLdgrEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    //FP7.1.14 stop
                    IF NOT tmpItemLdgrEntry.FINDFIRST THEN
                        //SF6.2.03 -- Delete
                        //InsertItemJnlLine("No.",dummyCode,dummyint,dummyCode,dummyDec,0);
                        //SF6.2.03 -- End Delete

                        //SF6.2.03 -- Insert
                        InsertItemJnlLine("No.", dummyCode, dummyint, dummyCode, dummyDec, 0, dummyCode, dummyCode);
                    //SF6.2.03 -- End Insert

                END;
                //FP End of change
                //WLB
                LastBin := 'dummy';
                LastLot := 'dummy';
                //WLB
            end;

            // trigger OnPostDataItem()
            // begin
            //     //FP begin
            //     IF IncludeBlockedItems THEN
            //         IF ItemT.FINDSET THEN BEGIN
            //             REPEAT
            //                 IF ItemT."Temp Blocked" THEN BEGIN
            //                     ItemT.Blocked := TRUE;
            //                     ItemT."Temp Blocked" := FALSE;
            //                     ItemT.MODIFY;
            //                 END;
            //             UNTIL ItemT.NEXT = 0;
            //         END;
            //     //FP end
            //     CalcPhysInvQtyAndInsertItemJnlLine;
            // end;//B2BUPG

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

                QuantityOnHandBuffer.RESET;
                QuantityOnHandBuffer.DELETEALL;
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
                        ApplicationArea = all;
                        Caption = 'Posting Date';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate;
                        end;
                    }
                    field(DocumentNo; NextDocNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Document No.';
                    }
                    field(ItemsNotOnInventory; ZeroQty)
                    {
                        ApplicationArea = all;
                        Caption = 'Items Not on Inventory';
                    }
                    field(ByDimensions; ColumnDim)
                    {
                        ApplicationArea = all;
                        Caption = 'By Dimensions';
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Calculate Inventory", ColumnDim);
                        end;
                    }
                    field(IncludeAllItems; IncludeAllItems)
                    {
                        ApplicationArea = all;
                        Caption = 'Include Item without Ledger';
                    }
                    field(ZeroPhysQty; ZeroPhysQty)
                    {
                        ApplicationArea = all;
                        Caption = 'Zero Out Phys. Qty Column';
                    }
                    field(DisregardIndirect; DisregardIndirect)
                    {
                        ApplicationArea = all;
                        Caption = 'Disregard Indirect %';
                    }
                    field(BreakOutByLotNo; BreakOutByLotNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Break out by Lot No.';
                    }
                    field(BreakOutBySerialNo; BreakOutBySerialNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Break out by Serial No.';
                    }
                    field(GenBusCode; GenBusCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Gen. Bus. Posting Group';
                    }
                    field(LocCode; LocCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Opening Inv. Location Code';
                        LookupPageID = "Location List";
                        TableRelation = Location;
                    }
                    field(BinCode; BinCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Opening Inv. Bin Code';
                        LookupPageID = "Bin List";
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

    trigger OnPostReport()
    begin
        binrec.RESET;
        IF Item.GETFILTER("Location Filter") <> '' THEN
            binrec.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));

        IF Item.GETFILTER("Bin Filter") <> '' THEN
            binrec.SETFILTER(Code, Item.GETFILTER("Bin Filter"));

        IF binrec.FINDSET THEN BEGIN
            REPEAT
                ItemJnlLine.RESET;
                ItemJnlLine.SETCURRENTKEY("Bin Code");
                ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");

                ItemJnlLine.SETRANGE("Bin Code", binrec.Code);
                //ItemJnlLine.SETRANGE("Lot No.", ItemJnlLine."Lot No."); //WLB
                IF NOT ItemJnlLine.FINDSET THEN BEGIN
                    ZeroQty := TRUE;
                    Location.GET(binrec."Location Code");
                    //WLB Original Line.
                    InsertItemJnlLine(ItemJnlLine."Item No.", ItemJnlLine."Item No.", ItemJnlLine."Dimension Set ID", binrec.Code, ItemJnlLine.Quantity, 0, '', '');
                    //WLB New Line.
                    //InsertItemJnlLine(ItemJnlLine."Item No.",ItemJnlLine."Item No.",ItemJnlLine."Dimension Set ID",binrec.Code,ItemJnlLine.Quantity,0,ItemJnlLine."Lot No.",''); //WLB
                    //InsertItemJnlLine(ItemJnlLine."Item No.",ItemJnlLine."Item No.",0,binrec.code,0,0,dummyCode,dummyCode);

                END;
            UNTIL binrec.NEXT = 0;
        END;
    end;

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
        binrec: Record Bin;
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
        Location: Record Location;
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
        TempSKU: Record "Stockkeeping Unit" temporary;
        "--FP--": Integer;
        IncludeAllItems: Boolean;
        i: Integer;
        ItemT: Record Item;
        ZeroPhysQty: Boolean;
        DisregardIndirect: Boolean;
        InventoryValue: Decimal;
        RemainingQty: Decimal;
        UnitCost: Decimal;
        AsOfDate: Date;
        Currency: Record Currency;
        GenBusCode: Code[10];
        IncludeBlockedItems: Boolean;
        LocCode: Code[10];
        BinCode: Code[20];
        BreakOutByLotNo: Boolean;
        BreakOutBySerialNo: Boolean;
        "-LW1.01-": Integer;
        ILERecGbl: Record "Item Ledger Entry";
        LastBin: Code[20];
        LastLot: Code[20];
        "-LW1.02-": Integer;
        BinContentRecGbl: Record "Bin Content";
        PickQtyOfBinCont: Decimal;


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


    procedure InsertItemJnlLine(var ItemNo: Code[20]; var VariantCode2: Code[10]; var DimEntryNo2: Integer; var BinCode2: Code[20]; var Quantity2: Decimal; PhysInvQuantity: Decimal; LotNo2: Code[20]; SerialNo2: Code[20])
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
        //FP6.2.03 -- Added two parameters LotNo2 and SerialNo2
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
            IF ItemJnlLine."Item No." <> '' THEN BEGIN
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
                //FP begin
                IF DisregardIndirect THEN
                    ItemJnlLine."Indirect Cost %" := 0;

                IF ZeroPhysQty THEN
                    //FP6.2.06
                    //"Qty. (Phys. Inventory)" := 0;
                    ItemJnlLine.VALIDATE("Qty. (Phys. Inventory)", 0);
                //FP end;


            END ELSE BEGIN
                ItemJnlLine."Location Code" := Location.Code;
                ItemJnlLine."Bin Code" := BinCode2;
            END;



            ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
            ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";

            ItemJnlLine."Phys Invt Counting Period Code" := PhysInvtCountCode;
            ItemJnlLine."Phys Invt Counting Period Type" := CycleSourceType;

            IF Location."Bin Mandatory" THEN
                ItemJnlLine."Dimension Set ID" := 0;
            ItemJnlLine."Shortcut Dimension 1 Code" := '';
            ItemJnlLine."Shortcut Dimension 2 Code" := '';

            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Item No.");
            ItemLedgEntry.SETRANGE("Item No.", ItemNo);
            IF ItemLedgEntry.FINDLAST THEN
                ItemJnlLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
            ELSE
                ItemJnlLine."Last Item Ledger Entry No." := 0;

            //FP  begin
            ItemJnlLine."Gen. Bus. Posting Group" := GenBusCode;
            //FP6.2 begin
            IF LocCode <> '' THEN
                ItemJnlLine."Location Code" := LocCode;
            IF BinCode <> '' THEN
                ItemJnlLine."Bin Code" := BinCode;
            //FP6.2 end
            //FP6.2.03 -- Begin
            ItemJnlLine."Lot No. for Phys. Inv." := LotNo2;
            ItemJnlLine."Serial No. for Phys. Inv." := SerialNo2;

            //LW1.01 Start
            ILERecGbl.RESET;
            ILERecGbl.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
            ILERecGbl.SETRANGE("Item No.", ItemJnlLine."Item No.");
            ILERecGbl.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
            ILERecGbl.SETRANGE("Location Code", ItemJnlLine."Location Code");
            ILERecGbl.SETRANGE("Lot No.", LotNo2);
            ILERecGbl.SETRANGE("Serial No.", SerialNo2);
            IF ILERecGbl.FINDLAST THEN
                ItemJnlLine."Expiration Date" := ILERecGbl."Expiration Date";
            //LW1.01 End

            //LW1.02 Start
            CLEAR(BinContentRecGbl);
            CLEAR(PickQtyOfBinCont);

            BinContentRecGbl.RESET;
            BinContentRecGbl.SETCURRENTKEY("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code");
            BinContentRecGbl.SETRANGE("Location Code", ItemJnlLine."Location Code");
            BinContentRecGbl.SETRANGE("Bin Code", ItemJnlLine."Bin Code");
            BinContentRecGbl.SETRANGE("Item No.", ItemJnlLine."Item No.");
            BinContentRecGbl.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
            BinContentRecGbl.SETRANGE("Lot No. Filter", LotNo2);
            BinContentRecGbl.SETFILTER("Pick Quantity (Base)", '<>%1', 0);
            IF BinContentRecGbl.FINDSET THEN BEGIN
                REPEAT
                    BinContentRecGbl.CALCFIELDS("Pick Quantity (Base)");
                    PickQtyOfBinCont += BinContentRecGbl."Pick Quantity (Base)";
                UNTIL BinContentRecGbl.NEXT = 0;
            END;

            //"Qty. on Pick" := PickQtyOfBinCont;
            //LW1.02 ENd

            //FP6.2.03 -- End

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
                                /*CreateReservEntry.CreateReservEntryFor(
                                  DATABASE::"Item Journal Line",
                                  ItemJnlLine."Entry Type",
                                  ForSubtype,
                                  ForID,
                                  ItemJnlLine."Journal Template Name",
                                  ItemJnlLine."Journal Batch Name",
                                  OrderLineNo,
                                  ItemJnlLine."Line No.",
                                  ItemJnlLine."Qty. per Unit of Measure",
                                  ABS(WhseEntry.Quantity),
                                   ABS(WhseEntry."Qty. (Base)"),
                                  WhseEntry."Serial No.",
                                  WhseEntry."Lot No.");*///B2BUPG

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
                                ReservEntry);//By B2BUPG



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
        //ItemTrackingMgt.CheckWhseItemTrkgSetup(QuantityOnHandBuffer."Item No.", WhseSNRequired, WhseLNRequired, FALSE);//B2BUPG
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

        //FP6.2.03
        IF BreakOutByLotNo THEN
            //MESSAGE('Breakout'); //WLB
            QuantityOnHandBuffer."Lot No." := "Item Ledger Entry"."Lot No.";
        IF BreakOutBySerialNo THEN
            QuantityOnHandBuffer."Serial No." := "Item Ledger Entry"."Serial No.";
        //end FP6.2.03

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

    local procedure CalcPhysInvQtyAndInsertItemJnlLine()
    begin
        QuantityOnHandBuffer.RESET;
        IF QuantityOnHandBuffer.FINDSET THEN BEGIN
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
                        //FP6.2.03
                        //InsertItemJnlLine(
                        //"Item No.","Variant Code","Dimension Entry No.",
                        //"Bin Code",Quantity,PosQty);
                        InsertItemJnlLine(
                    QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                    QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty,
                    QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No.");
                    //end FP6.2.03


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
                        //FP6.2.03
                        //InsertItemJnlLine(
                        //"Item No.","Variant Code","Dimension Entry No.",
                        //"Bin Code",Quantity,PosQty);
                        InsertItemJnlLine(
                          QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                          QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty,
                          QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No.");
                        //end FP6.2.03


                        ZeroQty := ZeroQtySave;
                    END;
                END ELSE BEGIN
                    PosQty := 0;
                    NegQty := 0;
                END;

                IF (PosQty = 0) AND (NegQty = 0) AND NOT AdjustPosQty THEN
                    //FP6.2.03
                    //InsertItemJnlLine(
                    //"Item No.","Variant Code","Dimension Entry No.",
                    //"Bin Code",Quantity,PosQty);
                    InsertItemJnlLine(
                  QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                  QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty,
                  QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No.");
            //end FP6.2.03

            UNTIL QuantityOnHandBuffer.NEXT = 0;
            QuantityOnHandBuffer.DELETEALL;
        END;
    end;


    procedure "-- FP --"()
    begin
    end;


    procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        InvoicedQty: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
        ValuedQty: Decimal;
    begin
        // adjust remaining quantity
        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry.Quantity;
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            IF ItemApplnEntry.FINDSET THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" + ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            IF ItemApplnEntry.FINDSET THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END;

        // calculate adjusted cost of entry
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        ValueEntry.SETRANGE("Posting Date", 0D, AsOfDate);
        IF ValueEntry.FINDSET THEN
            REPEAT
                IF ValueEntry."Expected Cost" THEN BEGIN
                    ExpectedValue := ExpectedValue + ValueEntry."Cost Amount (Expected)";
                    ExpectedValueACY := ExpectedValueACY + ValueEntry."Cost Amount (Expected) (ACY)";
                    IF ValuedQty = 0 THEN
                        ValuedQty := ValueEntry."Valued Quantity";
                END ELSE BEGIN
                    InvoicedQty := InvoicedQty + ValueEntry."Invoiced Quantity";
                    InvoicedValue := InvoicedValue + ValueEntry."Cost Amount (Actual)";
                    InvoicedValueACY := InvoicedValueACY + ValueEntry."Cost Amount (Actual) (ACY)";
                END;
            UNTIL ValueEntry.NEXT = 0;
        IF ValuedQty = 0 THEN BEGIN
            ValuedQty := InvoicedQty;
            ExpectedValue := 0;
            ExpectedValueACY := 0;
        END ELSE BEGIN
            ExpectedValue := ExpectedValue * (ValuedQty - InvoicedQty) / ValuedQty;
            ExpectedValueACY := ExpectedValueACY * (ValuedQty - InvoicedQty) / ValuedQty;
        END;
        ItemLedgEntry."Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue, 0.0001);  //<--//TAG
        ItemLedgEntry."Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY, Currency."Amount Rounding Precision");
    end;


    procedure ItemLotBinLocationIsCalculated(LotNo: Code[20]; BinCode: Code[20]): Boolean
    begin
        QuantityOnHandBuffer.RESET;
        QuantityOnHandBuffer.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
        QuantityOnHandBuffer.SETRANGE("Variant Code", "Item Ledger Entry"."Variant Code");
        QuantityOnHandBuffer.SETRANGE("Location Code", "Item Ledger Entry"."Location Code");
        QuantityOnHandBuffer.SETRANGE("Bin Code", BinCode);
        QuantityOnHandBuffer.SETRANGE("Lot No.", LotNo);
        EXIT(QuantityOnHandBuffer.FIND('-'));
    end;
}

