xmlport 50006 "Bin Code"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Bin; Bin)
            {
                XmlName = 'Bin';
                fieldelement(Location; Bin."Location Code")
                {
                    FieldValidate = no;
                }
                fieldelement(BinCode; Bin.Code)
                {
                    FieldValidate = no;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

