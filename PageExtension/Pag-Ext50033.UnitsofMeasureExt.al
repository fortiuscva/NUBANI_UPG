namespace Nubani.Nubani;

using Microsoft.Foundation.UOM;

pageextension 50033 "Units of Measure Ext" extends "Units of Measure"
{
    CaptionML = ENU = 'Units of Measure',
               ESM = 'Unidades medida',
               FRC = 'Unit‚s de mesure',
               ENC = 'Units of Measure';
    layout
    {
        addafter(Description)
        {
            field("Pallet Per"; Rec."Pallet Per")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Unit")
        {
            CaptionML = ENU = '&Unit',
                                 ESM = '&Unidad',
                                 FRC = '&Unit‚',
                                 ENC = '&Unit';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations',
                                 ESM = 'Traducciones',
                                 FRC = 'Traductions',
                                 ENC = 'Translations';
        }
    }
}
