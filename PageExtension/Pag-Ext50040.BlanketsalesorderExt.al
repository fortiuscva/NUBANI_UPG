namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50040 "Blanket sales order Ext" extends "Blanket Sales Order"
{
    CaptionML = ENU = 'Blanket Sales Order',
               ESM = 'Pedido abierto venta',
               FRC = 'Commande permanente ventes',
               ENC = 'Blanket Sales Order';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify("Sell-to County")
        {
            CaptionML = ENU = 'Sell-to State / ZIP Code',
                           ESM = 'Venta a-Estado / C.P.',
                           FRC = 'tat-Province/code postal (d‚biteur)',
                           ENC = 'Sell-to Province/State / Postal/ZIP Code';
        }
        moveafter("Sell-to City"; "Sell-to County")
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
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';
        }
        moveafter("Bill-to City"; "Bill-to County")
        moveafter("Bill-to County"; "Bill-to Post Code")
        moveafter("Pmt. Discount Date"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';
        }
        moveafter("Ship-to City"; "Ship-to County")
        moveafter("Ship-to County"; "Ship-to Post Code")

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
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder',
                                 ESM = '&Pedido',
                                 FRC = 'C&ommande',
                                 ENC = 'O&rder';
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
                    PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
            end;
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
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
        modify("F&unctions"
        )
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
        modify(MakeOrder)
        {
            CaptionML = ENU = 'Make &Order',
                                 ESM = '&Convertir en pedido',
                                 FRC = 'Faire &commande',
                                 ENC = 'Make &Order';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
    }
    trigger OnOpenPage()
    begin
        //NUB1.01 Start
        IF Eventsandsubscribe.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", Eventsandsubscribe.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    end;

    var
        Eventsandsubscribe: codeunit EventsandSubscribers;

}
