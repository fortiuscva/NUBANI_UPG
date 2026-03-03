report 50013 "Invt. Pick By User Report"
{
    // NUB1.01,02/04/21,ST: Enhancements to export inventory pick details created by user and date.
    //                       - Created new report.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                CLEAR(PostedPicksByUserDate);
                IF DateFilterVarGbl <> '' THEN
                    PostedPicksByUserDate.SETFILTER("Posting_Date", DateFilterVarGbl);
                IF AssignedUserIDFilterVarGbl <> '' THEN
                    PostedPicksByUserDate.SETFILTER("Assigned_User_ID", AssignedUserIDFilterVarGbl);
                PostedPicksByUserDate.OPEN;
                WHILE PostedPicksByUserDate.READ DO BEGIN

                    CLEAR(SalesHeaderTemp);
                    SalesHeaderTemp.DELETEALL;
                    TotalNoofPicksVarGbl := 0;

                    PostedInvPickHeadRecGbl.RESET;
                    PostedInvPickHeadRecGbl.SETRANGE("Posting Date", PostedPicksByUserDate.Posting_Date);
                    PostedInvPickHeadRecGbl.SETRANGE("Assigned User ID", PostedPicksByUserDate.Assigned_User_ID);
                    IF PostedInvPickHeadRecGbl.FINDSET THEN
                        REPEAT
                            SalesShptHeadRecGbl.GET(PostedInvPickHeadRecGbl."Source No.");
                            TotalNoofPicksVarGbl += 1;
                            IF NOT SalesHeaderTemp.GET(1, SalesShptHeadRecGbl."Order No.") THEN BEGIN
                                SalesHeaderTemp.INIT;
                                SalesHeaderTemp."Document Type" := SalesHeaderTemp."Document Type"::Order;
                                SalesHeaderTemp."No." := SalesShptHeadRecGbl."Order No.";
                                SalesHeaderTemp.INSERT;
                            END;
                        UNTIL PostedInvPickHeadRecGbl.NEXT = 0;
                    SalesHeaderTemp.RESET;
                    RowNo += 1;
                    EnterCell(RowNo, 1, FORMAT(PostedPicksByUserDate.Posting_Date), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    EnterCell(RowNo, 2, FORMAT(PostedPicksByUserDate.Assigned_User_ID), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(PostedPicksByUserDate.Sum_Quantity), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 4, FORMAT(TotalNoofPicksVarGbl), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 5, FORMAT(SalesHeaderTemp.COUNT), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                END;
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
                    field(DateFilterVarGbl; DateFilterVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';

                        trigger OnValidate()
                        begin
                            SalesHeaderRecGbl.RESET;
                            SalesHeaderRecGbl.SETFILTER("Date Filter", DateFilterVarGbl);
                            DateFilterVarGbl := SalesHeaderRecGbl.GETFILTER("Date Filter");
                        end;
                    }
                    field(AssignedUserIDFilterVarGbl; AssignedUserIDFilterVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Assigned User ID';
                        TableRelation = "Warehouse Employee";
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

    trigger OnPostReport()
    begin
        TempExcelBuffer.CreateNewBook('Details');
        TempExcelBuffer.WriteSheet('Details', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
        //TempExcelBuffer.GiveUserControl;//B2BUPG
    end;

    trigger OnPreReport()
    begin
        TempExcelBuffer.DELETEALL;
        CLEAR(TempExcelBuffer);

        RowNo := 1;
        EnterCell(RowNo, 1, 'Posting Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, 'Assigned User ID', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 3, 'No. of Cases', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 4, 'No. of Picks', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 5, 'No. of Orders', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        PostedPicksByUserDate: Query "Posted Picks By User ID&Date";
        DateFilterVarGbl: Text;
        AssignedUserIDFilterVarGbl: Text;
        PostedInvPickHeadRecGbl: Record "Posted Invt. Pick Header v1";
        PostedInvPickLineRecGbl: Record "Posted Invt. Pick Line v1";
        SalesShptHeadRecGbl: Record "Sales Shipment Header";
        SalesHeaderTemp: Record "Sales Header" temporary;
        SalesHeaderRecGbl: Record "Sales Header";
        TotalNoofPicksVarGbl: Integer;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := Format;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.INSERT;
    end;
}

