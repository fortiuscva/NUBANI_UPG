tableextension 50019 PurchaseHeaderExt extends "Purchase Header"
{

    Caption = 'Purchase Header';
    fields
    {
        modify("Tax Area Code")
        {
            trigger OnBeforeValidate()
            begin
                IF "Tax Area Code" = '' THEN
                    CLEAR(TaxArea)
                ELSE
                    TaxArea.GET("Tax Area Code");
            end;
        }
        // field(10005; "Ship-to UPS Zone"; Code[2])
        // {
        //     Caption = 'Ship-to UPS Zone';
        // }
        // field(10015; "Tax Exemption No."; Text[30])
        // {
        //     Caption = 'Tax Exemption No.';
        // }
        // field(10017; "Provincial Tax Area Code"; Code[20])
        // {
        //     Caption = 'Provincial Tax Area Code';
        //     TableRelation = "Tax Area" WHERE(Country = CONST(CA));

        //     trigger OnValidate()
        //     begin
        //         IF (CurrFieldNo = FIELDNO("Provincial Tax Area Code")) AND
        //            (xRec."Provincial Tax Area Code" = '') AND
        //            ("Provincial Tax Area Code" <> '')
        //         THEN BEGIN
        //             PurchSetup.GET;
        //             IF PurchSetup."Use Vendor's Tax Area Code" THEN BEGIN
        //                 IF "Buy-from Vendor No." <> Vend."No." THEN
        //                     Vend.GET("Buy-from Vendor No.");
        //             END;
        //             IF NOT VendorLocation.READPERMISSION THEN
        //                 VendorLocation."Business Presence" := TRUE
        //             ELSE
        //                 IF NOT VendorLocation.GET("Buy-from Vendor No.", "Location Code") THEN
        //                     VendorLocation."Business Presence" := TRUE;
        //             IF PurchSetup."Use Vendor's Tax Area Code" AND (Vend."Tax Area Code" <> '') THEN
        //                 VendorLocation."Business Presence" := TRUE;
        //             IF VendorLocation."Business Presence" THEN
        //                 IF NOT CONFIRM(USText001, FALSE, FIELDCAPTION("Provincial Tax Area Code")) THEN
        //                     ERROR('');
        //         END;
        //     end;
        // }
        // field(10018; "STE Transaction ID"; Text[20])
        // {
        //     Caption = 'STE Transaction ID';
        //     Editable = false;
        // }
        // field(10020; "IRS 1099 Code"; Code[10])
        // {
        //     Caption = 'IRS 1099 Code';
        //     TableRelation = "IRS 1099 Form-Box";
        // }
        // field(12600; "Prepmt. Include Tax"; Boolean)
        // {
        //     Caption = 'Prepmt. Include Tax';
        // }
        field(50000; "Expected Receipt Time"; Time)
        {

            // trigger OnValidate()
            // begin
            //     UpdatePurchLines(FIELDCAPTION("Expected Receipt Time"));
            // end;//B2BUPG
        }
        field(50001; "Contact Phone"; Text[30])
        {
        }
        field(50002; "Pallets-Cases"; Text[30])
        {
        }
        field(50006; "Total Qty."; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Description = 'NUB1.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Total Qty. Received"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Description = 'NUB1.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Total Qty. Invoiced"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Invoiced" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Description = 'NUB1.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Priority Level"; Text[30])
        {
        }
    }
    keys
    {
        key(Key50000; "Document Type", Status, "Expected Receipt Date")
        {
        }
    }

    trigger OnBeforeDelete()
    begin
        IF "Tax Area Code" <> '' THEN BEGIN
            SalesTaxDifference.RESET;
            SalesTaxDifference.SETRANGE("Document Product Area", SalesTaxDifference."Document Product Area"::Purchase);
            SalesTaxDifference.SETRANGE("Document Type", "Document Type");
            SalesTaxDifference.SETRANGE("Document No.", "No.");
            SalesTaxDifference.DELETEALL;
        END;
    end;

    procedure UpdateItemDescription()
    var
        PurchLineLRec: Record "Purchase Line";
        ItemLRec: Record Item;
        PurchLineExtTextLRec: Record "Purchase Line";
        TransferExtendedText: Codeunit "Transfer Extended Text";
    //NotesCU: Codeunit "Multi-Note";//14005020 B2BUPG
    begin
        PurchLineLRec.RESET;
        PurchLineLRec.SETRANGE("Document Type", "Document Type");
        PurchLineLRec.SETRANGE("Document No.", "No.");
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
                        //NotesCU.PurchLineGetNotes(PurchLineLRec);//B2BUPG
                    END;

                END;

            UNTIL PurchLineLRec.NEXT = 0;
    end;

    var
        SalesTaxDifference: Record "Sales Tax Amount Difference";
        VendorLocation: Record "vendor location";
        TaxArea: Record "Tax Area";
        USText001: Label 'You have added a %1, which will result in a Tax Entry being posted to record the amount of Sales Tax you will owe your Province as a result of this purchase. Are you sure you want to do this?';

}



