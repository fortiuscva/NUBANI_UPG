namespace Nubani.Nubani;

using Microsoft.Sales.Archive;

pageextension 50045 "Sales Quote Archive Ext" extends "Sales Quote Archive"
{
    CaptionML = ENU = 'Sales Quote Archive',
               ESM = 'Archivo cotizaci¢n venta',
               FRC = 'Archives devis',
               ENC = 'Sales Quote Archive';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify("Sell-to County")
        {
            CaptionML = ENU = 'Sell-to State / ZIP Code',
                           ESM = 'Venta a-Estado / C.P.',
                           FRC = 'tat-Province/code postal (d‚biteur)',
                           ENC = 'Sell-to Province/State / Postal/ZIP Code';
        }
        moveafter("Sell-to City"; "Sell-to County")
        moveafter("Sell-to County"; "Sell-to Post Code")
        addafter("Responsibility Center")
        {
            field("Pallets Spaces"; Rec."Pallets Spaces")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pallets Spaces")
        {
            field("Shipping Status"; Rec."Shipping Status")
            {
                ApplicationArea = All;
            }
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing',
                           ESM = 'Facturaci¢n',
                           FRC = 'Facturation',
                           ENC = 'Invoicing';
        }
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';
        }
        moveafter("Bill-to City"; "Bill-to County")
        moveafter("Bill-to County"; "Bill-to Post Code")
        moveafter("Payment Method Code"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping',
                           ESM = 'Env¡o',
                           FRC = 'Livraison',
                           ENC = 'Shipping';
        }
        modify("Ship-to County")

        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';
        }

        moveafter("Ship-to City"; "Ship-to County")
        moveafter("Ship-to County"; "Ship-to Post Code")
        moveafter("Ship-to Contact"; "Ship-to UPS Zone")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        modify(Version)
        {
            CaptionML = ENU = 'Version',
                           ESM = 'Versi¢n',
                           FRC = 'Version',
                           ENC = 'Version';
        }

    }
    actions
    {
        modify("Ver&sion")
        {
            CaptionML = ENU = 'Ver&sion',
                                 ESM = 'Ver&si¢n',
                                 FRC = 'Ver&sion',
                                 ENC = 'Ver&sion';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
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
        modify(Print)
        {
            CaptionML = ENU = 'Print',
                                 ESM = 'Imprimir',
                                 FRC = 'Imprimer',
                                 ENC = 'Print';
        }
        modify(Restore)
        {
            CaptionML = ENU = '&Restore',
                                 ESM = '&Restaurar',
                                 FRC = '&Restaurer',
                                 ENC = '&Restore';
        }
    }
}
