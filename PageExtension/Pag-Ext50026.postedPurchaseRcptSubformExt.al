namespace Nubani.Nubani;

using Microsoft.Purchases.History;

pageextension 50026 "postedPurchaseRcpt.SubformExt" extends "Posted Purchase Rcpt. Subform"
{
    CaptionML = ENU = 'Lines',
               ESM = 'L¡neas',
               FRC = 'Lignes',
               ENC = 'Lines';
    layout
    {
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
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking',
                                 ESM = '&Seguimiento pedido',
                                 FRC = '&Suivi de commande',
                                 ENC = 'Order &Tracking';
        }
        modify("&Undo Receipt")
        {
            CaptionML = ENU = '&Undo Receipt',
                                 ESM = 'Des&hacer recepci¢n',
                                 FRC = '&Annuler r‚ception',
                                 ENC = '&Undo Receipt';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(ItemTrackingEntries)
        {
            CaptionML = ENU = 'Item &Tracking Entries',
                                 ESM = 'Movs. &seguim. prod.',
                                 FRC = 'critures de &tra‡abilit‚',
                                 ENC = 'Item &Tracking Entries';
        }
        modify(ItemInvoiceLines)
        {
            CaptionML = ENU = 'Item Invoice &Lines',
                                 ESM = '&L¡n. factura productos',
                                 FRC = '&Lignes de facture d article',
                                 ENC = 'Item Invoice &Lines';
        }
    }
}
