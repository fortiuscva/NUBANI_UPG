namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50020 "Posted Sales shipment Ext" extends "Posted Sales Shipment"
{
    CaptionML = ENU = 'Posted Sales Shipment',
               ESM = 'Hist¢rico remisiones venta',
               FRC = 'Livraison vente report‚e',
               ENC = 'Posted Sales Shipment';
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
            Editable = false;
        }
        modify("Sell-to Post Code")
        {
            Editable = FALSE;
        }
        addafter("Salesperson Code")
        {
            field("Assigned User ID"; Rec."Assigned User ID")
            {
                ApplicationArea = All;
            }
        }


        addafter("Assigned User ID")
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
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        modify("Bill-to Post Code")
        {
            Editable = FALSE;
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping',
                           ESM = 'Env¡o',
                           FRC = 'Livraison',
                           ENC = 'Shipping';
        }
        modify("Ship-to City")
        {
            Editable = FALSE;
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        //moveafter("Assigned User ID";"Created Date & Time")
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment',
                                 ESM = 'En&v¡o',
                                 FRC = 'Livrai&son',
                                 ENC = '&Shipment';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
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
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;
}
