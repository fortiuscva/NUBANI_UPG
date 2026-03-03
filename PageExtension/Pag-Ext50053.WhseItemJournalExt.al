namespace Nubani.Nubani;

using Microsoft.Warehouse.Journal;

pageextension 50053 "Whse.Item Journal Ext" extends "Whse. Item Journal"
{
    CaptionML = ENU = 'Whse. Item Journal',
               ESM = 'Diario producto almac‚n',
               FRC = 'Journal article entrep“t',
               ENC = 'Whse. Item Journal';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name',
                           ESM = 'Nombre secci¢n',
                           FRC = 'Nom de lot',
                           ENC = 'Batch Name';
        }
        modify(CurrentLocationCode)
        {
            CaptionML = ENU = 'Location Code',
                           ESM = 'C¢d. almac‚n',
                           FRC = 'Code d emplacement',
                           ENC = 'Location Code';
        }
        addafter("Unit of Measure Code")
        {
            field("From Zone Code"; Rec."From Zone Code")
            {
                ApplicationArea = All;
            }
            field("From Bin Code"; Rec."From Bin Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code',
                           ESM = 'C¢d. auditor¡a',
                           FRC = 'Code motif',
                           ENC = 'Reason Code';
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
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
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
        modify("Warehouse Entries")
        {
            CaptionML = ENU = 'Warehouse Entries',
                                 ESM = 'Movimientos almac‚n',
                                 FRC = 'critures dentrep“t',
                                 ENC = 'Warehouse Entries';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents',
                                 ESM = 'Contenidos ubicaci¢n',
                                 FRC = 'Contenu de la zone',
                                 ENC = 'Bin Contents';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. reserva',
                                 FRC = 'critures r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify("&Registering")
        {
            CaptionML = ENU = '&Registering',
                                 ESM = '&Registro',
                                 FRC = '&Enregistrement',
                                 ENC = '&Registering';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify("&Register")
        {
            CaptionML = ENU = '&Register',
                                 ESM = '&Registrar',
                                 FRC = '&Registre',
                                 ENC = '&Register';
        }
        modify("Register and &Print")
        {
            CaptionML = ENU = 'Register and &Print',
                                 ESM = 'Registrar e &Imprimir',
                                 FRC = 'Enregistrer et &imprimer',
                                 ENC = 'Register and &Print';
        }

    }
}
