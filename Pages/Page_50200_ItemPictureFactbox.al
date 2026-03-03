page 50200 "Item Picture Factbox"  //14005167 id has been replaced with customized page id as 50200 by B2BUPG
{
    // NUB1.01,04/27/18,SK: Added new field as "Picture 2"

    Editable = false;
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; rec."No.")
            {
                ApplicationArea = All;
            }
            field(Picture; rec.Picture)
            {
                ApplicationArea = All;
            }
            field("Picture 2"; rec."Picture 2")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

