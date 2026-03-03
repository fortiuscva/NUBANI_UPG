page 50204 "Purchase Order Receiving List"//14004997
{
    // //FP6  New list form for the Purchase Receiving Form

    Caption = 'Purchase Order Receiving List';
    //CardPageID = "Purchase Order Receive";//14005150 B2BUPG
    DataCaptionFields = "Document Type";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE ("Document Type" = CONST (Order));

    layout
    {
        area(content)
        {
            repeater(Control1100768000)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea =All;
                }
                field("Your Reference"; rec."Your Reference")
                {
                    ApplicationArea =All;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea =All;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea =All;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea =All;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea =All;
                }
                field("Priority Level"; rec."Priority Level")
                {
                    ApplicationArea =All;
                }
                field("Pallets-Cases"; rec."Pallets-Cases")
                {
                    ApplicationArea =All;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea =All;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea =All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea =All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea =All;
                }
                field("Posting Date";rec. "Posting Date")
                {
                    ApplicationArea =All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //FP6 begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        end;

        Rec.SETRANGE(Status, Rec.Status::Released);
        //FP6 end
    end;

    var
        UserMgt: Codeunit "User Setup Management";
}

