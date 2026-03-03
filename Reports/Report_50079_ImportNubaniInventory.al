report 50079 "Import Nubani Inventory"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Import Nubani Inventory"; "Import Nubani Inventory")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE(Processed = CONST(false), Skip = CONST(false));

            trigger OnAfterGetRecord()
            begin
                IF "Lot No." <> '' THEN
                    CreateItemReclassJnlLine("Import Nubani Inventory", Quantity, TRUE, TRUE)
                ELSE
                    CreateItemReclassJnlLine("Import Nubani Inventory", Quantity, TRUE, FALSE);

                "Import Nubani Inventory".Processed := TRUE;
                "Import Nubani Inventory".MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Update in progresss..');
                LastItemNo := '';
                LastLotNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ReclassJnlLine: Record "Item Journal Line";
        CreateReservEntryLcl: Codeunit "Create Reserv. Entry";
        NextLineNo: Integer;
        ItemJnlLineRecLcl: Record "Item Journal Line";
        WhseMgmt: Codeunit "WMS Management";
        ItemRec: Record Item;
        DefaultRcvngBinCode: Code[20];
        DefaultBinCode: Code[20];
        DefaultRcvngBinExists: Boolean;
        DefaultBinExists: Boolean;
        TempName: Code[10];
        BatchName: Code[10];
        LastItemNo: Code[20];
        LastLotNo: Code[20];
        ItemReclassRec: Record "Posted Invt. Pick Line v1";
        QtyToReclassifiy: Decimal;
        Window: Dialog;
        ForSubtype: Integer;//B2BUPG
        ForReservEntry: Record "Reservation Entry";
        ForProdOrderLine: Integer;//B2BUPG


    procedure CreateItemReclassJnlLine(ItemReclassDet: Record "Import Nubani Inventory"; QtyToPost: Decimal; InsertLine: Boolean; UpdateLot: Boolean)
    begin
        DefaultBinCode := '';
        TempName := 'ITEM';
        BatchName := 'PHYSADJ';

        CLEAR(WhseMgmt);

        IF InsertLine THEN BEGIN
            ItemJnlLineRecLcl.RESET;
            ItemJnlLineRecLcl.SETRANGE("Journal Template Name", TempName);
            ItemJnlLineRecLcl.SETRANGE("Journal Batch Name", BatchName);
            IF ItemJnlLineRecLcl.FINDLAST THEN
                NextLineNo := (ItemJnlLineRecLcl."Line No." + 10000)
            ELSE
                NextLineNo := 10000;

            ItemRec.GET(ItemReclassDet."Item No.");

            ReclassJnlLine.INIT;
            ReclassJnlLine.VALIDATE("Journal Template Name", TempName);
            ReclassJnlLine.VALIDATE("Journal Batch Name", BatchName);
            ReclassJnlLine."Line No." := NextLineNo;
            ReclassJnlLine.VALIDATE("Entry Type", ItemReclassDet."Entry Type");
            ReclassJnlLine.VALIDATE("Posting Date", ItemReclassDet."Posting Date");
            ReclassJnlLine.VALIDATE("Document No.", ItemReclassDet."Document No.");
            ReclassJnlLine.VALIDATE("Item No.", ItemReclassDet."Item No.");
            ReclassJnlLine.VALIDATE("Unit of Measure Code", ItemReclassDet."UOM Code");
            ReclassJnlLine.VALIDATE("Location Code", ItemReclassDet."Location Code");
            ReclassJnlLine.VALIDATE(Quantity, QtyToPost);
            ReclassJnlLine.VALIDATE("Bin Code", ItemReclassDet."Bin Code");

            ReclassJnlLine."Source Code" := 'ITEMJNL';
            //ReclassJnlLine.VALIDATE("Reason Code",'CONVERSION');
            ReclassJnlLine.INSERT(TRUE);
        END;

        IF UpdateLot THEN BEGIN

            /*CreateReservEntryLcl.CreateReservEntryFor(DATABASE::"Item Journal Line", // source type
                                            ReclassJnlLine."Entry Type", // source subtype
                                            TempName, // source id
                                            BatchName, // source batch name
                                            0, // source prod. order line -> should not be filled in
                                            ReclassJnlLine."Line No.", // source ref. no.
                                            ReclassJnlLine."Qty. per Unit of Measure", // qty per uom
                                            ReclassJnlLine.Quantity, //quantity
                                            ReclassJnlLine."Quantity (Base)", // quantity (base) abs???
                                            ItemReclassDet."Serial No.", // serial no.
                                            ItemReclassDet."Lot No."); // lot no.*/ //B2BUPG

            CreateReservEntryLcl.CreateReservEntryFor(ReclassJnlLine."Entry Type".AsInteger(), ForSubtype, TempName, BatchName, ForProdOrderLine, ReclassJnlLine."Line No.", ReclassJnlLine."Qty. per Unit of Measure", ReclassJnlLine.Quantity, ReclassJnlLine."Quantity (Base)", ForReservEntry);
            CreateReservEntryLcl.SetDates(0D, ItemReclassDet."Expiration Date");
            //CreateReservEntryLcl.SetNewSerialLotNo('',"Item Reclass Details"."Lot No.");
            //CreateReservEntryLcl.SetNewExpirationDate("Item Reclass Details"."Expiration Date");
            CreateReservEntryLcl.CreateEntry(ReclassJnlLine."Item No.", // itemno
                                ReclassJnlLine."Variant Code", // variant code
                                ReclassJnlLine."Location Code", // location code
                                '', // description
                                WORKDATE, // expected receipt date
                                0D, // shipment date
                                0, // transferred from entry no
                                Enum::"Reservation Status"::"Prospect"); // status
        END;
    end;
}

