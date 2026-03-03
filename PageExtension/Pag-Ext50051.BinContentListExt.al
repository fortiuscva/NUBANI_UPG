namespace Nubani.Nubani;

using Microsoft.Warehouse.Structure;

pageextension 50051 "Bin Content List Ext" extends "Bin Contents List"
{
    CaptionML = ENU = 'Bin Contents List',
               ESM = 'Lista contenidos ubicaci¢n',
               FRC = 'Liste du contenu de la zone',
               ENC = 'Bin Contents List';

    layout
    {
        modify(CalcQtyUOM)
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify(CalcQtyAvailToTakeUOM)
        {
            CaptionML = ENU = 'Available Qty. to Take',
                           ESM = 'Cdad. a tomar disponible',
                           FRC = 'Qt‚ disponible pour pr‚lŠv.',
                           ENC = 'Available Qty. to Take';
        }
    }
}
