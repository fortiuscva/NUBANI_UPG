report 50023 "Purchase Order Report"
{
    // //RP7  Added 11 fields to the PageLoop Dataitem
    //        Added code to OnPreReport
    //        Added code to "Purchase Header" OnAfterGetRecord trigger
    //        Added one global variables and one Text Constant
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PurchaseOrderReport.rdl';

    Caption = 'Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(No_PurchaseHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                    column(BuyFromAddress1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddress5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddress6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddress7; BuyFromAddress[7])
                    {
                    }
                    column(ExpReceiptDate_PurchHeader; "Purchase Header"."Expected Receipt Date")
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
                    column(BuyfrmVendNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchaseHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchaseHeader; "Purchase Header"."No.")
                    {
                    }
                    column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddress8; BuyFromAddress[8])
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
                    column(CompanyInformationPhoneNo; CompanyInformation."Phone No.")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(VendTaxIdentificationType; FORMAT(Vend."Tax Identification Type"))
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ReceiveByCaption; ReceiveByCaptionLbl)
                    {
                    }
                    column(VendorIDCaption; VendorIDCaptionLbl)
                    {
                    }
                    column(ConfirmToCaption; ConfirmToCaptionLbl)
                    {
                    }
                    column(BuyerCaption; BuyerCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(ToCaption1; ToCaption1Lbl)
                    {
                    }
                    column(PurchOrderCaption; PurchOrderCaptionLbl)
                    {
                    }
                    column(PurchOrderNumCaption; PurchOrderNumCaptionLbl)
                    {
                    }
                    column(PurchOrderDateCaption; PurchOrderDateCaptionLbl)
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
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    // column(RP7; RP7Labels)
                    // {
                    // }
                    column(CompanyInformationPicture; CompanyInformation.Picture)
                    {
                    }
                    column(PurchaseDueDate; "Purchase Header"."Due Date")
                    {
                    }
                    column(PurchaseContact; "Purchase Header"."Buy-from Contact")
                    {
                    }
                    column(PurchaseHeaderLocation; "Purchase Header"."Location Code")
                    {
                    }
                    column(VendorPhoneNo; Vend."Phone No.")
                    {
                    }
                    column(VendorFaxNo; Vend."Fax No.")
                    {
                    }
                    column(VendorEmail; Vend."E-Mail")
                    {
                    }
                    column(LocationPhone; Location."Phone No.")
                    {
                    }
                    column(LocationFax; Location."Fax No.")
                    {
                    }
                    column(VendorOrderNo; "Purchase Header"."Vendor Order No.")
                    {
                    }
                    column(VendorInvoiceNo; "Purchase Header"."Vendor Invoice No.")
                    {
                    }
#pragma warning disable AL0432
                    column(CompanyInformationHomePage; CompanyInformation."Home Page")
#pragma warning restore AL0432
                    {
                    }
                    column(CompanyInformationFaxNo; CompanyInformation."Fax No.")
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                        {
                        }
                        column(Quantity_PurchaseLine; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Description_PurchaseLine; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(InvDiscountAmt_PurchaseLine; "Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(LineAmtTaxAmtInvDiscountAmt; "Line Amount" + TaxAmount - "Inv. Discount Amount")
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
                        column(BreakdownLabel2; BreakdownLabel[2])
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
                        column(DocumentNo_PurchaseLine; "Document No.")
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
                        column(InvDiscCaption; InvDiscCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(ShipAmt; ShipAmt)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            // NA0002.begin
                            // IF "Purchase Header"."Tax Area Code" <> '' THEN
                            // NA0002.end
                            // NA0002.begin
                            IF ("Purchase Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                                // NA0002.end
                                SalesTaxCalc.AddPurchLine("Purchase Line");

                            IF "Vendor Item No." <> '' THEN
                                ItemNumberToPrint := "Vendor Item No."
                            ELSE
                                ItemNumberToPrint := "No.";

                            IF Type = Type::" " THEN BEGIN
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            END;

                            IF (Type = Type::"G/L Account") AND ("No." = '50520') THEN
                                ShipAmt := "Line Amount";


                            AmountExclInvDisc := "Line Amount";

                            IF Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);

                            //NA0003.BEGIN
                            IF OnLineNumber = NumberOfLines THEN BEGIN
                                PrintFooter := TRUE;

                                IF "Purchase Header"."Tax Area Code" <> '' THEN BEGIN
                                    // NA0002.begin
                                    IF UseExternalTaxEngine THEN
                                        SalesTaxCalc.CallExternalTaxEngineForPurch("Purchase Header", TRUE)
                                    ELSE
                                        // NA0002.end
                                        SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                                    BrkIdx := 0;
                                    PrevPrintOrder := 0;
                                    PrevTaxPercent := 0;
                                    TaxAmount := 0;
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
                                                    //IF TaxArea.Country = TaxArea.Country::CA THEN//B2BUPG
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
                                            TaxAmount := TaxAmount + TempSalesTaxAmtLine."Tax Amount";
                                        UNTIL TempSalesTaxAmtLine.NEXT = 0;
                                    IF BrkIdx = 1 THEN BEGIN
                                        CLEAR(BreakdownLabel);
                                        CLEAR(BreakdownAmt);
                                    END;
                                END;
                            END;
                            //NA0003.END
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(AmountExclInvDisc, "Line Amount", "Inv. Discount Amount");
                            NumberOfLines := COUNT;
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
                            PurchasePrinted.RUN("Purchase Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                    TaxAmount := 0;

                    //NA0001.begin
                    CLEAR(BreakdownTitle);
                    CLEAR(BreakdownLabel);
                    CLEAR(BreakdownAmt);
                    TotalTaxLabel := Text008;
                    TaxRegNo := '';
                    TaxRegLabel := '';
                    IF "Purchase Header"."Tax Area Code" <> '' THEN BEGIN
                        TaxArea.GET("Purchase Header"."Tax Area Code");
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
                        UseExternalTaxEngine := TaxArea."Use External Tax Engine";  // NA0002
                        SalesTaxCalc.StartSalesTaxCalculation;
                    END;
                    //NA0001.end
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
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.LANGUAGE := EventsandSubcribes.GetLanguageID("Language Code");

                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;

                END;

                IF "Posting Date" <> 0D THEN
                    UseDate := "Posting Date"
                ELSE
                    UseDate := WORKDATE;

                //RP7 -- Begin
                IF NOT Vend.GET("Buy-from Vendor No.") THEN
                    CLEAR(Vend);

                IF "Location Code" = '' THEN
                    CLEAR(Location)
                ELSE
                    Location.GET("Location Code");
                //RP7 -- End

                ShipAmt := 0;
            end;

            trigger OnPreDataItem()
            begin
                IF PrintCompany THEN
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                ELSE
                    CLEAR(CompanyAddress);
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
        begin
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET('');
        CompanyInformation.CALCFIELDS(Picture); //RP7
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
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
        Text000: Label 'COPY';
        Text001: Label 'Transferred from page %1';
        Text002: Label 'Transferred to page %1';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        UseExternalTaxEngine: Boolean;

        ArchiveDocumentEnable: Boolean;

        LogInteractionEnable: Boolean;
        ToCaptionLbl: Label 'To:';
        ReceiveByCaptionLbl: Label 'Receive By';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        ToCaption1Lbl: Label 'To:';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvDiscCaptionLbl: Label 'Shipping:';
        TotalCaptionLbl: Label 'Total:';
        "--RP7--": Integer;
        Location: Record Location;
        //RP7Labels: '';
        ShipAmt: Decimal;
        EventsandSubcribes: codeunit EventsandSubscribers;
}

