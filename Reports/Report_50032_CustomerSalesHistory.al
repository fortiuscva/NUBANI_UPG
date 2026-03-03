report 50032 "Customer Sales History"
{
    // For use with Navision ATTAIN ver. 3.01 or above.
    // Copyright (c) 2001-2002 Cost Control Software, Incorporated by Richard N. Baxter, Jr.
    // Carmel, Indiana  46033
    // www.costcontrolsoftware.com
    // //Posted Line Lookup
    // 
    // This total section is a report total.  It is NOT
    // designed to sub-total by whatever you are using
    // as a filter.  If you are interested in a particular
    // customer's sales totals, then you would have to filter
    // specifically on that ONE customer, then the report
    // totals section would give you that customer's totals.
    // IF you use a range of customers, then the totals
    // section would give you the total for the range.
    // 
    // // 9/01/2004  Set sort for dataitem 'Customer' to customer no.
    // // 9/01/2004  Set sort for dataitem 'Sales Invoice Line' to posting date
    //    in desending order
    // // 9/01/2004  Set sort for dataitem 'Sales Cr. Memo line' to posting date
    //    in desending order
    // // 9/01/2004  Set up formulas for ExtendCost and LineProfit
    // // 9/01/2004  Adjusted script to total ExtendCost and LineProfit
    // // 9/01/2004  Created variabls to calculate totals for Invoices, Cr. Memos,
    //    and the customer
    // // 4.0 Menu Location: Financial Mgmt, Receivables, Reports, ADD to End of List.
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layout/CustomerSalesHistory.rdlc';
    Caption = 'Customer Sales History';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Customer Posting Group", "Date Filter";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(ItemNo; ItemNo)
            {
            }
            column(ResourceNo; ResourceNo)
            {
            }
            column(GenProdPostingGrp; GenProdPostingGrp)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Posted_Sales_Line_Detail_by_Customer_by_DateCaption; Posted_Sales_Line_Detail_by_Customer_by_DateCaptionLbl)
            {
            }
            column(Filters_Caption; Filters_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(ResourceNoCaption; ResourceNoCaptionLbl)
            {
            }
            column(GenProdPostingGrpCaption; GenProdPostingGrpCaptionLbl)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Posting Date") ORDER(Descending) WHERE(Quantity = FILTER(<> 0));
                column(Sales_Invoice_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Type; Type)
                {
                }
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(Sales_Invoice_Line_Description; Description)
                {
                }
                column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line__Unit_Cost__LCY__; "Unit Cost (LCY)")
                {
                }
                column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Invoice_Line_Amount; Amount)
                {
                }
                column(ExtendCost; ExtendCost)
                {
                }
                column(LineProfit; LineProfit)
                {
                }
                column(IsInvoice; IsInvoice)
                {
                }
                column(TotalFor___FIELDCAPTION__Posting_Date__; TotalFor + FieldCaption("Posting Date"))
                {
                }
                column(Sales_Invoice_Line_Quantity_Control1000000086; Quantity)
                {
                }
                column(Sales_Invoice_Line__Posting_Date__Control1000000016; "Posting Date")
                {
                }
                column(LineProfit_Control1240070016; LineProfit)
                {
                }
                column(ExtendCost_Control1240070015; ExtendCost)
                {
                }
                column(Sales_Invoice_Line_Amount_Control1240070014; Amount)
                {
                }
                column(Sales_Invoice_Line__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(Sales_Invoice_Line__Document_No__Caption; FieldCaption("Document No."))
                {
                }
                column(Sales_Invoice_Line_TypeCaption; FieldCaption(Type))
                {
                }
                column(Sales_Invoice_Line__No__Caption; FieldCaption("No."))
                {
                }
                column(Sales_Invoice_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Sales_Invoice_Line__Unit_of_Measure_Caption; FieldCaption("Unit of Measure"))
                {
                }
                column(Sales_Invoice_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(Sales_Invoice_Lines_Caption; Sales_Invoice_Lines_CaptionLbl)
                {
                }
                column(Sales_Invoice_Line__Unit_Cost__LCY__Caption; FieldCaption("Unit Cost (LCY)"))
                {
                }
                column(Sales_Invoice_Line__Unit_Price_Caption; FieldCaption("Unit Price"))
                {
                }
                column(Extended_PriceCaption; Extended_PriceCaptionLbl)
                {
                }
                column(Extended_CostCaption; Extended_CostCaptionLbl)
                {
                }
                column(Line_Item_ProfitCaption; Line_Item_ProfitCaptionLbl)
                {
                }
                column(Sales_Invoice_Line_Totals_Caption; Sales_Invoice_Line_Totals_CaptionLbl)
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Invoice_Line_Sell_to_Customer_No_; "Sell-to Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AmtBeforeDisc := Quantity * "Unit Cost (LCY)";

                    ExtendCost := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Cost (LCY)";
                    LineProfit := "Sales Invoice Line".Amount - ExtendCost;

                    RptTotQuantity := RptTotQuantity + Quantity;
                    RptTotLDA := RptTotLDA + "Line Discount Amount";
                    RptTotAmt := RptTotAmt + Amount;
                    RptTotAIT := RptTotAIT + "Amount Including VAT";
                    RptTotABD := RptTotABD + AmtBeforeDisc;

                    if IsServiceTier then
                        IsInvoice := true;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Posting Date");
                    ReportFilters := "Sales Invoice Line".GetFilters;

                    /*--Request panel filters----*/
                    if GenProdPostingGrp <> '' then
                        "Sales Invoice Line".SetRange("Posting Group", GenProdPostingGrp);
                    if ItemNo <> '' then
                        "Sales Invoice Line".SetRange("No.", ItemNo);
                    if ResourceNo <> '' then
                        "Sales Invoice Line".SetRange("No.", ResourceNo);
                    /*---------------------------*/

                    CurrReport.CreateTotals(AmtBeforeDisc, ExtendCost, LineProfit);

                end;
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Posting Date") ORDER(Descending) WHERE(Quantity = FILTER(<> 0));
                column(Sales_Cr_Memo_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Sales_Cr_Memo_Line__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Line_Type; Type)
                {
                }
                column(Sales_Cr_Memo_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Cr_Memo_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Cr_Memo_Line_Quantity; Quantity)
                {
                }
                column(Sales_Cr_Memo_Line_Description; Description)
                {
                }
                column(LineProfit_Control1240070010; LineProfit)
                {
                }
                column(ExtendCost_Control1240070011; ExtendCost)
                {
                }
                column(Sales_Cr_Memo_Line__Unit_Cost__LCY__; "Unit Cost (LCY)")
                {
                }
                column(Sales_Cr_Memo_Line_Amount; Amount)
                {
                }
                column(Sales_Cr_Memo_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Cr_Memo_Line_Quantity_Control1000000066; Quantity)
                {
                }
                column(Sales_Cr_Memo_Line__Posting_Date__Control1000000067; "Posting Date")
                {
                }
                column(TotalFor___FIELDCAPTION__Posting_Date___Control1000000068; TotalFor + FieldCaption("Posting Date"))
                {
                }
                column(LineProfit_Control1240070017; LineProfit)
                {
                }
                column(ExtendCost_Control1240070018; ExtendCost)
                {
                }
                column(Sales_Cr_Memo_Line_Amount_Control1240070020; Amount)
                {
                }
                column(Sales_Credit_Memo_Lines_Caption; Sales_Credit_Memo_Lines_CaptionLbl)
                {
                }
                column(Sales_Credit_Memo_Line_Totals_Caption; Sales_Credit_Memo_Line_Totals_CaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Cr_Memo_Line_Sell_to_Customer_No_; "Sell-to Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AmtBeforeDisc := Quantity * "Unit Cost (LCY)";

                    ExtendCost := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Cost (LCY)";
                    LineProfit := "Sales Cr.Memo Line".Amount - ExtendCost;

                    RptTotQuantity := RptTotQuantity - Quantity;

                    RptTotLDA := RptTotLDA - "Line Discount Amount";
                    RptTotAmt := RptTotAmt - Amount;
                    RptTotAIT := RptTotAIT - "Amount Including VAT";
                    RptTotABD := RptTotABD - AmtBeforeDisc;
                end;

                trigger OnPreDataItem()
                begin

                    /*--Request panel filters----*/
                    if GenProdPostingGrp <> '' then
                        "Sales Cr.Memo Line".SetRange("Posting Group", GenProdPostingGrp);
                    if ItemNo <> '' then
                        "Sales Cr.Memo Line".SetRange("No.", ItemNo);
                    if ResourceNo <> '' then
                        "Sales Cr.Memo Line".SetRange("No.", ResourceNo);
                    /*---------------------------*/

                    CurrReport.CreateTotals(AmtBeforeDisc, ExtendCost, LineProfit);

                    if IsServiceTier then
                        IsInvoice := false;

                end;
            }
            dataitem(ReportTotal; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CustTotalC; CustTotalC)
                {
                }
                column(CustTotalP; CustTotalP)
                {
                }
                column(CustTotalA; CustTotalA)
                {
                }
                column(Customer_Totals_Caption; Customer_Totals_CaptionLbl)
                {
                }
                column(ReportTotal_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 1);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                InvoiceTotalA := 0;     //clear variables A=Amount, C=Cost, P=profit
                InvoiceTotalC := 0;
                InvoiceTotalP := 0;
                MemoTotalA := 0;
                MemoTotalC := 0;
                MemoTotalP := 0;
                CustTotalA := 0;
                CustTotalC := 0;
                CustTotalP := 0;

                RptTotQuantity := 0;
                RptTotLDA := 0;
                RptTotAmt := 0;
                RptTotAIT := 0;
                RptTotABD := 0;

                /*--don't print if detail is not there--*/
                InvLinesT.SetCurrentKey("Sell-to Customer No.", Type, "No.", "Posting Date");
                InvLinesT.SetRange("Sell-to Customer No.", "No.");
                InvLinesT.SetRange("Posting Date", FromDate, ToDate);
                if ItemNo <> '' then begin
                    InvLinesT.SetFilter(Type, '=%1', InvLinesT.Type::Item);
                    InvLinesT.SetRange("No.", ItemNo);
                end;
                /*--- rem
                IF ResourceNo <> '' THEN BEGIN
                  InvLinesT.SETFILTER(Type,'=%1',InvLinesT.Type::Resource);
                  InvLinesT.SETRANGE("No.",ResourceNo);
                END;
                ---- rem ---*/
                if GenProdPostingGrp <> '' then
                    InvLinesT.SetRange("Gen. Prod. Posting Group", GenProdPostingGrp);

                if not InvLinesT.Find('-') then begin
                    CMLinesT.SetRange("Sell-to Customer No.", "No.");
                    CMLinesT.SetRange("Posting Date", FromDate, ToDate);
                    if ItemNo <> '' then begin
                        CMLinesT.SetFilter(Type, '=%1', CMLinesT.Type::Item);
                        CMLinesT.SetRange("No.", ItemNo);
                    end;
                    /*---- rem
                        IF ResourceNo <> '' THEN BEGIN
                        CMLinesT.SETFILTER(Type,'=%1',CMLinesT.Type::Resource);
                        CMLinesT.SETRANGE("No.",ResourceNo);
                      END;
                    ------ rem ---*/
                    if GenProdPostingGrp <> '' then
                        CMLinesT.SetRange("Gen. Prod. Posting Group", GenProdPostingGrp);

                    if not CMLinesT.Find('-') then
                        CurrReport.Skip;
                end;

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
                    field(ItemNo; ItemNo)
                    {
                        Caption = 'Item No. Filter';
                        TableRelation = Item;
                        ApplicationArea = All;
                    }
                    field(GenProdPostingGrp; GenProdPostingGrp)
                    {
                        Caption = 'Gen. Prod. Posting Group Code';
                        TableRelation = "Gen. Product Posting Group";
                        ApplicationArea = All;
                    }
                    field(ResourceNo; ResourceNo)
                    {
                        Caption = 'Resource No.';
                        TableRelation = Resource;
                        ApplicationArea = All;
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
        TestFilter := Customer.GetFilter("Date Filter");

        if TestFilter = '' then begin
            FromDate := 19800101D;
            ToDate := 20251231D;
            Customer.SetFilter("Date Filter", '%1..%2', FromDate, ToDate);
        end else begin
            FromDate := Customer.GetRangeMin("Date Filter");
            ToDate := Customer.GetRangeMax("Date Filter");
        end;

        ReportFilters := Customer.GetFilters;

        if (ItemNo <> '') and (ResourceNo <> '') then
            Error('Please select either an Item or a Resource but not both.');
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        ReportFilters: Text[250];
        AmtBeforeDisc: Decimal;
        CMLineProfit: Decimal;
        PostingDate: Date;
        "Sell-toCode": Text[30];
        RptTotQuantity: Decimal;
        RptTotLDA: Decimal;
        RptTotAmt: Decimal;
        RptTotAIT: Decimal;
        RptTotABD: Decimal;
        FromDate: Date;
        ToDate: Date;
        InvLinesT: Record "Sales Invoice Line";
        CMLinesT: Record "Sales Cr.Memo Line";
        ItemNo: Code[20];
        GenProdPostingGrp: Code[10];
        ResourceNo: Code[20];
        TestFilter: Text[150];
        ExtendCost: Decimal;
        LineProfit: Decimal;
        InvoiceTotalC: Decimal;
        InvoiceTotalP: Decimal;
        MemoTotalC: Decimal;
        MemoTotalP: Decimal;
        CustTotalC: Decimal;
        CustTotalP: Decimal;
        InvoiceTotalA: Decimal;
        MemoTotalA: Decimal;
        CustTotalA: Decimal;
        "--FP6--": Integer;
        IsInvoice: Boolean;
        Posted_Sales_Line_Detail_by_Customer_by_DateCaptionLbl: Label 'Posted Sales Line Detail by Customer by Date';
        Filters_CaptionLbl: Label 'Filters:';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ItemNoCaptionLbl: Label 'Item No.       :';
        ResourceNoCaptionLbl: Label 'Resource No.    :';
        GenProdPostingGrpCaptionLbl: Label 'Gen. Prod. Posting Group:';
        Sales_Invoice_Lines_CaptionLbl: Label 'Sales Invoice Lines:';
        Extended_PriceCaptionLbl: Label 'Extended Price';
        Extended_CostCaptionLbl: Label 'Extended Cost';
        Line_Item_ProfitCaptionLbl: Label 'Line Item Profit';
        Sales_Invoice_Line_Totals_CaptionLbl: Label 'Sales Invoice Line Totals:';
        Sales_Credit_Memo_Lines_CaptionLbl: Label 'Sales Credit Memo Lines:';
        Sales_Credit_Memo_Line_Totals_CaptionLbl: Label 'Sales Credit Memo Line Totals:';
        Customer_Totals_CaptionLbl: Label 'Customer Totals:';
}

