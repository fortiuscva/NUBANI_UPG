page 50025 "Item Recd  by Qty and Date"
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
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
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

