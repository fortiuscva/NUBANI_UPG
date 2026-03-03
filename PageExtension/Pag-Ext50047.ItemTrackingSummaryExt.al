namespace Nubani.Nubani;

using Microsoft.Inventory.Tracking;

pageextension 50047 "Item Tracking Summary Ext" extends "Item Tracking Summary"
{
    CaptionML = ENU = 'Item Tracking Summary',
               ESM = 'Resumen seguimiento prod.',
               FRC = 'Lignes tra‡abilit‚',
               ENC = 'Item Tracking Summary';
    layout
    {
        modify(Selectable)
        {
            CaptionML = ENU = 'Selectable',
                           ESM = 'Seleccionable',
                           FRC = 'S‚lectionnable',
                           ENC = 'Selectable';
        }
        modify(MaxQuantity1)
        {
            CaptionML = ENU = 'Selectable',
                           ESM = 'Seleccionable',
                           FRC = 'S‚lectionnable',
                           ENC = 'Selectable';
        }
        modify(Selected)
        {
            CaptionML = ENU = 'Selected',
                           ESM = 'Selecc.',
                           FRC = 'S‚lectionn‚',
                           ENC = 'Selected';
        }
        modify(Selected1)
        {
            CaptionML = ENU = 'Selected',
                           ESM = 'Seleccionado',
                           FRC = 'S‚lectionn‚',
                           ENC = 'Selected';
        }
        modify(Undefined)
        {
            CaptionML = ENU = 'Undefined',
                           ESM = 'Indefinido',
                           FRC = 'Non d‚fini',
                           ENC = 'Undefined';
        }
        modify(Undefined1)
        {
            CaptionML = ENU = 'Undefined',
                           ESM = 'Indefinido',
                           FRC = 'Non d‚fini',
                           ENC = 'Undefined';
        }
    }

    trigger OnOpenPage()
    begin
        rec.SETFILTER("Total Available Quantity", '<>%1', 0);
    end;
}
