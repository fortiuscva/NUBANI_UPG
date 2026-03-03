report 51014 "Sales Credit Memo RP"
{
    // //RP7.3  Adjust Header fields to change when printing multiple documents
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Layout/SalesCreditMemoRP.rdl';

    Caption = 'Sales Credit Memo RP RTC';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Type" = CONST("Posted Credit Memo"),
                                              "Print On Credit Memo" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        TempSalesCrMemoLine.INIT;
                        TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                        TempSalesCrMemoLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesCrMemoLine."Line No.";
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesCrMemoLine.Description) THEN BEGIN
                            TempSalesCrMemoLine.Description := Comment;
                            TempSalesCrMemoLine."Description 2" := '';
                        END ELSE BEGIN
                            SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                            WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                                SpacePointer := SpacePointer - 1;
                            IF SpacePointer = 1 THEN
                                SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                            TempSalesCrMemoLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesCrMemoLine."Description 2" :=
                              COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesCrMemoLine."Description 2"));
                        END;
                        TempSalesCrMemoLine.INSERT;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine := "Sales Cr.Memo Line";
                    TempSalesCrMemoLine.INSERT;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.RESET;
                    TempSalesCrMemoLine.DELETEALL;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST("Posted Credit Memo"),
                                          "Print On Credit Memo" = CONST(true),
                                          "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine.INIT;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCrMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCrMemoLine."Line No.";
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesCrMemoLine.Description) THEN BEGIN
                        TempSalesCrMemoLine.Description := Comment;
                        TempSalesCrMemoLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                        TempSalesCrMemoLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesCrMemoLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesCrMemoLine."Description 2"));
                    END;
                    TempSalesCrMemoLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.INIT;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCrMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCrMemoLine."Line No.";
                    TempSalesCrMemoLine.INSERT;
                end;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInformation_Picture; CompanyInformation.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_; BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_; BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_; BillToAddress[7])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Shipment_Date_; "Sales Cr.Memo Header"."Shipment Date")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Applies_to_Doc__Type_; "Sales Cr.Memo Header"."Applies-to Doc. Type")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Applies_to_Doc__No__; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(ShipToAddress_1_; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress_2_; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress_3_; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress_4_; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress_5_; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress_6_; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress_7_; ShipToAddress[7])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Your_Reference_; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Document_Date_; "Sales Cr.Memo Header"."Document Date")
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PAGENO)
                    {
                    }
                    column(BillToAddress_8_; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress_8_; ShipToAddress[8])
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CompanyAddress_1_; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress_2_; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress_3_; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress_4_; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress_5_; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress_6_; CompanyAddress[6])
                    {
                    }
                    column(CompanyAddress_7_; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress_8_; CompanyAddress[8])
                    {
                    }
                    column(CreditCaption; CreditCaptionLbl)
                    {
                    }
                    column(To_Caption; To_CaptionLbl)
                    {
                    }
                    column(Ship_DateCaption; Ship_DateCaptionLbl)
                    {
                    }
                    column(Apply_to_TypeCaption; Apply_to_TypeCaptionLbl)
                    {
                    }
                    column(Apply_to_NumberCaption; Apply_to_NumberCaptionLbl)
                    {
                    }
                    column(Customer_IDCaption; Customer_IDCaptionLbl)
                    {
                    }
                    column(P_O__NumberCaption; P_O__NumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(To_Caption_Control89; To_Caption_Control89Lbl)
                    {
                    }
                    column(CREDIT_MEMOCaption; CREDIT_MEMOCaptionLbl)
                    {
                    }
                    column(Credit_Memo_Number_Caption; Credit_Memo_Number_CaptionLbl)
                    {
                    }
                    column(Credit_Memo_Date_Caption; Credit_Memo_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(RP7; RP7Labels)
                    {
                    }
                    column(CustomerPhoneCaption; CustomerPhoneCaptionlbl)
                    {
                    }
                    column(CustomerPhone; Cust."Phone No.")
                    {
                    }
                    column(CustomerFaxCaption; CustomerFaxCaptionlbl)
                    {
                    }
                    column(CustomerFax; Cust."Fax No.")
                    {
                    }
                    column(CustomerEMail; Cust."E-Mail")
                    {
                    }
                    column(SalesCrMemoContact; "Sales Cr.Memo Header"."Sell-to Contact")
                    {
                    }
                    column(SalesCrMemoExtDocNo; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(SalesCrMemoLocCode; "Sales Cr.Memo Header"."Location Code")
                    {
                    }
                    column(LocationPhone; LocationT."Phone No.")
                    {
                    }
                    column(LocationFax; LocationT."Fax No.")
                    {
                    }
#pragma warning disable AL0432
                    column(CompanyInformationHomePage; CompanyInformation."Home Page")
#pragma warning restore AL0432
                    {
                    }
                    column(CompanyInformationPhoneNo; CompanyInformation."Phone No.")
                    {
                    }
                    column(CompanyInformationFaxNo; CompanyInformation."Fax No.")
                    {
                    }
                    column(WebsiteCaption; WebsiteCaptionLbl)
                    {
                    }
                    column(PhoneCaption; PhoneCaptionLbl)
                    {
                    }
                    column(FaxCaption; FaxCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    dataitem(SalesCrMemoLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(STRSUBSTNO_Text001_CurrReport_PAGENO___1_; STRSUBSTNO(Text001, CurrReport.PAGENO - 1))
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine__No__; TempSalesCrMemoLine."No.")
                        {
                        }
                        column(TempSalesCrMemoLine__Unit_of_Measure_; TempSalesCrMemoLine."Unit of Measure")
                        {
                        }
                        column(TempSalesCrMemoLine_Quantity; TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(AmountExclInvDisc_Control53; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine_Description_________TempSalesCrMemoLine__Description_2_; TempSalesCrMemoLine.Description + ' ' + TempSalesCrMemoLine."Description 2")
                        {
                        }
                        column(STRSUBSTNO_Text002_CurrReport_PAGENO___1_; STRSUBSTNO(Text002, CurrReport.PAGENO + 1))
                        {
                        }
                        column(AmountExclInvDisc_Control40; AmountExclInvDisc)
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLine_Amount___TaxLiable; TempSalesCrMemoLine.Amount - TaxLiable)
                        {
                        }
                        column(AmountExclInvDisc_Control79; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine_Amount___AmountExclInvDisc; TempSalesCrMemoLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT____TempSalesCrMemoLine_Amount; TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT_; TempSalesCrMemoLine."Amount Including VAT")
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel_1_; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel_2_; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt_1_; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt_2_; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownAmt_3_; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel_3_; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt_4_; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel_4_; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
#pragma warning disable AL0432
                        column(CompanyInformation__Home_Page_; CompanyInformation."Home Page")
#pragma warning restore AL0432
                        {
                        }
                        column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
                        {
                        }
                        column(CompanyInformation__Fax_No__; CompanyInformation."Fax No.")
                        {
                        }
                        column(Item_No_Caption; Item_No_CaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Total_PriceCaption; Total_PriceCaptionLbl)
                        {
                        }
                        column(Subtotal_Caption; Subtotal_CaptionLbl)
                        {
                        }
                        column(Invoice_Discount_Caption; Invoice_Discount_CaptionLbl)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(Amount_Subject_to_Sales_TaxCaption; Amount_Subject_to_Sales_TaxCaptionLbl)
                        {
                        }
                        column(Amount_Exempt_from_Sales_TaxCaption; Amount_Exempt_from_Sales_TaxCaptionLbl)
                        {
                        }
                        column(Visit_us_on_line_at__Caption; Visit_us_on_line_at__CaptionLbl)
                        {
                        }
                        column(Thank_you_for_your_business_Caption; Thank_you_for_your_business_CaptionLbl)
                        {
                        }
                        column(Call_on_us_at_Caption; Call_on_us_at_CaptionLbl)
                        {
                        }
                        column(CompanyInformation__Fax_No__Caption; CompanyInformation__Fax_No__CaptionLbl)
                        {
                        }
                        column(SalesCrMemoLine_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            IF OnLineNumber = 1 THEN
                                TempSalesCrMemoLine.FIND('-')
                            ELSE
                                TempSalesCrMemoLine.NEXT;

                            IF TempSalesCrMemoLine.Type = TempSalesCrMemoLine.Type::" " THEN BEGIN
                                TempSalesCrMemoLine."No." := '';
                                TempSalesCrMemoLine."Unit of Measure" := '';
                                TempSalesCrMemoLine.Amount := 0;
                                TempSalesCrMemoLine."Amount Including VAT" := 0;
                                TempSalesCrMemoLine."Inv. Discount Amount" := 0;
                                TempSalesCrMemoLine.Quantity := 0;
                            END ELSE IF TempSalesCrMemoLine.Type = TempSalesCrMemoLine.Type::"G/L Account" THEN
                                    TempSalesCrMemoLine."No." := '';

                            IF TempSalesCrMemoLine.Amount <> TempSalesCrMemoLine."Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesCrMemoLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesCrMemoLine.Amount + TempSalesCrMemoLine."Inv. Discount Amount";

                            IF TempSalesCrMemoLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0
                            // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesCrMemoLine.Quantity, 0.00001);

                            //IF ISSERVICETIER THEN BEGIN
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempSalesCrMemoLine.Amount, TempSalesCrMemoLine."Amount Including VAT");
                            NumberOfLines := TempSalesCrMemoLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PAGENO := 1;

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesCrMemoPrinted.RUN("Sales Cr.Memo Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;
                END;
                CurrReport.LANGUAGE := NUBLanguage.GetLanguageIdOrDefault("Language Code");

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Bill-to Customer No." = '' THEN BEGIN
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                END;

                FormatAddress.SalesCrMemoBillTo(BillToAddress, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddress, ShipToAddress, "Sales Cr.Memo Header");

                //RPK7 begin
                IF "Location Code" = '' THEN
                    CLEAR(LocationT)
                ELSE
                    LocationT.GET("Location Code");

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                //RPK7 end

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            BEGIN
                                TotalTaxLabel := Text007;
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            END;
                    END;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    IF TaxArea."Use External Tax Engine" THEN
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Cr.Memo Header", 0, "No.")
                    ELSE BEGIN
                        SalesTaxCalc.AddSalesCrMemoLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    END;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;
                    TempSalesTaxAmtLine.RESET;
                    TempSalesTaxAmtLine.SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                    IF TempSalesTaxAmtLine.FIND('-') THEN
                        REPEAT
                            IF (TempSalesTaxAmtLine."Print Order" = 0) OR
                               (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) OR
                               (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent)
                            THEN BEGIN
                                BrkIdx := BrkIdx + 1;
                                IF BrkIdx > 1 THEN BEGIN
                                    IF TaxArea."Country/Region" = TaxArea."Country/Region"::CA THEN
                                        BreakdownTitle := Text006
                                    ELSE
                                        BreakdownTitle := Text003;
                                END;
                                IF BrkIdx > ARRAYLEN(BreakdownAmt) THEN BEGIN
                                    BrkIdx := BrkIdx - 1;
                                    BreakdownLabel[BrkIdx] := Text004;
                                END ELSE
                                    BreakdownLabel[BrkIdx] := STRSUBSTNO(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                            END;
                            BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                        UNTIL TempSalesTaxAmtLine.NEXT = 0;
                    IF BrkIdx = 1 THEN BEGIN
                        CLEAR(BreakdownLabel);
                        CLEAR(BreakdownAmt);
                    END;
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
                    field(NoCopies; NoCopies)
                    {
                        Caption = 'Number of Copies';
                        ApplicationArea = All;
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        Caption = 'Print Company Address';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        SalesSetup.GET;
        CompanyInformation.CALCFIELDS(Picture);  //RP7
        CompanyInfo3.GET;
        CompanyInfo3.CALCFIELDS(Picture);
        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInformation.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;

        IF PrintCompany THEN
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        ELSE
            CLEAR(CompanyAddress);
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Transferred from page %1';
        Text002: Label 'Transferred to page %1';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID CREDIT MEMO';
        LogInteractionEnable: Boolean;
        CreditCaptionLbl: Label 'Credit';
        To_CaptionLbl: Label 'To:';
        Ship_DateCaptionLbl: Label 'Ship Date';
        Apply_to_TypeCaptionLbl: Label 'Apply to Type';
        Apply_to_NumberCaptionLbl: Label 'Apply to Number';
        Customer_IDCaptionLbl: Label 'Customer ID';
        P_O__NumberCaptionLbl: Label 'Your Reference';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        To_Caption_Control89Lbl: Label 'To:';
        CREDIT_MEMOCaptionLbl: Label 'CREDIT MEMO';
        Credit_Memo_Number_CaptionLbl: Label 'Credit Memo Number:';
        Credit_Memo_Date_CaptionLbl: Label 'Credit Memo Date:';
        Page_CaptionLbl: Label 'Page:';
        Item_No_CaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Total_PriceCaptionLbl: Label 'Total Price';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Invoice_Discount_CaptionLbl: Label 'Invoice Discount:';
        Total_CaptionLbl: Label 'Total:';
        Amount_Subject_to_Sales_TaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        Amount_Exempt_from_Sales_TaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        Visit_us_on_line_at__CaptionLbl: Label 'Website:';
        Thank_you_for_your_business_CaptionLbl: Label 'Thank you for your business.';
        Call_on_us_at_CaptionLbl: Label 'Phone:';
        CompanyInformation__Fax_No__CaptionLbl: Label 'Fax:';
        RP7Labels: Label 'RP 7 Labels';
        CustomerPhoneCaptionlbl: Label 'Cust. Phone';
        CustomerFaxCaptionlbl: Label 'Cust. Fax';
        WebsiteCaptionLbl: Label 'Website:';
        PhoneCaptionLbl: Label 'Phone:';
        FaxCaptionLbl: Label 'Fax:';
        LocationT: Record Location;
        Cust: Record Customer;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        CompanyInfo3: Record "Company Information";
}

