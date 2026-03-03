pageextension 50064 InventoryPicksExt extends "Inventory Picks"
{
    layout
    {
        addafter("Destination No.")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = all;
            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Customer Name"; "Assigned User ID")
        addafter("Sorting Method")
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}