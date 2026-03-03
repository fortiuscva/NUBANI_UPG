report 50010 "Average Sales By Lot. -Excel"
{
    // NUB1.01,05/16/19,ST: Created new report.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = CONST(Sale));
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord()
            begin
                EntryNo += 1;
                CALCFIELDS("Cost Amount (Expected)", "Cost Amount (Actual)", "Sales Amount (Actual)");
                IF NOT ItemRecGbl.GET("Item No.") THEN
                    CLEAR(ItemRecGbl);


                CLEAR(ErrorText);

                TempSalesShptLot.INIT;
                TempSalesShptLot."Entry No." := EntryNo;
                TempSalesShptLot."Posting Date" := "Posting Date";
                TempSalesShptLot."Item No." := "Item No.";
                TempSalesShptLot.Description := ItemRecGbl.Description;
                TempSalesShptLot."Item Category Code" := "Item Category Code";
                TempSalesShptLot."Entry Type" := "Entry Type".AsInteger();
                TempSalesShptLot."Cust No." := "Source No.";
                TempSalesShptLot."Document No." := "Document No.";
                TempSalesShptLot."Location Code" := "Location Code";
                TempSalesShptLot.Quantity := (Quantity * -1);
                TempSalesShptLot."Unit of Measure Code" := "Unit of Measure Code";
                //("Cost Amount (Expected)" + "Cost Amount (Actual)")
                TempSalesShptLot."Sales Amount (Actual)" := "Sales Amount (Actual)";
                TempSalesShptLot."Cost Per Case" := ("Sales Amount (Actual)" / TempSalesShptLot.Quantity);
                "Lot No." := DELCHR("Lot No.", '=', '/');
                TempSalesShptLot."Lot/Expiration" := "Lot No.";
                IF NOT EVALUATE(LotDate, COPYSTR("Lot No.", 5, 2) + COPYSTR("Lot No.", 7, 2) + COPYSTR("Lot No.", 1, 4)) THEN
                    UpdateError(STRSUBSTNO('Invalid Lot Date format %1', "Lot No."))
                ELSE BEGIN
                    TempSalesShptLot."Lot Date" := LotDate;
                    TempSalesShptLot."Delta Post vs Lot" := (TempSalesShptLot."Lot Date" - TempSalesShptLot."Posting Date");


                    IF (TempSalesShptLot."Delta Post vs Lot" < 0) THEN
                        TempSalesShptLot.Expired := TempSalesShptLot."Cost Per Case";
                    IF ((TempSalesShptLot."Delta Post vs Lot" >= 0) AND (TempSalesShptLot."Delta Post vs Lot" <= 61)) THEN
                        TempSalesShptLot."0-2 Months" := TempSalesShptLot."Cost Per Case";
                    IF ((TempSalesShptLot."Delta Post vs Lot" >= 61) AND (TempSalesShptLot."Delta Post vs Lot" <= 120)) THEN
                        TempSalesShptLot."2-4 Months" := TempSalesShptLot."Cost Per Case";
                    IF ((TempSalesShptLot."Delta Post vs Lot" >= 121) AND (TempSalesShptLot."Delta Post vs Lot" <= 180)) THEN
                        TempSalesShptLot."4-6 months" := TempSalesShptLot."Cost Per Case";
                    IF ((TempSalesShptLot."Delta Post vs Lot" >= 181) AND (TempSalesShptLot."Delta Post vs Lot" <= 240)) THEN
                        TempSalesShptLot."6-8 Months" := TempSalesShptLot."Cost Per Case";
                    IF (TempSalesShptLot."Delta Post vs Lot" >= 241) THEN
                        TempSalesShptLot."Above 8 Months" := TempSalesShptLot."Cost Per Case";
                END;
                TempSalesShptLot."Error Text" := ErrorText;
                TempSalesShptLot.INSERT;
            end;
        }
        dataitem("Export Details"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                TempSalesShptLot.RESET;
                TempSalesShptLot.SETCURRENTKEY("Item No.");
                TempSalesShptLot.SETFILTER("Error Text", '');
                IF TempSalesShptLot.FINDSET THEN BEGIN
                    PrevItemNo := TempSalesShptLot."Item No.";
                    PrevDescription := TempSalesShptLot.Description;
                    REPEAT
                        IF PrevItemNo <> TempSalesShptLot."Item No." THEN BEGIN
                            UpdateAverageValues;
                            WriteDataToExcel(PrevItemNo, PrevDescription, AvgExp, AvgTwoMon, AvgFourMon, AvgSixMon, AvgEightMon, AvgAboveEightMon);
                            ClearAverageVariables;
                        END;
                        IF (TempSalesShptLot.Expired > 0) THEN BEGIN
                            AvgExp += TempSalesShptLot.Expired;
                            AvgExpCount += 1;
                        END;
                        IF (TempSalesShptLot."0-2 Months" > 0) THEN BEGIN
                            AvgTwoMon += TempSalesShptLot."0-2 Months";
                            AvgTwoMonCount += 1;
                        END;
                        IF (TempSalesShptLot."2-4 Months" > 0) THEN BEGIN
                            AvgFourMon += TempSalesShptLot."2-4 Months";
                            AvgFourMonCount += 1;
                        END;
                        IF (TempSalesShptLot."4-6 months" > 0) THEN BEGIN
                            AvgSixMon += TempSalesShptLot."4-6 months";
                            AvgSixMonCount += 1;
                        END;
                        IF (TempSalesShptLot."6-8 Months" > 0) THEN BEGIN
                            AvgEightMon += TempSalesShptLot."6-8 Months";
                            AvgEightMonCount += 1;
                        END;
                        IF (TempSalesShptLot."Above 8 Months" > 0) THEN BEGIN
                            AvgAboveEightMon += TempSalesShptLot."Above 8 Months";
                            AvgAboveEightMonCount += 1;
                        END;
                        PrevItemNo := TempSalesShptLot."Item No.";
                        PrevDescription := TempSalesShptLot.Description;
                    UNTIL TempSalesShptLot.NEXT = 0;

                    //For Last Item
                    UpdateAverageValues;
                    WriteDataToExcel(PrevItemNo, PrevDescription, AvgExp, AvgTwoMon, AvgFourMon, AvgSixMon, AvgEightMon, AvgAboveEightMon);
                END;
            end;

            trigger OnPreDataItem()
            begin
                RowNo += 2;
                EnterCell(RowNo, 1, 'Item No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, 'Item Description', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, 'Average of Expired', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Average of 0-2 Months', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, 'Average of 2-4 Months', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, 'Average of 4-6 months', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, 'Average of 6-8 Months', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, 'Average of Above 8 Months', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
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
        TempExcelBuffer.CreateNewBook('Sales By Lot');
        TempExcelBuffer.WriteSheet('Sales By Lot', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
        //TempExcelBuffer.GiveUserControl;B2BUPG;
    end;

    trigger OnPreReport()
    begin
        TempExcelBuffer.DELETEALL;
        CLEAR(TempExcelBuffer);

        TempSalesShptLot.DELETEALL;
        CLEAR(TempSalesShptLot);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        ItemRecGbl: Record Item;
        EntryNo: Integer;
        TempSalesShptLot: Record "Sales Shipment By Lot";
        LotDate: Date;
        PrevItemNo: Code[20];
        PrevDescription: Text;
        AvgExp: Decimal;
        AvgExpCount: Integer;
        AvgTwoMon: Decimal;
        AvgTwoMonCount: Integer;
        AvgFourMon: Decimal;
        AvgFourMonCount: Integer;
        AvgSixMon: Decimal;
        AvgSixMonCount: Integer;
        AvgEightMon: Decimal;
        AvgEightMonCount: Integer;
        AvgAboveEightMon: Decimal;
        AvgAboveEightMonCount: Integer;
        ErrorText: Text;

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


    procedure ClearAverageVariables()
    begin
        CLEAR(AvgExp);
        CLEAR(AvgExpCount);
        CLEAR(AvgTwoMon);
        CLEAR(AvgTwoMonCount);
        CLEAR(AvgFourMon);
        CLEAR(AvgFourMonCount);
        CLEAR(AvgSixMon);
        CLEAR(AvgSixMonCount);
        CLEAR(AvgEightMon);
        CLEAR(AvgEightMonCount);
        CLEAR(AvgAboveEightMon);
        CLEAR(AvgAboveEightMonCount);
    end;


    procedure WriteDataToExcel(ItemNoPar: Code[20]; ItemDescriptionPar: Text[100]; AvgExpPar: Decimal; AvgTwoMonPar: Decimal; AvgFourMonPar: Decimal; AvgSixMonPar: Decimal; AvgEightMonPar: Decimal; AvgAboveEightMonPar: Decimal)
    begin
        RowNo += 1;
        EnterCell(RowNo, 1, ItemNoPar, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, ItemDescriptionPar, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 3, FORMAT(ROUND(AvgExpPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 4, FORMAT(ROUND(AvgTwoMonPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 5, FORMAT(ROUND(AvgFourMonPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 6, FORMAT(ROUND(AvgSixMonPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 7, FORMAT(ROUND(AvgEightMonPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 8, FORMAT(ROUND(AvgAboveEightMonPar, 0.01, '=')), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;


    procedure UpdateAverageValues()
    begin
        IF AvgExpCount <> 0 THEN
            AvgExp := (AvgExp / AvgExpCount)
        ELSE
            AvgExp := 0;
        IF AvgTwoMonCount <> 0 THEN
            AvgTwoMon := (AvgTwoMon / AvgTwoMonCount)
        ELSE
            AvgTwoMon := 0;
        IF AvgFourMonCount <> 0 THEN
            AvgFourMon := (AvgFourMon / AvgFourMonCount)
        ELSE
            AvgFourMon := 0;
        IF AvgSixMonCount <> 0 THEN
            AvgSixMon := (AvgSixMon / AvgSixMonCount)
        ELSE
            AvgSixMon := 0;
        IF AvgEightMonCount <> 0 THEN
            AvgEightMon := (AvgEightMon / AvgEightMonCount)
        ELSE
            AvgEightMon := 0;
        IF AvgAboveEightMonCount <> 0 THEN
            AvgAboveEightMon := (AvgAboveEightMon / AvgAboveEightMonCount)
        ELSE
            AvgAboveEightMon := 0;
    end;


    procedure UpdateError(ErrorTxtPar: Text)
    begin
        IF ErrorTxtPar <> '' THEN BEGIN
            IF ErrorText <> '' THEN
                ErrorText += '~' + ErrorTxtPar
            ELSE
                ErrorText := ErrorTxtPar;
        END;
    end;
}

