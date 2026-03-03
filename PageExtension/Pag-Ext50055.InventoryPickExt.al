namespace Nubani.Nubani;

using Microsoft.Warehouse.Activity;

pageextension 50055 "Inventory Pick Ext" extends "Inventory Pick"
{
    CaptionML = ENU = 'Inventory Pick',
               ESM = 'Picking inventario',
               FRC = 'Article en inventaire … pr‚lever',
               ENC = 'Inventory Pick';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify("WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")")
        {
            CaptionML = ENU = 'Name',
                           ESM = 'Nombre',
                           FRC = 'Nom',
                           ENC = 'Name';
        }
        moveafter("Shipment Date"; "Assigned User ID")
        addafter("External Document No.")
        {
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("P&ick")
        {
            CaptionML = ENU = 'P&ick',
                                 ESM = 'P&icking',
                                 FRC = '&Pr‚lŠvement',
                                 ENC = 'P&ick';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify("Posted Picks")
        {
            CaptionML = ENU = 'Posted Picks',
                                 ESM = 'Hist¢rico picking',
                                 FRC = 'Articles en stock report‚s … pr‚lever',
                                 ENC = 'Posted Picks';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document',
                                 ESM = 'Documento origen',
                                 FRC = 'Document origine',
                                 ENC = 'Source Document';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("&Get Source Document")
        {
            CaptionML = ENU = '&Get Source Document',
                                 ESM = '&Tomar documento origen',
                                 FRC = '&Obtenir le document source',
                                 ENC = '&Get Source Document';
        }
        modify(AutofillQtyToHandle)
        {
            CaptionML = ENU = 'Autofill Qty. to Handle',
                                 ESM = 'Rellenar cdad. manip. autom.',
                                 FRC = 'Remplir automatiquement la quantit‚ … traiter',
                                 ENC = 'Autofill Qty. to Handle';
        }
        modify("Delete Qty. to Handle")
        {
            CaptionML = ENU = 'Autofill Qty. to Handle',
                                 ESM = 'Rellenar cdad. manip. autom.',
                                 FRC = 'Remplir automatiquement la quantit‚ … traiter',
                                 ENC = 'Autofill Qty. to Handle';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting',
                                 ESM = '&Registro',
                                 FRC = 'Rep&ort',
                                 ENC = 'P&osting';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost',
                                 ESM = '&Registrar',
                                 FRC = 'Rep&orter',
                                 ENC = 'P&ost';
        }
        modify(PostAndPrint)
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
        modify("Picking List")
        {
            CaptionML = ENU = 'Picking List',
                                 ESM = 'Lista picking',
                                 FRC = 'Bordereau de pr‚lŠvement',
                                 ENC = 'Picking List';
        }
    }
}
