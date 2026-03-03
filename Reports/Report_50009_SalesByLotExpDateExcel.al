report 50009 "Sales By Lot/Exp. Date -Excel"
{
    // NUB1.01,04/30/19,ST: Created new report.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = CONST(Sale));
            RequestFilterFields = "Posting Date", "Item No.", "Document No.", "Source No.";

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                CALCFIELDS("Cost Amount (Expected)", "Cost Amount (Actual)", "Sales Amount (Actual)");
                IF NOT ItemRecGbl.GET("Item No.") THEN
                    CLEAR(ItemRecGbl);
                EnterCell(RowNo, 1, FORMAT("Posting Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 2, FORMAT("Item No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, FORMAT(ItemRecGbl.Description), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, FORMAT("Item Category Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, FORMAT("Entry Type"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, FORMAT("Source No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, FORMAT("Document No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, FORMAT("Location Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, FORMAT(Quantity * -1), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 10, FORMAT("Unit of Measure Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 11, FORMAT(("Cost Amount (Expected)" + "Cost Amount (Actual)")), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 12, FORMAT("Sales Amount (Actual)"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 13, FORMAT("Item Ledger Entry"."Lot No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuffer.CreateNewBook('Sales By Lot');
                TempExcelBuffer.WriteSheet('Sales By Lot', COMPANYNAME, USERID);
                TempExcelBuffer.CloseBook;
                TempExcelBuffer.OpenExcel;
                //TempExcelBuffer.GiveUserControl;//B2BUPG
            end;

            trigger OnPreDataItem()
            begin
                RowNo := 1;
                EnterCell(RowNo, 1, 'Posting Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, 'Item No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, 'Item Description', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Item Category Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, 'Entry Type', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, 'Cust No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, 'Document No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, 'Location Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, 'Quantity', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 10, 'Unit of Measure Code', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 11, 'Cost Amount', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 12, 'Sales Amount (Actual)', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 13, 'Lot/Expiration', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
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

    trigger OnPreReport()
    begin
        TempExcelBuffer.DELETEALL;
        CLEAR(TempExcelBuffer);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ItemRecGbl: Record Item;

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

