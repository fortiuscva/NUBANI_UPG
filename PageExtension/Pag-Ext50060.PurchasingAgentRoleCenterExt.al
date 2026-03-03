namespace Nubani.Nubani;

using Microsoft.Purchases.RoleCenters;

pageextension 50060 "Purchasing Agent RoleCenterExt" extends "Purchasing Agent Role Center"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        // addbefore(PurchaseOrders)
        // {
        //     action("Top __ Vendor List")  //10102 B2BUPG
        //     {
        //         CaptionML = ENU = 'Top __ Vendor List',
        //                          ESM = 'Listado __ mejores proveedores',
        //                          FRC = 'Liste __ meilleurs fournisseurs',
        //                          ENC = 'Top __ Vendor List';
        //         RunObject = Report 10102;
        //     }
        //     action("Vendor/Item Statistics")  //10113 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor/Item Statistics',
        //                          ESM = 'Estad. Proveedor/Prdto.',
        //                          FRC = 'Statistiques fournisseur/article',
        //                          ENC = 'Vendor/Item Statistics';
        //         RunObject = Report 10113;
        //     }
        //     action("Availability Projection")  //10130 B2BUPG
        //     {
        //         CaptionML = ENU = 'Availability Projection',
        //                          ESM = 'Proyecci¢n disponib.',
        //                          FRC = 'Pr‚vision de la disponibilit‚',
        //                          ENC = 'Availability Projection';
        //         RunObject = Report 10130;
        //     }
        //     action("Purchase Order Status")  //10156 B2BUPG
        //     {
        //         CaptionML = ENU = 'Purchase Order Status',
        //                          ESM = 'Estado pedido compra',
        //                          FRC = 'tat du bon de commande',
        //                          ENC = 'Purchase Order Status';
        //         RunObject = Report 10156;
        //     }
        //     action("Vendor Purchases by Item")  //10163 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor Purchases by Item',
        //                          ESM = 'Compras prov. por prod.',
        //                          FRC = 'Achats du fournisseur par article',
        //                          ENC = 'Vendor Purchases by Item';
        //         RunObject = Report 10163;
        //     }
        //     action("Item Cost and Price List")  //10142 B2BUPG
        //     {
        //         CaptionML = ENU = 'Item Cost and Price List',
        //                          ESM = 'Lista precios y costos prod.',
        //                          FRC = 'Liste des co–ts et prix par articles',
        //                          ENC = 'Item Cost and Price List';
        //         RunObject = Report 10142;
        //     }
        //     action("Outstanding Order Stat. by PO;")  //10094 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Order Stat. by PO',
        //                          ESM = 'Estado ped. pdte. por ped. compra',
        //                          FRC = 'Stat. commande suspens par BC',
        //                          ENC = 'Outstanding Order Stat. by PO';
        //         RunObject = Report 10094;
        //         Image = Report;
        //     }
        //     action("Outstanding Purch. Order Aging")  //10095 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Purch. Order Aging',
        //                          ESM = 'Antigedad pedido compra pdte.',
        //                          FRC = 'Bons de commande en suspens class‚s chronologiquement',
        //                          ENC = 'Outstanding Purch. Order Aging';
        //         RunObject = Report 10095;
        //         Image = Report;
        //     }
        //     action("Outstanding Purch.Order Status")  //10096 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Purch.Order Status',
        //                          ESM = 'Estado pedido compra pendiente',
        //                          FRC = 'tat des bons de commande en suspens',
        //                          ENC = 'Outstanding Purch.Order Status';
        //         RunObject = Report 10096;
        //         Image = Report;
        //     }
        //     action("Purchase Advice")  //10155 B2BUPG
        //     {
        //         CaptionML = ENU = 'Purchase Advice',
        //                          ESM = 'Aviso compra',
        //                          FRC = 'Avis d achat',
        //                          ENC = 'Purchase Advice';
        //         RunObject = Report 10155;
        //         Image = Report;
        //     }
        //     action("Vendor Purchase History")  //14005137 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor Purchase History';
        //         RunObject = Report 14005137;
        //     }
        //     action("Vendor Shipment Performance")  //14005139 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor Shipment Performance';
        //         RunObject = Report 14005139;
        //     }
        // }
        modify(PurchaseOrders)
        {
            CaptionML = ENU = 'Purchase Orders',
                                 ESM = 'Pedidos compra',
                                 FRC = 'Bons de commande',
                                 ENC = 'Purchase Orders';
        }
        modify(PurchaseOrdersPendConf)
        {
            CaptionML = ENU = 'Pending Confirmation',
                                 ESM = 'Confirmaci¢n pendiente',
                                 FRC = 'Confirmation en attente',
                                 ENC = 'Pending Confirmation';
        }
        modify(PurchaseOrdersPartDeliv)
        {
            CaptionML = ENU = 'Partially Delivered',
                                 ESM = 'Parcialmente entregados',
                                 FRC = 'Livr‚ partiellement',
                                 ENC = 'Partially Delivered';
        }
        modify("Purchase Quotes")
        {
            CaptionML = ENU = 'Purchase Quotes',
                                 ESM = 'Cotizaciones compra',
                                 FRC = 'Devis d achat',
                                 ENC = 'Purchase Quotes';
        }
        modify("Blanket Purchase Orders")
        {
            CaptionML = ENU = 'Blanket Purchase Orders',
                                 ESM = 'Pedidos abiertos compra',
                                 FRC = 'Commandes d achat ouvertes',
                                 ENC = 'Blanket Purchase Orders';
        }
        modify("Purchase Invoices")
        {
            CaptionML = ENU = 'Purchase Invoices',
                                 ESM = 'Facturas compra',
                                 FRC = 'Factures d achat',
                                 ENC = 'Purchase Invoices';
        }
        modify("Purchase Return Orders")
        {
            CaptionML = ENU = 'Purchase Return Orders',
                                 ESM = 'Devoluciones compra',
                                 FRC = 'Retours achat',
                                 ENC = 'Purchase Return Orders';
        }
        modify("Purchase Credit Memos")
        {
            CaptionML = ENU = 'Purchase Credit Memos',
                                 ESM = 'Notas de Cr‚dito de compra',
                                 FRC = 'Notes de cr‚dit d achat',
                                 ENC = 'Purchase Credit Memos';
        }
        modify("Assembly Orders")
        {
            CaptionML = ENU = 'Assembly Orders',
                                 ESM = 'Pedidos de ensamblado',
                                 FRC = 'Ordres d assemblage',
                                 ENC = 'Assembly Orders';
        }
        modify("Sales Orders")
        {
            CaptionML = ENU = 'Sales Orders',
                                 ESM = 'Pedidos venta',
                                 FRC = 'Documents de vente',
                                 ENC = 'Sales Orders';
        }
        modify(Vendors)
        {
            CaptionML = ENU = 'Vendors',
                                 ESM = 'Proveedores',
                                 FRC = 'Fournisseurs',
                                 ENC = 'Vendors';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items',
                                 ESM = 'Productos',
                                 FRC = 'Articles',
                                 ENC = 'Items';
            // RunObject = Page 50054;  //B2BUPG
        }
        modify("Stockkeeping Units")
        {
            CaptionML = ENU = 'Stockkeeping Units',
                                 ESM = 'Unidades de almacenamiento',
                                 FRC = 'Unit‚s de stock',
                                 ENC = 'Stockkeeping Units';
        }
        modify("Purchase Analysis Reports")
        {
            CaptionML = ENU = 'Purchase Analysis Reports',
                                 ESM = 'Informes de an lisis de compras',
                                 FRC = 'Rapports d analyse des achats',
                                 ENC = 'Purchase Analysis Reports';
        }
        modify("Inventory Analysis Reports")
        {
            CaptionML = ENU = 'Inventory Analysis Reports',
                                 ESM = 'Informes de an lisis de invent.',
                                 FRC = 'Rapports d analyse de l inventaire',
                                 ENC = 'Inventory Analysis Reports';
        }
        modify("Item Journals")
        {
            CaptionML = ENU = 'Item Journals',
                                 ESM = 'Diarios de productos',
                                 FRC = 'Journaux d articles',
                                 ENC = 'Item Journals';
        }
        modify("Purchase Journals")
        {
            CaptionML = ENU = 'Purchase Journals',
                                 ESM = 'Diarios de compras',
                                 FRC = 'Journaux d achat',
                                 ENC = 'Purchase Journals';
        }
        modify(RequisitionWorksheets)
        {
            CaptionML = ENU = 'Requisition Worksheets',
                                 ESM = 'Hojas de demanda',
                                 FRC = 'Feuilles de r‚quisition',
                                 ENC = 'Requisition Worksheets';
        }
        modify(SubcontractingWorksheets)
        {
            CaptionML = ENU = 'Subcontracting Worksheets',
                                 ESM = 'Hojas de subcontrataci¢n',
                                 FRC = 'Feuilles de sous-traitance',
                                 ENC = 'Subcontracting Worksheets';
        }
        modify("Standard Cost Worksheets")
        {
            CaptionML = ENU = 'Standard Cost Worksheets',
                                 ESM = 'Hojas de costo est ndar',
                                 FRC = 'Feuille des co–ts standard',
                                 ENC = 'Standard Cost Worksheets';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Purchase Receipts")
        {
            CaptionML = ENU = 'Posted Purchase Receipts',
                                 ESM = 'Hist¢ricos recepciones de compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Receipts';
        }
        modify("Posted Purchase Invoices")
        {
            CaptionML = ENU = 'Posted Purchase Invoices',
                                 ESM = 'Hist¢rico facturas compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Invoices';
        }
        modify("Posted Return Shipments")
        {
            CaptionML = ENU = 'Posted Return Shipments',
                                 ESM = 'Hist¢rico env¡os devoluci¢n',
                                 FRC = 'Livraisons de retour report‚es',
                                 ENC = 'Posted Return Shipments';
        }
        modify("Posted Purchase Credit Memos")
        {
            CaptionML = ENU = 'Posted Purchase Credit Memos',
                                 ESM = 'Notas de cr‚dito compras registradas',
                                 FRC = 'Notes de cr‚dit achat report‚es',
                                 ENC = 'Posted Purchase Credit Memos';
        }
        modify("Posted Assembly Orders")
        {
            CaptionML = ENU = 'Posted Assembly Orders',
                                 ESM = 'Pedidos de ensamblado registrados',
                                 FRC = 'Ordres d assemblage valid‚s',
                                 ENC = 'Posted Assembly Orders';
        }
        modify("Purchase &Quote")
        {
            CaptionML = ENU = 'Purchase &Quote',
                                 ESM = 'Cotizaci¢n com&pra',
                                 FRC = '&Devis d achat',
                                 ENC = 'Purchase &Quote';
        }
        modify("Purchase &Invoice")
        {
            CaptionML = ENU = 'Purchase &Invoice',
                                 ESM = '&Factura compra',
                                 FRC = 'Facture &achat',
                                 ENC = 'Purchase &Invoice';
        }
        modify("Purchase &Order")
        {
            CaptionML = ENU = 'Purchase &Order',
                                 ESM = 'Pedido de &compra',
                                 FRC = 'Bon de comm&ande',
                                 ENC = 'Purchase &Order';
        }
        modify("Purchase &Return Order")
        {
            CaptionML = ENU = 'Purchase &Return Order',
                                 ESM = 'De&voluci¢n compra',
                                 FRC = '&Retour achat',
                                 ENC = 'Purchase &Return Order';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify("&Purchase Journal")
        {
            CaptionML = ENU = '&Purchase Journal',
                                 ESM = 'Dia&rio compras',
                                 FRC = 'Journal de&s achats',
                                 ENC = '&Purchase Journal';
        }
        modify("Item &Journal")
        {
            CaptionML = ENU = 'Item &Journal',
                                 ESM = 'Diario prod&uctos',
                                 FRC = '&Journal article',
                                 ENC = 'Item &Journal';
        }
        modify("Order Plan&ning")
        {
            CaptionML = ENU = 'Order Plan&ning',
                                 ESM = 'P&lanificaci¢n de pedidos',
                                 FRC = 'Planificatio&n de commande',
                                 ENC = 'Order Plan&ning';
        }
        modify("Requisition &Worksheet")
        {
            CaptionML = ENU = 'Requisition &Worksheet',
                                 ESM = 'Ho&ja de demanda',
                                 FRC = '&Feuille de r‚quisition',
                                 ENC = 'Requisition &Worksheet';
        }
        // modify("Pur&chase Prices")
        // {
        //     CaptionML = ENU = 'Pur&chase Prices',
        //                          ESM = 'Precios co&mpra',
        //                          FRC = 'Prix a&chat',
        //                          ENC = 'Pur&chase Prices';
        // }
        // modify("Purchase &Line Discounts")
        // {
        //     CaptionML = ENU = 'Purchase &Line Discounts',
        //                          ESM = '&Descuentos l¡nea compra',
        //                          FRC = 'Escomptes &ligne achat',
        //                          ENC = 'Purchase &Line Discounts';
        // }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify("Navi&gate")
        {
            CaptionML = ENU = 'Navi&gate',
                                 ESM = '&Navegar',
                                 FRC = 'Navi&guer',
                                 ENC = 'Navi&gate';
        }

    }
}
