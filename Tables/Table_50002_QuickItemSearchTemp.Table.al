table 50002 "Quick Item Search Temp Table"
{
    // NUB1.01,SP2357,09/17/12,DRH:  New table for Quick Item Entry.


    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Item Description"; Text[100])
        {
        }
        field(3; UOM; Code[10])
        {
        }
        field(4; "Unit Price"; Decimal)
        {
        }
        field(5; "On Hand"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(6; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(7; "User ID"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

