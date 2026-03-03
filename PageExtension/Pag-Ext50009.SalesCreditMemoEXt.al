namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50009 "Sales Credit Memo EXt" extends "Sales Credit Memo"
{
    CaptionML = ENU = 'Sales Credit Memo',
               ESM = 'Nota cr‚dito venta',
               FRC = 'Note de cr‚dit de vente',
               ENC = 'Sales Credit Memo';
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
        moveafter("Sell-to Contact"; "Posting Description")
        addafter(Status)
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
        moveafter("Bill-to City"; "Bill-to County")
        moveafter("Bill-to County"; "Bill-to Post Code")
        moveafter("Payment Method Code"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        addafter("Tax Area Code")
        {
            field("Orig. Invoice No."; Rec."Orig. Invoice No.")
            {
                ApplicationArea = All;
            }
        }
        // addafter("Orig. Invoice No.")
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
        addbefore("Shipment Date")
        {
            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to City")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';
            }
        }
        addafter("Ship-to County")
        {
            field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
            {
                ApplicationArea = All;
            }
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        addafter(Control1906127307)
        {
            part(ItemInvoicingFactbox; 9089)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                // ProviderID =48; //B2BUPG
                // PartType =Page;
            }
        }

    }
    actions
    {
        modify("&Credit Memo")
        {
            CaptionML = ENU = '&Credit Memo',
                                 ESM = 'Nota de &cr‚dito',
                                 FRC = 'Note de c&r‚dit',
                                 ENC = '&Credit Memo';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            // PromotedIsBig = true;  //B2BUPG
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
            end;
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer',
                                 ESM = 'Cliente',
                                 FRC = 'Client',
                                 ENC = 'Customer';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
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
            CaptionML = ENU = 'Approvals',
                                 ESM = 'Aprobaciones',
                                 FRC = 'Approbations',
                                 ENC = 'Approvals';
        }
        modify(Action7)
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
        modify(GetPostedDocumentLinesToReverse)
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse',
                                 ESM = 'Revertir l¡neas doc&umentos registrados',
                                 FRC = 'Extraire les lignes de doc&ument report‚es … inverser',
                                 ENC = 'Get Posted Doc&ument Lines to Reverse';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount',
                                 ESM = 'Calcular dto. en la &factura',
                                 FRC = 'Calculer escompte &facture',
                                 ENC = 'Calculate &Invoice Discount';
        }
        modify(ApplyEntries)
        {
            CaptionML = ENU = 'Apply Entries',
                                 ESM = 'Liquidar movs.',
                                 FRC = 'Affecter les ‚critures',
                                 ENC = 'Apply Entries';
            //PromotedIsBig = true;  //B2BUPG
        }
        modify(GetStdCustSalesCodes)
        {
            CaptionML = ENU = 'Get St&d. Cust. Sales Codes',
                                 ESM = 'Tomar c¢d. est nd. &vtas. clie.',
                                 FRC = 'Obtenir les codes de vente de client stan&dard',
                                 ENC = 'Get St&d. Cust. Sales Codes';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document',
                                 ESM = 'Copiar l¡neas',
                                 FRC = 'Copier document',
                                 ENC = 'Copy Document';
            //PromotedIsBig = true;  //B2BUPG
        }
        modify("Move Negative Lines")
        {
            CaptionML = ENU = 'Move Negative Lines',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
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
        modify(TestReport)
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
        //NUB1.01 Start
        IF EventsandSubscriber.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventsandSubscriber.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    end;

    var
        EventsandSubscriber: codeunit EventsandSubscribers;

}
