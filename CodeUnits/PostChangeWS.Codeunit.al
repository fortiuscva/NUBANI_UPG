codeunit 50006 PostChange_WS
{

    trigger OnRun()
    begin
    end;


    procedure PostMovements(ItemNo: Text[50]; LotNo: Text[50]; BinCode: Text[50]; NewBinCode: Text[50]; Quantity: Integer; UnitOfMeasure: Text[50]; ItemDescription: Text[50]; ItemTrackingCode: Text[50]; BatchName: Text[50]; CurrentUserID: Text[50]; ItemLocationCode: Text[50]) ReturnString: Text[1000]
    var
        HighestLineNo: Integer;
        ItemLedgEntry: Record "Item Ledger Entry";
        TempBinContent: Record "Bin Content";
        TempUOM: Text[30];
        HighestEntryNo: Integer;
        ResEnt: Record "Reservation Entry";
        ItemJnlTempl: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ReservEntry: Record "Reservation Entry";
        tempExpirationDate: Date;
        WhseEntry: Record "Warehouse Entry";
        PIM: Codeunit PostInventoryManagement;
        QuantityInt: Integer;
    begin

        // ReturnString consists of a single return value in a Text[1000] field.
        // 1.  Return Code.  Value of '0' means that the Post Operation succeeded
        //       Value of '1' means that it did not.


        // Find the highest Line Number
        HighestLineNo := 0;
        ItemJnlLine.RESET;
        IF ItemJnlLine.FINDLAST THEN
            HighestLineNo := ItemJnlLine."Line No.";
        ItemJnlLine.RESET;
        HighestLineNo += 10000;

        ItemJnlLine.INIT;
        ItemJnlLine.VALIDATE("Item No.", ItemNo);
        ItemJnlLine."Journal Batch Name" := BatchName;
        ItemJnlLine."Line No." := HighestLineNo;

        // Retrieve the Item Journal Template name Value
        ItemJnlTempl.SETRANGE(Type, ItemJnlTempl.Type::Transfer);
        ItemJnlTempl.FINDFIRST;


        // Regular Fields:
        ItemJnlLine."Journal Template Name" := ItemJnlTempl.Name;

        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;

        ItemJnlLine.VALIDATE("Document No.", CurrentUserID);
        ItemJnlLine.VALIDATE("Posting Date", WORKDATE);
        ItemJnlLine.VALIDATE("Location Code", ItemLocationCode);
        ItemJnlLine.VALIDATE("New Location Code", ItemLocationCode);
        ItemJnlLine.VALIDATE("Bin Code", BinCode);
        ItemJnlLine.VALIDATE("New Bin Code", NewBinCode);
        ItemJnlLine.VALIDATE(Quantity, Quantity);
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;


        ItemJnlLine.INSERT(TRUE);
        // Set the Item Tracking's LotNo, NewLotNo, and Quantity
        //-------------------------------------------------------------
        // Reservation Entry Table
        CLEAR(ReservEntry);
        ReservEntry.LOCKTABLE;
        IF NOT ReservEntry.FINDLAST THEN;
        ReservEntry.INIT;
        ReservEntry."Entry No." += 1;
        ReservEntry."Item No." := ItemJnlLine."Item No.";
        ReservEntry."Location Code" := ItemJnlLine."Location Code";
        ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
        ReservEntry."Creation Date" := WORKDATE;
        // Get the Expiration Date from the item ledger Entry table
        ItemLedgEntry.SETRANGE("Lot No.", LotNo);
        ItemLedgEntry.SETRANGE("Location Code", ItemLocationCode);
        ItemLedgEntry.SETRANGE("Item No.", ItemNo);

        IF ItemLedgEntry.FINDFIRST THEN
            tempExpirationDate := ItemLedgEntry."Expiration Date";


        ReservEntry."New Expiration Date" := tempExpirationDate;

        ReservEntry."Source Type" := DATABASE::"Item Journal Line";
        ReservEntry."Source Subtype" := ReservEntry."Source Subtype"::"4";
        ReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReservEntry."Source Ref. No." := ItemJnlLine."Line No.";
        ReservEntry."Shipment Date" := WORKDATE;
        ReservEntry."Created By" := CurrentUserID;
        ReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
        ReservEntry."New Lot No." := LotNo;
        ReservEntry."Lot No." := LotNo;
        ReservEntry."Variant Code" := ItemJnlLine."Variant Code";
        ReservEntry."Bin Code" := BinCode;
        ReservEntry."Bin Code" := NewBinCode;
        ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReservEntry.VALIDATE("Quantity (Base)", -ItemJnlLine."Quantity (Base)");
        ReservEntry.INSERT;



        // Call PostInventoryManagement (Codeunit 50008) to Post the ItemJournalLine Record
        PIM.PostWarehouseInventory(ItemJnlLine);

        // Verify that the Post was successful and determine returnString based on success/failure.

        WhseEntry.SETRANGE("Item No.", ItemNo);
        WhseEntry.SETRANGE("Bin Code", NewBinCode);
        WhseEntry.SETRANGE("Location Code", ItemLocationCode);
        WhseEntry.SETRANGE("Registering Date", TODAY);

        WhseEntry.SETRANGE("Unit of Measure Code", UnitOfMeasure);


        IF WhseEntry.FINDLAST THEN BEGIN
            QuantityInt := ROUND(WhseEntry.Quantity, 1, '=');
            IF (QuantityInt >= Quantity) THEN BEGIN
                ReturnString := '0';
            END ELSE BEGIN
                ReturnString := '1';
            END;
        END;
    end;
}

