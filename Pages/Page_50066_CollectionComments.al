page 50066 "Collection Comments"
{
    PageType = List;
    SourceTable = "Collection Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Comments; rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

