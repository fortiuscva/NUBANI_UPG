page 50010 "Quick Item Entry Subform"
{
    // NUB1.01,SP2357,09/17/12,DRH:  New page for Quick Item Entry.

    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    Permissions = TableData "Quick Item Search Temp Table" = rimd;
    RefreshOnActivate = false;
    ShowFilter = false;
    SourceTable = "Quick Item Search Temp Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("On Hand"; Rec."On Hand")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.MODIFY;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("User ID", USERID);
    end;
}

