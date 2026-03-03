report 51013 "Purchase Receipt RP_UPG"//14004486
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2004-04-14" area="REPORTS PP" feature="620"
    //     releaseversion="NAVUS3.70">North American Purchase Receipt Document.</add>
    //   <change id="NA0001" dev="JNOZZI" date="2006-05-10" area="BUG FIX"  request="16629"
    //     baseversion="NAVUS3.70" releaseversion="NAVNA4.00.03">Allow the printing of a blank &quot;voided&quot;
    //     invoice.</change>
    //   <change id="NA0002" dev="V-STFANG" date="2008-05-21" area="REPORTS PP" feature="NC14261"
    //     baseversion="NAVNA4.00.03" releaseversion="NAVNA6.00">Report Transformation - local Report Layout</change>
    // </changelog>
    // 
    // NUB1.01,10/25/17,SK: Added code to Get Item Tracking Lines and dispplaying the Expiration Date in layout.
    // NUB1.02,10/02/19,ST: Modifications handled to show Total Case Receieved.
    //                       - Added text constants.
    //                       - Modified layout to display Total Case Received after the lines.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PurchaseReceiptRP.rdl';

    Caption = 'Purchase Receipt';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Receipt';
            column(No_PurchRcptHeader; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyAddr1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddress[7])
                    {
                    }
                    column(ExpRcptDate_PurchRcptHeader; "Purch. Rcpt. Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddr1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddress[7])
                    {
                    }
                    column(BuyfrmVendNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(DocDate_PurchRcptHeader; "Purch. Rcpt. Header"."Document Date")
                    {
                    }
                    column(CompanyAddr7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddr8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddr8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(OrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(OrderDate_PurchRcptHeader; "Purch. Rcpt. Header"."Order Date")
                    {
                    }
                    column(myCopyNo; CopyNo)
                    {
                    }
                    column(FromCaption; FromCaptionLbl)
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
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptCaption; PurchaseReceiptCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptNumberCaption; PurchaseReceiptNumberCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptDateCaption; PurchaseReceiptDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PurchaseCaption; PurchaseCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(RP7; RP70Labels)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(PurchaseDueDate; "Purch. Rcpt. Header"."Due Date")
                    {
                    }
                    column(PurchaseContact; "Purch. Rcpt. Header"."Buy-from Contact")
                    {
                    }
                    column(PurchaseHeaderLocation; "Purch. Rcpt. Header"."Location Code")
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
                    column(VendorOrderNo; "Purch. Rcpt. Header"."Vendor Order No.")
                    {
                    }
                    column(VendorShipmentNo; "Purch. Rcpt. Header"."Vendor Shipment No.")
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
                    column(CompanyInformationPicture; CompanyInformation.Picture)
                    {
                    }
                    column(TotalCaseReceivedCaption; TotalCaseReceivedCaptionLbl)
                    {
                    }
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ItemNumberToPrint_PurchRcptLine; ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchRcptLine; "Unit of Measure")
                        {
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                        }
                        column(OrderedQty_PurchRcptLine; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQty_PurchRcptLine; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Desc_PurchRcptLine; Description)
                        {
                        }
                        column(PrintFooter_PurchRcptLine; PrintFooter)
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
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
                        column(ReceivedCaption; ReceivedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        column(TrackingSpecBufferNo; TempItemLedgEntry."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TempItemLedgEntry.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TempItemLedgEntry."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TempItemLedgEntry."Serial No.")
                        {
                        }
                        column(TempItemLedgEntry_Expiration_Date; ExpDateVarGbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            IF "Order No." = '' THEN
                                OrderedQuantity := Quantity
                            ELSE BEGIN
                                IF OrderLine.GET(1, "Order No.", "Order Line No.") THEN BEGIN
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                END ELSE BEGIN
                                    ReceiptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                                    ReceiptLine.SETRANGE("Order No.", "Order No.");
                                    ReceiptLine.SETRANGE("Order Line No.", "Order Line No.");
                                    ReceiptLine.FIND('-');
                                    REPEAT
                                        OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                    UNTIL 0 = ReceiptLine.NEXT;
                                END;
                            END;

                            IF Type = Type::" " THEN BEGIN
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                Quantity := 0;
                            END ELSE
                                IF Type = Type::"G/L Account" THEN
                                    ItemNumberToPrint := "Vendor Item No."
                                ELSE
                                    ItemNumberToPrint := "No.";

                            //NA0002.BEGIN
                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            //NA0002.END


                            //NUB1.01 Start
                            CLEAR(TempItemLedgEntry);
                            CLEAR(ExpDateVarGbl);

                            ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
                            ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Purch. Rcpt. Line");
                            ItemEntryRelation.SETRANGE("Source Subtype", 0);
                            ItemEntryRelation.SETRANGE("Source ID", "Document No.");
                            ItemEntryRelation.SETRANGE("Source Batch Name", '');
                            ItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
                            ItemEntryRelation.SETRANGE("Source Ref. No.", "Line No.");
                            IF ItemEntryRelation.FINDSET THEN BEGIN
                                REPEAT
                                    ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                                    TempItemLedgEntry := ItemLedgEntry;
                                    IF ExpDateVarGbl = '' THEN
                                        ExpDateVarGbl := FORMAT(TempItemLedgEntry."Expiration Date")
                                    ELSE
                                        ExpDateVarGbl := FORMAT(ExpDateVarGbl) + ', ' + FORMAT(TempItemLedgEntry."Expiration Date");
                                UNTIL ItemEntryRelation.NEXT = 0;
                            END;
                            //NUB1.01 End
                        end;

                        trigger OnPreDataItem()
                        begin
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
                            PurchaseRcptPrinted.RUN("Purch. Rcpt. Header");
                        CurrReport.BREAK;
                    END;
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
                CurrReport.LANGUAGE := EventsandSubscriber.GetLanguageID("Language Code");

                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                // NA0001.begin
                IF "Buy-from Vendor No." = '' THEN BEGIN
                    "Buy-from Vendor Name" := Text009;
                    "Ship-to Name" := Text009;
                END;
                // NA0001.end

                //RP7 -- Begin
                IF NOT Vend.GET("Buy-from Vendor No.") THEN
                    CLEAR(Vend);

                IF "Location Code" = '' THEN
                    CLEAR(Location)
                ELSE
                    Location.GET("Location Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                //RP7 -- End

                FormatAddress.PurchRcptBuyFrom(BuyFromAddress, "Purch. Rcpt. Header");
                FormatAddress.PurchRcptShipTo(ShipToAddress, "Purch. Rcpt. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');

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
                        ApplicationArea = all;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = all;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
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
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Rcpt.") <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET('');
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        ReceiptLine: Record "Purch. Rcpt. Line";
        OrderLine: Record "Purchase Line";
        RespCenter: Record "Responsibility Center";
        NUBLanguage: Record Language;
        TaxArea: Record "Tax Area";
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchaseRcptPrinted: Codeunit 318;
        FormatAddress: Codeunit 365;
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        SegManagement: Codeunit 5051;
        LogInteraction: Boolean;
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        Text000: Label 'COPY';
        Text009: Label 'VOID RECEIPT';
        LogInteractionEnable: Boolean;
        FromCaptionLbl: Label 'From:';
        ReceiveByCaptionLbl: Label 'Receive By';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        ToCaptionLbl: Label 'To:';
        PurchaseReceiptCaptionLbl: Label 'Purchase Receipt';
        PurchaseReceiptNumberCaptionLbl: Label 'Purchase Receipt Number:';
        PurchaseReceiptDateCaptionLbl: Label 'Receipt Date';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        PONumberCaptionLbl: Label 'P.O. Number';
        PurchaseCaptionLbl: Label 'Purchase';
        PODateCaptionLbl: Label 'P.O. Date';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        ReceivedCaptionLbl: Label 'Received';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Back Ordered';
        "--RP70--": Integer;
        RP70Labels: Text;
        Vend: Record 23;
        Location: Record 14;
        PaymentTerms: Record 3;
        "-": Integer;
        TrackingSpecBuffer: Record 336 temporary;
        ItemTrackingMgt: Codeunit 6500;
        TrackingSpecCount: Integer;
        TempItemLedgEntry: Record 32 temporary;
        ItemEntryRelation: Record 6507;
        ItemLedgEntry: Record 32;
        ExpDateVarGbl: Text;
        TotalCaseReceivedCaptionLbl: Label 'Total Case Received:';
        EventsandSubscriber: codeunit EventsandSubscribers;
}

