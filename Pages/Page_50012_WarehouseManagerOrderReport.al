page 50012 "Warehouse Manager Order Report"
{
    // NUB1.01,10/30/18,SK: Created new page as required.

    Caption = 'Warehouse Manager Order Report';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = all;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ApplicationArea = all;
                }
                field("Method of Transportation"; ShipAgentRecGbl.Name)
                {
                    ApplicationArea = all;
                }
                field("No. Of Cases"; CasesVarGbl)
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        SalesLineRecGbl.RESET;
                        SalesLineRecGbl.SETRANGE("Document Type", Rec."Document Type");
                        SalesLineRecGbl.SETRANGE("Document No.", Rec."No.");
                        if SalesLineRecGbl.FINDSET then;
                        PAGE.RUNMODAL(PAGE::"Sales Lines", SalesLineRecGbl);
                    end;
                }
                field(Weight; NetWeightVarGbl)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(ShipAgentRecGbl);
        if ShipAgentRecGbl.GET(Rec."Shipping Agent Code") then;

        CLEAR(CasesVarGbl);
        CLEAR(NetWeightVarGbl);

        SalesLineRecGbl.RESET;
        SalesLineRecGbl.SETRANGE("Document Type", Rec."Document Type");
        SalesLineRecGbl.SETRANGE("Document No.", Rec."No.");
        SalesLineRecGbl.SETFILTER(Type, '<>%1', SalesLineRecGbl.Type::" ");
        SalesLineRecGbl.SETFILTER(Quantity, '<>%1', 0);
        if SalesLineRecGbl.FINDSET then begin
            repeat
                NetWeightVarGbl += SalesLineRecGbl.Quantity * SalesLineRecGbl."Net Weight";
                CasesVarGbl += SalesLineRecGbl.Quantity;
            until SalesLineRecGbl.NEXT = 0;
        end;
    end;

    var
        CasesVarGbl: Decimal;
        NetWeightVarGbl: Decimal;
        SalesLineRecGbl: Record "Sales Line";
        ShipAgentRecGbl: Record "Shipping Agent";
        SalesHeadRecGbl: Record "Sales Header";
}

