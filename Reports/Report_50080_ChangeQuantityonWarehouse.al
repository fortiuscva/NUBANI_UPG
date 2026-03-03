report 50080 "Change Quantity on Warehouse"
{
    Permissions = TableData "Warehouse Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {

            trigger OnAfterGetRecord()
            begin
                Quantity := NewQty;
                "Qty. (Base)" := (NewQty * "Warehouse Entry"."Qty. per Unit of Measure");
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF NewQty = 0 THEN
                    IF NOT CONFIRM('Do you want to modify the entry with zero?') THEN
                        ERROR('Update interrupetd to respect the warning');
                IF COUNT > 1 THEN
                    ERROR('You can only modify one record at a time');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewQty; NewQty)
                    {
                        ApplicationArea = All;
                        Caption = 'New Quantity';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        NewQty: Decimal;
}

