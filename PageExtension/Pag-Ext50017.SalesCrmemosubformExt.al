namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50017 "Sales Cr.memo subform Ext" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Unit Price")
        {
            field(Each; Rec.Each)
            {
                ApplicationArea = All;
            }
        }
        moveafter(Each; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Tax Group Code")
        moveafter("Line Amount"; "Amount Including VAT")
    }
    actions
    {
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
        modify(InsertExtTexts)
        {
            CaptionML = ENU = 'Insert &Ext. Texts',
                                 ESM = 'Insertar &textos adicionales',
                                 FRC = 'Ins‚rer texte ‚tendu',
                                 ENC = 'Insert &Ext. Text';
        }
        modify("Get Return &Receipt Lines")
        {
            CaptionML = ENU = 'Get Return &Receipt Lines',
                                 ESM = 'Tomar l¡ns. &recep. devol.',
                                 FRC = 'Ext&raire lignes r‚ception retour',
                                 ENC = 'Get Return &Receipt Lines';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
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
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'D&imensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment',
                                 ESM = '&Asignaci¢n cargos prod.',
                                 FRC = '&Affectation frais annexes',
                                 ENC = 'Item Charge &Assignment';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        addlast("Item Availability by")
        {
            action("Pop-&Up Notes")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-&Up Notes';
            }
            action("Sales History")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales History';
            }
        }
    }


    var
        "--FP--": Integer;
    //LineLookupC: Codeunit 14005058;  //B2BUPG
    //NotesCU: Codeunit 14005020;  //B2BUPG
}
