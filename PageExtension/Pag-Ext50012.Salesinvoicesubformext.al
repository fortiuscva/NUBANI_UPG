namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50012 "Sales invoice subform ext" extends "Sales Invoice Subform"
{
    CaptionML = ENU = 'Lines',
               ESM = 'L¡neas',
               FRC = 'Lignes',
               ENC = 'Lines';
    layout
    {
        modify(PriceExists)
        {
            CaptionML = ENU = 'Sales Price Exists',
                           ESM = 'Existe precio venta',
                           FRC = 'Prix de vente existant',
                           ENC = 'Sales Price Exists';
        }
        addafter("Unit Price")
        {
            field(Each; Rec.Each)
            {
                ApplicationArea = All;
            }
        }
        modify("Tax Liable")
        {
            Visible = FALSE;
            Editable = FALSE;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }

        moveafter("Line Amount"; "Amount Including VAT")
        modify(LineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists',
                           ESM = 'Existe dto. l¡nea venta',
                           FRC = 'Rem. ligne vente existante',
                           ENC = 'Sales Line Disc. Exists';
        }
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
        modify(GetPrice)
        {
            CaptionML = ENU = 'Get &Price',
                                 ESM = 'Tomar &precio',
                                 FRC = 'Obtenir le &prix',
                                 ENC = 'Get &Price';
        }
        modify(GetLineDiscount)
        {
            CaptionML = ENU = 'Get Li&ne Discount',
                                 ESM = 'Tomar descuento l¡&nea',
                                 FRC = 'Obtenir l escompte de li&gne',
                                 ENC = 'Get Li&ne Discount';
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
        modify(GetShipmentLines)
        {
            CaptionML = ENU = 'Get &Shipment Lines',
                                 ESM = '&Tomar l¡neas de env¡o',
                                 FRC = 'Extraire lignes livrai&son',
                                 ENC = 'Get &Shipment Lines';
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
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        addlast("&Line")
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
        "--POPN--": Integer;
    // NotesCU: Codeunit 14005020;   //B2BUPG
}
