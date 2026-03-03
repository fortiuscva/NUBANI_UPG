page 50201 "Recent Sales History"//14005135
{
    // For use with Navision ATTAIN ver. 3.01 or above.
    // Copyright (c) 2001-2002 Cost Control Software, Incorporated by Richard N. Baxter, Jr.
    // Carmel, Indiana  46033
    // www.costcontrolsoftware.com
    // //Posted Line Lookup
    // //PLL4  Change the Sort Key to:
    //            Sell-to Customer No.,Type,No.,Posting Date
    // //PLL5.01  Change Sort to use new Posting Date
    // NU1.01,04/27/18,SK: Added new field as "Sell-to Customer Name".
    ApplicationArea = All;
    DataCaptionFields = "Sell-to Customer No.", "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = SORTING("Sell-to Customer No.", Type, "No.", "Posting Date")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."NUB Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Customer Name';
                }
                field("Document No."; Rec."Document No.")
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
                field("Unit Price"; Rec."Unit Price")
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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
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
            action("&Show Doc.")
            {
                ApplicationArea = All;
                Caption = '&Show Doc.';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Sales Invoice";
                RunPageLink = "No." = FIELD("Document No.");
                RunPageView = SORTING("No.");
            }
            // action("View &Credits")
            // {
            //     Caption = 'View &Credits';
            //     Image = View;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Recent Sales Credit History";//14005136 B2BUPG
            //     RunPageLink = "Sell-to Customer No." = FIELD("Sell-to Customer No."),
            //                   Type = FIELD(Type),
            //                   "No." = FIELD("No.");
            //     RunPageView = SORTING("Sell-to Customer No.", Type, "No.", "Posting Date");
            // }//B2BUPG
        }
    }


    // procedure SetUpCustomer(CustomerNo: Code[20])
    // var
    //     TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
    //     Customer: record Customer;
    //     ItemLedgerEntry: Record "Item Ledger Entry";

    // begin

    //     IF CustomerNo = '' THEN BEGIN
    //         TempItemLedgerEntry.DELETEALL;
    //         Rec.SETRANGE(Number, 1, 0);
    //         CLEAR(Customer);
    //         CurrForm.UPDATE(FALSE);
    //     END ELSE BEGIN
    //         Customer.GET(CustomerNo);
    //         ItemLedgerEntry.RESET;
    //         ItemLedgerEntry.SETCURRENTKEY("Sell-to Customer No.", Type, "No.", "Variant Code", "Posting Date"); //001
    //         ItemLedgerEntry.SETRANGE("Sell-to Customer No.", CustomerNo);
    //         ItemLedgerEntry.SETFILTER(Type, '<>%1', Rec.Type::" ");
    //         SetUpTempItemLedgerEntries;
    //     END;

    //end;
}

