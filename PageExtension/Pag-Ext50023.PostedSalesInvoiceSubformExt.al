namespace Nubani.Nubani;
using Microsoft.Sales.History;

pageextension 50023 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    CaptionML = ENU = 'Lines',
               ESM = 'L¡neas',
               FRC = 'Lignes',
               ENC = 'Lines';
    layout
    {
        addafter(Description)
        {
            field("Qty.  Per Pallet"; Rec."Qty.  Per Pallet")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Return Reason Code"; "Package Tracking No.")
        moveafter("Unit Price"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Tax Group Code")
        moveafter("Line Amount"; "Amount Including VAT")
    }
    actions
    {
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
        modify(ItemShipmentLines)
        {
            CaptionML = ENU = 'Item Shipment &Lines',
                                 ESM = '&L¡ns. producto enviado',
                                 FRC = '&Lignes de livraison d article',
                                 ENC = 'Item Shipment &Lines';
        }
    }
}
