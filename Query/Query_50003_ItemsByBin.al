query 50003 "Items By Bin"
{
    // NUB1.01,08/15/19,ST: Modifications handled for phys. inventory journal enhancement's.
    //                       - Created new query. This query is used on report 790 to speed up the performance when there is bin filter.

    OrderBy = Ascending(Bin_Code);

    elements
    {
        dataitem(QueryElement4; "Bin Content")
        {
            column(Bin_Code; "Bin Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Sum_Quantity_Base; "Quantity (Base)")
            {
                ColumnFilter = Sum_Quantity_Base = FILTER(<> 0);
                Method = Sum;
            }
        }
    }
}

