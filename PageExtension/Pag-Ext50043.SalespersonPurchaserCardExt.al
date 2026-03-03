namespace Nubani.Nubani;

using Microsoft.CRM.Team;

pageextension 50043 "Salesperson/Purchaser Card Ext" extends "Salesperson/Purchaser Card"
{
    CaptionML = ENU = 'Salesperson/Purchaser Card',
               ESM = 'Ficha vendedor/comprador',
               FRC = 'Fiche vendeur/acheteur',
               ENC = 'Salesperson/Purchaser Card';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        // addafter(Name)
        // {
        //     field(Nickname; Rec.Nickname)
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        moveafter("Phone No."; "Commission %")
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing',
                           ESM = 'Facturaci¢n',
                           FRC = 'Facturation',
                           ENC = 'Invoicing';
        }
        addafter(Invoicing)
        {
            group(SendAsPDF)
            {
                CaptionML = ENU = 'SendAsPDF';
            }
        }
        // addfirst(SendAsPDF)
        // {
        //     field("Signature Picture"; Rec."Signature Picture")
        //     {

        //         Visible = FALSE;
        //         Enabled = FALSE;
        //         Editable = FALSE;
        //     }
        //     field("Email Signature"; Rec."Email Signature")
        //     {

        //         MultiLine = true;
        //     }
        // }
    }
    actions
    {
        modify("&Salesperson")
        {
            CaptionML = ENU = '&Salesperson',
                                 ESM = 'Ve&ndedor',
                                 FRC = '&Repr‚sentant',
                                 ENC = '&Salesperson';
        }
        modify("Tea&ms")
        {
            CaptionML = ENU = 'Tea&ms',
                                 ESM = 'E&quipos',
                                 FRC = '&quipes',
                                 ENC = 'Tea&ms';
        }
        modify("Con&tacts")
        {
            CaptionML = ENU = 'Con&tacts',
                                 ESM = 'Con&tactos',
                                 FRC = 'C&ontacts',
                                 ENC = 'Con&tacts';
            Promoted = true;
            PromotedIsBig = true;
            //Image = CustomerContact;  //B2BUPG
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            Promoted = false;
        }
        modify("C&ampaigns")
        {
            CaptionML = ENU = 'C&ampaigns',
                                 ESM = '&Campa¤as',
                                 FRC = '&Promotions',
                                 ENC = 'C&ampaigns';
        }
        modify("S&egments")
        {
            CaptionML = ENU = 'S&egments',
                                 ESM = '&Segmentos',
                                 FRC = 'Se&gments',
                                 ENC = 'S&egments';
        }
        modify("Interaction Log E&ntries")
        {
            CaptionML = ENU = 'Interaction Log E&ntries',
                                 ESM = '&Movs. log interacci¢n',
                                 FRC = 'critures jour&nal interaction',
                                 ENC = 'Interaction Log E&ntries';
        }
        modify("Postponed &Interactions")
        {
            CaptionML = ENU = 'Postponed &Interactions',
                                 ESM = '&Interacciones aplazadas',
                                 FRC = '&Interactions report‚es',
                                 ENC = 'Postponed &Interactions';
        }
        modify("Oppo&rtunities")
        {
            CaptionML = ENU = 'Oppo&rtunities',
                                 ESM = '&Oportunidades',
                                 FRC = 'Oppo&rtunit‚s',
                                 ENC = 'Oppo&rtunities';
            Promoted = true;
            PromotedIsBig = true;
            // Image = OpportunitiesList;  //B2BUPG
            PromotedCategory = Process;
        }
        modify("Create &Interaction")
        {
            CaptionML = ENU = 'Create &Interact',
                                 ESM = 'Crear &interacc.',
                                 FRC = 'Cr‚er &interact.',
                                 ENC = 'Create &Interact';
            // PromotedIsBig = true;  //B2BUPG
        }
    }
}
