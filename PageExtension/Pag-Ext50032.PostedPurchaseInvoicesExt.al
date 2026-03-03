namespace Nubani.Nubani;

using Microsoft.Purchases.History;

pageextension 50032 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
    CaptionML = ENU = 'Posted Purchase Invoices',
               ESM = 'Hist¢rico facturas de compra',
               FRC = 'Factures achat report‚es',
               ENC = 'Posted Purchase Invoices';
    layout
    {
        moveafter("Buy-from Vendor Name"; "Order No.")
        moveafter("Order No."; "Vendor Invoice No.")
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
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Purchase Invoice Statistics", Rec, Rec."No.")
                ELSE
                    PAGE.RUNMODAL(PAGE::"Purchase Invoice Stats.", Rec, Rec."No.");
            end;
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
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
        // addlast("&Invoice")
        // {
        //     action("Purchase - Invoice") //10121 B2BUPG
        //     {
        //         CaptionML = ENU = 'Purchase - Invoice',
        //                          ESM = 'Compras - Factura',
        //                          FRC = 'Achat - Facture',
        //                          ENC = 'Purchase - Invoice';
        //         RunObject = Report 10121;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Process;
        //     }
        //     action("Outstanding Purch. Order Aging")  //10095 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Purch. Order Aging',
        //                          ESM = 'Antigedad pedido compra pdte.',
        //                          FRC = 'Bons de commande en suspens class‚s chronologiquement',
        //                          ENC = 'Outstanding Purch. Order Aging';
        //         RunObject = Report 10095;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        //     action("Outstanding Purch. Order Status")  //10096 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Purch. Order Status',
        //                          ESM = 'Estado pedido compra pendiente',
        //                          FRC = 'tat des bons de commande en suspens',
        //                          ENC = 'Outstanding Purch. Order Status';
        //         RunObject = Report 10096;
        //         Promoted = true;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        // }
    }

}
