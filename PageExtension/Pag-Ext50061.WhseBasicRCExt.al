namespace Nubani.Nubani;

using Microsoft.Warehouse.RoleCenters;

pageextension 50061 "Whse.Basic RC Ext" extends "Whse. Basic Role Center"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        modify("Warehouse &Bin List")
        {
            CaptionML = ENU = 'Warehouse &Bin List',
                                 ESM = 'Lista u&bicaci¢n almac‚n',
                                 FRC = 'Liste des &zones de stockage',
                                 ENC = 'Warehouse &Bin List';
        }
        addafter("Warehouse &Bin List")
        {
            action("Receiving Bins report")
            {
                ApplicationArea = All;
                RunObject = Report "Display Receving Bin Sales";
                //Promoted = true;
                //PromotedIsBig = true;
                Image = Report;
            }
            action("Inv Pick By User Report")
            {
                ApplicationArea = All;
                RunObject = Report "Invt. Pick By User Report";
                //Promoted = true;
                //PromotedIsBig = true;
            }
            action("Item Replenishment")
            {
                ApplicationArea = All;
                RunObject = Report "Item Replenishment";
                //Promoted = true;
                //PromotedIsBig = true;
            }
            action("Bin Movement by User Report")
            {
                ApplicationArea = All;
                RunObject = Report "Bin Movement by User";
                //Promoted = true;
                //PromotedIsBig = true;
                Image = Report;
            }
        }
        modify("Physical &Inventory List")
        {
            CaptionML = ENU = 'Physical &Inventory List',
                                 ESM = 'Lista del inventario &f¡sico',
                                 FRC = 'Liste d &inventaire physique',
                                 ENC = 'Physical &Inventory List';
        }
        modify("Customer &Labels")
        {
            CaptionML = ENU = 'Customer &Labels',
                                 ESM = 'Eti&quetas de clientes',
                                 FRC = 'tiquettes c&lients',
                                 ENC = 'Customer &Labels';
        }
        addafter("Customer &Labels")
        {
            action("Warehouse Manager Order Report")
            {
                ApplicationArea = All;
                RunObject = Page "Warehouse Manager Order Report";
            }
        }
        // addafter("Customer &Labels")  
        // {
        //     action("Purchase Order Receiving")  //14004997 B2BUPG
        //     {
        //         RunObject = Page 14004997;
        //     }
        // }
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
        modify("Internal Picks")
        {
            CaptionML = ENU = 'Inventory Picks',
                                 ESM = 'Picking inventario',
                                 FRC = 'Articles en stocks … pr‚lever',
                                 ENC = 'Inventory Picks';
        }
        addafter("Internal Picks")
        {
            action("Items on Sales Orders")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Sales Orders";
            }
            action("Items on Picks")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Picks";
            }
        }
        modify("Internal Put-aways")
        {
            CaptionML = ENU = 'Inventory Put-aways',
                                 ESM = 'Ubicac. inventario',
                                 FRC = 'Articles en stock … classer',
                                 ENC = 'Inventory Put-aways';
        }
        modify(InventoryMovements)
        {
            CaptionML = ENU = 'Inventory Movements',
                                 ESM = 'Movimientos de inventario',
                                 FRC = 'Mouvements d inventaire',
                                 ENC = 'Inventory Movements';
        }
        modify("Internal Movements")
        {
            CaptionML = ENU = 'Internal Movements',
                                 ESM = 'Movimientos internos',
                                 FRC = 'Mouvements internes',
                                 ENC = 'Internal Movements';
        }
        modify(BinContents)
        {
            CaptionML = ENU = 'Bin Contents',
                                 ESM = 'Contenidos ubicaci¢n',
                                 FRC = 'Contenu de la zone',
                                 ENC = 'Bin Contents';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items',
                                 ESM = 'Productos',
                                 FRC = 'Articles',
                                 ENC = 'Items';

        }
        modify(Vendors)
        {
            CaptionML = ENU = 'Vendors',
                                 ESM = 'Proveedores',
                                 FRC = 'Fournisseurs',
                                 ENC = 'Vendors';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Invt. Picks")
        {
            CaptionML = ENU = 'Posted Invt. Picks',
                                 ESM = 'Pick. exist. regis.',
                                 FRC = 'Pr‚lŠv. stock report‚s',
                                 ENC = 'Posted Invt. Picks';
        }
        modify("Posted Sales Shipment")
        {
            CaptionML = ENU = 'Posted Sales Shipment',
                                 ESM = 'Hist¢rico remisiones venta',
                                 FRC = 'Livraison vente report‚e',
                                 ENC = 'Posted Sales Shipment';
        }
        modify("Posted Return Shipments")
        {
            CaptionML = ENU = 'Posted Return Shipments',
                                 ESM = 'Hist¢rico env¡os devoluci¢n',
                                 FRC = 'Livraisons de retour report‚es',
                                 ENC = 'Posted Return Shipments';
        }
        modify("Posted Purchase Receipts")
        {
            CaptionML = ENU = 'Posted Purchase Receipts',
                                 ESM = 'Hist¢ricos recepciones de compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Receipts';
        }
        modify("Posted Return Receipts")
        {
            CaptionML = ENU = 'Posted Return Receipts',
                                 ESM = 'Hist¢ricos recep. devoluci¢n',
                                 FRC = 'R‚ceptions de retour report‚es',
                                 ENC = 'Posted Return Receipts';
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
        modify("Inventory Pi&ck")
        {
            CaptionML = ENU = 'Inventory Pi&ck',
                                 ESM = 'Pi&cking inventario',
                                 FRC = 'Arti&cle en inventaire … pr‚lever',
                                 ENC = 'Inventory Pi&ck';
        }
        modify("Inventory P&ut-away")
        {
            CaptionML = ENU = 'Inventory P&ut-away',
                                 ESM = '&Ubicac. inventario',
                                 FRC = 'Article dans l in&ventaire … classer',
                                 ENC = 'Inventory P&ut-away';
        }
        modify("Edit Item Reclassification &Journal")
        {
            CaptionML = ENU = 'Edit Item Reclassification &Journal',
                                 ESM = '&Editar diario reclasificaci¢n producto',
                                 FRC = 'Modifier le &journal de reclassements d articles',
                                 ENC = 'Edit Item Reclassification &Journal';
        }
        modify("Item &Tracing")
        {
            CaptionML = ENU = 'Item &Tracing',
                                 ESM = 'Segu&imiento productos',
                                 FRC = 'Rep‚rage d ar&ticle',
                                 ENC = 'Item &Tracing';
        }
        // addafter("Item &Tracing")
        // {
        //     action(Customer)
        //     {
        //         CaptionML = ENU = 'Customer',
        //                          ESM = 'Cliente',
        //                          FRC = 'Client',
        //                          ENC = 'Customer';
        //         //IsHeader =true;  //B2BUPG
        //     }
        // action("Credit Management")  //36630 B2BUPG
        // {
        //     CaptionML = ENU = 'Credit Management',
        //                      ESM = 'Gesti¢n cr‚dito',
        //                      FRC = 'Gestion de cr‚dit',
        //                      ENC = 'Credit Management';
        //     RunObject = Page 36630;
        // }
        // action("Order Status")  //36631 B2BUPG
        // {
        //     CaptionML = ENU = 'Order Status',
        //                      ESM = 'Estado pedido',
        //                      FRC = 'tat commande',
        //                      ENC = 'Order Status';
        //     RunObject = Page 36631;
        // }
        // action("Sales Order Shipping")  //36626 B2BUPG
        // {
        //     CaptionML = ENU = 'Sales Order Shipping',
        //                      ESM = 'Env¡o pedido ventas',
        //                      FRC = 'Livraison de document de vente',
        //                      ENC = 'Sales Order Shipping';
        //     RunObject = Page 36626;
        // }
    }
}
