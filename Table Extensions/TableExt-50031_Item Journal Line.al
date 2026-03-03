tableextension 50031 ItemJournalLineExt extends "Item Journal Line"
{

    Caption = 'Item Journal Line';
    fields
    {
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                CheckQtyAvailToTake; // NUB1.01
            end;
        }
        field(50050; Skip; Boolean)
        {
            Description = 'NUB1.03';
        }
        field(60000; "Serial No. for Phys. Inv."; Code[20])
        {
            Caption = 'Serial No.';
            Description = 'FP6.2.06';
            Editable = false;
        }
        field(60001; "Lot No. for Phys. Inv."; Code[20])
        {
            Caption = 'Lot No.';
            Description = 'FP6.2.06';
            Editable = false;
        }
    }
    keys
    {
        key(Key50000; "Bin Code")
        {
        }
    }
    local procedure "--Nubani"()
    begin
    end;

    procedure CheckQtyAvailToTake()
    var
        AvailToTake: Decimal;
        BinContent: Record "Bin Content";
        Text_AvailToTake: Label '%1 cannot be more than %2 (available to take from bin %3).';
    begin
        // NUB1.01 - new function

        IF ("Bin Code" <> '') AND
           ("Entry Type" IN ["Entry Type"::Sale, "Entry Type"::"Negative Adjmt.", "Entry Type"::Transfer])
        THEN BEGIN
            BinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code");
            AvailToTake := BinContent.CalcQtyAvailToTakeUOM;
            IF Quantity > AvailToTake THEN
                ERROR(Text_AvailToTake, FIELDCAPTION(Quantity), AvailToTake, "Bin Code");
        END;
    end;

    procedure "---NUB1.02---"()
    begin
    end;

    procedure CreateReservEntryForLots()
    var
        ReservEntryRecLcl: Record "Reservation Entry";
        LastEntryNoVarLcl: Decimal;
    begin
        ReservEntryRecLcl.RESET;
        IF ReservEntryRecLcl.FINDLAST THEN
            LastEntryNoVarLcl := ReservEntryRecLcl."Entry No." + 1
        ELSE
            LastEntryNoVarLcl := 1;


        ReservEntryRecLcl.RESET;
        ReservEntryRecLcl.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservEntryRecLcl.SETRANGE("Source ID", "Journal Template Name");
        ReservEntryRecLcl.SETRANGE("Source Batch Name", "Journal Batch Name");
        ReservEntryRecLcl.SETRANGE("Source Ref. No.", "Line No.");
        IF NOT ReservEntryRecLcl.FINDFIRST THEN BEGIN
            ReservEntryRecLcl.INIT;
            ReservEntryRecLcl."Entry No." := LastEntryNoVarLcl;
            IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
                ReservEntryRecLcl."Source Subtype" := 2;
                ReservEntryRecLcl.Positive := TRUE;
            END ELSE BEGIN
                ReservEntryRecLcl."Source Subtype" := 3;
                ReservEntryRecLcl.Positive := FALSE;
            END;
            ReservEntryRecLcl.VALIDATE("Item No.", "Item No.");
            ReservEntryRecLcl.VALIDATE("Location Code", "Location Code");
            ReservEntryRecLcl."Reservation Status" := ReservEntryRecLcl."Reservation Status"::Prospect;
            ReservEntryRecLcl.VALIDATE("Creation Date", TODAY);
            ReservEntryRecLcl.VALIDATE("Source Type", 83);
            ReservEntryRecLcl.VALIDATE("Source ID", "Journal Template Name");
            ReservEntryRecLcl.VALIDATE("Source Batch Name", "Journal Batch Name");
            ReservEntryRecLcl.VALIDATE("Source Ref. No.", "Line No.");
            ReservEntryRecLcl."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            IF ReservEntryRecLcl.Positive THEN BEGIN
                ReservEntryRecLcl.VALIDATE("Quantity (Base)", "Quantity (Base)");
                ReservEntryRecLcl.VALIDATE("Expected Receipt Date", "Posting Date");
                ReservEntryRecLcl.VALIDATE("Expiration Date", "Expiration Date");
            END ELSE BEGIN
                ReservEntryRecLcl.VALIDATE("Quantity (Base)", -"Quantity (Base)");
                ReservEntryRecLcl.VALIDATE("Shipment Date", "Posting Date");
            END;
            ReservEntryRecLcl."Created By" := USERID;
            ReservEntryRecLcl."Planning Flexibility" := ReservEntryRecLcl."Planning Flexibility"::Unlimited;
            ReservEntryRecLcl.VALIDATE("Lot No.", "Lot No. for Phys. Inv.");
            ReservEntryRecLcl.UpdateItemTracking;
            ReservEntryRecLcl.INSERT;
        END;
    end;

}

