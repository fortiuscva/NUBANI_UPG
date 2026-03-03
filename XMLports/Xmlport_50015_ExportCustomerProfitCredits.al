xmlport 50015 "Export Customer Profit-Credits"
{
    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                XmlName = 'SalesCreditMemo';
                fieldelement(Date; "Sales Cr.Memo Line"."Posting Date")
                {
                }
                fieldelement(CustNo; "Sales Cr.Memo Line"."Sell-to Customer No.")
                {
                }
                fieldelement(InvoiceNo; "Sales Cr.Memo Line"."Document No.")
                {
                }
                fieldelement(Type; "Sales Cr.Memo Line".Type)
                {
                }
                fieldelement(No; "Sales Cr.Memo Line"."No.")
                {
                }
                fieldelement(Qty; "Sales Cr.Memo Line".Quantity)
                {
                }
                fieldelement(UnitPrice; "Sales Cr.Memo Line"."Unit Price")
                {
                }
                fieldelement(LineAmount; "Sales Cr.Memo Line"."Line Amount")
                {
                }
                fieldelement(UnitCost; "Sales Cr.Memo Line"."Unit Cost (LCY)")
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

