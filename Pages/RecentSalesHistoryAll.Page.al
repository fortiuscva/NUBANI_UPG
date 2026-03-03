#pragma implicitwith disable
page 50208 "Recent Sales History(All)"
{
    // Renumbered from 14005137
    DataCaptionFields = "Sell-to Customer No.", "No.";
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = SORTING("Sell-to Customer No.", Type, "No.", "Posting Date")
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field(CustName; CustName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
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
                RunObject = Page 132;
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
            //     RunObject = Page 14005136;
            //                     RunPageLink = "Sell-to Customer No."=FIELD("Sell-to Customer No."),
            //                   Type=FIELD(Type),
            //                   "No."=FIELD("No.");
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CustName := '';
        IF CustT.GET(Rec."Sell-to Customer No.") THEN
            CustName := CustT.Name
        ELSE
            CustName := '';
    end;

    var
        CustName: Text[100];
        CustT: Record Customer;

    procedure SetUpCustomer(CustomerNo: Code[20])
    begin
        /*
        IF CustomerNo = '' THEN BEGIN
          TempItemLedgerEntry.DELETEALL;
          SETRANGE(Number,1,0);
          CLEAR(Customer);
          CurrForm.UPDATE(FALSE);
        END ELSE BEGIN
          Customer.GET(CustomerNo);
          WITH ItemLedgerEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Sell-to Customer No.",Type,"No.","Variant Code","Posting Date"); //001
            SETRANGE("Sell-to Customer No.",CustomerNo);
            SETFILTER(Type,'<>%1',Type::" ");
          END;
          SetUpTempItemLedgerEntries;
        END;      ----*/

    end;
}

