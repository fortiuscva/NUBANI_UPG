page 50000 "Product Expiration"
{
    // NUB1.01,NUBANI-002,SP2152,6/21/12,OAS: New page.
    // NUB1.02,07/24/18,SK: Added new Factbox as "Lot Numbers by Bin FactBox" to display multiple Lot's against Items.
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Expiration Date")
                      WHERE("Remaining Quantity" = FILTER(> 0));

    layout
    {
        area(content)
        {
            repeater(Control1100796001)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("NUB Item Description"; Rec."NUB Item Description")
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Total Cost';
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1100796011; "Lot Numbers by Bin FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = FIELD("Item No."),
                              "Variant Code" = FIELD("Variant Code"),
                              "Location Code" = FIELD("Location Code");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("NUB Item Description");
    end;

    trigger OnOpenPage()
    begin
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Days to Expire");
        Rec.FILTERGROUP := 10;
        Rec.SETFILTER("Expiration Date", '<=%1', (CALCDATE(STRSUBSTNO('+%1D', SalesSetup."Days to Expire"), WORKDATE)));
        Rec.FILTERGROUP := 0;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}

