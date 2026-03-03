page 50202 "Salesperson Activities" //14005180
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Salesperson Cue";

    layout
    {
        area(content)
        {
            cuegroup(Marketing)
            {
                Caption = 'Marketing';
                field(Customers; Rec.Customers)
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Customer List";
                }
                field(Contacts; Rec.Contacts)
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Contact List";
                }
                field("Opportunities - Open"; Rec."Opportunities - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Opportunity List";
                }
                field("Opportunities - Closed"; Rec."Opportunities - Closed")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Opportunity List";
                }
                field(Campaigns; Rec.Campaigns)
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Campaign List";
                    Visible = false;
                }
                field("To-Do"; Rec."To-Do")
                {
                    ApplicationArea = All;
                    //DrillDownPageID = "To-do List";//B2BUPG
                }
            }
            cuegroup(Sales)
            {
                Caption = 'Sales';
                field("Sales Quotes - Open"; Rec."Sales Quotes - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Quotes - Released"; Rec."Sales Quotes - Released")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders - Open"; Rec."Sales Orders - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                field("Sales Orders - Released"; Rec."Sales Orders - Released")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Quote';
                        //Image = Quote;
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Order';
                        RunObject = Page 42;
                        RunPageMode = Create;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        if not Rec.GET then begin
            Rec.INIT;
            Rec.INSERT;
        end;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
        Rec.SETFILTER("Date Filter2", '>=%1', WORKDATE);

        //IF UserSetup.GET(USERID) THEN
        //SETRANGE("Salesperson Filter",UserSetup."Salespers./Purch. Code");
    end;

    var
        UserSetup: Record "User Setup";
}

