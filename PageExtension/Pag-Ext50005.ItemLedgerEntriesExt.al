namespace Nubani.Nubani;

using Microsoft.Inventory.Ledger;

pageextension 50005 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    CaptionML = ENU = 'Item Ledger Entries',
               ESM = 'Movs. productos',
               FRC = 'critures du grand livre d articles',
               ENC = 'Item Ledger Entries';
    layout
    {
        addafter(Description)
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Serial No.")
        {
            Visible = true;
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry',
                                 ESM = '&Movimiento',
                                 FRC = '&criture',
                                 ENC = 'Ent&ry';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries',
                                 ESM = 'Movs. &valor',
                                 FRC = 'critures &valeur',
                                 ENC = '&Value Entries';
        }
        modify("&Application")
        {
            CaptionML = ENU = '&Application',
                                 ESM = 'Li&quidaci¢n',
                                 FRC = '&Affectation',
                                 ENC = '&Application';
        }
        modify("Applied E&ntries")
        {
            CaptionML = ENU = 'Applied E&ntries',
                                 ESM = '&Movs. conciliados',
                                 FRC = '&critures affect‚es',
                                 ENC = 'Applied E&ntries';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. reserva',
                                 FRC = 'critures r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify("Application Worksheet")
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. reserva',
                                 FRC = 'critures r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking',
                                 ESM = '&Seguimiento pedido',
                                 FRC = '&Suivi de commande',
                                 ENC = 'Order &Tracking';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
    }
}
