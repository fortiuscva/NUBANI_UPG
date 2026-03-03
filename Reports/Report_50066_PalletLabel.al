report 50066 "Pallet Label"
{
    // NUB1.01,05/06/20,ST: Enhancements to print pallet label.
    //                       - Created new report.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PalletLabel.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;


    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending);
            column(OrderNo; OrderNo)
            {
            }
            column(PalletCount; PalletCount)
            {
            }
            column(Number; Number)
            {
            }

            trigger OnPreDataItem()
            begin
                IF PalletCount = 0 THEN
                    CurrReport.BREAK;

                SETRANGE(Number, 1, PalletCount);
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
        OrderNo: Code[20];
        PalletCount: Integer;


    procedure SetDetails(SalesHeadRec: Record "Sales Header")
    begin
        OrderNo := SalesHeadRec."No.";
        PalletCount := SalesHeadRec."Pallet Count";
    end;
}

