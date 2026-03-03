namespace Nubani.Nubani;

using Microsoft.Purchases.History;

pageextension 50025 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    CaptionML = ENU = 'Posted Purchase Receipt',
               ESM = 'Hist¢rico recepciones compra',
               FRC = 'R‚ception achat report‚e',
               ENC = 'Posted Purchase Receipt';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        moveafter("Buy-from City"; "Buy-from County")
        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from State/ZIP Code',
                           ESM = 'Compra a Estado/C.P.',
                           FRC = 'CP/Ville fournisseur',
                           ENC = 'Buy-from Province/State/Postal/ZIP Code';

            Editable = FALSE;
        }
        addafter("Responsibility Center")
        {
            field("Created Date & Time"; Rec."Created Date & Time")
            {
                ApplicationArea = All;
            }
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing',
                           ESM = 'Facturaci¢n',
                           FRC = 'Facturation',
                           ENC = 'Invoicing';
        }
        moveafter("Pay-to City"; "Pay-to County")
        modify("Pay-to County")
        {
            CaptionML = ENU = 'State/ZIP Code',
                           ESM = 'Pago a Estado / C.P.',
                           FRC = 'tat-Province/code postal (cr‚ancier)',
                           ENC = 'Province/State/Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Pay-to County"; "Pay-to Post Code")
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping',
                           ESM = 'Env¡o',
                           FRC = 'Livraison',
                           ENC = 'Shipping';
        }
        moveafter("Ship-to City"; "Ship-to County")
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State/ZIP Code',
                           ESM = 'Env¡o a Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State/Postal/ZIP Code';
            Editable = FALSE;
        }
        moveafter("Ship-to County"; "Ship-to Post Code")
        addafter("Expected Receipt Date")
        {
            field("Expected Receipt Time"; Rec."Expected Receipt Time")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt',
                                 ESM = 'R&ecepci¢n',
                                 FRC = '&Re‡u',
                                 ENC = '&Receipt';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
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
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
    }
}
