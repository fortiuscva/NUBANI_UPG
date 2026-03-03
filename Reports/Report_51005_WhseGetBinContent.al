report 51005 "Whse. Get Bin Content_UPG"///7391 id changed to 51005
{
    Caption = 'Whse. Get Bin Content';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bin Content"; "Bin Content")
        {
            RequestFilterFields = "Location Code", "Zone Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code";

            trigger OnAfterGetRecord()
            begin
                IF BinType.Code <> "Bin Type Code" THEN
                    BinType.GET("Bin Type Code");
                IF BinType.Receive AND NOT "Cross-Dock Bin" THEN
                    CurrReport.SKIP;
                IF DestinationType2 = 3 THEN
                    QtyToEmptyBase := CalcQtyAvailToPick(0)
                ELSE
                    QtyToEmptyBase := CalcQtyAvailToTake(0);
                IF QtyToEmptyBase <= 0 THEN
                    CurrReport.SKIP;

                CASE DestinationType2 OF
                    0:
                        InsertWWL;
                    1:
                        InsertWIPL;
                    2:
                        InsertItemJournalLine;
                    3:
                        BEGIN
                            TransferHeader.TESTFIELD("Transfer-from Code", "Location Code");
                            InsertTransferLine;
                        END;
                    4:
                        InsertIntMovementLine;
                END;

                GetSerialNoAndLotNo;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT ReportInitialized THEN
                    ERROR(Text001);

                Location.INIT;
            end;
        }
    }

    requestpage
    {

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
                        Editable = PostingDateEditable;
                    }
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                        Editable = DocNoEditable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            DocNoEditable := TRUE;
            PostingDateEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            CASE DestinationType2 OF
                2:
                    BEGIN
                        PostingDateEditable := TRUE;
                        DocNoEditable := TRUE;
                    END;
                ELSE BEGIN
                    PostingDateEditable := FALSE;
                    DocNoEditable := FALSE;
                END;
            END;
        end;
    }

    labels
    {
    }

    var
        WWLine: Record "Whse. Worksheet Line";
        WIPLine: Record "Whse. Internal Put-away Line";
        ItemJournalLine: Record "Item Journal Line";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        BinType: Record "Bin Type";
        Location: Record Location;
        InternalMovementHeader: Record "Internal Movement Header";
        InternalMovementLine: Record "Internal Movement Line";
        QtyToEmptyBase: Decimal;
        ReportInitialized: Boolean;
        Text001: Label 'Report must be initialized.';
        DestinationType2: Option;
        PostingDate: Date;
        DocNo: Code[20];

        PostingDateEditable: Boolean;

        DocNoEditable: Boolean;


    procedure InitializeReport(WWL: Record "Whse. Worksheet Line"; WIPH: Record "Whse. Internal Put-away Header"; DestinationType: Option)
    begin
        CASE DestinationType OF
            0:
                BEGIN
                    WWLine := WWL;
                    WWLine.SETCURRENTKEY("Worksheet Template Name", Name, "Location Code", "Line No.");
                    WWLine.SETRANGE("Worksheet Template Name", WWLine."Worksheet Template Name");
                    WWLine.SETRANGE(Name, WWLine.Name);
                    WWLine.SETRANGE("Location Code", WWLine."Location Code");
                    IF WWLine.FINDLAST THEN;
                END;
            1:
                BEGIN
                    WIPLine."No." := WIPH."No.";
                    WIPLine.SETRANGE("No.", WIPLine."No.");
                    IF WIPLine.FINDLAST THEN;
                END;
        END;

        DestinationType2 := DestinationType;
        ReportInitialized := TRUE;
    end;


    procedure InitializeItemJournalLine(ItemJournalLine2: Record "Item Journal Line")
    begin
        ItemJournalLine := ItemJournalLine2;
        ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalLine2."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalLine2."Journal Batch Name");
        IF ItemJournalLine.FINDLAST THEN;

        PostingDate := ItemJournalLine2."Posting Date";
        DocNo := ItemJournalLine2."Document No.";

        DestinationType2 := 2;
        ReportInitialized := TRUE;
    end;


    procedure InitializeTransferHeader(TransferHeader2: Record "Transfer Header")
    begin
        TransferLine.RESET;
        TransferLine.SETRANGE("Document No.", TransferHeader2."No.");
        IF NOT TransferLine.FINDLAST THEN BEGIN
            TransferLine.INIT;
            TransferLine."Document No." := TransferHeader2."No.";
        END;

        TransferHeader := TransferHeader2;

        DestinationType2 := 3;
        ReportInitialized := TRUE;
    end;


    procedure InitializeInternalMovement(InternalMovementHeader2: Record "Internal Movement Header")
    begin
        InternalMovementLine.RESET;
        InternalMovementLine.SETRANGE("No.", InternalMovementHeader2."No.");
        IF NOT InternalMovementLine.FINDLAST THEN BEGIN
            InternalMovementLine.INIT;
            InternalMovementLine."No." := InternalMovementHeader2."No.";
        END;
        InternalMovementHeader := InternalMovementHeader2;

        DestinationType2 := 4;
        ReportInitialized := TRUE;
    end;


    procedure InsertWWL()
    begin
        WWLine.INIT;
        WWLine."Line No." := WWLine."Line No." + 10000;
        WWLine.VALIDATE("Location Code", "Bin Content"."Location Code");
        WWLine.VALIDATE("Item No.", "Bin Content"."Item No.");
        WWLine.VALIDATE("Variant Code", "Bin Content"."Variant Code");
        WWLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        WWLine.VALIDATE("From Bin Code", "Bin Content"."Bin Code");
        WWLine."From Zone Code" := "Bin Content"."Zone Code";
        WWLine.VALIDATE("From Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        WWLine.VALIDATE(Quantity, CalcQtyUOM(QtyToEmptyBase, WWLine."Qty. per From Unit of Measure"));
        WWLine."Whse. Document Type" := WWLine."Whse. Document Type"::"Whse. Mov.-Worksheet";
        WWLine."Whse. Document No." := WWLine.Name;
        WWLine."Whse. Document Line No." := WWLine."Line No.";
        WWLine.INSERT;
    end;


    procedure InsertWIPL()
    begin
        WIPLine.INIT;
        WIPLine."Line No." := WIPLine."Line No." + 10000;
        WIPLine.VALIDATE("Location Code", "Bin Content"."Location Code");
        WIPLine.VALIDATE("Item No.", "Bin Content"."Item No.");
        WIPLine.VALIDATE("Variant Code", "Bin Content"."Variant Code");
        WIPLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        WIPLine.VALIDATE("From Bin Code", "Bin Content"."Bin Code");
        WIPLine."From Zone Code" := "Bin Content"."Zone Code";
        WIPLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        WIPLine.VALIDATE(Quantity, CalcQtyUOM(QtyToEmptyBase, WIPLine."Qty. per Unit of Measure"));
        WIPLine.INSERT;
    end;


    procedure InsertItemJournalLine()
    var
        ItemJournalTempl: Record "Item Journal Template";
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Line No." := ItemJournalLine."Line No." + 10000;
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Transfer);
        ItemJournalLine.VALIDATE("Item No.", "Bin Content"."Item No.");
        ItemJournalLine.VALIDATE("Posting Date", PostingDate);
        ItemJournalLine.VALIDATE("Document No.", DocNo);
        ItemJournalLine.VALIDATE("Location Code", "Bin Content"."Location Code");
        ItemJournalLine.VALIDATE("New Location Code", "Bin Content"."Location Code");
        ItemJournalLine.VALIDATE("Variant Code", "Bin Content"."Variant Code");
        ItemJournalLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        ItemJournalLine.VALIDATE("Bin Code", "Bin Content"."Bin Code");
        ItemJournalLine.VALIDATE("New Bin Code", '');
        ItemJournalLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        ItemJournalLine.VALIDATE(Quantity, CalcQtyUOM(QtyToEmptyBase, ItemJournalLine."Qty. per Unit of Measure"));
        ItemJournalTempl.GET(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Source Code" := ItemJournalTempl."Source Code";
        ItemJournalLine.INSERT;
    end;


    procedure InsertTransferLine()
    begin
        TransferLine.INIT;
        TransferLine."Line No." := TransferLine."Line No." + 10000;
        TransferLine.VALIDATE("Item No.", "Bin Content"."Item No.");
        TransferLine.VALIDATE("Variant Code", "Bin Content"."Variant Code");
        TransferLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        TransferLine.VALIDATE("Transfer-from Bin Code", "Bin Content"."Bin Code");
        TransferLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        TransferLine.VALIDATE(Quantity, CalcQtyUOM(QtyToEmptyBase, TransferLine."Qty. per Unit of Measure"));
        TransferLine.INSERT;
    end;


    procedure InsertIntMovementLine()
    begin
        InternalMovementLine.INIT;
        InternalMovementLine."Line No." := InternalMovementLine."Line No." + 10000;
        InternalMovementLine.VALIDATE("Location Code", "Bin Content"."Location Code");
        InternalMovementLine.VALIDATE("Item No.", "Bin Content"."Item No.");
        InternalMovementLine.VALIDATE("Variant Code", "Bin Content"."Variant Code");
        InternalMovementLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        InternalMovementLine.VALIDATE("From Bin Code", "Bin Content"."Bin Code");
        InternalMovementLine.VALIDATE("To Bin Code", InternalMovementHeader."To Bin Code");
        InternalMovementLine.VALIDATE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        InternalMovementLine.VALIDATE(Quantity, CalcQtyUOM(QtyToEmptyBase, InternalMovementLine."Qty. per Unit of Measure"));
        InternalMovementLine.INSERT;
    end;


    procedure GetSerialNoAndLotNo()
    var
        WarehouseEntry: Record "Warehouse Entry";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ReserveTransferLine: Codeunit "Transfer Line-Reserve";
        Direction: Option Outbound,Inbound;
        SNRequired: Boolean;
        LNRequired: Boolean;
        ItemTrackingSetup: Record "Item Tracking Setup" temporary;
        WhseEntry: Record "Warehouse Entry";
    begin
        CLEAR(ItemTrackingMgt);
        //ItemTrackingMgt.CheckWhseItemTrkgSetup("Bin Content"."Item No.", SNRequired, LNRequired, FALSE);//B2BUPG
        ItemTrackingMgt.CheckWhseItemTrkgSetup("Bin Content"."Item No.");
        IF NOT (SNRequired OR LNRequired) THEN
            EXIT;

        WarehouseEntry.RESET;
        WarehouseEntry.SETCURRENTKEY(
          "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        WarehouseEntry.SETRANGE("Item No.", "Bin Content"."Item No.");
        WarehouseEntry.SETRANGE("Bin Code", "Bin Content"."Bin Code");
        WarehouseEntry.SETRANGE("Location Code", "Bin Content"."Location Code");
        WarehouseEntry.SETRANGE("Variant Code", "Bin Content"."Variant Code");
        WarehouseEntry.SETRANGE("Unit of Measure Code", "Bin Content"."Unit of Measure Code");
        IF WarehouseEntry.FIND('-') THEN
            REPEAT
                IF (WarehouseEntry."Lot No." <> '') OR (WarehouseEntry."Serial No." <> '') THEN BEGIN
                    IF WarehouseEntry."Lot No." <> '' THEN
                        WarehouseEntry.SETRANGE("Lot No.", WarehouseEntry."Lot No.");
                    IF WarehouseEntry."Serial No." <> '' THEN
                        WarehouseEntry.SETRANGE("Serial No.", WarehouseEntry."Serial No.");
                    WarehouseEntry.CALCSUMS("Qty. (Base)");
                    QtyToEmptyBase := WarehouseEntry."Qty. (Base)";
                    IF QtyToEmptyBase > 0 THEN BEGIN
                        GetLocation(WarehouseEntry."Location Code", Location);
                        //ItemTrackingMgt.GetWhseExpirationDate("Item No.", "Variant Code", Location, "Lot No.", "Serial No.", "Expiration Date");//B2BUPG
                        ItemTrackingMgt.GetWhseExpirationDate(WarehouseEntry."Item No.", WarehouseEntry."Variant Code", Location, ItemTrackingSetup, WarehouseEntry."Expiration Date");

                        CASE DestinationType2 OF
                            0:
                                //WWLine.SetItemTrackingLines("Serial No.", "Lot No.", "Expiration Date", QtyToEmptyBase);B2BUPG
                                WWLine.SetItemTrackingLines(WhseEntry, QtyToEmptyBase);
                            1:
                                WIPLine.SetItemTrackingLines(WhseEntry, QtyToEmptyBase);
                            2:
                                //ReserveItemJnlLine.InitTrackingSpecification(ItemJournalLine, TempTrackingSpecification);//B2BUPG
                                ReserveItemJnlLine.CreateItemTracking(ItemJournalLine);
                            3:
                                InitTrackingSpecification(
                                  TransferLine, TempTrackingSpecification, TransferLine."Shipment Date", Direction::Outbound);
                            4:
                                InternalMovementLine.SetItemTrackingLines(WhseEntry, QtyToEmptyBase);
                        END;
                    END;
                    WarehouseEntry.FIND('+');
                    WarehouseEntry.SETRANGE("Lot No.");
                    WarehouseEntry.SETRANGE("Serial No.");
                END;
                IF DestinationType2 IN [2, 3] THEN
                    InsertTempTrackingSpec(WarehouseEntry, QtyToEmptyBase, TempTrackingSpecification);
            UNTIL WarehouseEntry.NEXT = 0;
        CASE DestinationType2 OF
            2:
                ReserveItemJnlLine.RegisterBinContentItemTracking(ItemJournalLine, TempTrackingSpecification);
            3:
                ReserveTransferLine.RegisterBinContentItemTracking(TransferLine, TempTrackingSpecification);
        END;
    end;

    local procedure GetLocation(LocationCode: Code[10]; var Location: Record Location)
    begin
        IF LocationCode = Location.Code THEN
            EXIT;

        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            Location.GET(LocationCode);
    end;


    procedure InsertTempTrackingSpec(WarehouseEntry: Record "Warehouse Entry"; QtyOnBin: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        TempTrackingSpecification.SetSkipSerialNoQtyValidation(TRUE);
        TempTrackingSpecification.VALIDATE("Serial No.", WarehouseEntry."Serial No.");
        TempTrackingSpecification.SetSkipSerialNoQtyValidation(FALSE);
        TempTrackingSpecification."New Serial No." := WarehouseEntry."Serial No.";
        TempTrackingSpecification.VALIDATE("Lot No.", WarehouseEntry."Lot No.");
        TempTrackingSpecification."New Lot No." := WarehouseEntry."Lot No.";
        TempTrackingSpecification."Quantity Handled (Base)" := 0;
        TempTrackingSpecification."Expiration Date" := WarehouseEntry."Expiration Date";
        TempTrackingSpecification."New Expiration Date" := WarehouseEntry."Expiration Date";
        TempTrackingSpecification.VALIDATE("Quantity (Base)", QtyOnBin);
        TempTrackingSpecification."Entry No." += 1;
        TempTrackingSpecification.INSERT;
    end;

    local procedure CalcQtyUOM(QtyBase: Decimal; QtyPerUOM: Decimal): Decimal
    begin
        IF QtyPerUOM = 0 THEN
            EXIT(0);

        EXIT(ROUND(QtyBase / QtyPerUOM, 0.00001));
    end;


    procedure InitTrackingSpecification(VAR TransLine: Record "Transfer Line"; VAR TrackingSpecification: Record "Tracking Specification"; VAR AvalabilityDate: Date; Direction: Option Outbound,Inbound)
    begin
        TrackingSpecification."Source Type" := DATABASE::"Transfer Line";
        TrackingSpecification."Item No." := TransLine."Item No.";
        TrackingSpecification.Description := TransLine.Description;
        TrackingSpecification."Variant Code" := TransLine."Variant Code";
        TrackingSpecification."Source Subtype" := Direction;
        TrackingSpecification."Source ID" := TransLine."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := TransLine."Derived From Line No.";
        TrackingSpecification."Source Ref. No." := TransLine."Line No.";
        TrackingSpecification."Quantity (Base)" := TransLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice (Base)" := TransLine."Quantity (Base)";
        TrackingSpecification."Qty. to Invoice" := TransLine.Quantity;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        TrackingSpecification."Qty. per Unit of Measure" := TransLine."Qty. per Unit of Measure";
        TrackingSpecification."Location Code" := '';
        CASE Direction OF
            Direction::Outbound:
                BEGIN
                    TrackingSpecification."Location Code" := TransLine."Transfer-from Code";
                    TrackingSpecification."Bin Code" := TransLine."Transfer-from Bin Code";
                    TrackingSpecification."Qty. to Handle (Base)" := TransLine."Qty. to Ship (Base)";
                    TrackingSpecification."Qty. to Handle" := TransLine."Qty. to Ship";
                    TrackingSpecification."Quantity Handled (Base)" := TransLine."Qty. Shipped (Base)";
                    AvalabilityDate := TransLine."Shipment Date";
                END;
            Direction::Inbound:
                BEGIN
                    TrackingSpecification."Location Code" := TransLine."Transfer-to Code";
                    TrackingSpecification."Bin Code" := TransLine."Transfer-To Bin Code";
                    TrackingSpecification."Qty. to Handle (Base)" := TransLine."Qty. to Receive (Base)";
                    TrackingSpecification."Qty. to Handle" := TransLine."Qty. to Receive";
                    TrackingSpecification."Quantity Handled (Base)" := TransLine."Qty. Received (Base)";
                    AvalabilityDate := TransLine."Receipt Date";
                END;
        END;

    end;
}

