report 50101 "Sales Quote RP70_UPG"//14004473
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-04-07" area="REPORTS SR" feature="622"
    //     releaseversion="NAVUS3.70">NA Sales Document</add>
    //   <change id="NA0003" dev="JNOZZI" date="2006-06-05" area="REPORTS SR" feature="337"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Implement the W1 Logo Position functionality.</change>
    //   <change id="NA0004" dev="MBAHADUR" date="2007-12-10" area="REPORTS SR" feature="0003"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">modified sales comment line tableview property to
    //     support comment line feature.</change>
    //   <change id="NA0005" dev="JNOZZI" date="2007-12-20" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Implement hooks to External Sales Tax Engine.
    //     </change>
    //   <change id="NA0006" dev="V-JELI" date="2008-05-16" area="NASALESTAX" feature="37492"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Change in handling Blank Tax Area on lines.</change>
    //   <change id="NA0007" dev="V-LOLU" date="2008-06-10" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Report Transformation - Local Report Layout.</change>
    //   <change id="NA0008" dev="V-JOOSTL" date="2009-04-23" area="REPORTS SR"  request="PS37379"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">If header comments exist, an extra blank page is printed
    //     before the documentt.</change>
    //   <add id="NA0009" dev="ALL-E" date="2010-11-15" area="MX" feature="VSTF202674"
    //     releaseversion="NA7.00">RFC and CURP data fields</add>
    // </changelog>
    // 
    // 
    // RP7.0
    // NUB1.01,11/11/2019,SK: Added "Each" column into layout.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SalesQuoteRP70.rdl';

    Caption = 'Sales Quote RP70';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Quote));
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Type" = CONST(Quote),
                                              "Print On Quote" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0004.begin
                        TempSalesLine.INIT;
                        TempSalesLine."Document Type" := "Sales Header"."Document Type";
                        TempSalesLine."Document No." := "Sales Header"."No.";
                        TempSalesLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesLine."Line No.";
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                            TempSalesLine.Description := Comment;
                            TempSalesLine."Description 2" := '';
                        END ELSE BEGIN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                            WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                                SpacePointer := SpacePointer - 1;
                            IF SpacePointer = 1 THEN
                                SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                            TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                        END;
                        TempSalesLine.INSERT;
                        //NA0004.end
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine := "Sales Line";
                    TempSalesLine.INSERT;
                    HighestLineNo := "Line No.";
                    // NA0005.begin
                    // IF "Sales Header"."Tax Area Code" <> '' THEN
                    // NA0005.end
                    // NA0005.begin
                    IF ("Sales Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                        // NA0005.end
                        SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;

                trigger OnPostDataItem()
                begin
                    IF "Sales Header"."Tax Area Code" <> '' THEN BEGIN
                        // NA0005.begin
                        IF UseExternalTaxEngine THEN
                            SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", TRUE)
                        ELSE
                            // NA0005.end
                            SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
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
                    TempSalesLine.RESET;
                    TempSalesLine.DELETEALL;
                end;
            }
            dataitem(DataItem8541; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST(Quote),
                                          "Print On Quote" = CONST(true),
                                          "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine.INIT;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                        TempSalesLine.Description := Comment;
                        TempSalesLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                    END;
                    TempSalesLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    //NA0004.begin
                    TempSalesLine.INIT;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    TempSalesLine.INSERT;
                    //NA0004.end
                end;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInformation.Picture)
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(OrderDate_SalesHeader; "Sales Header"."Order Date")
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
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
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
                    column(CustTaxIdentificationType; FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(SellCaption; SellCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesQuoteCaption; SalesQuoteCaptionLbl)
                    {
                    }
                    column(SalesQuoteNumberCaption; SalesQuoteNumberCaptionLbl)
                    {
                    }
                    column(SalesQuoteDateCaption; SalesQuoteDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
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
                    column(SalesHeaderDueDate; "Sales Header"."Due Date")
                    {
                    }
                    column(SalesHeaderShipDate; "Sales Header"."Shipment Date")
                    {
                    }
                    column(SalesHeaderContact; "Sales Header"."Sell-to Contact")
                    {
                    }
                    column(SalesHeaderExtDocNo; "Sales Header"."External Document No.")
                    {
                    }
                    column(SalesHeaderYourRef; "Sales Header"."Your Reference")
                    {
                    }
                    column(SalesHeaderLocCode; "Sales Header"."Location Code")
                    {
                    }
                    column(LocationPhone; LocationT."Phone No.")
                    {
                    }
                    column(LocationFax; LocationT."Fax No.")
                    {
                    }
                    dataitem(SalesLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Number_IntegerLine; SalesLine.Number)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesLineNo; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLineUOM; TempSalesLine."Unit of Measure")
                        {
                        }
                        column(TempSalesLineQuantity; TempSalesLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesLineDescription; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesLineLineAmtTaxLiable; TempSalesLine."Line Amount" - TaxLiable)
                        {
                        }
                        column(TempSalesLineInvDiscAmt; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(TempSalesLineLineAmtTaxAmtInvDiscAmt; TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TempSalesLineEach; FORMAT(TempSalesLine.Each, 0, '<Precision,2:4><Integer><Decimals>'))
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
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
                        column(AmtSubjecttoSalesTaxCptn; AmtSubjecttoSalesTaxCptnLbl)
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
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

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT;

                            IF TempSalesLine.Type.AsInteger() = 0 THEN BEGIN
                                TempSalesLine."No." := '';
                                TempSalesLine."Unit of Measure" := '';
                                TempSalesLine."Line Amount" := 0;
                                TempSalesLine."Inv. Discount Amount" := 0;
                                TempSalesLine.Quantity := 0;
                            END ELSE IF TempSalesLine.Type = TempSalesLine.Type::"G/L Account" THEN
                                    TempSalesLine."No." := '';
                            // NA0006.begin
                            // TaxAmount := "Amount Including VAT" - Amount;
                            IF TempSalesLine."Tax Area Code" <> '' THEN
                                TaxAmount := TempSalesLine."Amount Including VAT" - TempSalesLine.Amount
                            ELSE
                                TaxAmount := 0;
                            // NA0006.end
                            IF TaxAmount <> 0 THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesLine."Line Amount";

                            IF TempSalesLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0
                            // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesLine.Quantity, 0.00001);

                            //NA0007.begin
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //NA0007.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, TaxAmount, AmountExclInvDisc, TempSalesLine."Line Amount", TempSalesLine."Inv. Discount Amount");
                            NumberOfLines := TempSalesLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    //CurrReport.PAGENO := 1;

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesPrinted.RUN("Sales Header");
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
                CurrReport.Language := EventandSubscriber.GetLanguageID("Language Code");

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                // NA0002.begin
                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);
                // NA0002.end


                //RPK6.1 begin
                IF "Location Code" = '' THEN
                    CLEAR(LocationT)
                ELSE
                    LocationT.GET("Location Code");
                //RPK6.1 end

                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, CustAddr, "Sales Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
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
                    UseExternalTaxEngine := TaxArea."Use External Tax Engine";  // NA0005
                    SalesTaxCalc.StartSalesTaxCalculation;
                END;

                UseDate := WORKDATE;
            end;

            trigger OnPreDataItem()
            begin
                // NA0003.begin
                // CompanyInformation.GET('');
                // IF PrintCompany THEN
                //     FormatAddress.Company(CompanyAddress,CompanyInformation)
                // ELSE
                //   CLEAR(CompanyAddress);
                // NA0003.end
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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        var
            DocumentType: Enum "Interaction Log Entry Document Type";
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type".FromInteger(1)) <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInformation.CALCFIELDS(Picture); //RP7.0
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
    end;

    trigger OnPreReport()
    begin
        // NA0003.begin
        CompanyInformation.GET;
        SalesSetup.GET;

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
        // NA0003.end
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInformation: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        CompanyInfo3: Record 79;
        CompanyInfo: Record 79;
        SalesSetup: Record 311;
        TempSalesLine: Record 37 temporary;
        RespCenter: Record 5714;
        LanguageRec: Record 8;
        TempSalesTaxAmtLine: Record 10011 temporary;
        TaxArea: Record 318;
        Cust: Record 18;
        Item: Record 27;
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
        SalesPrinted: Codeunit 313;
        FormatAddress: Codeunit 365;
        SalesTaxCalc: Codeunit 398;
        ArchiveManagement: Codeunit 5063;
        TaxAmount: Decimal;
        SegManagement: Codeunit 5051;
        ArchiveDocument: Boolean;
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
        UseDate: Date;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        UseExternalTaxEngine: Boolean;
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        SellCaptionLbl: Label 'Sell';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        SalesQuoteCaptionLbl: Label 'Sales Quote';
        SalesQuoteNumberCaptionLbl: Label 'Sales Quote Number:';
        SalesQuoteDateCaptionLbl: Label 'Sales Quote Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Number';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmtSubjecttoSalesTaxCptnLbl: Label 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxCptnLbl: Label 'Amount Exempt from Sales Tax';
        RP7Labels: Label 'RP 7 Labels';
        CustomerPhoneCaptionlbl: Label 'Cust. Phone';
        CustomerFaxCaptionlbl: Label 'Cust. Fax';
        WebsiteCaptionLbl: Label 'Website:';
        PhoneCaptionLbl: Label 'Phone:';
        FaxCaptionLbl: Label 'Fax:';
        LocationT: Record 14;
        SalesHeader: Record "Sales Header";
        CustAddr: array[8] of Text[100];
        EventandSubscriber: codeunit EventsandSubscribers;
}

