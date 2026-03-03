report 50030 "Invoicing Rep. with Statistics"
{
    // NUB1.01,03/11/19,SK: Created new report (Save As from R10050)
    //                      Added code at "Sales Invoice Header - OnAfterGetRecord()" to get Statistics Details.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/InvoicingRepwithStatistics.rdl';

    Caption = 'Invoicing Rep. with Statistics';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Currency; Currency)
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                TempCurrency := Currency;
                TempCurrency.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                IF UseCurrency THEN BEGIN
                    CLEAR(TempCurrency);
                    TempCurrency.INSERT;
                END ELSE
                    CurrReport.BREAK;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            PrintOnlyIfDetail = true;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PAGENO)
            // {
            // }
            column(USERID; USERID)
            {
            }
            column(IncludeInvoices; IncludeInvoices)
            {
            }
            column(IncludeCreditMemos; IncludeCreditMemos)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(TempCurrency_TABLENAME__________TempCurrency_Code; TempCurrency.TABLENAME + ': ' + TempCurrency.Code)
            {
            }
            column(TempCurrency_Description; TempCurrency.Description)
            {
            }
            column(TempCurrency_Code_Control1020000; TempCurrency.Code)
            {
            }
            column(UseCurrency; UseCurrency)
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(Daily_Invoicing_ReportCaption; Daily_Invoicing_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "Posting Date", "Bill-to Customer No.", "Salesperson Code", "Payment Terms Code";
                RequestFilterHeading = 'Sales Invoice';
                column(Sales_Invoice_Header__No__; "No.")
                {
                }
                column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
                {
                }
                column(Sales_Invoice_Header__Payment_Terms_Code_; "Payment Terms Code")
                {
                }
                column(Sales_Invoice_Header__Salesperson_Code_; "Salesperson Code")
                {
                }
                column(Sales_Invoice_Header_Amount; Amount)
                {
                }
                column(SalesTax; SalesTax)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Invoice_Header_Amount_Control49; Amount)
                {
                }
                column(SalesTax_Control50; SalesTax)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT__Control51; "Amount Including VAT")
                {
                }
                column(TempCurrency_Code; TempCurrency.Code)
                {
                }
                column(Sales_Invoice_Header__No__Caption; Sales_Invoice_Header__No__CaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Posting_Date_Caption; Sales_Invoice_Header__Posting_Date_CaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Invoice_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name"))
                {
                }
                column(Sales_Invoice_Header__Payment_Terms_Code_Caption; FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Sales_Invoice_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Sales_Invoice_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(SalesTaxCaption; SalesTaxCaptionLbl)
                {
                }
                column(Sales_Invoice_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }
                column(Total_of_all_InvoicesCaption; Total_of_all_InvoicesCaptionLbl)
                {
                }
                column(TotalAdjCostLCY; TotalAdjCostLCY)
                {
                }
                column(AdjProfitLCY; AdjProfitLCY)
                {
                }
                column(AdjProfitPct; AdjProfitPct)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF IncludeInvoices THEN BEGIN
                        CALCFIELDS(Amount, "Amount Including VAT");
                        SalesTax := "Amount Including VAT" - Amount;
                        TotalAmtExclTax := TotalAmtExclTax + Amount;
                        TotalSalesTax := TotalSalesTax + SalesTax;
                        TotalAmtInclTax := TotalAmtInclTax + "Amount Including VAT";

                        //NUB1.01 Start
                        CLEAR(TotalAdjCostLCY);
                        CLEAR(AmountLCY);
                        CLEAR(AdjProfitLCY);
                        CLEAR(AdjProfitPct);

                        SalesInvLineRecGbl.RESET;
                        SalesInvLineRecGbl.SETRANGE("Document No.", "No.");
                        IF SalesInvLineRecGbl.FINDSET THEN
                            REPEAT
                                TotalAdjCostLCY := TotalAdjCostLCY + CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvLineRecGbl);
                            UNTIL SalesInvLineRecGbl.NEXT = 0;

                        CustLedgEntry.SETCURRENTKEY("Document No.");
                        CustLedgEntry.SETRANGE("Document No.", "No.");
                        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                        CustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
                        IF CustLedgEntry.FINDFIRST THEN
                            AmountLCY := CustLedgEntry."Sales (LCY)";

                        AdjProfitLCY := AmountLCY - TotalAdjCostLCY;

                        IF AmountLCY <> 0 THEN
                            AdjProfitPct := ROUND(100 * AdjProfitLCY / AmountLCY, 0.1);
                        //NUB1.01 End
                    END ELSE
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    IF IncludeInvoices THEN BEGIN
                        DoingInvoices := TRUE;
                        //CurrReport.CREATETOTALS(Amount, "Amount Including VAT", SalesTax);
                    END ELSE
                        CurrReport.BREAK;

                    IF UseCurrency THEN
                        SETRANGE("Currency Code", TempCurrency.Code);
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemTableView = SORTING("No.");
                column(Sales_Cr_Memo_Header__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Name_; "Bill-to Name")
                {
                }
                column(Sales_Cr_Memo_Header__Applies_to_Doc__No__; "Applies-to Doc. No.")
                {
                }
                column(Sales_Cr_Memo_Header__Salesperson_Code_; "Salesperson Code")
                {
                }
                column(Sales_Cr_Memo_Header_Amount; Amount)
                {
                }
                column(SalesTax_Control60; SalesTax)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(Sales_Cr_Memo_Header_Amount_Control62; Amount)
                {
                }
                column(SalesTax_Control63; SalesTax)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT__Control64; "Amount Including VAT")
                {
                }
                column(TempCurrency_Code_Control4; TempCurrency.Code)
                {
                }
                column(TotalAmtExclTax; TotalAmtExclTax)
                {
                }
                column(TotalSalesTax; TotalSalesTax)
                {
                }
                column(TotalAmtInclTax; TotalAmtInclTax)
                {
                }
                column(TempCurrency_Code_Control5; TempCurrency.Code)
                {
                }
                column(Sales_Cr_Memo_Header__No__Caption; Sales_Cr_Memo_Header__No__CaptionLbl)
                {
                }
                column(Cr__Memo_DateCaption; Cr__Memo_DateCaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name"))
                {
                }
                column(Sales_Cr_Memo_Header__Applies_to_Doc__No__Caption; FIELDCAPTION("Applies-to Doc. No."))
                {
                }
                column(Sales_Cr_Memo_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Sales_Cr_Memo_Header_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(SalesTax_Control60Caption; SalesTax_Control60CaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header__Amount_Including_VAT_Caption; FIELDCAPTION("Amount Including VAT"))
                {
                }
                column(Total_of_all_Credit_MemosCaption; Total_of_all_Credit_MemosCaptionLbl)
                {
                }
                column(Grand_Total_of_all_Invoices_and_Credit_MemosCaption; Grand_Total_of_all_Invoices_and_Credit_MemosCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF IncludeCreditMemos THEN BEGIN
                        CALCFIELDS(Amount, "Amount Including VAT");
                        SalesTax := "Amount Including VAT" - Amount;
                        TotalAmtExclTax := TotalAmtExclTax - Amount;
                        TotalSalesTax := TotalSalesTax - SalesTax;
                        TotalAmtInclTax := TotalAmtInclTax - "Amount Including VAT";
                    END ELSE
                        CurrReport.BREAK;
                end;

                trigger OnPreDataItem()
                begin
                    IF IncludeCreditMemos THEN BEGIN
                        IF UseCurrency THEN
                            SETRANGE("Currency Code", TempCurrency.Code);
                        "Sales Invoice Header".COPYFILTER("Posting Date", "Posting Date");
                        "Sales Invoice Header".COPYFILTER("Bill-to Customer No.", "Bill-to Customer No.");
                        "Sales Invoice Header".COPYFILTER("Salesperson Code", "Salesperson Code");
                        "Sales Invoice Header".COPYFILTER("Payment Terms Code", "Payment Terms Code");
                        "Sales Invoice Header".COPYFILTER("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        "Sales Invoice Header".COPYFILTER("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        "Sales Invoice Header".COPYFILTER("Sell-to Customer No.", "Sell-to Customer No.");
                        "Sales Invoice Header".COPYFILTER("Location Code", "Location Code");
                        "Sales Invoice Header".COPYFILTER("Tax Area Code", "Tax Area Code");
                        "Sales Invoice Header".COPYFILTER("Responsibility Center", "Responsibility Center");
                        DoingCreditMemos := TRUE;
                        DoingInvoices := FALSE;
                        //CurrReport.CREATETOTALS(Amount, "Amount Including VAT", SalesTax);
                    END ELSE
                        CurrReport.BREAK;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF UseCurrency THEN BEGIN
                    IF Number = 1 THEN
                        TempCurrency.FIND('-')
                    ELSE
                        TempCurrency.NEXT;
                END;

                TotalAmtExclTax := 0.0;
                TotalSalesTax := 0.0;
                TotalAmtInclTax := 0.0;
                DoingInvoices := FALSE;
                DoingCreditMemos := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                IF UseCurrency THEN
                    SETRANGE(Number, 1, TempCurrency.COUNT)
                ELSE BEGIN
                    SETRANGE(Number, 1);
                    CLEAR(TempCurrency);
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(IncludeInvoices; IncludeInvoices)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Invoices';
                    }
                    field(IncludeCreditMemos; IncludeCreditMemos)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Credit Memos';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IncludeInvoices := TRUE;
            IncludeCreditMemos := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF NOT (IncludeInvoices OR IncludeCreditMemos) THEN
            ERROR(Text000);

        CompanyInformation.GET;
        FilterString := "Sales Invoice Header".GETFILTERS;
        UseCurrency := Currency.FIND('-');
    end;

    var
        CompanyInformation: Record "Company Information";
        TempCurrency: Record Currency temporary;
        FilterString: Text[250];
        SalesTax: Decimal;
        DoingInvoices: Boolean;
        DoingCreditMemos: Boolean;
        IncludeInvoices: Boolean;
        IncludeCreditMemos: Boolean;
        UseCurrency: Boolean;
        TotalAmtExclTax: Decimal;
        TotalSalesTax: Decimal;
        TotalAmtInclTax: Decimal;
        Text000: Label 'You must Include either Invoices or Credit Memos.';
        Daily_Invoicing_ReportCaptionLbl: Label 'Daily Invoicing Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Sales_Invoice_Header__No__CaptionLbl: Label 'Invoice Number';
        Sales_Invoice_Header__Posting_Date_CaptionLbl: Label 'Invoice Date';
        SalesTaxCaptionLbl: Label 'Sales Tax';
        Total_of_all_InvoicesCaptionLbl: Label 'Total of all Invoices';
        Sales_Cr_Memo_Header__No__CaptionLbl: Label 'Cr. Memo Number';
        Cr__Memo_DateCaptionLbl: Label 'Cr. Memo Date';
        SalesTax_Control60CaptionLbl: Label 'Sales Tax';
        Total_of_all_Credit_MemosCaptionLbl: Label 'Total of all Credit Memos';
        Grand_Total_of_all_Invoices_and_Credit_MemosCaptionLbl: Label 'Grand Total of all Invoices and Credit Memos';
        "-NUB1.01-": Integer;
        TotalAdjCostLCY: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
        SalesInvLineRecGbl: Record "Sales Invoice Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        AmountLCY: Decimal;
        AdjProfitLCY: Decimal;
        AdjProfitPct: Decimal;
}

