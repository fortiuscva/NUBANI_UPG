tableextension 50000 CustomerExt extends Customer
{

    Caption = 'Customer';
    fields
    {
        field(50000; "Cert Expiration Date"; Date)
        {
            Caption = 'Reseller Certificate Expiration Date';
        }
        field(50006; "Customer Type Desc."; Text[80])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code")));
            Caption = 'Customer Type Desc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Collection Comments"; Code[20])
        {
            TableRelation = "Collection Comments".Code;
        }
    }

    keys
    {
        key(Key50000; "Cert Expiration Date")
        {
        }
    }

}

