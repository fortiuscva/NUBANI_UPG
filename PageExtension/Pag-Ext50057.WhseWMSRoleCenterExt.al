namespace Nubani.Nubani;

using Microsoft.Warehouse.RoleCenters;

pageextension 50057 "Whse. WMS Role Center Ext" extends "Whse. WMS Role Center"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        modify("&Picking List")
        {
            CaptionML = ENU = '&Picking List',
                                 ESM = 'Lista &picking',
                                 FRC = '&Bordereau de pr‚lŠvement',
                                 ENC = '&Picking List';
        }
        modify("P&ut-away List")
        {
            CaptionML = ENU = 'P&ut-away List',
                                 ESM = 'Lista &ubicac.',
                                 FRC = 'Liste d art&icles … classer',
                                 ENC = 'P&ut-away List';
        }
        modify("M&ovement List")
        {
            CaptionML = ENU = 'M&ovement List',
                                 ESM = 'Lista m&ovimiento',
                                 FRC = 'Liste de m&ouvements',
                                 ENC = 'M&ovement List';
        }
        modify("Whse. &Shipment Status")
        {
            CaptionML = ENU = 'Whse. &Shipment Status',
                                 ESM = 'E&stado env¡o alm.',
                                 FRC = 'tat des livraison&s d entrep“t',
                                 ENC = 'Whse. &Shipment Status';
        }
        modify("Warehouse &Bin List")
        {
            CaptionML = ENU = 'Warehouse &Bin List',
                                 ESM = 'Lista u&bicaci¢n almac‚n',
                                 FRC = 'Liste des &zones de stockage',
                                 ENC = 'Warehouse &Bin List';
        }
        modify("Whse. &Adjustment Bin")
        {
            CaptionML = ENU = 'Whse. &Adjustment Bin',
                                 ESM = 'Ubic. &ajuste alm.',
                                 FRC = 'Zone d &ajustement d entrep“t',
                                 ENC = 'Whse. &Adjustment Bin';
        }
        modify("P&hys. Inventory List")
        {
            CaptionML = ENU = 'P&hys. Inventory List',
                                 ESM = 'Lista in&ventario f¡sico',
                                 FRC = 'Liste de l inventaire p&hysique',
                                 ENC = 'P&hys. Inventory List';
        }
        modify("&Customer - Labels")
        {
            CaptionML = ENU = '&Customer - Labels',
                                 ESM = '&Cliente - Etiquetas',
                                 FRC = '&Client - tiquettes',
                                 ENC = '&Customer - Labels';
        }

        modify(WhseShptReleased)
        {
            CaptionML = ENU = 'Released',
                                 ESM = 'Lanzados',
                                 FRC = 'Relƒch‚',
                                 ENC = 'Released';
        }
        modify(WhseShptComplPicked)
        {
            CaptionML = ENU = 'Completely Picked',
                                 ESM = 'Picking completo',
                                 FRC = 'EntiŠrement pr‚l‚v‚',
                                 ENC = 'Completely Picked';
        }
        modify(WhseShptPartPicked)
        {
            CaptionML = ENU = 'Partially Picked',
                                 ESM = 'Picking parcial',
                                 FRC = 'Partiellement pr‚lev‚',
                                 ENC = 'Partially Picked';
        }
        modify(WhseShptPartShipped)
        {
            CaptionML = ENU = 'Partially Shipped',
                                 ESM = 'Enviados parcialmente',
                                 FRC = 'Partiellement livr‚',
                                 ENC = 'Partially Shipped';
        }
        modify(WhseRcpt)
        {
            CaptionML = ENU = 'Warehouse Receipts',
                                 ESM = 'Recepciones almac‚n',
                                 FRC = 'R‚ceptions de l entrep“t',
                                 ENC = 'Warehouse Receipts';
        }
        modify(WhseRcptPartReceived)
        {
            CaptionML = ENU = 'Partially Received',
                                 ESM = 'Recibidas parcialmente',
                                 FRC = 'Partiellement re‡u',
                                 ENC = 'Partially Received';
        }
        addafter(WhseRcptPartReceived)
        {
            action("Warehouse Manager Order Report")
            {
                ApplicationArea = All;
                RunObject = Page "Warehouse Manager Order Report";
            }
        }
        modify(SalesOrders)
        {
            CaptionML = ENU = 'Sales Orders',
                                 ESM = 'Pedidos venta',
                                 FRC = 'Documents de vente',
                                 ENC = 'Sales Orders';
        }
        modify(SalesOrdersReleased)
        {
            CaptionML = ENU = 'Released',
                                 ESM = 'Lanzados',
                                 FRC = 'Relƒch‚',
                                 ENC = 'Released';
        }
        modify(SalesOrdersPartShipped)
        {
            CaptionML = ENU = 'Partially Shipped',
                                 ESM = 'Enviados parcialmente',
                                 FRC = 'Partiellement livr‚',
                                 ENC = 'Partially Shipped';
        }
        modify(PurchaseReturnOrders)
        {
            CaptionML = ENU = 'Purchase Return Orders',
                                 ESM = 'Devoluciones compra',
                                 FRC = 'Retours achat',
                                 ENC = 'Purchase Return Orders';
        }
        modify(TransferOrders)
        {
            CaptionML = ENU = 'Transfer Orders',
                                 ESM = 'Peds. transfer.',
                                 FRC = 'Ordres de transfert',
                                 ENC = 'Transfer Orders';
        }
        modify(ReleasedProductionOrders)
        {
            CaptionML = ENU = 'Released Production Orders',
                                 ESM = 'àrdenes producci¢n lanzadas',
                                 FRC = 'Ordres de fabrication lanc‚s',
                                 ENC = 'Released Production Orders';
        }
        modify(PurchaseOrders)
        {
            CaptionML = ENU = 'Purchase Orders',
                                 ESM = 'Pedidos compra',
                                 FRC = 'Bons de commande',
                                 ENC = 'Purchase Orders';
        }
        modify(PurchaseOrdersReleased)
        {
            CaptionML = ENU = 'Released',
                                 ESM = 'Lanzados',
                                 FRC = 'Relƒch‚',
                                 ENC = 'Released';
        }
        modify(PurchaseOrdersPartReceived)
        {
            CaptionML = ENU = 'Partially Received',
                                 ESM = 'Recibidos parcialmente',
                                 FRC = 'Partiellement re‡u',
                                 ENC = 'Partially Received';
        }
        modify(AssemblyOrders)
        {
            CaptionML = ENU = 'Assembly Orders',
                                 ESM = 'Pedidos de ensamblado',
                                 FRC = 'Ordres d assemblage',
                                 ENC = 'Assembly Orders';
        }
        modify(SalesReturnOrders)
        {
            CaptionML = ENU = 'Sales Return Orders',
                                 ESM = 'Devoluciones venta',
                                 FRC = 'Retours vente',
                                 ENC = 'Sales Return Orders';
        }
        modify(Picks)
        {
            CaptionML = ENU = 'Picks',
                                 ESM = 'Picking',
                                 FRC = 'Pr‚lŠvements',
                                 ENC = 'Picks';
        }
        modify(PicksUnassigned)
        {
            CaptionML = ENU = 'Unassigned',
                                 ESM = 'No asignados',
                                 FRC = 'Non attribu‚',
                                 ENC = 'Unassigned';
        }
        modify(Putaway)
        {
            CaptionML = ENU = 'Put-away',
                                 ESM = 'Ubicaci¢n',
                                 FRC = 'Rangement',
                                 ENC = 'Put-away';
        }
        modify(PutawayUnassigned)
        {
            CaptionML = ENU = 'Unassigned',
                                 ESM = 'No asignada',
                                 FRC = 'Non attribu‚',
                                 ENC = 'Unassigned';
        }
        modify(Movements)
        {
            CaptionML = ENU = 'Movements',
                                 ESM = 'Movimientos',
                                 FRC = 'Mouvements',
                                 ENC = 'Movements';
        }
        modify(MovementsUnassigned)
        {
            CaptionML = ENU = 'Unassigned',
                                 ESM = 'No asignados',
                                 FRC = 'Non attribu‚',
                                 ENC = 'Unassigned';
        }
        modify(MovementWorksheets)
        {
            CaptionML = ENU = 'Movement Worksheets',
                                 ESM = 'Hojas trabajo movimiento',
                                 FRC = 'Feuilles de mouvement',
                                 ENC = 'Movement Worksheets';
        }
        modify(BinContents)
        {
            CaptionML = ENU = 'Bin Contents',
                                 ESM = 'Contenidos ubicaci¢n',
                                 FRC = 'Contenu de la zone',
                                 ENC = 'Bin Contents';
        }
        modify(WhseItemJournals)
        {
            CaptionML = ENU = 'Whse. Item Journals',
                                 ESM = 'Diarios producto almac‚n',
                                 FRC = 'Journaux d article d entrep“t',
                                 ENC = 'Whse. Item Journals';
        }
        modify(WhseReclassJournals)
        {
            CaptionML = ENU = 'Whse. Reclass. Journals',
                                 ESM = 'Diarios reclasificaci¢n alm.',
                                 FRC = 'Journaux de reclassements d entrep“t',
                                 ENC = 'Whse. Reclass. Journals';
        }
        modify(WhsePhysInvtJournals)
        {
            CaptionML = ENU = 'Whse. Phys. Invt. Journals',
                                 ESM = 'Diarios inv. f¡sico almac‚n',
                                 FRC = 'Journaux d inventaire d entrep“t',
                                 ENC = 'Whse. Phys. Invt. Journals';
        }
        modify(ItemJournals)
        {
            CaptionML = ENU = 'Item Journals',
                                 ESM = 'Diarios de productos',
                                 FRC = 'Journaux d articles',
                                 ENC = 'Item Journals';
        }
        modify(ItemReclassJournals)
        {
            CaptionML = ENU = 'Item Reclass. Journals',
                                 ESM = 'Diarios reclasif. producto',
                                 FRC = 'Journaux de reclassements d articles',
                                 ENC = 'Item Reclass. Journals';
        }
        modify(PhysInventoryJournals)
        {
            CaptionML = ENU = 'Phys. Inventory Journals',
                                 ESM = 'Diarios de inventario',
                                 FRC = 'Journaux de d‚compte d inventaire',
                                 ENC = 'Phys. Inventory Journals';
        }
        modify(Worksheet)
        {
            CaptionML = ENU = 'Worksheet',
                                 ESM = 'Hoja trabajo',
                                 FRC = 'Feuille activit‚',
                                 ENC = 'Worksheet';
        }
        modify(PutawayWorksheets)
        {
            CaptionML = ENU = 'Put-away Worksheets',
                                 ESM = 'Hojas trab. ubicaci¢n',
                                 FRC = 'Feuilles de rangement',
                                 ENC = 'Put-away Worksheets';
        }
        modify(PickWorksheets)
        {
            CaptionML = ENU = 'Pick Worksheets',
                                 ESM = 'Hojas trabajo picking',
                                 FRC = 'Feuilles de pr‚lŠvement',
                                 ENC = 'Pick Worksheets';
        }

        modify("Internal Put-aways")
        {
            CaptionML = ENU = 'Internal Put-aways',
                                 ESM = 'Ubicaciones internas',
                                 FRC = 'Rangements internes',
                                 ENC = 'Internal Put-aways';
        }
        modify("Internal Picks")
        {
            CaptionML = ENU = 'Internal Picks',
                                 ESM = 'Picking internos',
                                 FRC = 'Pr‚lŠvements internes',
                                 ENC = 'Internal Picks';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Whse Shipments")
        {
            CaptionML = ENU = 'Posted Whse Shipments',
                                 ESM = 'Hist¢rico env¡os almac‚n',
                                 FRC = 'Livraisons d entrep“t report‚es',
                                 ENC = 'Posted Whse Shipments';
        }
        modify("Posted Sales Shipment")
        {
            CaptionML = ENU = 'Posted Sales Shipment',
                                 ESM = 'Hist¢rico remisiones venta',
                                 FRC = 'Livraison vente report‚e',
                                 ENC = 'Posted Sales Shipment';
        }
        modify("Posted Transfer Shipments")
        {
            CaptionML = ENU = 'Posted Transfer Shipments',
                                 ESM = 'Hist¢rico env¡os transferencia',
                                 FRC = 'Livraisons de transfert report‚es',
                                 ENC = 'Posted Transfer Shipments';
        }
        modify("Posted Return Shipments")
        {
            CaptionML = ENU = 'Posted Return Shipments',
                                 ESM = 'Hist¢rico env¡os devoluci¢n',
                                 FRC = 'Livraisons de retour report‚es',
                                 ENC = 'Posted Return Shipments';
        }
        modify("Posted Whse Receipts")
        {
            CaptionML = ENU = 'Posted Whse Receipts',
                                 ESM = 'Hist¢rico recep. almac‚n',
                                 FRC = 'R‚ceptions d entrep“t report‚es',
                                 ENC = 'Posted Whse Receipts';
        }
        modify("Posted Purchase Receipts")
        {
            CaptionML = ENU = 'Posted Purchase Receipts',
                                 ESM = 'Hist¢ricos recepciones de compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Receipts';
        }
        modify("Posted Transfer Receipts")
        {
            CaptionML = ENU = 'Posted Transfer Receipts',
                                 ESM = 'Hist. recepciones transferencia',
                                 FRC = 'R‚ceptions de transfert report‚es',
                                 ENC = 'Posted Transfer Receipts';
        }
        modify("Posted Return Receipts")
        {
            CaptionML = ENU = 'Posted Return Receipts',
                                 ESM = 'Hist¢ricos recep. devoluci¢n',
                                 FRC = 'R‚ceptions de retour report‚es',
                                 ENC = 'Posted Return Receipts';
        }
        modify("Posted Assembly Orders")
        {
            CaptionML = ENU = 'Posted Assembly Orders',
                                 ESM = 'Pedidos de ensamblado registrados',
                                 FRC = 'Ordres d assemblage valid‚s',
                                 ENC = 'Posted Assembly Orders';
        }
        modify("Registered Documents")
        {
            CaptionML = ENU = 'Registered Documents',
                                 ESM = 'Documentos registrados',
                                 FRC = 'Documents enregistr‚s',
                                 ENC = 'Registered Documents';
        }
        modify("Registered Picks")
        {
            CaptionML = ENU = 'Registered Picks',
                                 ESM = 'Picking registrados',
                                 FRC = 'Pr‚lŠvements enregistr‚s',
                                 ENC = 'Registered Picks';
        }
        modify("Registered Put-aways")
        {
            CaptionML = ENU = 'Registered Put-aways',
                                 ESM = 'Ubicaciones registradas',
                                 FRC = 'Rangements enregistr‚s',
                                 ENC = 'Registered Put-aways';
        }
        modify("Registered Movements")
        {
            CaptionML = ENU = 'Registered Movements',
                                 ESM = 'Movimientos registrados',
                                 FRC = 'Mouvements enregistr‚s',
                                 ENC = 'Registered Movements';
        }
        modify("Whse. &Shipment")
        {
            CaptionML = ENU = 'Whse. &Shipment',
                                 ESM = 'E&nv¡o almac‚n',
                                 FRC = '&Livraison magasin',
                                 ENC = 'Whse. &Shipment';
        }
        modify("T&ransfer Order")
        {
            CaptionML = ENU = 'T&ransfer Order',
                                 ESM = '&Ped. transfer.',
                                 FRC = 'O&rdre de transfert',
                                 ENC = 'T&ransfer Order';
        }
        modify("&Purchase Order")
        {
            CaptionML = ENU = '&Purchase Order',
                                 ESM = '&Pedido compra',
                                 FRC = '&Bon de commande',
                                 ENC = '&Purchase Order';
        }
        modify("&Whse. Receipt")
        {
            CaptionML = ENU = '&Whse. Receipt',
                                 ESM = 'Rece&pci¢n almac‚n',
                                 FRC = '&R‚ception en magasin',
                                 ENC = '&Whse. Receipt';
        }
        modify("P&ut-away Worksheet")
        {
            CaptionML = ENU = 'P&ut-away Worksheet',
                                 ESM = 'Hoja trabajo &ubicaci¢n',
                                 FRC = 'Fe&uille rangement',
                                 ENC = 'P&ut-away Worksheet';
        }
        modify("Pi&ck Worksheet")
        {
            CaptionML = ENU = 'Pi&ck Worksheet',
                                 ESM = 'Preparar ho&j. trab. pedido',
                                 FRC = 'Feuille pr‚lŠ&vement',
                                 ENC = 'Pi&ck Worksheet';
        }
        modify("M&ovement Worksheet")
        {
            CaptionML = ENU = 'M&ovement Worksheet',
                                 ESM = 'Hoja trabajo mo&vimiento',
                                 FRC = 'Feuille m&ouvement',
                                 ENC = 'M&ovement Worksheet';
        }
        modify("W&hse. Item Journal")
        {
            CaptionML = ENU = 'W&hse. Item Journal',
                                 ESM = '&Diario producto almac‚n',
                                 FRC = '&Journal article entrep“t',
                                 ENC = 'W&hse. Item Journal';
        }
        modify("Whse. &Phys. Invt. Journal")
        {
            CaptionML = ENU = 'Whse. Phys. &Invt. Journal',
                                 ESM = 'Diario inv. &f¡s. almac‚n',
                                 FRC = 'Journal d inventaire d entre&p“t',
                                 ENC = 'Whse. &Phys. Invt. Journal';
        }
        modify("Item &Tracing")
        {
            CaptionML = ENU = 'Item &Tracing',
                                 ESM = 'Segu&imiento productos',
                                 FRC = 'Rep‚rage d ar&ticle',
                                 ENC = 'Item &Tracing';
        }
        // addlast("Registered Documents")
        // {
        //     action("Credit Management")  //36630 B2BUPG
        //     {
        //         CaptionML = ENU = 'Credit Management',
        //                          ESM = 'Gesti¢n cr‚dito',
        //                          FRC = 'Gestion de cr‚dit',
        //                          ENC = 'Credit Management';
        //         RunObject = Page 36630;
        //     }
        //     action("Order Status")  //36631 B2BUPG
        //     {
        //         CaptionML = ENU = 'Order Status',
        //                          ESM = 'Estado pedido',
        //                          FRC = 'tat commande',
        //                          ENC = 'Order Status';
        //         RunObject = Page 36631;
        //     }
        //     action("Sales Order Shipping")  //36626 B2BUPG
        //     {
        //         CaptionML = ENU = 'Sales Order Shipping',
        //                          ESM = 'Env¡o pedido ventas',
        //                          FRC = 'Livraison de document de vente',
        //                          ENC = 'Sales Order Shipping';
        //         RunObject = Page 36626;
        //     }
        // }
    }
}
