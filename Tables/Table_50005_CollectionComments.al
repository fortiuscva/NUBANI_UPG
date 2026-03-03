table 50005 "Collection Comments"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }


}

