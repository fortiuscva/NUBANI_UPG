tableextension 50034 PurchRcptLineExt extends "Purch. Rcpt. Line"
{

    Caption = 'Purch. Rcpt. Line';
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';

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
            //OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';



        }
        modify("No.")
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account" ELSE IF (Type = CONST(Item)) Item ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset" ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
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
        modify("Expected Receipt Date")
        {
            Caption = 'Expected Receipt Date';
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
        modify("Direct Unit Cost")
        {
            Caption = 'Direct Unit Cost';
        }
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost (LCY)';
        }
        modify("VAT %")
        {
            Caption = 'VAT %';

            //Unsupported feature: Property Modification (Editable) on ""VAT %"(Field 25)".

        }
        modify("Line Discount %")
        {
            Caption = 'Line Discount %';
        }
        modify("Unit Price (LCY)")
        {
            Caption = 'Unit Price (LCY)';
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
        modify("Item Rcpt. Entry No.")
        {
            Caption = 'Item Rcpt. Entry No.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Indirect Cost %")
        {
            Caption = 'Indirect Cost %';
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            Caption = 'Qty. Rcd. Not Invoiced';



        }
        modify("Quantity Invoiced")
        {
            Caption = 'Quantity Invoiced';



        }
        modify("Order No.")
        {
            Caption = 'Order No.';
        }
        modify("Order Line No.")
        {
            Caption = 'Order Line No.';
        }
        modify("Pay-to Vendor No.")
        {
            Caption = 'Pay-to Vendor No.';
        }
        modify("Vendor Item No.")
        {
            Caption = 'Vendor Item No.';
        }
        modify("Sales Order No.")
        {
            Caption = 'Sales Order No.';
        }
        modify("Sales Order Line No.")
        {
            Caption = 'Sales Order Line No.';
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
            Caption = 'VAT Calculation Type';
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
        modify("Entry Point")
        {
            Caption = 'Entry Point';
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
        modify("Use Tax")
        {
            Caption = 'Use Tax';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';

            //Unsupported feature: Property Modification (Editable) on ""Currency Code"(Field 91)".

        }
        modify("Blanket Order No.")
        {

            //Unsupported feature: Property Modification (TestTableRelation) on ""Blanket Order No."(Field 97)".

            Caption = 'Blanket Order No.';
        }
        modify("Blanket Order Line No.")
        {
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"), "Document No." = FIELD("Blanket Order No."));

            //Unsupported feature: Property Modification (TestTableRelation) on ""Blanket Order Line No."(Field 98)".

            Caption = 'Blanket Order Line No.';
        }
        modify("VAT Base Amount")
        {
            Caption = 'VAT Base Amount';


        }
        modify("Unit Cost")
        {
            Caption = 'Unit Cost';



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
        modify("Job Line Type")
        {
            Caption = 'Job Line Type';
            //OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';

        }
        modify("Job Unit Price")
        {
            Caption = 'Job Unit Price';

        }
        modify("Job Total Price")
        {
            Caption = 'Job Total Price';

        }
        modify("Job Line Amount")
        {
            Caption = 'Job Line Amount';

        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';

        }
        modify("Job Line Discount %")
        {
            Caption = 'Job Line Discount %';

        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';

        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';

        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';

        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';

        }
        modify("Job Currency Factor")
        {
            Caption = 'Job Currency Factor';

        }
        modify("Job Currency Code")
        {
            Caption = 'Job Currency Code';
        }
        modify("Prod. Order No.")
        {



            Caption = 'Prod. Order No.';
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
        modify("Qty. Invoiced (Base)")
        {
            Caption = 'Qty. Invoiced (Base)';



        }
        modify("FA Posting Date")
        {
            Caption = 'FA Posting Date';
        }
        modify("FA Posting Type")
        {
            Caption = 'FA Posting Type';
            //OptionCaption = ' ,Acquisition Cost,Maintenance';

        }
        modify("Depreciation Book Code")
        {
            Caption = 'Depreciation Book Code';
        }
        modify("Salvage Value")
        {
            Caption = 'Salvage Value';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Depr. Acquisition Cost")
        {
            Caption = 'Depr. Acquisition Cost';
        }
        modify("Maintenance Code")
        {
            Caption = 'Maintenance Code';
        }
        modify("Insurance No.")
        {
            Caption = 'Insurance No.';
        }
        modify("Budgeted FA No.")
        {
            Caption = 'Budgeted FA No.';
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
        /*  modify("Product Group Code")
         {
             Caption = 'Product Group Code';
         } *///B2BUpg
        modify("Special Order Sales No.")
        {
            Caption = 'Special Order Sales No.';
        }
        modify("Special Order Sales Line No.")
        {
            Caption = 'Special Order Sales Line No.';
        }
        modify("Requested Receipt Date")
        {
            Caption = 'Requested Receipt Date';
        }
        modify("Promised Receipt Date")
        {
            Caption = 'Promised Receipt Date';
        }
        modify("Lead Time Calculation")
        {
            Caption = 'Lead Time Calculation';
        }
        modify("Inbound Whse. Handling Time")
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        modify("Planned Receipt Date")
        {
            Caption = 'Planned Receipt Date';
        }
        modify("Order Date")
        {
            Caption = 'Order Date';
        }
        modify("Item Charge Base Amount")
        {
            Caption = 'Item Charge Base Amount';
        }
        modify(Correction)
        {
            Caption = 'Correction';

        }
        modify("Return Reason Code")
        {
            Caption = 'Return Reason Code';
        }
        modify("Routing No.")
        {
            Caption = 'Routing No.';
        }
        modify("Operation No.")
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE(Status = FILTER(Released ..), "Prod. Order No." = FIELD("Prod. Order No."), "Routing No." = FIELD("Routing No."));
            Caption = 'Operation No.';
        }
        modify("Work Center No.")
        {
            Caption = 'Work Center No.';
        }
        modify("Prod. Order Line No.")
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FILTER(Released ..), "Prod. Order No." = FIELD("Prod. Order No."));
            Caption = 'Prod. Order Line No.';
        }
        modify("Overhead Rate")
        {
            Caption = 'Overhead Rate';
        }
        modify("Routing Reference No.")
        {
            Caption = 'Routing Reference No.';
        }
        field(50000; "Expected Receipt Time"; Time)
        {
        }
        field(60020; "Allow Qty Change"; Boolean)
        {
            Description = 'FP  system entered and temp';
        }
        field(60021; "Original Qty"; Decimal)
        {
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
        field(60033; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Description = 'Original PO No.';
        }
    }
    keys
    {


    }





}

