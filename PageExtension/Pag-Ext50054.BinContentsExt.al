namespace Nubani.Nubani;

using Microsoft.Warehouse.Structure;

pageextension 50054 "Bin Contents Ext" extends "Bin Contents"
{
    CaptionML = ENU = 'Bin Contents',
               ESM = 'Contenidos ubicaci¢n',
               FRC = 'Contenu de la zone',
               ENC = 'Bin Contents';

    layout
    {
        modify(Options)
        {
            CaptionML = ENU = 'Options',
                           ESM = 'Opciones',
                           FRC = 'Options',
                           ENC = 'Options';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Filter',
                           ESM = 'Filtro almac‚n',
                           FRC = 'Filtre emplacement',
                           ENC = 'Location Filter';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Filter',
                           ESM = 'Filtro zona',
                           FRC = 'Filtre zone',
                           ENC = 'Zone Filter';
        }
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
        addafter("Cross-Dock Bin")
        {
            field("Pick Qty."; rec."Pick Qty.")
            {
                ApplicationArea = All;
            }

        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description',
                           ESM = 'Descripci¢n producto',
                           FRC = 'Description article',
                           ENC = 'Item Description';
        }
        modify("Qty. on Adjustment Bin")
        {
            CaptionML = ENU = 'Qty. on Adjustment Bin',
                           ESM = 'Cdad. en ubicaci¢n ajuste',
                           FRC = 'Qt‚ zone ajustement',
                           ENC = 'Qty. on Adjustment Bin';
        }
        modify(CalcQtyonAdjmtBin)
        {
            CaptionML = ENU = 'Qty. on Adjustment Bin',
                           ESM = 'Cdad. en ubicaci¢n ajuste',
                           FRC = 'Qt‚ zone ajustement',
                           ENC = 'Qty. on Adjustment Bin';
        }
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
        modify("Warehouse Entries")
        {
            CaptionML = ENU = 'Warehouse Entries',
                                 ESM = 'Movimientos almac‚n',
                                 FRC = 'critures dentrep“t',
                                 ENC = 'Warehouse Entries';
        }
    }
    var
        Text000: TextConst ENU = 'Location code is not allowed for user %1.', ESM = 'No se permite C¢d. almac‚n para usuario %1.', FRC = 'L''utilisateur %1 n''est pas autoris‚ … utiliser ce code magasin.', ENC = 'Location code is not allowed for user %1.';
}
