report 50087 "Check item qty on whse-3"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/Checkitemqtyonwhse3.rdl';
   UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem(Item; Item)
        {
            column(itemno; Item."No.")
            {
            }
            column(itemqty; Item.Inventory)
            {
            }
            column(whseqty; whseentry."Qty. (Base)")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Item.Inventory);
                CLEAR(whseentry);
                whseentry.RESET;
                whseentry.SETCURRENTKEY("Item No.");
                whseentry.SETRANGE("Item No.", "No.");
                whseentry.CALCSUMS(whseentry."Qty. (Base)");
                IF whseentry."Qty. (Base)" = Item.Inventory THEN
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        whseentry: Record "Warehouse Entry";
}

