pageextension 50072 BlanketSalesOrdersExt extends "Blanket Sales Orders"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Statistics)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                IF rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Stats.", Rec);
            end;
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;

    var
        myInt: Integer;
}