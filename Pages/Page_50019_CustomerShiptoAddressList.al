page 50019 "Customer Ship-to Address List"
{
    // NUB1.01,07/24/18,SK: Pullout "Customer Name" field.

    Caption = 'Ship-to Address List';
    CardPageID = "Ship-to Address";
    DataCaptionFields = "Customer No.";
    Editable = false;
    PageType = List;
    SourceTable = "Ship-to Address";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Code"; rec.Code)
                {
                    Caption = 'Ship-To Code';
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field(County; rec.County)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
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
            group("&Address")
            {
                Caption = '&Address';
                Image = Addresses;
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.DisplayMap;
                    end;
                }
            }
        }
    }
}

