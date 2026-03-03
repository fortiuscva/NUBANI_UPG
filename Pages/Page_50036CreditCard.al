page 50036 "Credit Card"
{
    Caption = 'Credit Card';
    PageType = Card;
    SourceTable = "Credit Card";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        // CurrPage.UPDATE;
                    end;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        creditCardNumber := Rec."Credit Card Number";
                    end;
                }
                field("Card Holder Name"; Rec."Card Holder Name")
                {
                    ApplicationArea = all;
                }
                field("CC No."; rec."CC No.")
                {
                    ApplicationArea = all;
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                    Caption = 'Expiry Date (MMYY)';
                    ApplicationArea = all;
                }
                field("CVV Code"; rec."CVV Code")
                {
                    ApplicationArea = all;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Credit Card")
            {
                Caption = '&Credit Card';
                Image = CreditCard;

                // action("Transaction Log E&ntries")
                // {
                //     Caption = 'Transaction Log E&ntries';
                //     ApplicationArea = all;
                //     Image = Log;
                //     RunObject = Page "DO Payment Trans. Log Entries";
                //     RunPageLink = "Credit Card No." = FIELD ("No.");///829 B2BUPG PAGE not found
                //     ShortCutKey = 'Ctrl+F7';
                // }B2BUPG
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        creditCardNumber := rec."Credit Card Number";
    end;

    var
        creditCardNumber: Text[30];
}

