namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50008 "Sales Invoice Ext" extends "Sales Invoice"
{
    CaptionML = ENU = 'Sales Invoice',
               ESM = 'Factura venta',
               FRC = 'Facture vente',
               ENC = 'Sales Invoice';
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
        moveafter("External Document No."; "Your Reference")
        modify("Your Reference")
        {
            CaptionML = ENU = 'Your Reference',
                           ESM = 'Su/Ntra. ref.',
                           FRC = 'Votre r‚f‚rence',
                           ENC = 'Your Reference';
        }
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


        // addafter("Tax Area Code")
        // {
        //     field(GetCreditcardNumber; GetCreditcardNumber)
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Cr. Card Number (Last 4 Digits)',
        //                    ESM = 'N£mero tarjeta cr‚dito (cuatro £ltimos d¡gitos)',
        //                    FRC = 'Num‚ro de carte de cr‚dit (4ÿderniers chiffres)',
        //                    ENC = 'Cr. Card Number (Last 4 Digits)';
        //     }
        // }
        moveafter("Ship-to Address 2"; "Ship-to City")
        moveafter("Ship-to City"; "Ship-to County")

        moveafter("Ship-to Contact"; "Ship-to UPS Zone")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice',
                                 ESM = '&Factura',
                                 FRC = '&Facture',
                                 ENC = '&Invoice';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            // PromotedIsBig = true;  //B2BUPG
            trigger OnBeforeAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
            end;

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
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(Action9)
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
        modify(Function_CustomerCard)
        {
            CaptionML = ENU = 'Customer',
                                 ESM = 'Cliente',
                                 FRC = 'Client',
                                 ENC = 'Customer';
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
            // PromotedIsBig = true;  //B2BUPG
        }
        modify("Move Negative Lines")
        {
            CaptionML = ENU = 'Move Negative Lines',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
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
        IF Eventsandsubscriber.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", Eventsandsubscriber.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    end;

    var
        Eventsandsubscriber: codeunit EventsandSubscribers;
}
