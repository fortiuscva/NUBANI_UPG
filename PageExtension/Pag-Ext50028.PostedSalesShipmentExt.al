namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50028 "Posted Sales Shipments Ext" extends "Posted Sales Shipments"
{
    CaptionML = ENU = 'Posted Sales Shipments',
               ESM = 'Hist¢rico remisiones de venta',
               FRC = 'Livraisons ventes report‚es',
               ENC = 'Posted Sales Shipments';
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("Created Date & Time"; Rec."Created Date & Time")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment',
                                 ESM = 'En&v¡o',
                                 FRC = '&Livraison',
                                 ENC = '&Shipment';
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
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("&Track Package")
        {
            CaptionML = ENU = '&Track Package',
                                 ESM = 'Seguimiento pa&quete',
                                 FRC = '&Retracer livraison',
                                 ENC = '&Track Package';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
            //  PromotedIsBig = true;  //B2BUPG
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
            // PromotedIsBig = true;  //B2BUPG
        }
        // addlast("F&unctions")
        // {
        //     action("Sales - Shipment per Package")  //10080  B2BUPG
        //     {
        //         CaptionML = ENU = 'Sales - Shipment per Package',
        //                          ESM = 'Ventas - Remisi¢n por bulto',
        //                          FRC = 'Ventes - Livraison par colis',
        //                          ENC = 'Sales - Shipment per Package';
        //         RunObject = Report 10080;
        //         Promoted = true;
        //         Image = Report;
        //         PromotedCategory = Process;
        //     }
        //     action("Outstanding Sales Order Aging")  //10055 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Sales Order Aging',
        //                          ESM = 'Antig. pedido venta pendiente',
        //                          FRC = 'Document de vente en souffrance ouvert',
        //                          ENC = 'Outstanding Sales Order Aging';
        //         RunObject = Report 10055;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        //     action("Outstanding Sales Order Status")  //10056 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Sales Order Status',
        //                          ESM = 'Estado pedidos vta. pendientes',
        //                          FRC = 'tat document de vente en souffrance',
        //                          ENC = 'Outstanding Sales Order Status';
        //         RunObject = Report 10056;
        //         Promoted = true;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        //     action("Shipping Labels")   //10078 B2BUPG
        //     {
        //         CaptionML = ENU = 'Shipping Labels',
        //                          ESM = 'Etiq. de env¡o',
        //                          FRC = 'tiquettes de livraison',
        //                          ENC = 'Shipping Labels';
        //         RunObject = Report 10078;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        // }
    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;


}
