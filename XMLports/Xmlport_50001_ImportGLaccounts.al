xmlport 50001 "Import GL accounts"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Account"; "G/L Account")
            {
                XmlName = 'GL_Accounts';
                fieldelement(Account_No; "G/L Account"."No.")
                {
                }
                fieldelement(Name; "G/L Account".Name)
                {
                }
                fieldelement(Income_Balance; "G/L Account"."Search Name")
                {
                }
                fieldelement(Account_Type; "G/L Account"."Income/Balance")
                {
                }
                fieldelement(Root; "G/L Account"."Account Type")
                {
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

