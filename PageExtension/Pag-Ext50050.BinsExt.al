namespace Nubani.Nubani;

using Microsoft.Warehouse.Structure;

pageextension 50050 "Bins Ext" extends Bins
{
    CaptionML = ENU = 'Bins',
               ESM = 'Ubicaciones',
               FRC = 'Zones',
               ENC = 'Bins';
    layout
    {
        addafter(Code)
        {
            field("Bin Order"; Rec."Bin Order")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Bin")
        {
            CaptionML = ENU = '&Bin',
                                 ESM = '&Ubic.',
                                 FRC = '&Zone',
                                 ENC = '&Bin';
        }
        modify("&Contents")
        {
            CaptionML = ENU = '&Contents',
                                 ESM = '&Contenidos',
                                 FRC = '&Contenu',
                                 ENC = '&Contents';
        }
    }
    var
        Text004: TextConst ENU = 'Do you want to update the bin contents?', ESM = '¨Desea actualizar el contenido de la ubicaci¢n?', FRC = 'Souhaitez-vous mettre … jour le contenu emplacementÿ?', ENC = 'Do you want to update the bin contents?';

}
