xmlport 50011 "Export Invoice Data"
{
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Invoice Header"; "Sales Invoice Header")
            {
                XmlName = 'InvoiceHeader';
                fieldelement(InvoiceNo; "Sales Invoice Header"."No.")
                {
                }
                fieldelement(PostingDate; "Sales Invoice Header"."Posting Date")
                {
                }
                fieldelement(CustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                fieldelement(CustomeName; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                fieldelement(Salesperson; "Sales Invoice Header"."Salesperson Code")
                {
                }
                fieldelement(State; "Sales Invoice Header"."Sell-to County")
                {
                }
                fieldelement(Amount; "Sales Invoice Header".Amount)
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

