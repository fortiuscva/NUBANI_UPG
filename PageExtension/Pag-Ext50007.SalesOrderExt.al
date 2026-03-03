namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50007 "Sales Order EXt" extends "Sales Order"
{
    CaptionML = ENU = 'Sales Order',
               ESM = 'Pedido venta',
               FRC = 'Document de vente',
               ENC = 'Sales Order';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        moveafter("Sell-to City"; "Sell-to County")
        moveafter("Sell-to County"; "Sell-to Post Code")
        moveafter("No. of Archived Versions"; "Posting Description")
        moveafter("Requested Delivery Date"; "Shipping Agent Code")
        moveafter("Quote No."; "Your Reference")
        addafter(Status)
        {
            field("Allow Backorder"; Rec."Allow Backorder")
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Backorder")
        {
            field("No. of Pallets"; Rec."No. of Pallets")
            {
                ApplicationArea = All;
            }
        }
        moveafter("No. of Pallets"; "Location Code")
        addafter("Location Code")
        {
            field("Invt. Pick Exists"; Rec."Invt. Pick Exists")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invt. Pick Exists")
        {
            field("Order Shipped"; Rec."Order Shipped")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Shipped")
        {
            field("Pallets Spaces"; Rec."Pallets Spaces")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pallets Spaces")
        {
            field("Shipping Status"; Rec."Shipping Status")
            {
                ApplicationArea = All;
            }
        }
        moveafter("CFDI Export Code"; "Quote No.")
        moveafter("Shipping Status"; "Shipment Method Code")
        movefirst("Invoice Details"; BillToOptions, "Bill-to Contact No.", "Bill-to Name")
        moveafter("Bill-to Name"; "Bill-to Address", "Bill-to Address 2", "Bill-to City", "Bill-to County", "Bill-to Country/Region Code", "Bill-to Post Code", "Bill-to Contact")
        moveafter("Sell-to"; "Ship-to Name", "Ship-to Address", "Ship-to Address 2", "Ship-to City", "Ship-to Country/Region Code", "Ship-to Post Code")
        moveafter("Payment Terms Code"; "Due Date")

        addafter("Shipment Method Code")
        {
            field("Pallet Count"; Rec."Pallet Count")
            {
                ApplicationArea = All;
            }
        }
        //moveafter("Bill-to City"; "Bill-to County")
        //moveafter("Bill-to County"; "Bill-to Post Code")


        // addafter("Tax Area Code")
        // {
        //     field(GetCreditcardNumber; Rec.GetCreditcardNumber)
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Cr. Card Number (Last 4 Digits)',
        //                    ESM = 'N£mero tarjeta cr‚dito (cuatro £ltimos d¡gitos)',
        //                    FRC = 'Num‚ro de carte de cr‚dit (4ÿderniers chiffres)',
        //                    ENC = 'Cr. Card Number (Last 4 Digits)';
        //     }
        // }//B2BUPG
        moveafter("Ship-to Address 2"; "Ship-to City")
        moveafter("Ship-to City"; "Ship-to County")

        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        moveafter("Prepmt. Pmt. Discount Date"; "Prepmt. Include Tax")
        modify(Control1900201301)
        {
            CaptionML = ENU = 'Prepayment',
                           ESM = 'Anticipo',
                           FRC = 'Paiement an';
        }
        addafter(Control1903720907)
        {
            part(LotNumbersByBin; 9126)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Lot Numbers By Bin';
                Provider = SalesLines;
                SubPageLink = "Item No." = FIELD("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
                //"Variant Code" = FIELD("Variant Code");


            }
        }
        addafter(Control1907234507)
        {
            part(Control1100796006; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100796005; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part("Item Invoicing FactBox"; 9089)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Item Invoicing FactBox';
                SubPageLink = "No." = FIELD("No.");
                Provider = SalesLines;
            }
            part(Control1100796004; "Item Picture Factbox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
        }

    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder',
                                 ESM = '&Pedido',
                                 FRC = 'C&ommande',
                                 ENC = 'O&rder';
        }
        modify(Statistics)
        {
            Enabled = false;
            Visible = false;
        }
        addafter(Statistics)
        {
            action("NUB Statistics")
            {
                ApplicationArea = All;
                Visible = true;
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
                trigger OnAction()
                begin
                    IF Rec."Tax Area Code" = '' THEN
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec)
                    ELSE
                        PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                end;
            }
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'A&pprovals',
                                 ESM = 'A&probaciones',
                                 FRC = 'A&pprobations',
                                 ENC = 'A&pprovals';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(AssemblyOrders)
        {
            CaptionML = ENU = 'Assembly Orders',
                                 ESM = 'Pedidos de ensamblado',
                                 FRC = 'Ordres d assemblage',
                                 ENC = 'Assembly Orders';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify("S&hipments")
        {
            CaptionML = ENU = 'S&hipments',
                                 ESM = '&Env¡os',
                                 FRC = 'L&ivraisons',
                                 ENC = 'S&hipments';
        }
        modify(Invoices)
        {
            CaptionML = ENU = 'Invoices',
                                 ESM = 'Facturas',
                                 FRC = 'Factures',
                                 ENC = 'Invoices';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                 ESM = 'L¡neas ubicac./ pic&k exist.',
                                 FRC = 'Lignes d articles en stoc&k … classer/pr‚lever',
                                 ENC = 'In&vt. Put-away/Pick Lines';
            // RunObject = Page 50007; //B2BUPG
        }
        modify("Warehouse Shipment Lines")
        {
            CaptionML = ENU = 'Whse. Shipment Lines',
                                 ESM = 'L¡neas de env¡o almac‚n',
                                 FRC = 'Lignes livraison entrep“t',
                                 ENC = 'Whse. Shipment Lines';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment',
                                 ESM = 'Anticipo',
                                 FRC = 'Paiement anticip‚',
                                 ENC = 'Prepayment';
        }
        modify(PagePostedSalesPrepaymentInvoices)
        {
            CaptionML = ENU = 'Prepa&yment Invoices',
                                 ESM = '&Facturas anticipo',
                                 FRC = '&Factures pour paiement anticip‚',
                                 ENC = 'Prepa&yment Invoices';
        }
        modify(PagePostedSalesPrepaymentCrMemos)
        {
            CaptionML = ENU = 'Prepayment Credi&t Memos',
                                 ESM = '&Notas cr‚dito anticipo',
                                 FRC = 'Notes de cr‚di&t pour paiement anticip‚',
                                 ENC = 'Prepayment Credi&t Memos';
        }
        modify(Action21)
        {
            CaptionML = ENU = 'Release',
                                 ESM = 'Lanzar',
                                 FRC = 'Lancer',
                                 ENC = 'Release';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease',
                                 ESM = 'Lan&zar',
                                 FRC = '&Lancer',
                                 ENC = 'Re&lease';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open',
                                 ESM = '&Volver a abrir',
                                 FRC = 'R‚&ouvrir',
                                 ENC = 'Re&open';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount',
                                 ESM = 'Calcular dto. en la &factura',
                                 FRC = 'Calculer escompte &facture',
                                 ENC = 'Calculate &Invoice Discount';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document',
                                 ESM = 'Copiar l¡neas',
                                 FRC = 'Copier document',
                                 ENC = 'Copy Document';
        }
        modify(MoveNegativeLines)
        {
            CaptionML = ENU = 'Move Negative Lines',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document',
                                 ESM = '&Archivar documento',
                                 FRC = 'Archi&ver document',
                                 ENC = 'Archi&ve Document';
        }
        addlast("F&unctions")
        {
            action("Quick Item Entry")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Quick Item Entry';
                Promoted = true;
                PromotedIsBig = true;
                Image = ItemLines;
                PromotedCategory = Process;
                Trigger OnAction()
                VAR
                    QuickItem: Page "Quick Item Entry";
                BEGIN
                    Rec.TESTFIELD(Rec.Status, Rec.Status::Open);
                    QuickItem.SetValues(Rec."No.", Rec."Sell-to Customer No.", Rec."Document Type");
                    QuickItem.RUN;
                END;
            }
            action(PalletsCalculator)
            {
                ApplicationArea = All;

                CaptionML = ENU = 'Pallets Calculator';
                Promoted = true;
                PromotedIsBig = true;
                Image = CalculateInvoiceDiscount;
                PromotedCategory = Process;
                trigger OnAction()
                VAR
                    SalesLineLRec: Record "Sales Line";
                    UOMlRec: Record 204;
                BEGIN
                    //NUB1.05 Start
                    CLEAR(TotalPallets);

                    SalesLineLRec.RESET;
                    SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                    SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                    SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                    SalesLineLRec.SETFILTER("No.", '<>%1', '');
                    IF SalesLineLRec.FINDSET THEN BEGIN
                        REPEAT
                            // IF UOMlRec.GET(SalesLineLRec."Unit of Measure Code") THEN
                            //     IF UOMlRec."Pallet Per" = 0 THEN
                            //         ERROR('Please fill Pallets Per for %1 UOM', UOMlRec.Code);

                            //TotalPallets += (SalesLineLRec."Outstanding Quantity" / UOMlRec."Pallet Per");
                            TotalPallets += (SalesLineLRec."Outstanding Quantity" / SalesLineLRec."Qty.  Per Pallet");
                        UNTIL SalesLineLRec.NEXT = 0;
                    END;

                    Rec."No. of Pallets" := TotalPallets;
                    //NUB1.05 ENd
                END;
            }
        }
        modify(Plan)
        {
            CaptionML = ENU = 'Plan',
                                 ESM = 'Planificar',
                                 FRC = 'Planifier',
                                 ENC = 'Plan';
        }
        modify(OrderPromising)
        {
            CaptionML = ENU = 'Order &Promising',
                                 ESM = 'Comprom&iso entrega',
                                 FRC = '&Promesse de livraison',
                                 ENC = 'Order &Promising';
        }
        modify("Demand Overview")
        {
            CaptionML = ENU = 'Demand Overview',
                                 ESM = 'Panorama de demanda',
                                 FRC = 'Aper‡u demande',
                                 ENC = 'Demand Overview';
        }
        modify("Pla&nning")
        {
            CaptionML = ENU = 'Pla&nning',
                                 ESM = 'Plani&ficaci¢n',
                                 FRC = 'Pla&nification',
                                 ENC = 'Pla&nning';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request',
                                 ESM = 'Enviar solicitud a&probaci¢n',
                                 FRC = 'Envoyer demande d a&pprobation',
                                 ENC = 'Send A&pproval Request';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest',
                                 ESM = '&Cancelar solicitud aprobaci¢n',
                                 FRC = 'Annuler demande d appro&bation',
                                 ENC = 'Cancel Approval Re&quest';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away / Pick',
                                 ESM = 'Crear &ubicac./ pick. inventario',
                                 FRC = 'Cr‚er une r‚servation/sortie de stoc&k',
                                 ENC = 'Create Inventor&y Put-away / Pick';
            trigger OnBeforeAction()

            VAR
                "-NUB1.04-": Integer;
                SalesLineLRec: Record "Sales Line";
                TempSalesLineLRec: Record "Sales Line" temporary;
                ItemLRec: Record 27;
            BEGIN
                //NUB1.04 Start
                //Checking the Item Inventory before creating Pick.
                Rec.TESTFIELD(Rec.Status, Rec.Status::Released);

                SalesLineLRec.RESET;
                SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                SalesLineLRec.SETFILTER("No.", '<>%1', '');
                IF SalesLineLRec.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLRec.GET(SalesLineLRec."No.") THEN
                            ItemLRec.CALCFIELDS(Inventory);

                        IF ItemLRec.Inventory = 0 THEN BEGIN
                            TempSalesLineLRec.INIT;
                            TempSalesLineLRec.TRANSFERFIELDS(SalesLineLRec);
                            TempSalesLineLRec.INSERT;
                        END;
                    UNTIL SalesLineLRec.NEXT = 0;
                END;

                IF TempSalesLineLRec.COUNT > 0 THEN
                    PAGE.RUNMODAL(PAGE::"Sales Lines", TempSalesLineLRec);
                //NUB1.04 End

                //NUB1.06 STart
                CLEAR(TempSalesLineLRec); //NUB1.07
                TempSalesLineLRec.DELETEALL; //NUB1.07

                SalesLineLRec.RESET;
                SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                SalesLineLRec.SETFILTER("No.", '<>%1', '');
                SalesLineLRec.SETFILTER("Qty. to Ship", '<>%1', 0);  //NUB1.07
                IF SalesLineLRec.FINDSET THEN BEGIN
                    REPEAT
                        ResEntryRecGbl.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
                        ResEntryRecGbl.SETRANGE("Source ID", SalesLineLRec."Document No.");
                        ResEntryRecGbl.SETRANGE("Source Ref. No.", SalesLineLRec."Line No.");
                        ResEntryRecGbl.CALCSUMS("Qty. to Handle (Base)");
                        QtyToHandleVar := ABS(ResEntryRecGbl."Qty. to Handle (Base)");

                        IF ItemLRec.GET(SalesLineLRec."No.") THEN;

                        IF (QtyToHandleVar = 0) AND (ItemLRec."Item Tracking Code" <> '') THEN BEGIN
                            TempSalesLineLRec.INIT;
                            TempSalesLineLRec.TRANSFERFIELDS(SalesLineLRec);
                            TempSalesLineLRec.INSERT;
                        END;
                    UNTIL SalesLineLRec.NEXT = 0;
                END;

                IF TempSalesLineLRec.COUNT > 0 THEN
                    PAGE.RUNMODAL(PAGE::"Sales Lines", TempSalesLineLRec);
                //NUB1.06 End

            end;
        }
        modify("Create &Warehouse Shipment")
        {
            CaptionML = ENU = 'Create &Whse. Shipment',
                                 ESM = 'Crear &env¡o alm.',
                                 FRC = 'Cr‚er une livraison d &entrep“t',
                                 ENC = 'Create &Whse. Shipment';
        }
        // addlast(Warehouse)
        // {
        // action(SendAsPDF)
        // {

        //     CaptionML = ENU = 'SendAsPDF';
        //     Promoted = true;
        //     PromotedIsBig = true;
        //     Image = SendEmailPDF;
        //     PromotedCategory = Process;
        //     trigger OnAction()
        //     VAR
        //         Mail: Codeunit 397;
        //         Name: Text;
        //         FileName: Text;
        //         ToFile: Text;
        //         //ReportHelper: Codeunit 14005067;  //B2BUPG
        //         //EmailTracking: Record 14005150;   //B2BUPG
        //         "--FP7.0.09---": Integer;
        //         DialogOption: Option Always,Never,Ask;
        //         ShowDialog: Boolean;
        //     BEGIN
        //         /*  //FP6.2.01 begin
        //          CurrPage.SETSELECTIONFILTER(SalesHeader);
        //          Name := STRSUBSTNO('Order No. %1.pdf', Rec."No."); //Default Subject is PDF FIlename
        //          ToFile := Name;
        //          FileName := TEMPORARYPATH + ToFile; */

        //         //FP7.0.09 Start
        //         //Document-Type-Specific Stuff here...

        //         IF Rec."Shipping Agent Code" <> '' THEN BEGIN
        //             IF ShippingAgent.GET(Rec."Shipping Agent Code") THEN
        //                 Aux1 := ', via ' + ShippingAgent.Name;
        //             IF Rec."Shipping Agent Service Code" <> '' THEN BEGIN
        //                 IF ShippingAgentServices.GET(Rec."Shipping Agent Code", Rec."Shipping Agent Service Code") THEN
        //                     Aux1 := Aux1 + ', ' + ShippingAgentServices.Description;
        //             END;
        //         END;

        //         IF Rec."External Document No." <> '' THEN BEGIN
        //             ExtNo := Rec.."External Document No.";
        //         END;


        //         BodyText := '';

        //         //FP7.0.09 Start
        //         //ImgTag := ReportHelperCU.CreateImgTag; //Form an HTML '<img>' Tag, if appropriate
        //         //ReportHelperCU.HandleTopImg(BodyText,ImgTag); //If desired, Start email Body with Logo on Top, with two Carriage Returns after
        //         //FP7.0.09 Finish

        //         EmailCommT.SETRANGE(Type, EmailCommT.Type::Customer);
        //         EmailCommT.SETRANGE("No.", "Sell-to Customer No.");
        //         IF EmailCommT.FINDFIRST THEN BEGIN
        //             IF (EmailCommT."Order Email Body Salutation" <> '') AND (EmailCommT."Order Email Body Text" <> '') THEN BEGIN
        //                 //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
        //                 BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
        //                 EmailSubj := EmailCommT."Order Email Subject";
        //             END;

        //             IF (EmailCommT."Order Email Body Salutation" <> '') AND (EmailCommT."Order Email Body Text" = '') THEN BEGIN
        //                 EmailCommT2.RESET;
        //                 EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
        //                 EmailCommT2.SETRANGE("No.", 'DEFAULT');
        //                 IF EmailCommT2.FINDFIRST THEN BEGIN
        //                     //      BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
        //                     BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
        //                     EmailSubj := EmailCommT2."Order Email Subject";
        //                 END;
        //             END;

        //             IF (EmailCommT."Order Email Body Salutation" = '') AND (EmailCommT."Order Email Body Text" <> '') THEN BEGIN
        //                 EmailCommT2.RESET;
        //                 EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
        //                 EmailCommT2.SETRANGE("No.", 'DEFAULT');
        //                 IF EmailCommT2.FINDFIRST THEN BEGIN
        //                     //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
        //                     BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
        //                     EmailSubj := EmailCommT."Order Email Subject"
        //                 END;
        //             END;

        //             IF (EmailCommT."Order Email Body Salutation" = '') AND (EmailCommT."Order Email Body Text" = '') THEN BEGIN
        //                 EmailCommT2.RESET;
        //                 EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
        //                 EmailCommT2.SETRANGE("No.", 'DEFAULT');
        //                 IF EmailCommT2.FINDFIRST THEN BEGIN
        //                     //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
        //                     BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
        //                     EmailSubj := EmailCommT2."Order Email Subject"
        //                 END;
        //             END;

        //         END ELSE BEGIN  //EmailCommT Record for this CUSTOMER NOT Found
        //             EmailCommT.RESET;
        //             EmailCommT.SETRANGE(Type, EmailCommT.Type::Default);
        //             EmailCommT.SETRANGE("No.", 'DEFAULT');
        //             IF EmailCommT.FINDFIRST THEN BEGIN
        //                 //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
        //                 BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
        //                 EmailSubj := EmailCommT."Order Email Subject";
        //             END;
        //         END;

        //         //FP7.0.09 Next Line REM-ed out
        //         //ReportHelperCU.HandleBotImg(BodyText,ImgTag); //Finish with Image on Bottom, if desired, followed by a Carriage Return

        //         DialogOption := EmailCommT."Open Order Email";

        //         //FP7.0.09 Finish

        //         //FP7.0.09 Start
        //         BodyText := SendAsPDFSubstitutions(BodyText, FALSE); //"merge" arguments into Email Body
        //         IF (EmailSubj <> '') THEN
        //             Name := SendAsPDFSubstitutions(EmailSubj, TRUE); //"merge" arguments into Subject, too...

        //         ReportHelperCU.AddSlogan(BodyText); //Add Random Marketing Slogan to Body from Master File Setup Defaults
        //         ReportHelperCU.AddBanners(BodyText); //Add Top and Bottom Banners to Body from Master File Setup Defaults

        //         ShowDialog := TRUE; //Default to Opening Outlook on Send
        //         IF DialogOption = DialogOption::Never THEN
        //             ShowDialog := FALSE
        //         ELSE IF DialogOption = DialogOption::Ask THEN
        //             ShowDialog := CONFIRM('Do you want to open the email before sending?', TRUE);
        //         //FP7.0.09 Finish

        //         ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
        //         ReportSelections.SETFILTER("Report ID", '<>0');
        //         IF ReportSelections.FINDFIRST THEN
        //             ReportID := ReportSelections."Report ID";

        //         REPORT.SAVEASPDF(ReportID, FileName, SalesHeader);
        //         ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);
        //         Mail.NewMessage(EmailTracking."Order Ackn. Send Email To", EmailTracking."Order Ackn. CC Email To", Name, BodyText, ToFile, ShowDialog);
        //         FILE.ERASE(FileName);
        //         //FP6.2.01 end
        //     END;
        // }
        // action(SaveAsPDF)
        // {

        //     CaptionML = ENU = 'SaveAsPDF';
        //     Promoted = true;
        //     PromotedIsBig = true;
        //     Image = PrintForm;
        //     PromotedCategory = Process;
        //     trigger OnAction()
        //     BEGIN
        //         CurrPage.SETSELECTIONFILTER(SalesHeader);

        //         ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
        //         ReportSelections.SETFILTER("Report ID", '<>0');
        //         IF ReportSelections.FINDFIRST THEN
        //             ReportID := ReportSelections."Report ID";

        //         //FP6.2.06
        //         DefSetup.GET;
        //         //REPORT.SAVEASPDF(ReportID, 'C:\temp\default.pdf', SalesHeader);
        //         REPORT.SAVEASPDF(ReportID, DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', SalesHeader);

        //         Tofile := STRSUBSTNO('Order No. %1.pdf', Rec."No.");

        //         //FP6.2.06
        //         //PdfDownloaded := DOWNLOAD('C:\temp\default.pdf', 'Save PDF As..', 'C:\','PDF file(*.pdf)|*.pdf', Tofile );
        //         PdfDownloaded := DOWNLOAD(DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', 'Save PDF As..', 'C:\',
        //             'PDF file(*.pdf)|*.pdf', Tofile);
        //     END;
        // }
        // }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting',
                                 ESM = '&Registro',
                                 FRC = 'Rep&ort',
                                 ENC = 'P&osting';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost',
                                 ESM = '&Registrar',
                                 FRC = 'Rep&orter',
                                 ENC = 'P&ost';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue',
                                 ESM = 'Quitar de cola de proyecto',
                                 FRC = 'Supprimer de la file d attente des travaux',
                                 ENC = 'Remove From Job Queue';
        }
        modify("Prepa&yment")
        {
            CaptionML = ENU = 'Prepa&yment',
                                 ESM = '&Anticipo',
                                 FRC = 'Paie&ment anticip‚',
                                 ENC = 'Prepa&yment';
        }
        modify("Prepayment &Test Report")
        {
            CaptionML = ENU = 'Prepayment &Test Report',
                                 ESM = 'Informe prue&ba anticipo',
                                 FRC = 'Rapport de &test de paiement anticip‚',
                                 ENC = 'Prepayment &Test Report';
        }
        modify(PostPrepaymentInvoice)
        {
            CaptionML = ENU = 'Post Prepayment &Invoice',
                                 ESM = '&Registrar factura anticipo',
                                 FRC = 'Reporter facture pa&iement anticip‚',
                                 ENC = 'Post Prepayment &Invoice';
        }
        modify("Post and Print Prepmt. Invoic&e")
        {
            CaptionML = ENU = 'Post and Print Prepmt. Invoic&e',
                                 ESM = '&Registrar e imprimir factura anticipo',
                                 FRC = 'Reporter et imprimer factur&e paiem. ant.',
                                 ENC = 'Post and Print Prepmt. Invoic&e';
        }
        modify(PostPrepaymentCreditMemo)
        {
            CaptionML = ENU = 'Post Prepayment &Credit Memo',
                                 ESM = '&Registrar nota cr‚dito anticipo',
                                 FRC = 'Reporter note de &cr‚dit paiement anticip‚',
                                 ENC = 'Post Prepayment &Credit Memo';
        }
        modify("Post and Print Prepmt. Cr. Mem&o")
        {
            CaptionML = ENU = 'Post and Print Prepmt. Cr. Mem&o',
                                 ESM = 'Registrar e imprimir nota cr‚di&to anticipo',
                                 FRC = 'Reporter et imprimer n&ote cr. paiem. ant.',
                                 ENC = 'Post and Print Prepmt. Cr. Mem&o';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("&Order Confirmation")
        {
            CaptionML = ENU = 'Order Confirmation',
                                 ESM = 'Confirmaci¢n pedido',
                                 FRC = 'Confirmation de commande',
                                 ENC = 'Order Confirmation';
        }
        addlast(processing)
        {
            action("Customer Catalog")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Catalog';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    //NUB1.01 Start
                    SalesHeadGRec.RESET;
                    SalesHeadGRec.SETRANGE("Document Type", Rec."Document Type");
                    SalesHeadGRec.SETRANGE("No.", Rec."No.");
                    IF SalesHeadGRec.FINDFIRST THEN;

                    REPORT.RUNMODAL(REPORT::"Customer catalog", TRUE, FALSE, SalesHeadGRec);
                    //NUB1.01 End
                END;
            }
            action(Action1100768005)  //14005135 B2BUPG
            {
                ApplicationArea = All;
                CaptionML = ENU = '&View Sales History';
                RunObject = Page "Recent Sales History";
                RunPageLink = "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = View;
                PromotedCategory = Process;
            }
        }
        modify("Work Order")
        {
            CaptionML = ENU = 'Work Order',
                                 ESM = 'Solicitud trabajo',
                                 FRC = 'Bon de travail',
                                 ENC = 'Work Order';
        }
        modify("Pick Instruction")
        {
            CaptionML = ENU = 'Pick Instruction',
                                 ESM = 'Instrucci¢n picking',
                                 FRC = 'Instruction pr‚lŠvement',
                                 ENC = 'Pick Instruction';
        }
        addlast("&Print")
        {
            action(SOCheckSheet)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'SO Check Sheet';
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
                trigger OnAction()
                VAR
                    SalesHeadLRec: Record "Sales Header";
                BEGIN
                    //NUB1.09 Start
                    SalesHeadLRec.RESET;
                    SalesHeadLRec.SETRANGE("Document Type", Rec."Document Type");
                    SalesHeadLRec.SETRANGE("No.", Rec."No.");
                    IF SalesHeadLRec.FINDFIRST THEN;

                    REPORT.RUNMODAL(REPORT::"SO Check Sheet", TRUE, FALSE, SalesHeadLRec);
                    //NUB1.09 End
                END;
            }
            action(SOCheckSheetForDriver)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Driver Delivery Report';
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
                trigger OnAction()
                VAR
                    SalesHeadLRec: Record "Sales Header";
                BEGIN
                    //NUB1.13 Start
                    SalesHeadLRec.RESET;
                    SalesHeadLRec.SETRANGE("Document Type", Rec."Document Type");
                    SalesHeadLRec.SETRANGE("No.", Rec."No.");
                    SalesHeadLRec.FINDFIRST;

                    REPORT.RUNMODAL(REPORT::"Driver Delivery Report", TRUE, FALSE, SalesHeadLRec);
                    //NUB1.13 End
                END;
            }
            action(PalletLabel)
            {
                ApplicationArea = All;

                CaptionML = ENU = 'Pallet Label';
                trigger OnAction()
                VAR
                    PalletLabelRepVarLcl: Report "Pallet Label";
                BEGIN
                    //NUB1.15 Start
                    Rec.TESTFIELD(Rec."Pallet Count");
                    CLEAR(PalletLabelRepVarLcl);
                    PalletLabelRepVarLcl.SetDetails(Rec);
                    PalletLabelRepVarLcl.RUNMODAL;
                    //NUB1.15 End
                END;
            }
            action("Warehouse Shipping Status")
            {
                ApplicationArea = All;
                RunObject = Report "Warehouse Shipping Status";
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = New;
            }
            // action("Drop Shipment Status")
            // {
            //     CaptionML = ENU = 'Drop Shipment Status',
            //                      ESM = 'Estado env¡o directo',
            //                      FRC = 'tat de livraison directe',
            //                      ENC = 'Drop Shipment Status';
            //     //RunObject = Report 10051;  //B2BUPG
            //     Promoted = false;
            //     Image = Report;
            //    // PromotedCategory = Report;  //B2BUPG
            // }
            action("Picking List by Order")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Picking List by Order',
                                 ESM = 'List. picking por ped.',
                                 FRC = 'Bon de cueillette par commande',
                                 ENC = 'Picking List by Order';
                // RunObject = Report 10153;  //B2BUPG
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
            }
        }
        modify(Action3)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        addafter(CopyDocument)
        {
            action(NUBCopyDocument)
            {
                ApplicationArea = All;
                Caption = 'NUB Copy Document';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                trigger OnAction()
                var
                    NUBCopySalesDocument: Report "NUB Sales Copy Document";
                begin
                    NUBCopySalesDocument.SetSalesHeader(Rec);
                    NUBCopySalesDocument.RunModal();

                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                    CurrPage.SalesLines.Page.ForceTotalsCalculation();
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //NUB1.03 Start
        IF EventsandSubscribers.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventsandSubscribers.GetSalesPersonFilter);
        END;
        //NUB1.03 End
    end;



    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean OutgoingText : Text)   //Addon
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, "No.", DocTypeTXT, FORMAT("Order Date"),
    //                                     "Sell-to Customer Name", "Sell-to Contact", FORMAT("Shipment Date"), "Salesperson Code", Aux1, '', '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                                                                                                                                               //  END;
    //                                                                                                                                                               //END;
    // END;


    var
        "--SendToPDF--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        // EmailCommT: Record 14005144;  //B2BUPG
        //ReportHelperCU: Codeunit 14005067;  //B2BUPG
        SalesHeader: Record "Sales Header";
        // EmailCommT2: Record 14005144;  //B2BUPG
        // DefSetup: Record 14005001;  //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'P.O. No.';
        ShippingAgent: Record 291;
        ShippingAgentServices: Record 5790;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "-NUB1.02-": Integer;
        SalesHeadGRec: Record "Sales Header";
        "-NUB1.05-": Integer;
        TotalPallets: Decimal;
        "-NUB1.06-": Integer;
        ResEntryRecGbl: Record 337;
        QtyToHandleVar: Decimal;
        EventsandSubscribers: codeunit EventsandSubscribers;
}
