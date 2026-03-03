tableextension 50018 SalesLineExt extends "Sales Line"
{

    Caption = 'Sales Line';

    //Unsupported feature: Property Modification (PasteIsValid) on ""Sales Line"(Table 37)".

    fields
    {
        modify("Document Type")
        {
            Caption = 'Document Type';
            //OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 1)".

        }
        modify("Sell-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';

            //Unsupported feature: Property Modification (Editable) on ""Sell-to Customer No."(Field 2)".

        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Line No.")
        {
            Caption = 'Line No.';
        }
        modify(Type)
        {
            Caption = 'Type';
            //OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 5)".

        }
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text" ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" ELSE IF (Type = CONST(Item)) Item ELSE IF (Type = CONST(Resource)) Resource ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset" ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
            Caption = 'No.';
            trigger OnAfterValidate()
            var
                Item: Record Item;
                SalesLine: Record "Sales Line";
            begin
                if not (Type = Type::Item) then
                    exit;

                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("No.", Rec."No.");
                SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                if SalesLine.FindFirst() then
                    Message('Item No. %1 already exists in Line No. %2', SalesLine."No.", SalesLine."Line No.");

                Item.Get("No.");
                Rec."Qty.  Per Pallet" := Item."Qty.  Per Pallet";
                Rec."Unit Count" := Item."Unit Count";
                Rec."Inner UPC" := Item."Inner UPC";
            end;
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group" ELSE IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            Caption = 'Posting Group';

            //Unsupported feature: Property Modification (Editable) on ""Posting Group"(Field 8)".

        }
        modify("Shipment Date")
        {
            Caption = 'Shipment Date';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify("Unit of Measure")
        {
            Caption = 'Unit of Measure';
        }
        modify(Quantity)
        {
            Caption = 'Quantity';
            trigger OnAfterValidate()
            begin

                IF "Unit Count" <> 0 THEN
                    Each := "Unit Price" / "Unit Count"
                ELSE
                    Each := 0;
                //NUB1.01 Start
                IF ("Document Type" = "Document Type"::Order) AND (Type = Type::Item) AND (Quantity <> 0) AND ("Item Category Code" = 'REGULAR') THEN
                    AutomataicTracking();
                //NUB1.01 End

            end;


        }
        modify("Outstanding Quantity")
        {
            Caption = 'Outstanding Quantity';

            //Unsupported feature: Property Modification (Editable) on ""Outstanding Quantity"(Field 16)".

        }
        modify("Qty. to Invoice")
        {
            Caption = 'Qty. to Invoice';
        }
        modify("Qty. to Ship")
        {
            Caption = 'Qty. to Ship';
        }
        modify("Unit Price")
        {
            Caption = 'Unit Price';
            trigger OnAfterValidate()
            begin

                IF "Unit Count" <> 0 THEN
                    Each := "Unit Price" / "Unit Count"
                ELSE
                    Each := 0;
            end;
        }
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost ($)';
        }
        modify("VAT %")
        {
            Caption = 'Tax %';

            //Unsupported feature: Property Modification (Editable) on ""VAT %"(Field 25)".

        }
        modify("Line Discount %")
        {
            Caption = 'Line Discount %';
        }
        modify("Line Discount Amount")
        {
            Caption = 'Line Discount Amount';
        }
        modify(Amount)
        {
            Caption = 'Amount';

            //Unsupported feature: Property Modification (Editable) on "Amount(Field 29)".

        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including Tax';

            //Unsupported feature: Property Modification (Editable) on ""Amount Including VAT"(Field 30)".

        }
        modify("Allow Invoice Disc.")
        {
            Caption = 'Allow Invoice Disc.';
        }
        modify("Gross Weight")
        {
            Caption = 'Gross Weight';
        }
        modify("Net Weight")
        {
            Caption = 'Net Weight';
        }
        modify("Units per Parcel")
        {
            Caption = 'Units per Parcel';
        }
        modify("Unit Volume")
        {
            Caption = 'Unit Volume';
        }
        modify("Appl.-to Item Entry")
        {
            Caption = 'Appl.-to Item Entry';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Customer Price Group")
        {
            Caption = 'Customer Price Group';

            //Unsupported feature: Property Modification (Editable) on ""Customer Price Group"(Field 42)".

        }
        modify("Job No.")
        {
            Caption = 'Job No.';

            //Unsupported feature: Property Modification (Editable) on ""Job No."(Field 45)".

        }
        modify("Work Type Code")
        {
            Caption = 'Work Type Code';
        }
        modify("Outstanding Amount")
        {
            Caption = 'Outstanding Amount';

            //Unsupported feature: Property Modification (Editable) on ""Outstanding Amount"(Field 57)".

        }
        modify("Qty. Shipped Not Invoiced")
        {
            Caption = 'Qty. Shipped Not Invoiced';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Shipped Not Invoiced"(Field 58)".

        }
        modify("Shipped Not Invoiced")
        {
            Caption = 'Shipped Not Invoiced';

            //Unsupported feature: Property Modification (Editable) on ""Shipped Not Invoiced"(Field 59)".

        }
        modify("Quantity Shipped")
        {
            Caption = 'Quantity Shipped';

            //Unsupported feature: Property Modification (Editable) on ""Quantity Shipped"(Field 60)".

        }
        modify("Quantity Invoiced")
        {
            Caption = 'Quantity Invoiced';

            //Unsupported feature: Property Modification (Editable) on ""Quantity Invoiced"(Field 61)".

        }
        modify("Shipment No.")
        {
            Caption = 'Shipment No.';

            //Unsupported feature: Property Modification (Editable) on ""Shipment No."(Field 63)".

        }
        modify("Shipment Line No.")
        {
            Caption = 'Shipment Line No.';

            //Unsupported feature: Property Modification (Editable) on ""Shipment Line No."(Field 64)".

        }
        modify("Profit %")
        {
            Caption = 'Profit %';

            //Unsupported feature: Property Modification (Editable) on ""Profit %"(Field 67)".

        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';

            //Unsupported feature: Property Modification (Editable) on ""Bill-to Customer No."(Field 68)".

        }
        modify("Inv. Discount Amount")
        {
            Caption = 'Inv. Discount Amount';

            //Unsupported feature: Property Modification (Editable) on ""Inv. Discount Amount"(Field 69)".

        }
        modify("Purchase Order No.")
        {
            Caption = 'Purchase Order No.';

            //Unsupported feature: Property Modification (Editable) on ""Purchase Order No."(Field 71)".

        }
        modify("Purch. Order Line No.")
        {
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Purchase Order No."));
            Caption = 'Purch. Order Line No.';

            //Unsupported feature: Property Modification (Editable) on ""Purch. Order Line No."(Field 72)".

        }
        modify("Drop Shipment")
        {
            Caption = 'Drop Shipment';

            //Unsupported feature: Property Modification (Editable) on ""Drop Shipment"(Field 73)".

        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("VAT Calculation Type")
        {
            Caption = 'Tax Calculation Type';
            //OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';

            //Unsupported feature: Property Modification (OptionString) on ""VAT Calculation Type"(Field 77)".


            //Unsupported feature: Property Modification (Editable) on ""VAT Calculation Type"(Field 77)".

        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
        }
        modify("Transport Method")
        {
            Caption = 'Transport Method';
        }
        modify("Attached to Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."));
            Caption = 'Attached to Line No.';

            //Unsupported feature: Property Modification (Editable) on ""Attached to Line No."(Field 80)".

        }
        modify("Exit Point")
        {
            Caption = 'Exit Point';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("Transaction Specification")
        {
            Caption = 'Transaction Specification';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';

            //Unsupported feature: Property Insertion (Editable) on ""Tax Liable"(Field 86)".

        }
        modify("Tax Group Code")
        {
            Caption = 'Tax Group Code';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Tax Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Tax Prod. Posting Group';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';

            //Unsupported feature: Property Modification (Editable) on ""Currency Code"(Field 91)".

        }
        modify("Outstanding Amount (LCY)")
        {
            Caption = 'Outstanding Amount ($)';

            //Unsupported feature: Property Modification (Editable) on ""Outstanding Amount (LCY)"(Field 92)".

        }
        modify("Shipped Not Invoiced (LCY)")
        {
            Caption = 'Shipped Not Invoiced ($)';

            //Unsupported feature: Property Modification (Editable) on ""Shipped Not Invoiced (LCY)"(Field 93)".

        }
        modify("Reserved Quantity")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Quantity"(Field 95)".

            Caption = 'Reserved Quantity';

            //Unsupported feature: Property Modification (Editable) on ""Reserved Quantity"(Field 95)".

        }
        modify(Reserve)
        {
            Caption = 'Reserve';
            //OptionCaption = 'Never,Optional,Always';
        }
        modify("Blanket Order No.")
        {

            //Unsupported feature: Property Modification (TestTableRelation) on ""Blanket Order No."(Field 97)".

            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"), "Document No." = FIELD("Blanket Order No."));

            //Unsupported feature: Property Modification (TestTableRelation) on ""Blanket Order Line No."(Field 98)".

            Caption = 'Blanket Order Line No.';
        }
        modify("VAT Base Amount")
        {
            Caption = 'Tax Base Amount';

            //Unsupported feature: Property Modification (Editable) on ""VAT Base Amount"(Field 99)".

        }
        modify("Unit Cost")
        {
            Caption = 'Unit Cost';

            //Unsupported feature: Property Modification (Editable) on ""Unit Cost"(Field 100)".

        }
        modify("System-Created Entry")
        {
            Caption = 'System-Created Entry';

            //Unsupported feature: Property Modification (Editable) on ""System-Created Entry"(Field 101)".

        }
        modify("Line Amount")
        {
            Caption = 'Line Amount';
        }
        modify("VAT Difference")
        {
            Caption = 'Tax Difference';

            //Unsupported feature: Property Modification (Editable) on ""VAT Difference"(Field 104)".

        }
        modify("Inv. Disc. Amount to Invoice")
        {
            Caption = 'Inv. Disc. Amount to Invoice';

            //Unsupported feature: Property Modification (Editable) on ""Inv. Disc. Amount to Invoice"(Field 105)".

        }
        modify("VAT Identifier")
        {
            Caption = 'Tax Identifier';

            //Unsupported feature: Property Modification (Editable) on ""VAT Identifier"(Field 106)".

        }
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
            //OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.';

            //Unsupported feature: Property Modification (OptionString) on ""IC Partner Ref. Type"(Field 107)".

        }
        modify("IC Partner Reference")
        {
            Caption = 'IC Partner Reference';
        }
        modify("Prepayment %")
        {
            Caption = 'Prepayment %';
        }
        modify("Prepmt. Line Amount")
        {
            Caption = 'Prepmt. Line Amount';
        }
        modify("Prepmt. Amt. Inv.")
        {
            Caption = 'Prepmt. Amt. Inv.';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. Amt. Inv."(Field 111)".

        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            Caption = 'Prepmt. Amt. Incl. Tax';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. Amt. Incl. VAT"(Field 112)".

        }
        modify("Prepayment Amount")
        {
            Caption = 'Prepayment Amount';

            //Unsupported feature: Property Modification (Editable) on ""Prepayment Amount"(Field 113)".

        }
        modify("Prepmt. VAT Base Amt.")
        {
            Caption = 'Prepmt. Tax Base Amt.';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. VAT Base Amt."(Field 114)".

        }
        modify("Prepayment VAT %")
        {
            Caption = 'Prepayment Tax %';

            //Unsupported feature: Property Modification (Editable) on ""Prepayment VAT %"(Field 115)".

        }
        modify("Prepmt. VAT Calc. Type")
        {
            Caption = 'Prepmt. Tax Calc. Type';
            //OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';

            //Unsupported feature: Property Modification (OptionString) on ""Prepmt. VAT Calc. Type"(Field 116)".


            //Unsupported feature: Property Modification (Editable) on ""Prepmt. VAT Calc. Type"(Field 116)".

        }
        modify("Prepayment VAT Identifier")
        {
            Caption = 'Prepayment Tax Identifier';

            //Unsupported feature: Property Modification (Editable) on ""Prepayment VAT Identifier"(Field 117)".

        }
        modify("Prepayment Tax Area Code")
        {
            Caption = 'Prepayment Tax Area Code';
        }
        modify("Prepayment Tax Liable")
        {
            Caption = 'Prepayment Tax Liable';
        }
        modify("Prepayment Tax Group Code")
        {
            Caption = 'Prepayment Tax Group Code';
        }
        modify("Prepmt Amt to Deduct")
        {
            Caption = 'Prepmt Amt to Deduct';
        }
        modify("Prepmt Amt Deducted")
        {
            Caption = 'Prepmt Amt Deducted';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt Amt Deducted"(Field 122)".

        }
        modify("Prepayment Line")
        {
            Caption = 'Prepayment Line';

            //Unsupported feature: Property Modification (Editable) on ""Prepayment Line"(Field 123)".

        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. Tax';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. Amount Inv. Incl. VAT"(Field 124)".

        }
        modify("Prepmt. Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. Amount Inv. ($)';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. Amount Inv. (LCY)"(Field 129)".

        }
        modify("IC Partner Code")
        {
            Caption = 'IC Partner Code';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            Caption = 'Prepmt. Tax Amount Inv. ($)';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt. VAT Amount Inv. (LCY)"(Field 132)".

        }
        modify("Prepayment VAT Difference")
        {
            Caption = 'Prepayment Tax Difference';

            //Unsupported feature: Property Modification (Editable) on ""Prepayment VAT Difference"(Field 135)".

        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            Caption = 'Prepmt Tax Diff. to Deduct';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt VAT Diff. to Deduct"(Field 136)".

        }
        modify("Prepmt VAT Diff. Deducted")
        {
            Caption = 'Prepmt Tax Diff. Deducted';

            //Unsupported feature: Property Modification (Editable) on ""Prepmt VAT Diff. Deducted"(Field 137)".

        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';

            //Unsupported feature: Property Modification (Editable) on ""Dimension Set ID"(Field 480)".

        }
        modify("Qty. to Assemble to Order")
        {
            Caption = 'Qty. to Assemble to Order';
        }
        modify("Qty. to Asm. to Order (Base)")
        {
            Caption = 'Qty. to Asm. to Order (Base)';
        }
        modify("ATO Whse. Outstanding Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""ATO Whse. Outstanding Qty."(Field 902)".

            Caption = 'ATO Whse. Outstanding Qty.';


            //Unsupported feature: Property Modification (Editable) on ""ATO Whse. Outstanding Qty."(Field 902)".

        }
        modify("ATO Whse. Outstd. Qty. (Base)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""ATO Whse. Outstd. Qty. (Base)"(Field 903)".

            Caption = 'ATO Whse. Outstd. Qty. (Base)';


            //Unsupported feature: Property Modification (Editable) on ""ATO Whse. Outstd. Qty. (Base)"(Field 903)".

        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';

            //Unsupported feature: Property Modification (Editable) on ""Job Task No."(Field 1001)".

        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';

            //Unsupported feature: Property Modification (Editable) on ""Job Contract Entry No."(Field 1002)".

        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Bin Code")
        {
            TableRelation = IF ("Document Type" = FILTER(Order | Invoice), Quantity = FILTER(>= 0), "Qty. to Asm. to Order (Base)" = CONST(0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"), "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Code")) ELSE IF ("Document Type" = FILTER("Return Order" | "Credit Memo"), Quantity = FILTER(< 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"), "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Code")) ELSE
            Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            Caption = 'Bin Code';
        }
        modify("Qty. per Unit of Measure")
        {
            Caption = 'Qty. per Unit of Measure';

            //Unsupported feature: Property Modification (Editable) on ""Qty. per Unit of Measure"(Field 5404)".

        }
        modify(Planned)
        {
            Caption = 'Planned';

            //Unsupported feature: Property Modification (Editable) on "Planned(Field 5405)".

        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No.")) ELSE IF (Type = CONST(Resource)) "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("No.")) ELSE
            "Unit of Measure";
            Caption = 'Unit of Measure Code';
        }
        modify("Quantity (Base)")
        {
            Caption = 'Quantity (Base)';
        }
        modify("Outstanding Qty. (Base)")
        {
            Caption = 'Outstanding Qty. (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Outstanding Qty. (Base)"(Field 5416)".

        }
        modify("Qty. to Invoice (Base)")
        {
            Caption = 'Qty. to Invoice (Base)';
        }
        modify("Qty. to Ship (Base)")
        {
            Caption = 'Qty. to Ship (Base)';
        }
        modify("Qty. Shipped Not Invd. (Base)")
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Shipped Not Invd. (Base)"(Field 5458)".

        }
        modify("Qty. Shipped (Base)")
        {
            Caption = 'Qty. Shipped (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Shipped (Base)"(Field 5460)".

        }
        modify("Qty. Invoiced (Base)")
        {
            Caption = 'Qty. Invoiced (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Invoiced (Base)"(Field 5461)".

        }
        modify("Reserved Qty. (Base)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Reserved Qty. (Base)"(Field 5495)".

            Caption = 'Reserved Qty. (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Reserved Qty. (Base)"(Field 5495)".

        }
        modify("FA Posting Date")
        {
            Caption = 'FA Posting Date';
        }
        modify("Depreciation Book Code")
        {
            Caption = 'Depreciation Book Code';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("Use Duplication List")
        {
            Caption = 'Use Duplication List';
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';

            //Unsupported feature: Property Modification (Editable) on ""Responsibility Center"(Field 5700)".

        }
        modify("Out-of-Stock Substitution")
        {
            Caption = 'Out-of-Stock Substitution';

            //Unsupported feature: Property Modification (Editable) on ""Out-of-Stock Substitution"(Field 5701)".

        }
        modify("Substitution Available")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Substitution Available"(Field 5702)".

            Caption = 'Substitution Available';

            //Unsupported feature: Property Modification (Editable) on ""Substitution Available"(Field 5702)".

        }
        modify("Originally Ordered No.")
        {
            Caption = 'Originally Ordered No.';
        }
        modify("Originally Ordered Var. Code")
        {
            Caption = 'Originally Ordered Var. Code';
        }
        /*  modify("Cross-Reference No.")
         {
             Caption = 'Cross-Reference No.';
         }
         modify("Unit of Measure (Cross Ref.)")
         {
             Caption = 'Unit of Measure (Cross Ref.)';
         }
         modify("Cross-Reference Type")
         {
             Caption = 'Cross-Reference Type';
             OptionCaption = ' ,Customer,Vendor,Bar Code';

             //Unsupported feature: Property Modification (OptionString) on ""Cross-Reference Type"(Field 5707)".
         }
         modify("Cross-Reference Type No.")
         {
             Caption = 'Cross-Reference Type No.';
         } */
        modify("Item Category Code")
        {
            Caption = 'Item Category Code';
        }
        modify(Nonstock)
        {
            Caption = 'Nonstock';

            //Unsupported feature: Property Modification (Editable) on "Nonstock(Field 5710)".

        }
        modify("Purchasing Code")
        {
            Caption = 'Purchasing Code';
        }
        /* modify("Product Group Code")
        {
            Caption = 'Product Group Code';
        } *///B2BUpg
        modify("Special Order")
        {
            Caption = 'Special Order';

            //Unsupported feature: Property Modification (Editable) on ""Special Order"(Field 5713)".

        }
        modify("Special Order Purchase No.")
        {
            Caption = 'Special Order Purchase No.';
        }
        modify("Special Order Purch. Line No.")
        {
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Special Order Purchase No."));
            Caption = 'Special Order Purch. Line No.';
        }
        modify("Whse. Outstanding Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Whse. Outstanding Qty."(Field 5749)".

            Caption = 'Whse. Outstanding Qty.';


            //Unsupported feature: Property Modification (Editable) on ""Whse. Outstanding Qty."(Field 5749)".

        }
        modify("Whse. Outstanding Qty. (Base)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".

            Caption = 'Whse. Outstanding Qty. (Base)';


            //Unsupported feature: Property Modification (Editable) on ""Whse. Outstanding Qty. (Base)"(Field 5750)".

        }
        modify("Completely Shipped")
        {
            Caption = 'Completely Shipped';

            //Unsupported feature: Property Modification (Editable) on ""Completely Shipped"(Field 5752)".

        }
        modify("Requested Delivery Date")
        {
            Caption = 'Requested Delivery Date';
        }
        modify("Promised Delivery Date")
        {
            Caption = 'Promised Delivery Date';
        }
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Outbound Whse. Handling Time")
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        modify("Planned Delivery Date")
        {
            Caption = 'Planned Delivery Date';
        }
        modify("Planned Shipment Date")
        {
            Caption = 'Planned Shipment Date';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Allow Item Charge Assignment")
        {
            Caption = 'Allow Item Charge Assignment';
        }
        modify("Qty. to Assign")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Qty. to Assign"(Field 5801)".

            Caption = 'Qty. to Assign';

            //Unsupported feature: Property Modification (Editable) on ""Qty. to Assign"(Field 5801)".

        }
        modify("Qty. Assigned")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Qty. Assigned"(Field 5802)".

            Caption = 'Qty. Assigned';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Assigned"(Field 5802)".

        }
        modify("Return Qty. to Receive")
        {
            Caption = 'Return Qty. to Receive';
        }
        modify("Return Qty. to Receive (Base)")
        {
            Caption = 'Return Qty. to Receive (Base)';
        }
        modify("Return Qty. Rcd. Not Invd.")
        {
            Caption = 'Return Qty. Rcd. Not Invd.';

            //Unsupported feature: Property Modification (Editable) on ""Return Qty. Rcd. Not Invd."(Field 5805)".

        }
        modify("Ret. Qty. Rcd. Not Invd.(Base)")
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';

            //Unsupported feature: Property Modification (Editable) on ""Ret. Qty. Rcd. Not Invd.(Base)"(Field 5806)".

        }
        modify("Return Rcd. Not Invd.")
        {
            Caption = 'Return Rcd. Not Invd.';

            //Unsupported feature: Property Modification (Editable) on ""Return Rcd. Not Invd."(Field 5807)".

        }
        modify("Return Rcd. Not Invd. (LCY)")
        {
            Caption = 'Return Rcd. Not Invd. ($)';

            //Unsupported feature: Property Modification (Editable) on ""Return Rcd. Not Invd. (LCY)"(Field 5808)".

        }
        modify("Return Qty. Received")
        {
            Caption = 'Return Qty. Received';

            //Unsupported feature: Property Modification (Editable) on ""Return Qty. Received"(Field 5809)".

        }
        modify("Return Qty. Received (Base)")
        {
            Caption = 'Return Qty. Received (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Return Qty. Received (Base)"(Field 5810)".

        }
        modify("Appl.-from Item Entry")
        {
            Caption = 'Appl.-from Item Entry';
        }
        modify("BOM Item No.")
        {
            Caption = 'BOM Item No.';
        }
        modify("Return Receipt No.")
        {
            Caption = 'Return Receipt No.';

            //Unsupported feature: Property Modification (Editable) on ""Return Receipt No."(Field 6600)".

        }
        modify("Return Receipt Line No.")
        {
            Caption = 'Return Receipt Line No.';

            //Unsupported feature: Property Modification (Editable) on ""Return Receipt Line No."(Field 6601)".

        }
        modify("Return Reason Code")
        {
            Caption = 'Return Reason Code';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("Customer Disc. Group")
        {
            Caption = 'Customer Disc. Group';
        }






        // field(10000; "Package Tracking No."; Text[30])
        // {
        //     Caption = 'Package Tracking No.';
        // }
        field(50000; "Lot Qty"; Decimal)
        {
        }
        field(50001; "Unit Count"; Decimal)
        {
        }
        field(50002; Each; Decimal)
        {
        }
        field(50006; "Inner UPC"; Text[20])
        {
        }
        field(50007; "Country/Region Purchased Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(50016; "Qty.  Per Pallet"; Decimal)
        {
            Description = 'NUB1.03';
            Editable = false;
        }
        field(50050; "Commission Perc."; Decimal)
        {
            Caption = 'Commission Percentage';
            Description = 'NU1.01';
            Editable = false;
        }
        field(50051; "Salesperson Code"; Code[20])
        {
            CalcFormula = Lookup("Sales Header"."Salesperson Code" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.")));
            Description = 'NU1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; GMO; Boolean)
        {
            Description = 'NUB1.04';
        }
        field(60020; "Allow Qty Change"; Boolean)
        {
            Description = 'FP  system entered and temp';
            Editable = false;
        }
        field(60021; "Original Qty"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'FP  system entered';
            Editable = false;
        }
        field(60022; "Orig Unit of Measure Code"; Code[10])
        {
            Description = 'FP  system entered';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No.")) ELSE
            "Unit of Measure";
        }
        field(60023; "Original Qty (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'FP  system entered';
            Editable = false;
        }
        field(60210; "Outstanding Sales Amt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order)));
            DecimalPlaces = 0 : 2;
            Description = 'FP 6.3';
            FieldClass = FlowField;
        }
        field(60211; "Stop Note"; Boolean)
        {
            Description = 'POPN6.3';
        }
    }
    keys
    {
    }



    procedure "-NUM1.01-"()
    begin
    end;

    procedure AutomataicTracking()
    var
        TrackingSpec: Record "Tracking Specification" temporary;
        ItemTrackingDataCollection: Codeunit "NUB Item Tracking Data Collect";
        CurrentSignFactor: Integer;
        MaxQuantity: Decimal;
        InsertIsBlocked: Boolean;
    begin
        CLEAR(ItemTrackingDataCollection);
        CurrentSignFactor := -1;
        MaxQuantity := "Quantity (Base)";
        InsertIsBlocked := FALSE;

        TrackingSpec.INIT;
        TrackingSpec."Item No." := "No.";
        TrackingSpec."Location Code" := "Location Code";
        TrackingSpec."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
        TrackingSpec."Source ID" := "Document No.";
        TrackingSpec."Source Ref. No." := "Line No.";
        TrackingSpec."Source Type" := 37;
        TrackingSpec."Source Subtype" := 1;

        "Lot Qty" := ItemTrackingDataCollection.SelectLotSerialNo(TrackingSpec, (CurrentSignFactor * TrackingSpec."Quantity (Base)" < 0) AND NOT
          InsertIsBlocked, CurrentSignFactor, 1, MaxQuantity);
    end;



    var
        "-FP-": Integer;
        lvSalesHeaderT: Record "Sales Header";
        //lvDefaultsT: Record "Master File Setup Defaults";//14005001 B2BUPG
        TestQty: Decimal;
        ToleratedQty: Decimal;
        GLSetup: Record "General Ledger Setup";
        Text050: Label 'must be %1 when the Prepayment Invoice has already been posted', Comment = 'starts with a field name; %1 - numeric value';
        Text1020000: Label 'You must reopen the document since this will affect Sales Tax.';
        Text1020003: Label 'The %1 field in the %2 used on the %3 must match the %1 field in the %2 used on the %4.';
        "--FP--": Integer;
        QtyToShip: Decimal;
        FPText000: Label 'Confirm with YES if Original Quantity is also to change.';
        FPText001: Label 'Confirm with YES if you intend to ship more then the original quantity.';
        FPText002: Label 'You have aborted the Qty. to Ship entry.';
        FPText003: Label 'Order must be reopened for tolerated quantity changes.';
        FPText004: Label 'Confirm with YES if this is your final shipment quantity for this line.';
        "--POPN--": Integer;
        ReservEntry: record "Reservation Entry";

        LastSummaryEntryNo: Integer;
        LastReservEntryNo: Integer;
        FullGlobalDataSetExists: Boolean;
        PartialGlobalDataSetExists: Boolean;
        StrictExpirationPosting: boolean;
        TempGlobalReservEntry: record "Reservation Entry";
        TempGlobalEntrySummary: record "Entry Summary";

        CurrBinCode: Code[20];
        CurrItemTrackingCode: Record "Item Tracking Code";
    // NotesCU: Codeunit "Multi-Note";
    // "-NU1.01-": Integer;
    // ProdGroupRec: Record "Product Group";B2BUPG
}

