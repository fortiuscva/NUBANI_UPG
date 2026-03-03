table 50000 "Posted Invt. Pick Header v1"
{

    Caption = 'Posted Invt. Pick Header';


    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;

        }
        field(4; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';

        }
        field(5; "Assignment Date"; Date)
        {
            Caption = 'Assignment Date';
        }
        field(6; "Assignment Time"; Time)
        {
            Caption = 'Assignment Time';
        }
        field(8; "Registering Date"; Date)
        {
            Caption = 'Registering Date';
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;

        }
        field(10; Comment; Boolean)
        {

            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Invt Pick No."; Code[20])
        {
            Caption = 'Invt Pick No.';
        }
        field(12; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7306; "Source No."; Code[20])
        {
            Caption = 'Source No.';

        }
        field(7307; "Source Document"; Option)
        {

            Caption = 'Source Document';
            OptionCaption = ' ,Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,Prod. Output';
            OptionMembers = " ","Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order","Inbound Transfer","Outbound Transfer","Prod. Consumption","Prod. Output";
        }
        field(7308; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(7309; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(7310; "Destination Type"; Option)
        {
            Caption = 'Destination Type';
            OptionCaption = ' ,Customer,Vendor,Location,Item,Family,Sales Order';
            OptionMembers = " ",Customer,Vendor,Location,Item,Family,"Sales Order";
        }
        field(7311; "Destination No."; Code[20])
        {
            Caption = 'Destination No.';

        }
        field(7312; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(7314; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(7315; "External Document No.2"; Code[35])
        {
            Caption = 'External Document No.2';
        }
        field(50006; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';

        }
        field(50007; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Invt Pick No.")
        {
        }
        key(Key3; "Location Code")
        {
        }
    }

    fieldgroups
    {
    }


}

