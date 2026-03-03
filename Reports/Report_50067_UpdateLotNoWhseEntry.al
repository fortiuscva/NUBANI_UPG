report 50067 "Update Lot No. Whse Entry"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry No." = CONST(1374260));

            trigger OnAfterGetRecord()
            begin
                "Warehouse Entry"."Lot No." := '20200101';
                MODIFY;
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
}

