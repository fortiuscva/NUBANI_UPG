page 50053 "NUB Item Supply FB"
{
    Caption = 'Supply';
    Editable = false;
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                    ValueEntryT: Record "Value Entry";
                begin
                    //FP
                    //add two local variables
                    ValueEntryT.SETRANGE("Item No.", Rec."No.");
                    Rec.COPYFILTER("Global Dimension 1 Filter", ValueEntryT."Global Dimension 1 Code");
                    Rec.COPYFILTER("Global Dimension 2 Filter", ValueEntryT."Global Dimension 2 Code");
                    Rec.COPYFILTER("Location Filter", ValueEntryT."Location Code");
                    Rec.COPYFILTER("Variant Filter", ValueEntryT."Variant Code");
                    //ItemLedgEntry.DrillDownOnEntries(ValueEntryT);
                    DrillDownOnEntries(ValueEntryT);
                end;
            }
            field("Purch. Req. Receipt (Qty.)"; Rec."Purch. Req. Receipt (Qty.)")
            {
                ApplicationArea = all;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = all;
            }
            field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                ApplicationArea = all;
            }
            field("Qty. in Transit"; Rec."Qty. in Transit")
            {
                ApplicationArea = all;
            }
            field(NetSupply; NetSupply)
            {
                Caption = 'Net Supply';
                ApplicationArea = all;

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."No." <> '' then begin
            Rec.CALCFIELDS(Inventory, "Qty. on Purch. Order", "Qty. on Prod. Order", "Qty. in Transit",
                       "Purch. Req. Receipt (Qty.)");

            NetSupply := Rec.Inventory + Rec."Purch. Req. Receipt (Qty.)" + Rec."Qty. on Purch. Order" +
                            Rec."Qty. on Prod. Order" + Rec."Qty. in Transit";
        end;
    end;

    var
        NetSupply: Decimal;
    //B2BUPG
    PROCEDURE DrillDownOnEntries(VAR ValueEntryT: Record "Value Entry")
    var
        ItemLedgEntry: record "Item Ledger Entry";
    begin

        ItemLedgEntry.RESET;
        ValueEntryT.COPYFILTER("Item No.", ItemLedgEntry."Item No.");
        ValueEntryT.COPYFILTER("Location Code", ItemLedgEntry."Location Code");
        ValueEntryT.COPYFILTER("Variant Code", ItemLedgEntry."Variant Code");
        ValueEntryT.COPYFILTER("Global Dimension 1 Code", ItemLedgEntry."Global Dimension 1 Code");
        ValueEntryT.COPYFILTER("Global Dimension 2 Code", ItemLedgEntry."Global Dimension 2 Code");
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Posting Date");
        ItemLedgEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
        PAGE.RUN(0, ItemLedgEntry);
    end;
}

