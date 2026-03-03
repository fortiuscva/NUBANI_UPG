report 50022 "Sales Shipment Report"
{
    // //RP7.3  Adjusted the header to work with multiple documents
    // NUB1.01,08/04/16,ST: Report modified to print only the lines which are shipping and to print the additional description defined for the lines.
    // NUB1.02,05/16/19,ST: Modified code to fix the error with line no.
    //                        - Added and commented code in "Sales Shipment Line - OnAfterGetRecord()".
    // NUB1.03,02/17/21,SK: Added code to fix the Totals of Shipped and Net Weight columns.
    //         04/19/22,SK: Moved the totals cummulative code to another place.
    //         05/23/22,SK: Clearing the Grandtotals to avoid wrong totals with multiple copies "CopyLoop - OnAfterGetRecord()".
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SalesShipmentReport.rdl';

    Caption = 'Sales Shipment';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Quantity = FILTER(<> 0));
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0005.begin
                        TempSalesShipmentLine.INIT;
                        TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                        TempSalesShipmentLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesShipmentLine."Line No.";
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesShipmentLine.Description) THEN BEGIN
                            TempSalesShipmentLine.Description := Comment;
                            TempSalesShipmentLine."Description 2" := '';
                        END ELSE BEGIN
                            SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                            WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                                SpacePointer := SpacePointer - 1;
                            IF SpacePointer = 1 THEN
                                SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                            TempSalesShipmentLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesShipmentLine."Description 2" :=
                              COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesShipmentLine."Description 2"));
                        END;
                        TempSalesShipmentLine.INSERT;
                        //NA0005.end
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine := "Sales Shipment Line";
                    TempSalesShipmentLine.INSERT;

                    //NUB1.01 Start
                    CLEAR(SkipLoopVarGbl);
                    NextShptLineRecGbl.RESET;
                    NextShptLineRecGbl.SETRANGE("Document No.", "Document No.");
                    NextShptLineRecGbl.SETFILTER("Line No.", '>%1', "Line No.");
                    IF NextShptLineRecGbl.FINDSET THEN
                        REPEAT
                            IF NextShptLineRecGbl."No." <> '' THEN
                                SkipLoopVarGbl := TRUE
                            ELSE BEGIN
                                TempSalesShipmentLine := NextShptLineRecGbl;
                                HighestLineNo := NextShptLineRecGbl."Line No."; //NUB1.02
                                TempSalesShipmentLine.INSERT;
                            END;
                        UNTIL (NextShptLineRecGbl.NEXT = 0) OR SkipLoopVarGbl;
                    //NUB1.01 End

                    // NA0008.begin
                    TempSalesShipmentLineAsm := "Sales Shipment Line";
                    TempSalesShipmentLineAsm.INSERT;
                    // NA0008.end
                    //HighestLineNo := "Line No.";  //NUB1.02
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.RESET;
                    TempSalesShipmentLine.DELETEALL;
                    // NA0008.begin
                    TempSalesShipmentLineAsm.RESET;
                    TempSalesShipmentLineAsm.DELETEALL;
                    // NA0008.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine.INIT;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesShipmentLine.Description) THEN BEGIN
                        TempSalesShipmentLine.Description := Comment;
                        TempSalesShipmentLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesShipmentLine.Description) + 1;
                        TempSalesShipmentLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesShipmentLine."Description 2" :=
                          COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesShipmentLine."Description 2"));
                    END;
                    TempSalesShipmentLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    //NA0005.begin
                    TempSalesShipmentLine.INIT;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    TempSalesShipmentLine.INSERT;
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
                    column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ShptDate_SalesShptHeader; "Sales Shipment Header"."Shipment Date")
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
                    column(OrderDate_SalesShptHeader; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(PackageTrackingNoText; PackageTrackingNoText)
                    {
                    }
                    column(ShippingAgentCodeText; ShippingAgentCodeText)
                    {
                    }
                    column(ShippingAgentCodeLabel; ShippingAgentCodeLabel)
                    {
                    }
                    column(PackageTrackingNoLabel; PackageTrackingNoLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoopNumber; Number)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
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
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(ShipmentNumberCaption; ShipmentNumberCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
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
                    column(SalesShipContact; "Sales Shipment Header"."Sell-to Contact")
                    {
                    }
                    column(SalesShipExtDocNo; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(SalesShipLocCode; "Sales Shipment Header"."Location Code")
                    {
                    }
                    column(PaymentTermsDescription; "Sales Shipment Header"."Payment Terms Code")
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
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(PickedByCaption; PickedByCaptionLbl)
                    {
                    }
                    column(PackedByCaption; PackedByCaptionLbl)
                    {
                    }
                    column(ReceivedByCaption; ReceivedByCaptionLbl)
                    {
                    }
                    dataitem(SalesShptLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TotalWeight; TempSalesShipmentLine.Quantity * TempSalesShipmentLine."Net Weight")
                        {
                        }
                        column(WeightCaption; WeightCaptionLbl)
                        {
                        }
                        column(SalesShptLineNumber; SalesShptLine.Number)
                        {
                        }
                        column(TempSalesShptLineNo; TempSalesShipmentLine."No.")
                        {
                        }
                        column(TempSalesShptLineUOM; TempSalesShipmentLine."Unit of Measure")
                        {
                        }
                        column(TempSalesShptLineQy; TempSalesShipmentLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TotalShippedQty; TotalShippedQty)
                        {
                        }
                        column(GrandTotalWeight; GrandTotalWeight)
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQuantity; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesShptLineDesc; TempSalesShipmentLine.Description + ' ' + TempSalesShipmentLine."Description 2")
                        {
                        }
                        column(PackageTrackingText; PackageTrackingText)
                        {

                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(PrintFooter; PrintFooter)
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
                        column(ShippedCaption; ShippedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        dataitem(SNLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(Number_SNLoop; SNLoop.Number)
                            {
                            }
                            column(SerialNoCaption; SerialNoLbl)
                            {
                            }
                            column(SerialNbrsDisplay; SerialNbrsDisplay)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                SNList: array[5] of Code[20];
                            begin
                                //SERIALNOS
                                IF SNLoop.Number = 1 THEN
                                    TempItemLedgEntry.FINDFIRST
                                ELSE
                                    TempItemLedgEntry.NEXT;
                                TotalSerialNosProcessed += 1;

                                CLEAR(SNList);
                                SerialNbrsDisplay := TempItemLedgEntry."Serial No.";

                                FOR i := 2 TO 5 DO BEGIN
                                    IF TotalSerialNosProcessed < NbrSN THEN BEGIN
                                        TempItemLedgEntry.NEXT;
                                        TotalSerialNosProcessed += 1;
                                        SerialNbrsDisplay := SerialNbrsDisplay + ', ' + TempItemLedgEntry."Serial No.";
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            var
                                NumberOfSNRows: Integer;
                            begin
                                NumberOfSNRows := ROUND((NbrSN + 4) / 5, 1.0, '<');  //SERIALNOS
                                SETRANGE(Number, 1, NumberOfSNRows);
                                ; // SERIALNOS
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {

                            }

                            trigger OnAfterGetRecord()
                            begin
                                // NA0008.begin
                                IF Number = 1 THEN
                                    PostedAsmLine.FINDSET
                                ELSE
                                    PostedAsmLine.NEXT;
                                // NA0008.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0008.begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmHeaderExists THEN
                                    CurrReport.BREAK;
                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                                // NA0008.end
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesShipmentLine: Record "Sales Shipment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesShipmentLine.FIND('-')
                            ELSE
                                TempSalesShipmentLine.NEXT;

                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            IF TempSalesShipmentLine."Order No." = '' THEN
                                OrderedQuantity := TempSalesShipmentLine.Quantity
                            ELSE BEGIN
                                IF OrderLine.GET(1, TempSalesShipmentLine."Order No.", TempSalesShipmentLine."Order Line No.") THEN BEGIN
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                END ELSE BEGIN
                                    ReceiptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                                    ReceiptLine.SETRANGE("Order No.", TempSalesShipmentLine."Order No.");
                                    ReceiptLine.SETRANGE("Order Line No.", TempSalesShipmentLine."Order Line No.");
                                    ReceiptLine.FIND('-');
                                    REPEAT
                                        OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                    UNTIL 0 = ReceiptLine.NEXT;
                                END;
                            END;

                            IF TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::" " THEN BEGIN
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                TempSalesShipmentLine."No." := '';
                                TempSalesShipmentLine."Unit of Measure" := '';
                                TempSalesShipmentLine.Quantity := 0;
                            END ELSE IF TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::"G/L Account" THEN
                                    TempSalesShipmentLine."No." := '';

                            PackageTrackingText := '';
#pragma warning disable AL0432
                            IF (TempSalesShipmentLine."Package Tracking No." <> "Sales Shipment Header"."Package Tracking No.") AND
                               (TempSalesShipmentLine."Package Tracking No." <> '') AND (PrintPackageTrackingNos) THEN
                                PackageTrackingText := Text002 + ' ' + TempSalesShipmentLine."Package Tracking No.";
                            // NA0008.begin
#pragma warning restore AL0432
                            IF DisplayAssemblyInformation THEN
                                IF TempSalesShipmentLineAsm.GET(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") THEN BEGIN
                                    SalesShipmentLine.GET(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.");
                                    AsmHeaderExists := SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader);
                                END;
                            // NA0008.end
                            //SerialNos
                            TempItemLedgEntry.RESET;
                            TempItemLedgEntry.DELETEALL;
                            IF RetrieveILEFromShptRcpt(TempItemLedgEntry, DATABASE::"Sales Shipment Line", 0, TempSalesShipmentLine."Document No.",
                                                    '', 0, TempSalesShipmentLine."Line No.") THEN BEGIN
                                NbrSN := TempItemLedgEntry.COUNT;
                            END ELSE
                                NbrSN := 0;
                            //  IF CallPostedItemTracking(RowID1) THEN BEGIN
                            //    NbrSN := SNItemLedgerEntry.COUNT;
                            //  END ELSE
                            //    NbrSN := 0;
                            //end serialnos
                            //NUB1.03 Start
                            TotalShippedQty += TempSalesShipmentLine.Quantity;
                            GrandTotalWeight += TempSalesShipmentLine.Quantity * TempSalesShipmentLine."Net Weight";
                            //NUB1.03 end
                            //NA0006.begin
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //NA0006.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := TempSalesShipmentLine.COUNT;
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
                            SalesShipmentPrinted.RUN("Sales Shipment Header");
                        CurrReport.BREAK;
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;

                    //NUB1.03 Start
                    CLEAR(TotalShippedQty);
                    CLEAR(GrandTotalWeight);
                    //NUB1.03 End
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
                ShipToAddr: array[8] of Text[100];
            begin
                IF PrintCompany THEN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.LANGUAGE := EventsandSubcribes.GetLanguageID("Language Code");

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                // NA0002.begin
                IF "Sell-to Customer No." = '' THEN BEGIN
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                END;
                // NA0002.end
                // NA0003.begin
                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);
                // NA0003.end

                //RPK7 begin
                IF "Location Code" = '' THEN
                    CLEAR(LocationT)
                ELSE
                    LocationT.GET("Location Code");
                //RPK7 end

                FormatAddress.SalesShptBillTo(BillToAddress, ShipToAddr, "Sales Shipment Header");
                FormatAddress.SalesShptShipTo(ShipToAddress, "Sales Shipment Header");

                ShippingAgentCodeLabel := '';
                ShippingAgentCodeText := '';
                PackageTrackingNoLabel := '';
                PackageTrackingNoText := '';
                IF PrintPackageTrackingNos THEN BEGIN
                    ShippingAgentCodeLabel := Text003;
                    ShippingAgentCodeText := "Sales Shipment Header"."Shipping Agent Code";
                    PackageTrackingNoLabel := Text001;
#pragma warning disable AL0432
                    PackageTrackingNoText := "Sales Shipment Header"."Package Tracking No.";
#pragma warning restore AL0432
                END;
                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", '');   // NA0001
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            ;
                        TaxArea."Country/Region"::CA:
                            BEGIN
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            END;
                    END;
                END;

                //NUB1.03 Start
                CLEAR(TotalShippedQty);
                CLEAR(GrandTotalWeight);
                //NUB1.03 End
            end;

            trigger OnPreDataItem()
            begin
                // NA0004.begin
                // CompanyInformation.GET;  // NA0001
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
                    field(PrintPackageTrackingNos; PrintPackageTrackingNos)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Package Tracking Nos.';
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

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        SalesSetup.GET;
        CompanyInfo.CALCFIELDS(Picture);  //RP7
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
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;

        // NA0004.begin
        CompanyInformation.GET;
        SalesSetup.GET;

        //RP7
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);  //RP7

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
        // NA0004.end
    end;

    var
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ReceiptLine: Record "Sales Shipment Line";
        OrderLine: Record "Sales Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentLine: Record "Sales Shipment Line" temporary;
        TempSalesShipmentLineAsm: Record "Sales Shipment Line" temporary;
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Record Language;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        Item: Record Item;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
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
        SalesShipmentPrinted: Codeunit "Sales Shpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        PackageTrackingText: Text[50];
        PrintPackageTrackingNos: Boolean;
        PackageTrackingNoText: Text[50];
        PackageTrackingNoLabel: Text[50];
        ShippingAgentCodeText: Text[50];
        ShippingAgentCodeLabel: Text[50];
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Tracking No.';
        Text002: Label 'Specific Tracking No.';
        Text003: Label 'Shipping Agent';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        Text009: Label 'VOID SHIPMENT';
        OutputNo: Integer;

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        ShipmentCaptionLbl: Label 'PACKING SLIP';
        ShipmentNumberCaptionLbl: Label 'Packing Slip No:';
        ShipmentDateCaptionLbl: Label 'Shipment Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        ItemNoCaptionLbl: Label 'Number';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        ShippedCaptionLbl: Label 'Shipped';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        LocationT: Record Location;
        RP7Labels: Label 'RP 7 Labels';
        CustomerPhoneCaptionlbl: Label 'Cust. Phone';
        CustomerFaxCaptionlbl: Label 'Cust. Fax';
        WebsiteCaptionLbl: Label 'Website:';
        PhoneCaptionLbl: Label 'Phone:';
        FaxCaptionLbl: Label 'Fax:';
        TermsCaptionLbl: Label 'Terms';
        "--SerialNos--": Integer;
        i: Integer;
        NbrSN: Integer;
        SerialNbrs: array[150] of Code[20];
        SNLine: Boolean;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TotalSerialNosProcessed: Integer;
        SerialNbrsDisplay: Code[250];
        SerialNoLbl: Label 'Serial No.';
        WeightCaptionLbl: Label 'Weight';
        PickedByCaptionLbl: Label 'Picked By';
        PackedByCaptionLbl: Label 'Packed By';
        ReceivedByCaptionLbl: Label 'Received By';
        "-NUB1.01-": Integer;
        NextShptLineRecGbl: Record "Sales Shipment Line";
        SkipLoopVarGbl: Boolean;
        TotalShippedQty: Decimal;
        GrandTotalWeight: Decimal;
        EventsandSubcribes: codeunit EventsandSubscribers;


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Shpt. Note") <> '';
    end;


    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0008.begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
        // NA0008.end
    end;


    procedure BlanksForIndent(): Text[10]
    begin
        // NA0008.begin
        EXIT(PADSTR('', 2, ' '));
        // NA0008.end
    end;


    procedure "-- SN --"()
    begin
    end;


    procedure TableSignFactor(TableNo: Integer): Integer
    begin
        IF TableNo IN [
          DATABASE::"Sales Line",
          DATABASE::"Sales Shipment Line",
          DATABASE::"Sales Invoice Line",
          DATABASE::"Purch. Cr. Memo Line",
          DATABASE::"Prod. Order Component",
          DATABASE::"Transfer Shipment Line",
          DATABASE::"Return Shipment Line",
          DATABASE::"Service Invoice Line",
          DATABASE::"Planning Component"]
        THEN
            EXIT(-1)
        ELSE
            EXIT(1);
    end;


    procedure AddTempRecordToSet(var TempItemLedgEntry1: Record "Item Ledger Entry" temporary; SignFactor: Integer)
    var
        TempItemLedgEntry2: Record "Item Ledger Entry" temporary;
    begin
        IF SignFactor <> 1 THEN BEGIN
            TempItemLedgEntry1.Quantity *= SignFactor;
            TempItemLedgEntry1."Remaining Quantity" *= SignFactor;
            TempItemLedgEntry1."Invoiced Quantity" *= SignFactor;
        END;
    end;

    local procedure RetrieveILEFromShptRcpt(var TempItemLedgEntry: Record "Item Ledger Entry" temporary; Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer): Boolean
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        SignFactor: Integer;
    begin
        // retrieves a data set of Item Ledger Entries (Posted Shipments/Receipts)

        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", Type);
        ItemEntryRelation.SETRANGE("Source Subtype", Subtype);
        ItemEntryRelation.SETRANGE("Source ID", ID);
        ItemEntryRelation.SETRANGE("Source Batch Name", BatchName);
        ItemEntryRelation.SETRANGE("Source Prod. Order Line", ProdOrderLine);
        ItemEntryRelation.SETRANGE("Source Ref. No.", RefNo);
        IF ItemEntryRelation.FINDSET THEN BEGIN
            SignFactor := TableSignFactor(Type);
            REPEAT
                ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                TempItemLedgEntry := ItemLedgEntry;
                AddTempRecordToSet(TempItemLedgEntry, SignFactor);
                TempItemLedgEntry.INSERT;
            UNTIL ItemEntryRelation.NEXT = 0;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;
}

