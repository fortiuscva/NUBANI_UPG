namespace Nubani.Nubani;

using Microsoft.Inventory.Journal;

pageextension 50036 "Item reclass Journal Ext" extends "Item Reclass. Journal"
{
    CaptionML = ENU = 'Item Reclass. Journal',
               ESM = 'Diario reclasif. producto',
               FRC = 'Feuille reclassement article',
               ENC = 'Item Reclass. Journal';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name',
                           ESM = 'Nombre secci¢n',
                           FRC = 'Nom de lot',
                           ENC = 'Batch Name';
        }
        addafter("New Shortcut Dimension 2 Code")
        {
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Lot No.")
        {
            field("New Lot No."; Rec."New Lot No.")
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
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents',
                                 ESM = 'Contenidos ubicaci¢n',
                                 FRC = 'Contenu de la zone',
                                 ENC = 'Bin Contents';
        }
        modify("&Item")
        {
            CaptionML = ENU = '&Item',
                                 ESM = '&Producto',
                                 FRC = '&Article',
                                 ENC = '&Item';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by',
                                 ESM = 'Disponibilidad prod. por',
                                 FRC = 'Disponibilit‚ d article par',
                                 ENC = 'Item Availability by';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event',
                                 ESM = 'Evento',
                                 FRC = 'v‚nement',
                                 ENC = 'Event';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period',
                                 ESM = 'Periodo',
                                 FRC = 'P‚riode',
                                 ENC = 'Period';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant',
                                 ESM = 'Variante',
                                 FRC = 'Variante',
                                 ENC = 'Variant';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location',
                                 ESM = 'Almac‚n',
                                 FRC = 'Emplacement',
                                 ENC = 'Location';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level',
                                 ESM = 'Nivel L.M.',
                                 FRC = 'Niveau nomenclature',
                                 ENC = 'BOM Level';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM',
                                 ESM = '&Desplegar L.M.',
                                 FRC = '&clater nomenclature',
                                 ENC = 'E&xplode BOM';
        }
        modify("Get Bin Content")
        {
            CaptionML = ENU = 'Get Bin Content',
                                 ESM = 'Tomar conten. ubicac.',
                                 FRC = 'Extraire contenu de la zone',
                                 ENC = 'Get Bin Content';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting',
                                 ESM = '&Registro',
                                 FRC = 'Rep&ort',
                                 ENC = 'P&osting';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost',
                                 ESM = '&Registrar',
                                 FRC = 'Rep&orter',
                                 ENC = 'P&ost';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print',
                                 ESM = 'Registrar e &imprimir',
                                 FRC = 'Reporter et im&primer',
                                 ENC = 'Post and &Print';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
    }
    var
        Text000: TextConst ENU = '1,2,3,New ', ESM = '1,2,3,Nuevo', FRC = '1,2,3,Nouveau', ENC = '1,2,3,New';
        Text001: TextConst ENU = '1,2,4,New ', ESM = '1,2,4,Nuevo ', FRC = '1,2,4,Nouveau ', ENC = '1,2,4,New ';
        Text002: TextConst ENU = '1,2,5,New ', ESM = '1,2,5,Nuevo ', FRC = '1,2,5,Nouveau ', ENC = '1,2,5,New';
        Text003: TextConst ENU = '1,2,6,New ', ESM = '1,2,6,Nuevo ', FRC = '1,2,6,Nouveau ', ENC = '1,2,6,New ';
        Text004: TextConst ENU = '1,2,7,New ', ESM = '1,2,7,Nuevo ', FRC = '1,2,7,Nouveau ', ENC = '1,2,7,New ';
        Text005: TextConst ENU = '1,2,8,New ', ESM = '1,2,8,Nuevo ', FRC = '1,2,8,Nouveau ', ENC = '1,2,8,New ';

}
