namespace Nubani.Nubani;
using Microsoft.Purchases.Document;

pageextension 50013 "Purchase order Ext" extends "Purchase Order"
{
    CaptionML = ENU = 'Purchase Order',
               ESM = 'Pedido compra',
               FRC = 'Bon de commande',
               ENC = 'Purchase Order';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        moveafter("Buy-from Address 2"; "Buy-from City")

        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from State / ZIP Code',
                           ESM = 'Compra a-Estado / C.P.',
                           FRC = 'CP/Ville fournisseur',
                           ENC = 'Buy-from Province/State / Postal/ZIP Code';
        }
        modify("Your Reference")
        {
            ApplicationArea = All;
        }
        addafter("Buy-from County")
        {
            field("Contact Phone"; Rec."Contact Phone")
            {
                ApplicationArea = All;
            }
        }
        modify("Posting Description")
        {
            Visible = true;
        }
        moveafter("Contact Phone"; "Posting Description")
        //moveafter("Ship-to Code"; "Lead Time Calculation")
        moveafter("Creditor No."; "Due Date")
        moveafter("Posting Description"; "Your Reference")
        movebefore("Currency Code"; PayToOptions, "Pay-to Contact", "Pay-to Name", "Pay-to Address", "Pay-to Address 2", "Pay-to City", "Pay-to Post Code", "Pay-to Contact No.")
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Carrier',
                           ESM = 'C¢d. m‚todo de env¡o',
                           FRC = 'Code m‚thode de livraison',
                           ENC = 'Shipment Method Code';
        }
        modify("Expected Receipt Date")
        {
            Importance = Promoted;
        }
        addafter("Responsibility Center")
        {
            field("Expected Receipt Time"; Rec."Expected Receipt Time")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt time")
        {
            field("Priority Level"; Rec."Priority Level")
            {
                ApplicationArea = All;
            }
        }
        addafter("Priority Level")
        {
            field("Pallets-Cases"; Rec."Pallets-Cases")
            {
                ApplicationArea = All;
            }
        }

        // moveafter("Invoice Details")
        moveafter("Ship-to UPS Zone"; "Location Code")
        moveafter("Remit-to Code"; "Inbound Whse. Handling Time", "Requested Receipt Date", "Promised Receipt Date", "Sell-to Customer No.", "Ship-to Code")
        moveafter("Pay-to Address 2"; "Pay-to City")
        modify("Pay-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';

        }

        // moveafter("Payment Method Code"; "IRS 1099 Code")
        // moveafter("IRS 1099 Code"; "On Hold")
        moveafter("Payment Method Code"; "On Hold")
        moveafter("Pmt. Discount Date"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Tax Exemption No.")
        moveafter("Tax Exemption No."; "Provincial Tax Area Code")
        moveafter("Ship-to Address 2"; "Ship-to City")
        moveafter("Inbound Whse. Handling Time"; "Lead Time Calculation")
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';
        }

        moveafter("Ship-to Contact"; "Ship-to UPS Zone")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';

        }
        modify("Transaction Specification")
        {
            ApplicationArea = All;
        }
        modify("Transaction Type")
        {
            ApplicationArea = All;
        }
        modify("Transport Method")
        {
            ApplicationArea = All;
        }
        modify("Entry Point")
        {
            ApplicationArea = All;
        }
        modify("Area")
        {
            ApplicationArea = All;
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment',
                           ESM = 'Anticipo',
                           FRC = 'Paiement anticip‚',
                           ENC = 'Prepayment';
        }

        moveafter("Vendor Cr. Memo No."; "Prepmt. Include Tax")

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
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Purchase Order Stats.", Rec)
            end;
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals',
                                 ESM = 'Aprobaciones',
                                 FRC = 'Approbations',
                                 ENC = 'Approvals';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify(Receipts)
        {
            CaptionML = ENU = 'Receipts',
                                 ESM = 'Recepciones',
                                 FRC = 'Re‡us',
                                 ENC = 'Receipts';
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
        }
        modify("Whse. Receipt Lines")
        {
            CaptionML = ENU = 'Whse. Receipt Lines',
                                 ESM = 'L¡neas recep. alm.',
                                 FRC = 'Lignes r‚ception entrep“t',
                                 ENC = 'Whse. Receipt Lines';
        }
        modify(Action225)
        {
            CaptionML = ENU = 'Dr&op Shipment',
                                 ESM = 'En&v¡o directo',
                                 FRC = '&Livraison directe',
                                 ENC = 'Dr&op Shipment';
        }
        modify("Get &Sales Order")
        {
            CaptionML = ENU = 'Get &Sales Order',
                                 ESM = 'Tomar pedido &venta',
                                 FRC = 'Obtenir le &document de vente',
                                 ENC = 'Get &Sales Order';
        }
        modify(Action186)
        {
            CaptionML = ENU = 'Speci&al Order',
                                 ESM = '&Pedido especial',
                                 FRC = 'C&ommande sp‚ciale',
                                 ENC = 'Speci&al Order';
        }
        modify(Action13)
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
        addlast("F&unctions")
        {
            action("Update Item Description")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Update Item Description',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    //NUB1.02 Start
                    Rec.UpdateItemDescription;
                    //NUB1.02 End
                END;
            }
        }
        modify("Dr&op Shipment")
        {
            CaptionML = ENU = 'Dr&op Shipment',
                                 ESM = '&Env¡o directo',
                                 FRC = 'Livrais&on directe',
                                 ENC = 'Dr&op Shipment';
        }
        modify(Warehouse_GetSalesOrder)
        {
            CaptionML = ENU = 'Get &Sales Order',
                                 ESM = 'Tomar pedido &venta',
                                 FRC = 'Obtenir le &document de vente',
                                 ENC = 'Get &Sales Order';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order',
                                 ESM = '&Pedido especial',
                                 FRC = 'Commande sp‚ci&ale',
                                 ENC = 'Speci&al Order';
        }
        modify(Action187)
        {
            CaptionML = ENU = 'Get &Sales Order',
                                 ESM = 'Tomar pedido &venta',
                                 FRC = 'Obtenir le &document de vente',
                                 ENC = 'Get &Sales Order';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document',
                                 ESM = '&Archivar documento',
                                 FRC = 'Archi&ver document',
                                 ENC = 'Archi&ve Document';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval',
                                 ESM = 'Aprobaci¢n',
                                 FRC = 'Approbation',
                                 ENC = 'Approval';
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
        modify(Action17)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt',
                                 ESM = 'Crear &recep. almac‚n',
                                 FRC = 'Cr‚er un re‡u d &entrep“t',
                                 ENC = 'Create &Whse. Receipt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away / Pick',
                                 ESM = 'Crear &ubicac./ pick. inventario',
                                 FRC = 'Cr‚er une r‚servation/sortie de stoc&k',
                                 ENC = 'Create Inventor&y Put-away / Pick';
        }

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
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print',
                                 ESM = 'Registrar e &imprimir',
                                 FRC = 'Reporter et im&primer',
                                 ENC = 'Post and &Print';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch',
                                 ESM = 'Registrar por &lotes',
                                 FRC = 'Reporter &lot',
                                 ENC = 'Post &Batch';
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
        modify("Prepayment Test &Report")
        {
            CaptionML = ENU = 'Prepayment Test &Report',
                                 ESM = 'Informe prue&ba anticipo',
                                 FRC = '&Rapport de test de paiement anticip‚',
                                 ENC = 'Prepayment Test &Report';
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
            CaptionML = ENU = 'Post Prepayment &Credit Memo',
                                 ESM = '&Registrar nota cr‚dito anticipo',
                                 FRC = 'Reporter note de &cr‚dit paiement anticip‚',
                                 ENC = 'Post Prepayment &Credit Memo';
        }
        modify(Print)
        {
            CaptionML = ENU = 'Print',
                                 ESM = 'Imprimir',
                                 FRC = 'Imprimer',
                                 ENC = 'Print';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        // addlast(Print)
        // {
        //     action("Purchase Advice")  //10155  B2BUPG
        //     {
        //         CaptionML = ENU = 'Purchase Advice',
        //                          ESM = 'Aviso compra',
        //                          FRC = 'Avis d achat',
        //                          ENC ='Purchase Advice';
        //         RunObject = Report 10155;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;  
        //     }
        //     action("Vendor/Item Catalog")  //10164 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor/Item Catalog',
        //                          ESM = 'Cat logo de productos/proveedor',
        //                          FRC = 'Catalogue d articles/fournisseur',
        //                          ENC = 'Vendor/Item Catalogue';
        //         RunObject = Report 10164;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        // }
    }


    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;  //Addon
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, Rec."No.", DocTypeTXT, FORMAT("Order Date"), "Buy-from Vendor Name", "Buy-from Contact", '', "Purchaser Code", Aux1, '', '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                                                                                                                                                                                                              //  END;
    //                                                                                                                                                                                                                              //END;
    // END;

    var
        "--SendToPDF--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        // EmailCommT: Record 14005144; //B2BUPG
        // ReportHelperCU: Codeunit 14005067;  //B2BUPG
        PurchHeader: Record "Purchase Header";
        // EmailCommT2: Record 14005144;  //B2BUPG
        // DefSetup: Record 14005001;  //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        ShippingAgent: Record 291;
        ShippingAgentServices: Record 5790;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'Your Reference';
}
