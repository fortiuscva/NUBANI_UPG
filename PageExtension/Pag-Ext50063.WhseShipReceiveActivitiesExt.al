namespace Nubani.Nubani;

using Microsoft.Warehouse.RoleCenters;

pageextension 50063 "WhseShip&ReceiveActivities Ext" extends "Whse Ship & Receive Activities"
{
    CaptionML = ENU = 'Activities',
               ESM = 'Actividades',
               FRC = 'Activit‚s',
               ENC = 'Activities';
    layout
    {
        modify("Outbound - Today")
        {
            CaptionML = ENU = 'Outbound - Today',
                           ESM = 'Salida - Hoy',
                           FRC = 'Sortie - Aujourd hui',
                           ENC = 'Outbound - Today';
        }
        modify("Inbound - Today")
        {
            CaptionML = ENU = 'Inbound - Today',
                           ESM = 'Entrada - Hoy',
                           FRC = 'Entr‚e - Aujourd hui',
                           ENC = 'Inbound - Today';
        }
        modify(Internal)
        {
            CaptionML = ENU = 'Internal',
                           ESM = 'Interno',
                           FRC = 'Interne',
                           ENC = 'Internal';
        }
    }
    actions
    {
        // modify("New Transfer Order")
        // {
        //     CaptionML = ENU = 'New Transfer Order',
        //                                      ESM = 'Nuevo pedido transferencia',
        //                                      FRC = 'Nouvel ordre de transfert',
        //                                      ENC = 'New Transfer Order';
        // }
        // modify("New Purchase Order")
        // {
        //     CaptionML = ENU = 'New Purchase Order',
        //                                      ESM = 'Nuevo pedido de compra',
        //                                      FRC = 'Nouveau bon de commande',
        //                                      ENC = 'New Purchase Order';
        // }
        // modify("New Inventory Pick")
        // {
        //     CaptionML = ENU = 'New Inventory Pick',
        //                                      ESM = 'Nuevo picking inventario',
        //                                      FRC = 'Nouveau pr‚lŠvement de stock',
        //                                      ENC = 'New Inventory Pick';
        // }
        // modify("New Inventory Put-away")
        // {
        //     CaptionML = ENU = 'New Inventory Put-away',
        //                                      ESM = 'Nueva ubicaci¢n inventario',
        //                                      FRC = 'Nouveau rangement de stock',
        //                                      ENC = 'New Inventory Put-away';
        // }
        // modify("Edit Item Reclassification Journal")
        // {
        //     CaptionML = ENU = 'Edit Item Reclassification Journal',
        //                                      ESM = 'Editar diario reclasificaci¢n producto',
        //                                      FRC = 'Modifier le journal de reclassements d articles',
        //                                      ENC = 'Edit Item Reclassification Journal';
        // }
    }
}
