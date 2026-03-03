report 50071 "Commission Report - GrossV1"
{
    // For use with Navision ATTAIN ver. 3.01 or above.
    // Copyright (c) 2001-2002 Cost Control Software, Incorporated by Richard N. Baxter, Jr.
    // Carmel, Indiana  46033
    // www.costcontrolsoftware.com
    // //Foundation Pack
    // FP6.2.02
    Caption = 'NUB Commission Report - GrossV1';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/CommissionReportGrossV1.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Date Filter";
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(ReportID; ReportID)
            {
            }
            column(SalespersonFilters_________ReportFilters_________LineFilters; SalespersonFilters + ' ' + ReportFilters + ' ' + LineFilters)
            {
            }
            column(ShowDetail; ShowDetail)
            {
            }
            column(Salesperson_Purchaser__Name; "Salesperson/Purchaser".Name)
            {
            }
            column(Salesperson_Purchaser__Code; "Salesperson/Purchaser".Code)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(OnlyOnePerPage; OnlyOnePerPage)
            {
            }
            column(GTAmount; GTAmount)
            {
            }
            column(GTCommAmt; GTCommAmt)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Posted_CommissionsCaption; Posted_CommissionsCaptionLbl)
            {
            }
            column(Filters_Caption; Filters_CaptionLbl)
            {
            }
            column(CommAmt_Control1240080005Caption; CommAmt_Control1240080005CaptionLbl)
            {
            }
            column(Salesperson_Purchaser___Commission____Control1240080013Caption; Salesperson_Purchaser___Commission____Control1240080013CaptionLbl)
            {
            }
            column(Extended_PriceCaption; Extended_PriceCaptionLbl)
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Bill_to_Customer_No_Caption; Bill_to_Customer_No_CaptionLbl)
            {
            }
            column(Sell_to_Customer_No_Caption; Sell_to_Customer_No_CaptionLbl)
            {
            }
            column(Shipment_DateCaption; Shipment_DateCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(ContactCaption_Control1240080006; ContactCaption_Control1240080006Lbl)
            {
            }
            column(NameCaption_Control1240080007; NameCaption_Control1240080007Lbl)
            {
            }
            column(Bill_to_CustomerCaption; Bill_to_CustomerCaptionLbl)
            {
            }
            column(Sell_to_CustomerCaption; Sell_to_CustomerCaptionLbl)
            {
            }
            column(Shipment_DateCaption_Control1240080009; Shipment_DateCaption_Control1240080009Lbl)
            {
            }
            column(Posting_DateCaption_Control1240080011; Posting_DateCaption_Control1240080011Lbl)
            {
            }
            column(No_Caption_Control1240080012; No_Caption_Control1240080012Lbl)
            {
            }
            column(Salesperson_Purchaser__CodeCaption; Salesperson_Purchaser__CodeCaptionLbl)
            {
            }
            column(Report_TotalsCaption; Report_TotalsCaptionLbl)
            {
            }
            column(Salesperson_Purchaser_Date_Filter; "Date Filter")
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Sell-to Customer No.";
                RequestFilterHeading = 'Enter Invoice Filter(s) :';
                column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Contact_; "Sales Invoice Header"."Bill-to Contact")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___Sell_to_Customer_No__; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___Shipment_Date_; "Sales Invoice Header"."Shipment Date")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
                {
                }
                column(Sales_Invoice_Header__Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                {
                }
                column(InvoiceFlag; InvoiceFlag)
                {
                }
                column(SpAmount; SpAmount)
                {
                }
                column(CommAmt; CommAmt)
                {
                }
                column(InvGroupNo; InvGroupNo)
                {
                }
                column(Sales_Invoice_Totals__Caption; Sales_Invoice_Totals__CaptionLbl)
                {
                }
                column(Sales_Invoice_Header_Salesperson_Code; "Salesperson Code")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(<> " "));
                    RequestFilterFields = Type, "No.", "Location Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Job No.";
                    RequestFilterHeading = 'Enter Line Item Filter(s):';
                    column(Sales_Invoice_Line_Description; Description)
                    {
                    }
                    column(Sales_Invoice_Line_Quantity; Quantity)
                    {
                    }
                    column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                    {
                    }
                    column(Sales_Invoice_Line_Amount; Amount)
                    {
                    }
                    column(Sales_Invoice_Line_Type; Type)
                    {
                    }
                    column(Sales_Invoice_Line__No__; "No.")
                    {
                    }
                    column(Sales_Invoice_Line__Location_Code_; "Location Code")
                    {
                    }
                    column(Sales_Invoice_Line__Shipment_Date_; "Shipment Date")
                    {
                    }
                    // column(Salesperson_Purchaser___Commission___; "Salesperson/Purchaser"."Commission %")
                    // {
                    // }
                    column(Salesperson_Purchaser___Commission___; ItemRec."Commission %")
                    {
                    }
                    column(CommAmt_Control1240080030; CommAmt)
                    {
                    }
                    column(Salesperson_Purchaser___Commission____Control1240080013; "Salesperson/Purchaser"."Commission %")
                    {
                    }
                    column(CommAmt_Control1240080005; CommAmt)
                    {
                    }
                    column(Sales_Invoice_Line_Amount_Control1240080016; Amount)
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Contact_; "Sales Invoice Header"."Bill-to Contact")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_Customer_No__; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(Sales_Invoice_Header___Shipment_Date_; "Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(CommAmt_Control1240080025; CommAmt)
                    {
                    }
                    column(Sales_Invoice_Line_Amount_Control57; Amount)
                    {
                    }
                    column(Commission_AmountCaption; Commission_AmountCaptionLbl)
                    {
                    }
                    column(Extended_PriceCaption_Control52; Extended_PriceCaption_Control52Lbl)
                    {
                    }
                    column(Commission__Caption; Commission__CaptionLbl)
                    {
                    }
                    column(QuantityCaption; QuantityCaptionLbl)
                    {
                    }
                    column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Line_DescriptionCaption; FieldCaption(Description))
                    {
                    }
                    column(Sales_Invoice_Line__No__Caption; FieldCaption("No."))
                    {
                    }
                    column(Sales_Invoice_Line__Location_Code_Caption; FieldCaption("Location Code"))
                    {
                    }
                    column(Sales_Invoice_Line__Shipment_Date_Caption; FieldCaption("Shipment Date"))
                    {
                    }
                    column(Sales_Invoice_Line_TypeCaption; FieldCaption(Type))
                    {
                    }
                    column(Total_for_Invoice__Caption; Total_for_Invoice__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Line_Document_No_; "Document No.")
                    {
                    }
                    column(Sales_Invoice_Line_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CommAmt := 0;
                        if ItemRec.Get("No.") then
                            CommAmt := (ItemRec."Commission %" * Amount) / 100;
                        //CommAmt := ("Salesperson/Purchaser"."Commission %" * Amount) / 100;
                        SpAmount := SpAmount + Amount;
                        GTAmount := GTAmount + Amount;
                        GTCommAmt := GTCommAmt + CommAmt;

                        if PrintToExcel then
                            MakeExcelDataBodyInv;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CreateTotals(Amount, CommAmt);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //IF ISSERVICETIER THEN
                    //  InvGroupNo := InvGroupNo + 1;
                    InvoiceFlag := true;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("Sales Invoice Line".Amount, CommAmt);
                    SpAmount := 0;
                    //InvGroupNo :=  1;
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                column(Sales_Cr_Memo_Header__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Cr_Memo_Header__Shipment_Date_; "Shipment Date")
                {
                }
                column(Sales_Cr_Memo_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Name_; "Bill-to Name")
                {
                }
                column(Sales_Cr_Memo_Header__Bill_to_Contact_; "Bill-to Contact")
                {
                }
                column(CrMemoGroupNo; CrMemoGroupNo)
                {
                }
                column(InvoiceFlag2; InvoiceFlag)
                {
                }
                column(CrCommAmt; -CrCommAmt)
                {
                }
                column(CrSpAmount; -CrSpAmount)
                {
                }
                column(Credit_Memo_Totals_Caption; Credit_Memo_Totals_CaptionLbl)
                {
                }
                column(Sales_Cr_Memo_Header_Salesperson_Code; "Salesperson Code")
                {
                }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Sell-to Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(<> " "));
                    column(Sales_Cr_Memo_Line_Type; Type)
                    {
                    }
                    column(Sales_Cr_Memo_Line__No__; "No.")
                    {
                    }
                    column(Sales_Cr_Memo_Line__Location_Code_; "Location Code")
                    {
                    }
                    column(Sales_Cr_Memo_Line__Shipment_Date_; "Shipment Date")
                    {
                    }
                    column(Sales_Cr_Memo_Line_Description; Description)
                    {
                    }
                    column(Sales_Cr_Memo_Line_Quantity; Quantity)
                    {
                    }
                    column(Sales_Cr_Memo_Line__Unit_Price_; "Unit Price")
                    {
                    }
                    column(Amount; -Amount)
                    {
                    }
                    column(Salesperson_Purchaser___Commission____Control1240080061; "Salesperson/Purchaser"."Commission %")
                    {
                    }
                    column(CrCommAmt_Control1240080062; -CrCommAmt)
                    {
                    }
                    column(CrCommAmt_Control1240080063; -CrCommAmt)
                    {
                    }
                    column(Salesperson_Purchaser___Commission____Control1240080064; "Salesperson/Purchaser"."Commission %")
                    {
                    }
                    column(Amount_Control1240080065; -Amount)
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Contact_; "Sales Cr.Memo Header"."Bill-to Contact")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Name_; "Sales Cr.Memo Header"."Bill-to Name")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Sell_to_Customer_No__; "Sales Cr.Memo Header"."Sell-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Shipment_Date_; "Sales Cr.Memo Header"."Shipment Date")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Posting_Date_; "Sales Cr.Memo Header"."Posting Date")
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(CrCommAmt_Control1240080073; -CrCommAmt)
                    {
                    }
                    column(Amount_Control1000000008; -Amount)
                    {
                    }
                    column(Commission_AmountCaption_Control1240080051; Commission_AmountCaption_Control1240080051Lbl)
                    {
                    }
                    column(Extended_PriceCaption_Control1240080052; Extended_PriceCaption_Control1240080052Lbl)
                    {
                    }
                    column(Commission__Caption_Control1240080053; Commission__Caption_Control1240080053Lbl)
                    {
                    }
                    column(Unit_PriceCaption_Control1240080054; Unit_PriceCaption_Control1240080054Lbl)
                    {
                    }
                    column(QuantityCaption_Control1240080055; QuantityCaption_Control1240080055Lbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(Shipment_DateCaption_Control1000000040; Shipment_DateCaption_Control1000000040Lbl)
                    {
                    }
                    column(Location_CodeCaption; Location_CodeCaptionLbl)
                    {
                    }
                    column(No_Caption_Control1000000038; No_Caption_Control1000000038Lbl)
                    {
                    }
                    column(TypeCaption; TypeCaptionLbl)
                    {
                    }
                    column(Total_for_Credit_Memo__Caption; Total_for_Credit_Memo__CaptionLbl)
                    {
                    }
                    column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
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
                        CrCommAmt := 0;
                        if ItemRec.Get("No.") then
                            CrCommAmt := ("Salesperson/Purchaser"."Commission %" * Amount) / 100;
                        CrSpAmount := CrSpAmount + Amount;
                        GTAmount := GTAmount - Amount;
                        GTCommAmt := GTCommAmt - CrCommAmt;
                        InvoiceFlag := false;
                        if PrintToExcel then
                            MakeExcelDataBodyCr;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //Type,No.,Location Code,Shortcut Dimension 1 Code,Shortcut Dimension 2 Code,Job No.
                        "Sales Invoice Line".CopyFilter("Sales Invoice Line".Type, "Sales Cr.Memo Line".Type);


                        CurrReport.CreateTotals(Amount, CrCommAmt);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.SKIP;
                    if IsServiceTier then
                        if FirstTime then
                            CrMemoGroupNo := CrMemoGroupNo + 1;
                    FirstTime := false;
                end;

                trigger OnPreDataItem()
                begin
                    "Sales Invoice Header".CopyFilter("Sales Invoice Header"."Posting Date", "Sales Cr.Memo Header"."Posting Date");
                    "Sales Invoice Header".CopyFilter("Sales Invoice Header"."Sell-to Customer No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                    "Sales Invoice Header".CopyFilter("Sales Invoice Header"."Salesperson Code", "Sales Cr.Memo Header"."Salesperson Code");


                    CurrReport.CreateTotals("Sales Cr.Memo Line".Amount, CrCommAmt);
                    CrSpAmount := 0;
                    FirstTime := true;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if IsServiceTier then begin
                    if OnlyOnePerPage then
                        PageGroupNo := PageGroupNo + 1;
                    InvGroupNo := InvGroupNo + 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if PrintToExcel then
                    MakeExcelInfo;
                CurrReport.NewPagePerRecord := OnlyOnePerPage;
                InvGroupNo := 0;
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
                    field(OnlyOnePerPage; OnlyOnePerPage)
                    {
                        Caption = 'New Page Per Salesperson';
                        ApplicationArea = All;
                    }
                    field(ShowDetail; ShowDetail)
                    {
                        Caption = 'Show Detail';
                        ApplicationArea = All;
                    }

                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
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
    trigger OnInitReport()
    begin
        ExcelBuf.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        if PrintToExcel then
            CreateExcelBook;
    end;

    trigger OnPreReport()
    begin
        SalespersonFilters := "Salesperson/Purchaser".GetFilters;
        ReportFilters := "Sales Invoice Header".GetFilters;
        LineFilters := "Sales Invoice Line".GetFilters;
        ReportID := CurrReport.ObjectId;
        CompanyInformation.Get;

        if IsServiceTier then begin
            PageGroupNo := 0;
            CodeFilter := CopyStr("Salesperson/Purchaser".GetFilter(Code), 1, MaxStrLen(CodeFilter));
        end;

    end;

    var
        ItemRec: Record Item;
        CompanyInformation: Record "Company Information";
        AmountST: Decimal;
        AmountGT: Decimal;
        ReportFilters: Text[250];
        ReportID: Text[50];
        RptTotalAmount: Decimal;
        RptTotalExtended: Decimal;
        RptTotalLine: Decimal;
        ShowDetail: Boolean;
        CommAmt: Decimal;
        ReportTitle: Text[50];
        int: Integer;
        SpAmount: Decimal;
        CrCommAmt: Decimal;
        CrSpAmount: Decimal;
        SalespersonFilters: Text[250];
        GTAmount: Decimal;
        GTCommAmt: Decimal;
        Text001: Label 'Commissions';
        Text002: Label 'NUB Commission Report - GrossV1';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date/Time';
        Text008: Label 'Extended Price';
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text009: Label 'Commission Percent';
        Text010: Label 'Commission Amount';
        Text011: Label 'Filters';
        LineFilters: Text[250];
        OnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        CodeFilter: Text[30];
        InvGroupNo: Integer;
        CrMemoGroupNo: Integer;
        InvoiceFlag: Boolean;
        FirstTime: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Posted_CommissionsCaptionLbl: Label 'Posted Commissions';
        Filters_CaptionLbl: Label 'Filters:';
        CommAmt_Control1240080005CaptionLbl: Label 'Commission Amount';
        Salesperson_Purchaser___Commission____Control1240080013CaptionLbl: Label 'Commission %';
        Extended_PriceCaptionLbl: Label 'Extended Price';
        ContactCaptionLbl: Label 'Contact';
        NameCaptionLbl: Label 'Name';
        Bill_to_Customer_No_CaptionLbl: Label 'Bill-to Customer No.';
        Sell_to_Customer_No_CaptionLbl: Label 'Sell-to Customer No.';
        Shipment_DateCaptionLbl: Label 'Shipment Date';
        Posting_DateCaptionLbl: Label 'Posting Date';
        No_CaptionLbl: Label 'No.';
        ContactCaption_Control1240080006Lbl: Label 'Contact';
        NameCaption_Control1240080007Lbl: Label 'Name';
        Bill_to_CustomerCaptionLbl: Label 'Bill-to Customer';
        Sell_to_CustomerCaptionLbl: Label 'Sell-to Customer';
        Shipment_DateCaption_Control1240080009Lbl: Label 'Shipment Date';
        Posting_DateCaption_Control1240080011Lbl: Label 'Posting Date';
        No_Caption_Control1240080012Lbl: Label 'No.';
        Salesperson_Purchaser__CodeCaptionLbl: Label 'Salesperson:';
        Report_TotalsCaptionLbl: Label 'Report Totals';
        Sales_Invoice_Totals__CaptionLbl: Label 'Sales Invoice Totals :';
        Commission_AmountCaptionLbl: Label 'Commission Amount';
        Extended_PriceCaption_Control52Lbl: Label 'Extended Price';
        Commission__CaptionLbl: Label 'Commission %';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Total_for_Invoice__CaptionLbl: Label 'Total for Invoice :';
        Credit_Memo_Totals_CaptionLbl: Label 'Credit Memo Totals:';
        Commission_AmountCaption_Control1240080051Lbl: Label 'Commission Amount';
        Extended_PriceCaption_Control1240080052Lbl: Label 'Extended Price';
        Commission__Caption_Control1240080053Lbl: Label 'Commission %';
        Unit_PriceCaption_Control1240080054Lbl: Label 'Unit Price';
        QuantityCaption_Control1240080055Lbl: Label 'Quantity';
        DescriptionCaptionLbl: Label 'Description';
        Shipment_DateCaption_Control1000000040Lbl: Label 'Shipment Date';
        Location_CodeCaptionLbl: Label 'Location Code';
        No_Caption_Control1000000038Lbl: Label 'No.';
        TypeCaptionLbl: Label 'Type';
        Total_for_Credit_Memo__CaptionLbl: Label 'Total for Credit Memo :';


    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, FALSE, FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn(Report::"Commission Report - GrossV1", FALSE, FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 2);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', 3);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', 1);
        ExcelBuf.AddInfoColumn((SalespersonFilters + ' ' + ReportFilters + ' ' + LineFilters), FALSE, FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.NewRow;

        ExcelBuf.ClearNewRow;

        MakeExcelDataHeader;


    end;


    procedure MakeExcelDataHeader()
    begin
        //0=Number,1=Text,2=Date,3=Time

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Salesperson/Purchaser".FIELDCAPTION(Code), FALSE, '', TRUE, FALSE, TRUE, '@', 1);
        ExcelBuf.AddColumn("Salesperson/Purchaser".FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Posting Date"), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Shipment Date"), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Bill-to Name"), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        ExcelBuf.AddColumn("Sales Invoice Header".FIELDCAPTION("Bill-to Contact"), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        IF ShowDetail THEN BEGIN
            ExcelBuf.AddColumn("Sales Invoice Line".FIELDCAPTION(Type), FALSE, '', TRUE, FALSE, TRUE, '', 1);
            ExcelBuf.AddColumn("Sales Invoice Line".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', 1);
            ExcelBuf.AddColumn("Sales Invoice Line".FIELDCAPTION("Location Code"), FALSE, '', TRUE, FALSE, TRUE, '', 1);
            ExcelBuf.AddColumn("Sales Invoice Line".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', 1);
        END;

        ExcelBuf.AddColumn(FORMAT(Text008), FALSE, '', TRUE, FALSE, TRUE, '', 1);  //Extended Price
        ExcelBuf.AddColumn(FORMAT(Text009), FALSE, '', TRUE, FALSE, TRUE, '', 1);  //Commis Percent
        ExcelBuf.AddColumn(FORMAT(Text010), FALSE, '', TRUE, FALSE, TRUE, '', 1);  //Commis Amount


    end;

    //  [Scope('Internal')] PC
    procedure MakeExcelDataBodyInv()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Salesperson/Purchaser".Code, FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn("Salesperson/Purchaser".Name, FALSE, '', FALSE, FALSE, FALSE, '', 1);


        ExcelBuf.AddColumn(("Sales Invoice Header"."No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', 2);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Shipment Date"), FALSE, '', FALSE, FALSE, FALSE, '', 2);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Sell-to Customer No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Bill-to Customer No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Bill-to Name"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Invoice Header"."Bill-to Contact"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        IF ShowDetail THEN BEGIN
            ExcelBuf.AddColumn((FORMAT("Sales Invoice Line".Type)), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Invoice Line"."No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Invoice Line"."Location Code"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Invoice Line".Description), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        END;
        ExcelBuf.AddColumn(("Sales Invoice Line".Amount), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);
        ExcelBuf.AddColumn((ItemRec."Commission %"), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);
        ExcelBuf.AddColumn(CommAmt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);


    end;


    PROCEDURE CreateExcelbook()
    BEGIN
        ExcelBuf.CreateNewBook(Text001);
        ExcelBuf.WriteSheet(Text001, CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo(Text001, UserId));
        ExcelBuf.OpenExcel();
    END;

    //[Scope('Internal')]   PC
    procedure MakeExcelDataBodyCr()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Salesperson/Purchaser".Code, FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn("Salesperson/Purchaser".Name, FALSE, '', FALSE, FALSE, FALSE, '', 1);


        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', 2);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Shipment Date"), FALSE, '', FALSE, FALSE, FALSE, '', 2);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Sell-to Customer No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Bill-to Customer No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Bill-to Name"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        ExcelBuf.AddColumn(("Sales Cr.Memo Header"."Bill-to Contact"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        IF ShowDetail THEN BEGIN
            ExcelBuf.AddColumn((FORMAT("Sales Cr.Memo Line".Type)), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Cr.Memo Line"."No."), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Cr.Memo Line"."Location Code"), FALSE, '', FALSE, FALSE, FALSE, '', 1);
            ExcelBuf.AddColumn(("Sales Cr.Memo Line".Description), FALSE, '', FALSE, FALSE, FALSE, '', 1);
        END;
        ExcelBuf.AddColumn((-"Sales Cr.Memo Line".Amount), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);
        ExcelBuf.AddColumn(("Salesperson/Purchaser"."Commission %"), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);
        ExcelBuf.AddColumn(-CrCommAmt, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', 0);

    end;

}

