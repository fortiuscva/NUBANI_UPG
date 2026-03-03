page 50035 "Credit Card List"
{
    Caption = 'DO Payment Credit Card List';
    CardPageID = "Credit Card";
    Editable = false;
    PageType = List;
    SourceTable = "Credit Card";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Card Holder Name"; rec."Card Holder Name")
                {
                    ApplicationArea = All;
                }
                field("CC No."; rec."CC No.")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("CVV Code"; rec."CVV Code")
                {
                    ApplicationArea = All;
                }
                field("Contact No."; rec."Contact No.")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        // area(navigation)
        // {
        //     group("&Credit Card")
        //     {
        //         Caption = '&Credit Card';
        //         Image = CreditCard;
        //         action("Transaction Log E&ntries")
        //         {
        //             Caption = 'Transaction Log E&ntries';
        //             Image = Log;
        //             RunObject = Page "DO Payment Trans. Log Entries";//829 B2BUPG PAGE not found
        //             RunPageLink = "Credit Card No." = FIELD ("No.");
        //             ShortCutKey = 'Ctrl+F7';
        //         }
        //     }
        // }//B2BUPG
    }
}

