page 50003 "Posted Invt. Pick List v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P7395.

    Caption = 'Posted Invt. Pick List';
    CardPageID = "Posted Invt. Pick v1";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Invt. Pick Header v1";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Invt Pick No."; Rec."Invt Pick No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = all;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ick")
            {
                Caption = 'P&ick';
                Image = CreateInventoryPickup;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = all;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Posted Invt. Pick"),
                                  Type = CONST(" "),
                                  "No." = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    // Navigate;
                end;
            }
        }
    }
}

