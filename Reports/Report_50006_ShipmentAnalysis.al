report 50006 "Shipment Analysis"
{
    // NUB1.01,08/31/18,SK: Created New report with Excel.
    //         09/05/18,SK: Added new column as "Zip Code"in excel.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            CalcFields = "Sell-to Customer No.";
            DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(<> ' '));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                IF SalesInvHeadRecGbl.GET("Document No.") THEN;

                RowNo += 1;
                EnterCell(RowNo, 1, FORMAT("Sales Invoice Line"."Posting Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 2, FORMAT("Sales Invoice Line"."Document No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, FORMAT(SalesInvHeadRecGbl."Ship-to Post Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, FORMAT("Sales Invoice Line"."Sell-to Customer No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, FORMAT("Sales Invoice Line"."NUB Sell-to Customer Name"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, FORMAT("Sales Invoice Line".Type), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, FORMAT("Sales Invoice Line"."No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, FORMAT("Sales Invoice Line".Description), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, FORMAT("Sales Invoice Line".Quantity), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 10, FORMAT("Sales Invoice Line"."Line Amount"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 11, FORMAT("Sales Invoice Line"."Net Weight"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPreDataItem()
            begin
                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);

                RowNo := 2;
                EnterCell(RowNo, 1, 'Posting Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, 'Document No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, 'Zip Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Customer No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, 'Customer Name', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, 'Type', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, 'No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, 'Description', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, 'Quantity', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 10, 'Amount', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 11, 'Gross Weight', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
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
        TempExcelBuffer.CreateNewBook('Shipment Analysis');
        TempExcelBuffer.WriteSheet('Shipment Analysis', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
        // TempExcelBuffer.GiveUserControl;//B2BUPG
    end;

    var
        PrintToExcel: Boolean;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        SalesInvHeadRecGbl: Record "Sales Invoice Header";

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

