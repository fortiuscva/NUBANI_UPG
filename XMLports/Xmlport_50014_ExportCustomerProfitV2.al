xmlport 50014 "Export Customer Profit-V2"
{
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Invoice Line"; "Sales Invoice Line")
            {
                XmlName = 'SalesInvoiceLines';
                fieldelement(Date; "Sales Invoice Line"."Posting Date")
                {
                }
                fieldelement(CustNo; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                fieldelement(InvoiceNo; "Sales Invoice Line"."Document No.")
                {
                }
                fieldelement(Type; "Sales Invoice Line".Type)
                {
                }
                fieldelement(No; "Sales Invoice Line"."No.")
                {
                }
                fieldelement(Qty; "Sales Invoice Line".Quantity)
                {
                }
                fieldelement(UnitPrice; "Sales Invoice Line"."Unit Price")
                {
                }
                fieldelement(LineAmount; "Sales Invoice Line"."Line Amount")
                {
                }
                fieldelement(UnitCost; "Sales Invoice Line"."Unit Cost (LCY)")
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

