table 50004 "Delete Bins"
{

    fields
    {
        field(1; "Bin Code"; Code[20])
        {
        }
        field(2; Processed; Boolean)
        {
        }
        field(3; "Error Text"; Text[250])
        {
        }
        field(4; "Error Text 2"; Text[250])
        {
        }
        field(5; "Error Text 3"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Bin Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

