xmlport 50012 "Export Credit Memo Data"
{
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                XmlName = 'SalesCreditMemo';
                fieldelement(No; "Sales Cr.Memo Header"."No.")
                {
                }
                fieldelement(Date; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                fieldelement(CustNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
                {
                }
                fieldelement(CustName; "Sales Cr.Memo Header"."Sell-to Customer Name")
                {
                }
                fieldelement(Salesperson; "Sales Cr.Memo Header"."Salesperson Code")
                {
                }
                fieldelement(State; "Sales Cr.Memo Header"."Sell-to County")
                {
                }
                fieldelement(Amount; "Sales Cr.Memo Header".Amount)
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

