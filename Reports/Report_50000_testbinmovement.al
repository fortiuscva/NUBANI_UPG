report 50000 "test bin movement"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/testbinmovement.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;
    

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                postcu.PostMovements('61164', 'LOT0097', '0601B2',
                '0601A1', 12, 'CASE', 'Blong 3 Watermelon Gum 24/40ct Box', 'LOT', 'DEFAULT', 'MAINWHSE\RBARRERA', 'BELLWOOD');
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
        postcu: Codeunit PostChange_WS;
}

