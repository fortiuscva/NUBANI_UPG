#pragma implicitwith disable
page 50209 "Recent Purch. History"
{
    // Runumbered from 14005138
    // For use with Navision ATTAIN ver. 3.01 or above.
    // Copyright (c) 2001-2002 Cost Control Software, Incorporated by Richard N. Baxter, Jr.
    // Carmel, Indiana  46033
    // www.costcontrolsoftware.com
    // //Posted Line Lookup
    // //PLL4  Change the Sort Key to:
    //            Buy-from Vendor No.,Type,No.,Posting Date
    // //PLL5.01  Change Sort to use new Posting Date

    DataCaptionFields = "Buy-from Vendor No.", Type, "No.", Description;
    Editable = false;
    PageType = List;
    SourceTable = "Purch. Inv. Line";
    SourceTableView = SORTING("Buy-from Vendor No.", Type, "No.", "Posting Date")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000022>")
            {
                ApplicationArea = All;
                Caption = 'Show Doc.';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Purchase Invoice";
                RunPageLink = "No." = FIELD("Document No.");
                RunPageView = SORTING("No.");
            }
            // action("<Action1000000023>")
            // {
            //     Caption = 'Show Credits';
            //     Image = View;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page 14005140;
            //     RunPageLink = "Buy-from Vendor No." = FIELD("Buy-from Vendor No."),
            //                   "Type" = FIELD("Type"),
            //                   "No." = FIELD("No.");
            //     RunPageView = SORTING("Buy-from Vendor No.", Type, "No.", "Posting Date");
            // }
        }
    }
}

