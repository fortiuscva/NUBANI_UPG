xmlport 50003 "Import Customers"
{
    FieldDelimiter = '<>';
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Customer; Customer)
            {
                AutoSave = false;
                XmlName = 'Cust';
                fieldelement(f1; Customer."No.")
                {
                }
                fieldelement(f2; Customer.Name)
                {
                }
                fieldelement(f3; Customer.Address)
                {
                }
                fieldelement(f4; Customer."Phone No.")
                {
                }
                fieldelement(f5; Customer."Post Code")
                {
                }
                fieldelement(f6; Customer."Tax Exemption No.")
                {
                }
                fieldelement(f7; Customer."Salesperson Code")
                {
                    FieldValidate = no;
                }

                trigger OnBeforeInsertRecord()
                begin
                    CustRec.INIT;
                    CustRec."No." := Customer."No.";
                    CustRec.VALIDATE(Name, Customer.Name);
                    CustRec.Address := Customer.Address;
                    CustRec."Phone No." := Customer."Phone No.";
                    CustRec.VALIDATE("Post Code", Customer."Post Code");
                    CustRec."Tax Exemption No." := Customer."Tax Exemption No.";
                    CustRec."Salesperson Code" := Customer."Salesperson Code";
                    CustRec.INSERT;
                end;
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

    var
        CustRec: Record Customer;
}

