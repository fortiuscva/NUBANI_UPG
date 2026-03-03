namespace Nubani.Nubani;

using Microsoft.Purchases.History;

pageextension 50031 "Posted purchase Receipts" extends "Posted Purchase Receipts"
{
    CaptionML = ENU = 'Posted Purchase Receipts',
               ESM = 'Hist¢ricos recepciones de compra',
               FRC = 'Bons r‚ception achat report‚s',
               ENC = 'Posted Purchase Receipts';
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Your Reference")
        {
            field("Created Date & Time"; Rec."Created Date & Time")
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
            Promoted = true;
        }
    }
}
