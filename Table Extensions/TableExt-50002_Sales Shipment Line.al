tableextension 50002 SalesShipmentLineExt extends "Sales Shipment Line"
{

    // //FP  Added new key: Posting Date
    //       Added four fields 60020 to 60023 - for Over under Ship
    // NU1.01,19-Feb-16,ST: Added new fields 50050/Commission Perc., 50051/Salesperson Code(flow field) to the table.
    // NUB1.02,10/03/18,SK: Added new filed as 50016/"Qty. Per Pallet".
    // NUB1.03,04/24/19,ST: Modifications handled to track GMO fron item and use it on sales documents.
    //                        - Added field 50055/GMO.
    //                        - Added code in "No. - OnValidate()".



    Caption = 'Sales Shipment Line';
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
        modify("Item Shpt. Entry No.")
        {
            Caption = 'Item Shpt. Entry No.';
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
        modify("Qty. Shipped Not Invoiced")
        {
            Caption = 'Qty. Shipped Not Invoiced';

            //Unsupported feature: Property Modification (Editable) on ""Qty. Shipped Not Invoiced"(Field 58)".

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
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';

        }
        modify("Purchase Order No.")
        {
            Caption = 'Purchase Order No.';
        }
        modify("Purch. Order Line No.")
        {
            Caption = 'Purch. Order Line No.';
        }
        modify("Drop Shipment")
        {
            Caption = 'Drop Shipment';
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
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';

        }
        modify("Authorized for Credit Card")
        {
            Caption = 'Authorized for Credit Card';
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
        modify("Qty. Invoiced (Base)")
        {
            Caption = 'Qty. Invoiced (Base)';



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
        /*  modify("Item Reference No.")
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
        modify("Appl.-from Item Entry")
        {
            Caption = 'Appl.-from Item Entry';
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
        field(50016; "Qty.  Per Pallet"; Decimal)
        {
            Description = 'NUB1.02';
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
            CalcFormula = Lookup("Sales Shipment Header"."Salesperson Code" WHERE("No." = FIELD("Document No.")));
            Description = 'NU1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; GMO; Boolean)
        {
            Description = 'NUB1.03';
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
    }
    keys
    {


    }


    procedure NUBStartTrackingSite()
    var
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        SalesShptHeader.GET("Document No.");
        //SalesShptHeader.StartTrackingSite("Package Tracking No.");
        SalesShptHeader.StartTrackingSite();
    end;


}

