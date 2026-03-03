table 50001 "Posted Invt. Pick Line v1"
{
    // NUB1.01,5/1/13,OAS: Copy of T7343.

    Caption = 'Posted Invt. Pick Line';


    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(5; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(7; "Source Line No."; Integer)
        {

            Caption = 'Source Line No.';
        }
        field(8; "Source Subline No."; Integer)
        {

            Caption = 'Source Subline No.';
        }
        field(9; "Source Document"; Option)
        {

            Caption = 'Source Document';
            OptionCaption = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output';
            OptionMembers = ,"Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order","Inbound Transfer","Outbound Transfer","Prod. Consumption","Prod. Output";
        }
        field(11; "Location Code"; Code[10])
        {
            Caption = 'Location Code';

        }
        field(12; "Shelf No."; Code[10])
        {
            Caption = 'Shelf No.';
        }
        field(13; "Sorting Sequence No."; Integer)
        {
            Caption = 'Sorting Sequence No.';
        }
        field(14; "Item No."; Code[20])
        {
            Caption = 'Item No.';

        }
        field(15; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';

        }
        field(16; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';

        }
        field(17; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(18; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(19; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;


        }
        field(21; "Qty. (Base)"; Decimal)
        {
            Caption = 'Qty. (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(31; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(34; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(39; "Destination Type"; Option)
        {
            Caption = 'Destination Type';
            OptionCaption = ' ,Customer,Vendor,Location,Item,Family,Sales Order';
            OptionMembers = " ",Customer,Vendor,Location,Item,Family,"Sales Order";
        }
        field(40; "Destination No."; Code[20])
        {
            Caption = 'Destination No.';

        }
        field(41; "Whse. Activity No."; Code[20])
        {
            Caption = 'Whse. Activity No.';
        }
        field(42; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';

        }
        field(43; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';

        }
        field(44; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';

        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';


        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';


        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(7300; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

        }
        field(7301; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';

        }
        field(7305; "Action Type"; Option)
        {
            Caption = 'Action Type';
            Editable = false;
            OptionCaption = ' ,Take,Place';
            OptionMembers = " ",Take,Place;
        }
        field(7312; "Special Equipment Code"; Code[10])
        {
            Caption = 'Special Equipment Code';

        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Sorting Sequence No.")
        {
        }
        key(Key3; "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.")
        {
        }
    }

    fieldgroups
    {
    }


}

