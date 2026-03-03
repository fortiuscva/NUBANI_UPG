#pragma implicitwith disable
page 50022 "Item Received by Qty and Date"
{
    Editable = false;
    PageType = List;
    SourceTable = "Purch. Rcpt. Line";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Item),
                            Quantity = FILTER(> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
                field("Unit of Measure"; Rec."Unit of Measure")
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
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
    }
}

#pragma implicitwith restore

