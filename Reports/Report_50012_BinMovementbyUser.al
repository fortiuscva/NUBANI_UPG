report 50012 "Bin Movement by User"
{
    // NUB1.01,05/21/20,ST: Enhancements to export Bin movement details.
    //                        - Created new report.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = SORTING("Registering Date") ORDER(Ascending) WHERE("Entry Type" = CONST(Movement), Quantity = FILTER(> 0));
            RequestFilterFields = "Registering Date", "User ID";

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                EnterCell(RowNo, 1, FORMAT("Registering Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 2, FORMAT("User ID"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, FORMAT("Location Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, FORMAT("Bin Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, FORMAT("Item No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, FORMAT("Lot No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, FORMAT(Quantity), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 8, FORMAT("Unit of Measure Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, FORMAT("Expiration Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
            end;

            trigger OnPreDataItem()
            begin
                RowNo += 1;
                EnterCell(RowNo, 1, GETFILTERS, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                RowNo += 2;
                EnterCell(RowNo, 1, 'Registering Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, 'User ID', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, 'Location Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Bin Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, 'Item No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, 'Lot No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, 'Quantity', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, 'UOM', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, 'Expiration Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
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

    trigger OnPostReport()
    begin
        TempExcelBuffer.CreateNewBook('Bin Movement by User');
        TempExcelBuffer.WriteSheet('Bin Movement by User', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
        //TempExcelBuffer.GiveUserControl;B2BUPG
    end;

    trigger OnPreReport()
    begin
        TempExcelBuffer.DELETEALL;
        CLEAR(TempExcelBuffer);
    end;

    var
        RowNo: Integer;
        TempExcelBuffer: Record "Excel Buffer" temporary;

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

