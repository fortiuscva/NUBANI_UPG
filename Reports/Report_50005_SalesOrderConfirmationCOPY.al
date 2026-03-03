report 50005 "Sales Order Confirmation_COPY"
{
    // //RP7.3 03/04/13  Doug McIntosh, Cost Control Software
    //   - Corrected the Code.GetData expressions for "Contact", "Cust. Phone", "Cust. FAX" and "Email" fields in Header
    // 
    // -------------------------------------------------------
    // 
    // NUB1.01 ???
    // 
    // NUB1.02,1/14/14,OAS: Add line numbering.
    // 
    // NUB1.03, 1/29/14 : Add ItemSku
    // NUB1.04,08/23/17,SK: Added New Dataitem as "Lot Information".
    //                      Generating the lot details aganst the Sales Line wise and displaying in layout.
    //                      Added code in "LOT Information - OnPreDataItem()" & "LOT Information - OnAfterGetRecord()" & delcared global variables.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SalesOrderConfirmationCOPY.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Order RP70';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(No_SalesHeader; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Order), "Print On Order Confirmation" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0005.begin
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
                        //NA0005.end
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine := "Sales Line";
                    TempSalesLine.INSERT;
                    // NA0012.begin
                    TempSalesLineAsm := "Sales Line";
                    TempSalesLineAsm.INSERT;

                    // NA0012.end
                    HighestLineNo := "Line No.";
                    // NA0004.begin
                    // IF "Sales Header"."Tax Area Code" <> '' THEN
                    // NA0004.end
                    // NA0004.begin
                    IF ("Sales Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                        // NA0004.end
                        SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;

                trigger OnPostDataItem()
                begin
                    IF "Sales Header"."Tax Area Code" <> '' THEN BEGIN
                        // NA0004.begin
                        IF UseExternalTaxEngine THEN
                            SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", TRUE)
                        ELSE
                            // NA0004.end
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

                    //adsk
                    SetRetrieveAsmItemTracking(TRUE);
                    //TrackingSpecCount := ItemTrackingMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Header"."No.", DATABASE::"Sales Header", 0);
                    SetRetrieveAsmItemTracking(FALSE);
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesLine.RESET;
                    TempSalesLine.DELETEALL;
                    // NA0012.begin
                    TempSalesLineAsm.RESET;
                    TempSalesLineAsm.DELETEALL;
                    // NA0012.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Order), "Print On Order Confirmation" = CONST(true), "Document Line No." = CONST(0));

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
                    //NA0005.begin
                    TempSalesLine.INIT;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    TempSalesLine.INSERT;
                    //NA0005.end
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
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
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
                    column(ShptDate_SalesHeader; "Sales Header"."Shipment Date")
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
                    column(YourRef_SalesHeader; "Sales Header"."Your Reference")
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
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(SoldCaption; SoldCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesOrderCaption; SalesOrderCaptionLbl)
                    {
                    }
                    column(SalesOrderNumberCaption; SalesOrderNumberCaptionLbl)
                    {
                    }
                    column(SalesOrderDateCaption; SalesOrderDateCaptionLbl)
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
                    column(PODateCaption; PODateCaptionLbl)
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
                    column(SalesHeaderDueDate; FORMAT("Sales Header"."Due Date"))
                    {
                    }
                    column(SalesHeaderContact; "Sales Header"."Sell-to Contact")
                    {
                    }
                    column(SalesHeaderExtDocNo; "Sales Header"."External Document No.")
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
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(SubTotalVarGbl; SubTotalVarGbl)
                        {
                        }
                        column(InvDiscAmtVarGbl; InvDiscAmtVarGbl)
                        {
                        }
                        column(GrandTotalVarGbl; GrandTotalVarGbl)
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
                        column(TempSalesLineDesc; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(TempSalesLineDocumentNo; TempSalesLine."Document No.")
                        {
                        }
                        column(TempSalesLineLineNo; TempSalesLine."Line No.")
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
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
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
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
                        column(TempSalesLineEach; FORMAT(TempSalesLine.Each, 0, '<Precision,2:4><Integer><Decimals>'))
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
                        {
                        }
                        column(LineSeq; LineSeq)
                        {
                        }
                        column(ItemSKU; ItemSKU)
                        {
                        }
                        dataitem("LOT Information"; "Integer")
                        {
                            DataItemTableView = SORTING(Number) ORDER(Ascending);
                            column(LOTInformation_Number; Number)
                            {
                            }
                            column(Lot_Caption; Lot_CaptionLbl)
                            {
                            }
                            column(Exp_Date_Caption; Exp_Date_CaptionLbl)
                            {
                            }
                            column(ReservEntryGbl_Lot_No; ReservEntryGbl."Lot No.")
                            {
                            }
                            column(ExpirationDateVarGbl; ExpirationDateVarGbl)
                            {
                            }
                            column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                            {
                            }
                            column(TrackingSpecBuffer_ExpDate; TrackingSpecBuffer."Expiration Date")
                            {
                            }
                            column(TrackingSpecCount; TrackingSpecCount)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    TrackingSpecBuffer.FINDSET
                                ELSE
                                    TrackingSpecBuffer.NEXT;

                                /*
                                //NUB1.04 Start
                                IF Number = 1 THEN
                                  ReservEntryGbl.FINDSET
                                ELSE
                                  ReservEntryGbl.NEXT;
                                */

                                ExpDatefromLot := COPYSTR(ReservEntryGbl."Lot No.", 5, 2) + COPYSTR(ReservEntryGbl."Lot No.", 7, 2) + COPYSTR(ReservEntryGbl."Lot No.", 1, 4);
                                EVALUATE(ExpirationDateVarGbl, ExpDatefromLot);
                                //NUB1.04 End

                            end;

                            trigger OnPreDataItem()
                            begin
                                /*
                                //NUB1.04 Start
                                IF TempSalesLine.Type <> TempSalesLine.Type::Item THEN
                                  CurrReport.BREAK;
                                
                                ReservEntryGbl.RESET;
                                ReservEntryGbl.SETRANGE("Source Type",DATABASE::"Sales Line");
                                ReservEntryGbl.SETRANGE("Source Subtype",TempSalesLine."Document Type");
                                ReservEntryGbl.SETRANGE("Source ID",TempSalesLine."Document No.");
                                ReservEntryGbl.SETRANGE("Source Batch Name",'');
                                ReservEntryGbl.SETRANGE("Source Prod. Order Line",0);
                                ReservEntryGbl.SETRANGE("Source Ref. No.",TempSalesLine."Line No.");
                                //ReservEntryGbl.SETRANGE("Item No.",TempSalesLine."No.");
                                SETRANGE(Number,1,ReservEntryGbl.COUNT);
                                //NUB1.04 End
                                */

                                IF TrackingSpecCount = 0 THEN
                                    CurrReport.BREAK;

                                SETRANGE(Number, 1, TrackingSpecCount);

                                TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineUnitOfMeasureText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineType; AsmLine.Type)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                // NA0012.begin
                                IF Number = 1 THEN
                                    AsmLine.FINDSET
                                ELSE
                                    AsmLine.NEXT;
                                // NA0012.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0012.begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                                // NA0012.end
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesLine: Record "Sales Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT;
                            //NUB1.03 - BEGIN
                            ItemSKU := '';
                            CASE TempSalesLine.Type OF
                                TempSalesLine.Type::" ":
                                    BEGIN
                                        TempSalesLine."No." := '';
                                        TempSalesLine."Unit of Measure" := '';
                                        TempSalesLine."Line Amount" := 0;
                                        TempSalesLine."Inv. Discount Amount" := 0;
                                        TempSalesLine.Quantity := 0;
                                    END;
                                TempSalesLine.Type::"G/L Account":
                                    BEGIN
                                        TempSalesLine."No." := '';
                                        LineSeq += 1;
                                    END;
                                TempSalesLine.Type::Item:
                                    BEGIN
                                        tempItem.RESET;
                                        IF tempItem.GET(TempSalesLine."No.") THEN BEGIN
                                            ItemSKU := tempItem."Search Description";
                                        END;
                                        LineSeq += 1;
                                    END;
                                ELSE BEGIN
                                    LineSeq += 1;
                                END;
                            END;
                            //NUB1.03 - END

                            /*
                              IF Type = 0 THEN BEGIN
                                "No." := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                              // NUB1.02 - start
                              END ELSE BEGIN
                                IF Type = Type::"G/L Account" THEN "No." := '';
                                LineSeq += 1;
                              END;
                              // NUB1.02 - end
                              */

                            // NA0006.begin
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
                                UnitPriceToPrint := 0  // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesLine.Quantity, 0.00001);
                            // NA0012.begin
                            IF DisplayAssemblyInformation THEN BEGIN
                                AsmInfoExistsForLine := FALSE;
                                IF TempSalesLineAsm.GET(TempSalesLine."Document Type", TempSalesLine."Document No.", TempSalesLine."Line No.") THEN BEGIN
                                    SalesLine.GET(TempSalesLine."Document Type", TempSalesLine."Document No.", TempSalesLine."Line No.");
                                    AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);
                                END;
                            END;
                            // NA0012.end
                            //NA0007.Begin
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //NA0007.end

                            //NUB1.04 Start
                            SubTotalVarGbl += TempSalesLine."Line Amount";
                            InvDiscAmtVarGbl += TempSalesLine."Inv. Discount Amount";
                            GrandTotalVarGbl := SubTotalVarGbl - InvDiscAmtVarGbl;
                            //NUB1.04 End

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

                    trigger OnPreDataItem()
                    begin
                        TrackingSpecCount := 0; //adsk
                    end;
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

                    //NUB1.04 Start
                    CLEAR(SubTotalVarGbl);
                    CLEAR(InvDiscAmtVarGbl);
                    CLEAR(GrandTotalVarGbl);
                    //NUB1.04 End
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
                CurrReport.LANGUAGE := EventsandSubcribes.GetLanguageID("Language Code");

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
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
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
                    UseExternalTaxEngine := TaxArea."Use External Tax Engine";  // NA0004
                    SalesTaxCalc.StartSalesTaxCalculation;
                END;

                IF "Posting Date" <> 0D THEN
                    UseDate := "Posting Date"
                ELSE
                    UseDate := WORKDATE;

                LineSeq := 0; // NUB1.02
            end;

            trigger OnPreDataItem()
            begin
                // NA0003.begin
                // CompanyInformation.GET('');
                // IF PrintCompany THEN
                //   FormatAddress.Company(CompanyAddress,CompanyInformation)
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
                        ApplicationArea = all;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Company Address';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = all;
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
                        ApplicationArea = all;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field("Display Assembly information"; DisplayAssemblyInformation)
                    {
                        ApplicationArea = all;
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

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
        // NA0003.end
    end;

    var
        LineSeq: Integer;
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesLine: Record "Sales Line" temporary;
        TempSalesLineAsm: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        Item: Record Item;
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
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
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        TaxAmount: Decimal;
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Transferred from page %1';
        Text002: Label 'Transferred to page %1';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Sales Tax:';
        Text008: Label 'Tax:';
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
        UseExternalTaxEngine: Boolean;

        ArchiveDocumentEnable: Boolean;

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        SoldCaptionLbl: Label 'Sold';
        ToCaptionLbl: Label 'To:';
        ShipDateCaptionLbl: Label 'Ship Date';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        SalesOrderCaptionLbl: Label 'Sales Order';
        SalesOrderNumberCaptionLbl: Label 'Sales Order Number';
        SalesOrderDateCaptionLbl: Label 'Sales Order Date';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        PODateCaptionLbl: Label 'P.O. Date';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Number';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Case Price';
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
        LocationT: Record Location;
        tempItem: Record Item;
        ItemSKU: Code[50];
        "-NUB1.04-": Integer;
        ReservEntryGbl: Record "Reservation Entry";
        ExpDatefromLot: Text;
        ExpirationDateVarGbl: Date;
        Lot_CaptionLbl: Label 'Lot No.:';
        Exp_Date_CaptionLbl: Label 'Exp. Date:';
        "-": Integer;
        SubTotalVarGbl: Decimal;
        InvDiscAmtVarGbl: Decimal;
        GrandTotalVarGbl: Decimal;
        TrackSpecRecGbl: Record "Tracking Specification";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        TrackingSpecCount: Integer;
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        EventsandSubcribes: codeunit EventsandSubscribers;
        Text009: label 'Table %1 is not supported';


    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0012.begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
        // NA0012.end
    end;


    procedure BlanksForIndent(): Text[10]
    begin
        // NA0012.begin
        EXIT(PADSTR('', 2, ' '));
        // NA0012.end
    end;

    procedure SetRetrieveAsmItemTracking(RetrieveAsmItemTracking2: Boolean)
    var
        RetrieveAsmItemTracking: Boolean;
    begin
        RetrieveAsmItemTracking := RetrieveAsmItemTracking2;
    end;


    /*procedure RetrieveDocumentItemTracking(VAR TrackingSpecBuffer :  Record "Tracking Specification" temporary;SourceID : Code[20];SourceType : Integer;SourceSubType : Option) : Integer
     begin

     //retrieves Item Tracking for Purchase Header, Sales Header, Sales Shipment Header, Sales Invoice Header

    TrackingSpecBuffer.DELETEALL;

    CASE SourceType OF
      DATABASE::"Purchase Header":
        RDITPurchase(TrackingSpecBuffer,SourceID,SourceSubType);
      DATABASE::"Sales Header":
        RDITSales(TrackingSpecBuffer,SourceID,SourceSubType);
      DATABASE::"Service Header":
        RDITService(TrackingSpecBuffer,SourceID,SourceSubType);
      DATABASE::"Sales Shipment Header":
        RDITSalesShipment(TrackingSpecBuffer,SourceID);
      DATABASE::"Sales Invoice Header":
        RDITSalesInvoice(TrackingSpecBuffer,SourceID);
      DATABASE::"Service Shipment Header":
        RDITServiceShipment(TrackingSpecBuffer,SourceID);
      DATABASE::"Service Invoice Header":
        RDITServiceInvoice(TrackingSpecBuffer,SourceID);
      ELSE
        ERROR(Text009,SourceType);
    END;

    TrackingSpecBuffer.RESET;
    EXIT(TrackingSpecBuffer.COUNT);

     end;

     procedure RDITPurchase(VAR TempTrackingSpecBuffer : Record "Tracking Specification" TEMPORARY ;SourceID : Code[20];SourceSubType : Option)
     var
     PurchaseLine : Record "Purchase Line";
     Descr : text;
     begin
        
PurchaseLine.SETRANGE("Document Type",SourceSubType);
PurchaseLine.SETRANGE("Document No.",SourceID);
IF NOT PurchaseLine.ISEMPTY THEN BEGIN
  PurchaseLine.FINDSET;
  REPEAT
    IF (PurchaseLine.Type = PurchaseLine.Type::Item) AND
       (PurchaseLine."Quantity (Base)" <> 0)
    THEN BEGIN
      IF Item.GET(PurchaseLine."No.") THEN
        Descr := Item.Description;
      FindReservEntries(TempTrackingSpecBuffer,DATABASE::"Purchase Line",PurchaseLine."Document Type",
        PurchaseLine."Document No.",'',0,PurchaseLine."Line No.",Descr);
      FindTrackingEntries(TempTrackingSpecBuffer,DATABASE::"Purchase Line",PurchaseLine."Document Type",
        PurchaseLine."Document No.",'',0,PurchaseLine."Line No.",Descr);
    END;
  UNTIL PurchaseLine.NEXT = 0;
END;

     end;

     procedure FindReservEntries(VAR TempTrackingSpecBuffer :  Record "Tracking Specification" TEMPORARY;Type : Integer;Subtype : Integer;ID : Code[20];BatchName : Code[10];ProdOrderLine : Integer;RefNo : Integer;Description : Text[50])
     begin
        
FilterReservEntries(ReservEntry,Type,Subtype,ID,BatchName,ProdOrderLine,RefNo);
IF ReservEntry.FINDSET THEN
  REPEAT
    IF (ReservEntry."Lot No." <> '') OR (ReservEntry."Serial No." <> '') THEN
      FillTrackingSpecBuffer(TempTrackingSpecBuffer,Type,Subtype,ID,BatchName,
        ProdOrderLine,RefNo,Description,ReservEntry."Item No.",ReservEntry."Lot No.",
        ReservEntry."Serial No.",ReservEntry."Quantity (Base)");
  UNTIL ReservEntry.NEXT = 0;

     end;*/
}

