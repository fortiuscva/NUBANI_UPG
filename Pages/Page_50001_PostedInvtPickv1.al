page 50001 "Posted Invt. Pick v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P7392.
    // NUB1.02,10/22/18,SK: Addd new field as "Requested Delivery Date" & "Shipping Agent Code".
    ApplicationArea = All;
    Caption = 'Posted Invt. Pick';
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Posted Invt. Pick Header v1";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 0));
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Destination Type"; Rec."Destination No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 1));
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 2));
                    ApplicationArea = all;
                }
                field("External Document No.2"; Rec."External Document No.2")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 3));
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
            part(WhseActivityLines; "Posted Invt. Pick Subform v1")
            {
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "Sorting Sequence No.");
                ApplicationArea = all;
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
                    //Navigate;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE;
    end;

    var
        WMSMgt: Codeunit "WMS Management";
}

