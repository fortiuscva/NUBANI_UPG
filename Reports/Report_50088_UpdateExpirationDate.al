report 50088 "Update Expiration Date"
{
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Warehouse Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord()
            begin
                "Expiration Date" := NewExpDate;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT RunforILE THEN
                    CurrReport.BREAK;
                IF GETFILTER("Entry No.") = '' THEN
                    ERROR('Entry No. cannot be empty');

                IF NewExpDate = 0D THEN
                    ERROR('New Expiration cannot be empty');
            end;
        }
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord()
            begin
                "Expiration Date" := NewExpDate;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT RunForWarehoueEntry THEN
                    CurrReport.BREAK;


                IF GETFILTER("Entry No.") = '' THEN
                    ERROR('Entry No. cannot be empty');

                IF NewExpDate = 0D THEN
                    ERROR('New Expiration cannot be empty');
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
                    field(RunforILE; RunforILE)
                    {
                        ApplicationArea = All;
                        Caption = 'Run For ILE';
                    }
                    field(RunForWarehoueEntry; RunForWarehoueEntry)
                    {
                        ApplicationArea = All;
                        Caption = 'Run For Warehouse Entry';
                    }
                    field(NewExpDate; NewExpDate)
                    {
                        ApplicationArea = All;
                        Caption = 'New Expiration Date';
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

    trigger OnPreReport()
    begin
        RunforILE := TRUE;
    end;

    var
        NewExpDate: Date;
        RunforILE: Boolean;
        RunForWarehoueEntry: Boolean;
}

