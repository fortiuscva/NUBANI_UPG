namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Inventory.Reports;

reportextension 50002 "Availability Status" extends "Availability Status"
{
    dataset
    {
        modify(Item)
        {
            RequestFilterFields = "No.", "Gen. Prod. Posting Group", Description, Blocked;
        }
    }
    requestpage
    {
        trigger OnOpenPage()
        begin
            Item.SetFilter(Blocked, 'FALSE');
        end;
    }
}