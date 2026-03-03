pageextension 50075 "Lot Numbers by Bin FB Ext" extends "Lot Numbers by Bin FactBox"//9126
{
    layout
    {
        addafter("Qty. (Base)")
        {
            field("Available Qty. to Take"; Rec."Available Qty. to Take")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}