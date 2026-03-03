report 50021 "Sales Invoice Report"
{
    // //RP7.3  Changed header fields from field reference to function call
    // NUB1.01,09/27/19,ST: Modifications to format the totals and print the value with dollar sign.
    //                       - Modified the format settings and used regional settings to print thousands seperator and dollar sign.
    // NUB1.02,11/11/2019,SK: Added "Each" column into layout.
    //         11/12/2019,SK: Adjusted the Item No Column in layout.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SalesInvoiceReport.rdl';

    Caption = 'Sales Invoice RP70';
    EnableHyperlinks = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';
            column(No_SalesInvHeader; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0007- Begin
                        TempSalesInvoiceLine.INIT;
                        TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                        TempSalesInvoiceLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesInvoiceLine."Line No.";
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) THEN BEGIN
                            TempSalesInvoiceLine.Description := Comment;
                            TempSalesInvoiceLine."Description 2" := '';
                        END ELSE BEGIN
                            SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                            WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                                SpacePointer := SpacePointer - 1;
                            IF SpacePointer = 1 THEN
                                SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                            TempSalesInvoiceLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesInvoiceLine."Description 2" :=
                              COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                        END;
                        TempSalesInvoiceLine.INSERT;
                        //NA0007 - End
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.INSERT;
                    // NA0014.begin
                    TempSalesInvoiceLineAsm := "Sales Invoice Line";
                    TempSalesInvoiceLineAsm.INSERT;

                    // NA0014.end
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.RESET;
                    TempSalesInvoiceLine.DELETEALL;
                    // NA0014.begin
                    TempSalesInvoiceLineAsm.RESET;
                    TempSalesInvoiceLineAsm.DELETEALL;
                    // NA0014.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine.INIT;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) THEN BEGIN
                        TempSalesInvoiceLine.Description := Comment;
                        TempSalesInvoiceLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                    END;
                    TempSalesInvoiceLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    //NA0007- Begin
                    TempSalesInvoiceLine.INIT;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                    TempSalesInvoiceLine.INSERT;
                    //NA0007- End
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInformationPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(ShptDate_SalesInvHeader; "Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(DueDate_SalesInvHeader; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesInvHeader; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesInvHeader; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderDate_SalesInvHeader; "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesInvHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocumentDate_SalesInvHeader; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(DocumentText; DocumentText)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(InvoiceNumberCaption; InvoiceNumberCaptionLbl)
                    {
                    }
                    column(InvoiceDateCaption; InvoiceDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
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
                    column(SalesInvContact; "Sales Invoice Header"."Sell-to Contact")
                    {
                    }
                    column(SalesInvExtDocNo; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(SalesInvLocCode; "Sales Invoice Header"."Location Code")
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
                    dataitem(SalesInvLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineNo; TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLineUOM; TempSalesInvoiceLine."Unit of Measure")
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLineQty; TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(LowDescriptionToPrint; LowDescriptionToPrint)
                        {
                        }
                        column(HighDescriptionToPrint; HighDescriptionToPrint)
                        {
                        }
                        column(TempSalesInvoiceLineDocNo; TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLineLineNo; TempSalesInvoiceLine."Line No.")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtTaxLiable; TempSalesInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtAmtExclInvDisc; TempSalesInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVATAmount; TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVAT; TempSalesInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(TempSalesInvoiceLineEach; FORMAT(TempSalesInvoiceLine.Each, 0, '<Precision,2:4><Integer><Decimals>'))
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(ItemNumberCaption; ItemNumberCaptionLbl)
                        {
                        }
                        column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(OrderQtyCaption; OrderQtyCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(AmountSubjecttoSalesTaxCaption; AmountSubjecttoSalesTaxCaptionLbl)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption; AmountExemptfromSalesTaxCaptionLbl)
                        {
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                //DecimalPlaces = 0:5;
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // NA0014.begin
                                IF Number = 1 THEN
                                    TempPostedAsmLine.FINDSET
                                ELSE
                                    TempPostedAsmLine.NEXT;
                                // NA0014.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0014.begin
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                                // NA0014.end
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesInvoiceLine.FIND('-')
                            ELSE
                                TempSalesInvoiceLine.NEXT;

                            OrderedQuantity := 0;
                            IF "Sales Invoice Header"."Order No." = '' THEN
                                OrderedQuantity := TempSalesInvoiceLine.Quantity
                            ELSE BEGIN
                                IF OrderLine.GET(1, "Sales Invoice Header"."Order No.", TempSalesInvoiceLine."Line No.") THEN
                                    OrderedQuantity := OrderLine.Quantity
                                ELSE BEGIN
                                    ShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SETRANGE("Order Line No.", TempSalesInvoiceLine."Line No.");
                                    IF ShipmentLine.FIND('-') THEN
                                        //NA0002
                                        REPEAT
                                            OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                        UNTIL 0 = ShipmentLine.NEXT;
                                END;
                            END;

                            DescriptionToPrint := TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2";
                            IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                IF OnLineNumber < NumberOfLines THEN BEGIN
                                    TempSalesInvoiceLine.NEXT;
                                    IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::" " THEN BEGIN
                                        DescriptionToPrint :=
                                          COPYSTR(DescriptionToPrint + ' ' + TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2", 1, MAXSTRLEN(DescriptionToPrint));
                                        OnLineNumber := OnLineNumber + 1;
                                        SalesInvLine.NEXT;
                                    END ELSE
                                        TempSalesInvoiceLine.NEXT(-1);
                                END;
                                TempSalesInvoiceLine."No." := '';
                                TempSalesInvoiceLine."Unit of Measure" := '';
                                TempSalesInvoiceLine.Amount := 0;
                                TempSalesInvoiceLine."Amount Including VAT" := 0;
                                TempSalesInvoiceLine."Inv. Discount Amount" := 0;
                                TempSalesInvoiceLine.Quantity := 0;
                            END ELSE IF TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" THEN
                                    TempSalesInvoiceLine."No." := '';

                            IF TempSalesInvoiceLine."No." = '' THEN BEGIN
                                HighDescriptionToPrint := DescriptionToPrint;
                                LowDescriptionToPrint := '';
                            END ELSE BEGIN
                                HighDescriptionToPrint := '';
                                LowDescriptionToPrint := DescriptionToPrint;
                            END;

                            IF TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesInvoiceLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";

                            IF TempSalesInvoiceLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0
                            // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);

                            //NA0010.Begin
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //NA0010.end
                            // NA0014.begin
                            CollectAsmInformation(TempSalesInvoiceLine);
                            // NA0014.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, AmountExclInvDisc, TempSalesInvoiceLine.Amount, TempSalesInvoiceLine."Amount Including VAT");
                            NumberOfLines := TempSalesInvoiceLine.COUNT;
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
                            SalesInvPrinted.RUN("Sales Invoice Header");
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
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustAddr: array[8] of Text[100];
            begin
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;
                END;
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");B2BUPG
                CurrReport.LANGUAGE := EventsandSubscriber.GetLanguageID("Language Code");

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                // NA0003.begin
                IF NOT Customer.GET("Bill-to Customer No.") THEN BEGIN
                    CLEAR(Customer);
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                END;
                // NA0003.end
                //NA0008.begin
                DocumentText := USText000;
                IF "Prepayment Invoice" THEN
                    DocumentText := USText001;
                //NA0008.end

                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress, CustAddr, "Sales Invoice Header");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                //RPK7 begin
                IF "Location Code" = '' THEN
                    CLEAR(LocationT)
                ELSE
                    LocationT.GET("Location Code");

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);

                //RPK7 end

                // NA0003.begin
                // Customer.GET("Bill-to Customer No.");
                // NA0003.end

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;

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
                    // NA0006.begin
                    IF TaxArea."Use External Tax Engine" THEN
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, "No.")
                    ELSE BEGIN
                        // NA0006.end
                        SalesTaxCalc.AddSalesInvoiceLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    END;  // NA0006
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

            trigger OnPreDataItem()
            begin
                // NA0004.begin
                // CompanyInformation.GET('');
                // IF PrintCompany THEN
                //   FormatAddress.Company(CompanyAddress,CompanyInformation)
                // ELSE
                //   CLEAR(CompanyAddress);
                // NA0004.end
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
                        ApplicationArea = All;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        // NA0004.begin
        CompanyInformation.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
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
        // NA0004.end
    end;

    var
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        TempSalesInvoiceLineAsm: Record "Sales Invoice Line" temporary;
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Item: Record Item;
        Cust: Record Customer;
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
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
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
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
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID INVOICE';
        DocumentText: Text[20];
        USText000: Label 'INVOICE';
        USText001: Label 'PREPAYMENT REQUEST';

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        ShipViaCaptionLbl: Label 'Ship Via';
        ShipDateCaptionLbl: Label 'Ship Date';
        DueDateCaptionLbl: Label 'Due Date';
        TermsCaptionLbl: Label 'Terms';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        InvoiceNumberCaptionLbl: Label 'Invoice Number:';
        InvoiceDateCaptionLbl: Label 'Invoice Date';
        PageCaptionLbl: Label 'Page:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemDescriptionCaptionLbl: Label 'Description';
        UnitCaptionLbl: Label 'Unit';
        OrderQtyCaptionLbl: Label 'Order Qty';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmountSubjecttoSalesTaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        AmountExemptfromSalesTaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        RP7Labels: Label 'RP 7 Labels';
        CustomerPhoneCaptionlbl: Label 'Cust. Phone';
        CustomerFaxCaptionlbl: Label 'Cust. Fax';
        WebsiteCaptionLbl: Label 'Website:';
        PhoneCaptionLbl: Label 'Phone:';
        FaxCaptionLbl: Label 'Fax:';
        LocationT: Record Location;
        ItemNumberCaptionLbl: Label 'Number';
        EventsandSubscriber: codeunit EventsandSubscribers;


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;


    procedure CollectAsmInformation(TempSalesInvoiceLine: Record "Sales Invoice Line" temporary)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        // NA0014.begin
        TempPostedAsmLine.DELETEALL;
        IF NOT DisplayAssemblyInformation THEN
            EXIT;
        IF NOT TempSalesInvoiceLineAsm.GET(TempSalesInvoiceLine."Document No.", TempSalesInvoiceLine."Line No.") THEN
            EXIT;
        SalesInvoiceLine.GET(TempSalesInvoiceLineAsm."Document No.", TempSalesInvoiceLineAsm."Line No.");
        IF SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item THEN
            EXIT;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
        IF NOT ValueEntry.FINDSET THEN
            EXIT;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
            END;
        UNTIL ValueEntry.NEXT = 0;
        // NA0014.end
    end;


    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        // NA0014.begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
        // NA0014.end
    end;


    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0014.begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
        // NA0014.end
    end;


    procedure BlanksForIndent(): Text[10]
    begin
        // NA0014.begin
        EXIT(PADSTR('', 2, ' '));
        // NA0014.end
    end;
}

