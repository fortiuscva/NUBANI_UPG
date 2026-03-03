query 50000 "WMS-LotsByItemAndLocation"
{

    elements
    {
        dataitem(QueryElement1100796000; "Warehouse Entry")
        {
            column(Item_No; "Item No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Bin_Code; "Bin Code")
            {
            }
            column(Lot_No; "Lot No.")
            {
            }
            column(Expiration_Date; "Expiration Date")
            {
            }
            column(Sum_Qty_Base; "Qty. (Base)")
            {
                Method = Sum;
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            dataitem(QueryElement1100796007; Item)
            {
                DataItemLink = "No." = QueryElement1100796000."Item No.";
                column(Description; Description)
                {
                }
            }
        }
    }
}

