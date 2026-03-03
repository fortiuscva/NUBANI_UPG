page 50011 "Item Det. by PO FactBox"
{
    // NUB1.01,09/28/18,SK: Created new Page.

    Caption = 'Item Det. by PO FactBox';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableTemporary = true;
    SourceTableView = WHERE("No." = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        FillTempTable;
        exit(rec.FIND(Which));
    end;

    local procedure FillTempTable()
    var
        LotNosByBinCode: Query "Lot Numbers by Bin";
        ItemPODetailsQuery: Query "Item Wise PO Details";//
    begin
        ItemPODetailsQuery.SETRANGE(ItemPODetailsQuery.No, rec.GETRANGEMIN("No."));
        ItemPODetailsQuery.OPEN;

        rec.DELETEALL;

        while ItemPODetailsQuery.READ do begin
            rec.INIT;
            rec."Document Type" := rec."Document Type"::Order;
            rec."Document No." := ItemPODetailsQuery.Document_No;
            rec."Line No." := ItemPODetailsQuery.Line_No;
            rec.Type := rec.Type::Item;
            rec."No." := ItemPODetailsQuery.No;
            rec.Quantity := ItemPODetailsQuery.Quantity;
            rec."Direct Unit Cost" := ItemPODetailsQuery.Direct_Unit_Cost;
            rec.INSERT;
        end;
    end;
}

