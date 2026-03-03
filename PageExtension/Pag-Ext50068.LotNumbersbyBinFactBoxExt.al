pageextension 50068 LotNumbersbyBinFactBoxExt extends "Lot Numbers by Bin FactBox"
{
    layout
    {
        addafter("Zone Code")
        {
            field("Location Code"; Rec."Location Code")
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