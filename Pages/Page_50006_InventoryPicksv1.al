page 50006 "Inventory Picks v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P9316.
    // NUB1.02,02/19/19,SK: Pullout field as "Customer Name" & "Creation Date".

    Caption = 'Inventory Picks';
    CardPageID = "Inventory Pick v1";
    Editable = false;
    PageType = List;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = WHERE(Type = CONST("Invt. Pick"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                /* field("Source Document"; rec."Source Document")
                {
                } */
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Destination Type"; rec."Destination Type")
                {
                    ApplicationArea = all;
                }
                field("Destination No."; rec."Destination No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("No. of Lines"; rec."No. of Lines")
                {
                    ApplicationArea = all;
                }
                field("Sorting Method"; rec."Sorting Method")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Date of Last Printing"; rec."Date of Last Printing")
                {
                    ApplicationArea = all;
                }
                field("Time of Last Printing"; rec."Time of Last Printing")
                {
                    ApplicationArea = all;
                }
                field("No. Printed"; rec."No. Printed")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = all;
                Visible = false;
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
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type),
                                  "No." = FIELD("No.");
                }
                action("Posted Picks")
                {
                    Caption = 'Posted Picks';
                    Image = PostedInventoryPick;
                    ApplicationArea = all;
                    RunObject = Page "Posted Invt. Pick List v1";
                    RunPageLink = "Invt Pick No." = FIELD("No.");
                    RunPageView = SORTING("Invt Pick No.");
                }
                action("Source Document")
                {
                    Caption = 'Source Document';
                    Image = "Order";
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WMSMgt: Codeunit "WMS Management";
                    begin
                        WMSMgt.ShowSourceDocCard(rec."Source Type", rec."Source Subtype", rec."Source No.");
                    end;
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        rec.ErrorIfUserIsNotWhseEmployee;
    end;
}

