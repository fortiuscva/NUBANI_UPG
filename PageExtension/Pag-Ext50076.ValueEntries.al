namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Payables;

pageextension 50076 "Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
