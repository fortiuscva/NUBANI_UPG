tableextension 50020 PurchaseLineExt extends "Purchase Line"
{

    Caption = 'Purchase Line';



    fields
    {

        field(50000; "Expected Receipt Time"; Time)
        {
        }
        field(60020; "Allow Qty Change"; Boolean)
        {
            Description = 'FP  system entered and temp';
        }
        field(60021; "Original Qty"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'FP  system entered';
        }
        field(60022; "Orig Unit of Measure Code"; Code[10])
        {
            Description = 'FP  system entered';
        }
        field(60023; "Original Qty (Base)"; Decimal)
        {
            Description = 'FP  system entered';
        }
        field(60024; "Paym. Disc. Allowed"; Boolean)
        {
            Description = 'FP6.2.06';
        }
        field(60025; "Amt. for Paym. Disc. Allowed"; Decimal)
        {
            Description = 'FP6.2.06';
        }

    }

    procedure UpdateItemDescription()
    var
        PurchLineLRec: record "Purchase Line";
        ItemLRec: record Item;
        PurchLineExtTextLRec: Record "Purchase Line";
        TransferExtendedText: codeunit "Transfer Extended Text";
    //NotesCU : codeunit "mulit note";14005020B2BUPG
    begin

        PurchLineLRec.RESET;
        PurchLineLRec.SETRANGE("Document Type", "Document Type");
        PurchLineLRec.SETRANGE("Document No.", "Document No.");
        PurchLineLRec.SETRANGE("Line No.", "Line No.");
        PurchLineLRec.SETRANGE(Type, PurchLineLRec.Type::Item);
        IF PurchLineLRec.FINDSET THEN
            REPEAT
                IF ItemLRec.GET(PurchLineLRec."No.") THEN BEGIN
                    PurchLineLRec.Description := ItemLRec.Description;
                    PurchLineLRec."Description 2" := ItemLRec."Description 2";
                    PurchLineLRec.MODIFY;

                    PurchLineExtTextLRec.RESET;
                    PurchLineExtTextLRec.SETRANGE("Document Type", PurchLineLRec."Document Type");
                    PurchLineExtTextLRec.SETRANGE("Document No.", PurchLineLRec."Document No.");
                    PurchLineExtTextLRec.SETRANGE("Attached to Line No.", PurchLineLRec."Line No.");
                    PurchLineExtTextLRec.DELETEALL;

                    IF TransferExtendedText.PurchCheckIfAnyExtText(PurchLineLRec, FALSE) THEN BEGIN
                        TransferExtendedText.InsertPurchExtText(PurchLineLRec);
                    END;

                    IF PurchLineLRec.Type = PurchLineLRec.Type::Item THEN BEGIN
                        COMMIT;
                        //NotesCU.PurchLineGetNotes(PurchLineLRec);//14005020B2BUPG
                    END;
                END;

            UNTIL PurchLineLRec.NEXT = 0;
    end;

}

