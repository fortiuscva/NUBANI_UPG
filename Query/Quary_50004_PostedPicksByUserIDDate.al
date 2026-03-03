query 50004 "Posted Picks By User ID&Date"
{
    // NUB1.01,02/04/21,ST: Enhancements to export inventory pick details created by user and date.
    //                       - Created new query.


    elements
    {
        dataitem(QueryElement1100796000; "Posted Invt. Pick Header v1")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            column(Assigned_User_ID; "Assigned User ID")
            {
            }
            column(Count_)
            {
                Method = Count;
            }
            dataitem(QueryElement1100796003; "Posted Invt. Pick Line v1")
            {
                DataItemLink = "No." = QueryElement1100796000."No.";
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}

