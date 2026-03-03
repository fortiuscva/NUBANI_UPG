page 50056 "Recent Purch. History-No Cost"
{
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
            repeater(Control1000000000)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
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
                Caption = 'Show Doc.';
                Image = View;
                ApplicationArea = all;
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
            //     RunObject = Page "Recent Purch. Credit History";//14005140 B2BUPG
            //     RunPageLink = "Buy-from Vendor No." = FIELD ("Buy-from Vendor No."),
            //                   Type = FIELD (Type),
            //                   "No." = FIELD ("No.");
            //     RunPageView = SORTING ("Buy-from Vendor No.", Type, "No.", "Posting Date");
            // }//B2BUPG
        }
    }
}

