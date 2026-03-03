namespace Nubani.Nubani;

using Microsoft.Manufacturing.Document;

pageextension 50046 "Prod. Order Line list Ext" extends "Prod. Order Line List"
{
    CaptionML = ENU = 'Prod. Order Line List',
               ESM = 'Lista l¡n. orden producc.',
               FRC = 'Liste lignes bon prod.',
               ENC = 'Prod. Order Line List';
    layout
    {
        addafter("Item No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Remaining Quantity")
        {
            field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
            {
                ApplicationArea = All;
            }
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
        modify(ShowDocument)
        {
            CaptionML = ENU = 'Show Document',
                                 ESM = 'Muestra documento',
                                 FRC = 'Afficher le document',
                                 ENC = 'Show Document';
        }
        modify(ShowReservEntries)
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. &reserva',
                                 FRC = 'Entr‚es de r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify(ShowTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
    }
}
