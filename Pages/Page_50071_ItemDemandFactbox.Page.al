page 50071 "NUB Item Demand FB"
{
    // FP7.0.07  09/19/12  Doug McIntosh, Cost Control Software
    //         - Added "Qty. On Job Order", and adjusted Net Demand Formulas accordingly

    Caption = 'Demand';
    Editable = false;
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. Reserved SO"; Rec."Reserved Qty. on Sales Orders")
            {
                ApplicationArea = All;
            }
            field("Qty. Reserved Inv."; Rec."Reserved Qty. on Inventory")
            {
                ApplicationArea = All;
            }

            field("Qty. on Service Order"; Rec."Qty. on Service Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Job Order"; Rec."Qty. on Job Order")
            {
                ApplicationArea = All;
            }
            field(NetDemand; NetDemand)
            {
                Caption = 'Net Demand';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
            field(NetAvailable; NetAvailable)
            {
                Caption = 'Net Available';
                DecimalPlaces = 0 : 0;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."No." <> '' THEN BEGIN
            Rec.CALCFIELDS(Inventory, "Qty. on Purch. Order", "Qty. on Prod. Order", "Qty. in Transit",
                       "Purch. Req. Receipt (Qty.)",
                       "Qty. on Sales Order", "Qty. on Service Order", "Qty. on Component Lines", "Reserved Qty. on Sales Orders", "Reserved Qty. on Inventory");

            NetSupply := Rec.Inventory + Rec."Purch. Req. Receipt (Qty.)" + Rec."Qty. on Purch. Order" +
                            Rec."Qty. on Prod. Order" + Rec."Qty. in Transit";

            NetDemand := Rec."Qty. on Sales Order" + Rec."Qty. on Service Order" + Rec."Qty. on Component Lines" + Rec."Qty. on Job Order";

            NetAvailable := NetSupply - NetDemand;
        END;
    end;

    var
        NetSupply: Decimal;
        NetDemand: Decimal;
        NetAvailable: Decimal;

}

