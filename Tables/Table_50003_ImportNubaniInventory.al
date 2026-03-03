table 50003 "Import Nubani Inventory"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Entry Type"; Option)
        {
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(4; "Document No."; Code[20])
        {
        }
        field(5; "Item No."; Code[20])
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; "Location Code"; Code[20])
        {
        }
        field(8; "Bin Code"; Code[20])
        {
        }
        field(9; Quantity; Decimal)
        {
        }
        field(10; "UOM Code"; Code[20])
        {
        }
        field(11; "Lot No."; Code[20])
        {
        }
        field(12; "Serial No."; Code[20])
        {
        }
        field(13; "Expiration Date"; Date)
        {
        }
        field(100; Processed; Boolean)
        {
        }
        field(200; Skip; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

