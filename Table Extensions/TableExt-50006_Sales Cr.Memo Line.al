tableextension 50006 SalesCrMemoLineExt extends "Sales Cr.Memo Line"
{

    Caption = 'Sales Cr.Memo Line';
    fields
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';



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



        }
        modify("No.")
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account" ELSE IF (Type = CONST(Item)) Item ELSE IF (Type = CONST(Resource)) Resource ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset" ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
            Caption = 'No.';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group" ELSE IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            Caption = 'Posting Group';



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
        }
        modify("Unit Price")
        {
            Caption = 'Unit Price';
        }
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost ($)';
        }
        modify("VAT %")
        {
            Caption = 'Tax %';



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
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including Tax';
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
        }
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Work Type Code")
        {
            Caption = 'Work Type Code';
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';



        }
        modify("Inv. Discount Amount")
        {
            Caption = 'Inv. Discount Amount';
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
            Caption = 'Attached to Line No.';
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
        modify("Blanket Order No.")
        {



            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"), "Document No." = FIELD("Blanket Order No."));



            Caption = 'Blanket Order Line No.';
        }
        modify("VAT Base Amount")
        {
            Caption = 'Tax Base Amount';



        }
        modify("Unit Cost")
        {
            Caption = 'Unit Cost';



        }
        modify("System-Created Entry")
        {
            Caption = 'System-Created Entry';



        }
        modify("Line Amount")
        {
            Caption = 'Line Amount';
        }
        modify("VAT Difference")
        {
            Caption = 'Tax Difference';
        }
        modify("VAT Identifier")
        {
            Caption = 'Tax Identifier';



        }
        modify("IC Partner Ref. Type")
        {
            Caption = 'IC Partner Ref. Type';
            //OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.';



        }
        modify("IC Partner Reference")
        {
            Caption = 'IC Partner Reference';
        }
        modify("Prepayment Line")
        {
            Caption = 'Prepayment Line';



        }
        modify("IC Partner Code")
        {
            Caption = 'IC Partner Code';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';



        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';

        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';

        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Bin Code")
        {
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"), "Item Filter" = FIELD("No."), "Variant Filter" = FIELD("Variant Code"));
            Caption = 'Bin Code';
        }
        modify("Qty. per Unit of Measure")
        {
            Caption = 'Qty. per Unit of Measure';



        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No.")) ELSE
            "Unit of Measure";
            Caption = 'Unit of Measure Code';
        }
        modify("Quantity (Base)")
        {
            Caption = 'Quantity (Base)';
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
        }
        modify("Item Reference No.")
        {
            Caption = 'Cross-Reference No.';
        }
        /*  modify("Unit of Measure (Cross Ref.)")
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
         } *///B2BUpg
        modify("Item Category Code")
        {
            Caption = 'Item Category Code';
        }
        modify(Nonstock)
        {
            Caption = 'Nonstock';
        }
        modify("Purchasing Code")
        {
            Caption = 'Purchasing Code';
        }
        /* modify("Product Group Code")
        {
            Caption = 'Product Group Code';
        } *///B2BUpg
        modify("Appl.-from Item Entry")
        {
            Caption = 'Appl.-from Item Entry';
        }
        modify("Return Receipt No.")
        {
            Caption = 'Return Receipt No.';



        }
        modify("Return Receipt Line No.")
        {
            Caption = 'Return Receipt Line No.';



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

        field(50001; "Unit Count"; Decimal)
        {
        }
        field(50002; Each; Decimal)
        {
        }
        field(50050; "Commission Perc."; Decimal)
        {
            Caption = 'Commission Percentage';
            Description = 'NU1.01';
            Editable = false;
        }
        field(50051; "Salesperson Code"; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Salesperson Code" WHERE("No." = FIELD("Document No.")));
            Description = 'NU1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; GMO; Boolean)
        {
            Description = 'NUB1.02';
        }
    }
    keys
    {
    }



}

