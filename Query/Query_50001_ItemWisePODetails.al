query 50001 "Item Wise PO Details"
{
    // NUB1.01,09/28/18,SK: Created new Query.


    elements
    {
        dataitem(QueryElement1100796010; "Purchase Line")
        {
            DataItemTableFilter = Type = CONST(Item);
            column(Document_No; "Document No.")
            {
            }
            column(Line_No; "Line No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Direct_Unit_Cost; "Direct Unit Cost")
            {
            }
        }
    }
}

