report 50024 "Post Movements Unit Test"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PostMovementsUnitTest.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Integer"; "Integer")
        {

            trigger OnAfterGetRecord()
            begin
                postcu.PostMovements('00034000950195', '20151201', '0502A2', '0502A1',
                  1, 'CASE', 'Hershey Ast 360ct Bar', 'LOT', 'DEFAULT',
                  'Administrator', 'BELLWOOD')
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

