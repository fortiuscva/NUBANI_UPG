namespace Nubani.Nubani;

using Microsoft.Purchases.History;

pageextension 50027 "Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    CaptionML = ENU = 'Posted Purchase Invoice',
               ESM = 'Hist¢rico facturas compra',
               FRC = 'Facture achat report‚e',
               ENC = 'Posted Purchase Invoice';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        moveafter("Buy-from City"; "Buy-from County")
        modify("Buy-from County")
        {
            CaptionML = ENU = 'Buy-from State / ZIP Code',
                           ESM = 'Compra a-Estado / C.P.',
                           FRC = 'CP/Ville fournisseur',
                           ENC = 'Buy-from Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Buy-from County"; "Buy-from Post Code")
        moveafter("Pay-to City"; "Pay-to County")
        modify("Pay-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Pay-to County"; "Pay-to Post Code")
        //moveafter("Pay-to Contact"; "IRS 1099 Code")
        moveafter("Pmt. Discount Date"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Tax Exemption No.")
        moveafter("Tax Exemption No."; "Provincial Tax Area Code")
        moveafter("Ship-to City"; "Ship-to County")
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State/ZIP Code',
                           ESM = 'Env¡o a Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State/Postal/ZIP Code';
            Editable = FALSE;
        }
        moveafter("Ship-to County"; "Ship-to Post Code")
        addafter("Expected Receipt Date")
        {
            field("Expected Receipt Time"; Rec."Expected Receipt Time")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice',
                                 ESM = '&Factura',
                                 FRC = '&Facture',
                                 ENC = '&Invoice';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Purchase Invoice Statistics", Rec, Rec."No.")
                ELSE
                    PAGE.RUNMODAL(PAGE::"Purchase Invoice Stats.", Rec, Rec."No.");
            end;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals',
                                 ESM = 'Aprobaciones',
                                 FRC = 'Approbations',
                                 ENC = 'Approvals';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
    }
}
