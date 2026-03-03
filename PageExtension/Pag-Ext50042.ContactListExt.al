namespace Nubani.Nubani;

using Microsoft.CRM.Contact;

pageextension 50042 "Contact List Ext" extends "Contact List"
{
    CaptionML = ENU = 'Contact List',
               ESM = 'Lista contactos',
               FRC = 'Liste des contacts',
               ENC = 'Contact List';
    layout
    {
        moveafter("Company Name"; "Job Title")
        moveafter("Job Title"; "E-Mail")
        moveafter("Phone No."; "Fax No.")
        addafter("Phone No.")
        {
            field("Extension No."; Rec."Extension No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Extension No."; "Mobile Phone No.")
    }
    actions
    {
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact',
                                 ESM = '&Contacto',
                                 FRC = 'Con&tact',
                                 ENC = 'C&ontact';
        }
        modify("Comp&any")
        {
            CaptionML = ENU = 'Comp&any',
                                 ESM = 'E&mpresa',
                                 FRC = 'Comp&agnie',
                                 ENC = 'Comp&any';
        }
        modify("Business Relations")
        {
            CaptionML = ENU = 'Business Relations',
                                 ESM = 'Relaciones negocio',
                                 FRC = 'Relations d affaires',
                                 ENC = 'Business Relations';
        }
        modify("Industry Groups")
        {
            CaptionML = ENU = 'Industry Groups',
                                 ESM = 'Grupos industria',
                                 FRC = 'Secteurs d activit‚',
                                 ENC = 'Industry Groups';
        }
        modify("Web Sources")
        {
            CaptionML = ENU = 'Web Sources',
                                 ESM = 'Enlaces web',
                                 FRC = 'Sources Web',
                                 ENC = 'Web Sources';
        }
        modify("P&erson")
        {
            CaptionML = ENU = 'P&erson',
                                 ESM = '&Persona',
                                 FRC = 'P&ersonne',
                                 ENC = 'P&erson';
        }
        modify("Job Responsibilities")
        {
            CaptionML = ENU = 'Job Responsibilities',
                                 ESM = 'Responsabilidades cargo',
                                 FRC = 'Responsabilit‚s',
                                 ENC = 'Job Responsibilities';
        }
        modify("Pro&files")
        {
            CaptionML = ENU = 'Pro&files',
                                 ESM = 'Per&files',
                                 FRC = 'Pro&fil',
                                 ENC = 'Pro&files';
        }
        modify("&Picture")
        {
            CaptionML = ENU = '&Picture',
                                 ESM = '&Imagen',
                                 FRC = '&Image',
                                 ENC = '&Picture';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
            Promoted = true;
            PromotedIsBig = true;
            // Image = ViewComments; //B2BUPG
            PromotedCategory = Process;
        }
        addafter("Co&mments")
        {
            action("Company-Wide Comments")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Company-Wide Comments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
                RunObject = Page 5072;
                RunPageLink = "Table Name" = CONST(Contact),
                                  "Sub No." = CONST(0);
                Promoted = true;
                Visible = IsSalesMgr;
                Enabled = IsCompany;
                PromotedIsBig = true;
                Image = ViewComments;
                PromotedCategory = Process;
            }
        }
        modify("Alternati&ve Address")
        {
            CaptionML = ENU = 'Alternati&ve Address',
                                 ESM = '&Direcci¢n alterna',
                                 FRC = 'A&dresse secondaire',
                                 ENC = 'Alternati&ve Address';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
        }
        modify("Date Ranges")
        {
            CaptionML = ENU = 'Date Ranges',
                                 ESM = 'Rangos fecha',
                                 FRC = 'Plage de dates',
                                 ENC = 'Date Ranges';
        }
        modify("Related Information")
        {
            CaptionML = ENU = 'Related Information',
                                 ESM = 'Informaci¢n relacionada',
                                 FRC = 'Informations connexes',
                                 ENC = 'Related Information';
        }
        modify("Relate&d Contacts")
        {
            CaptionML = ENU = 'Related Information',
                                 ESM = 'Informaci¢n relacionada',
                                 FRC = 'Informations connexes',
                                 ENC = 'Related Information';
        }
        modify("Segmen&ts")
        {
            CaptionML = ENU = 'Segmen&ts',
                                 ESM = '&Segmentos',
                                 FRC = 'S&egments',
                                 ENC = 'Segmen&ts';
        }
        modify("Mailing &Groups")
        {
            CaptionML = ENU = 'Mailing &Groups',
                                 ESM = '&Grupos correo',
                                 FRC = '&Groupes de distribution',
                                 ENC = 'Mailing &Groups';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify("Postponed &Interactions")
        {
            CaptionML = ENU = 'Postponed &Interactions',
                                 ESM = '&Interacciones aplazadas',
                                 FRC = '&Interactions report‚es',
                                 ENC = 'Postponed &Interactions';
        }
        modify("Interaction Log E&ntries")
        {
            CaptionML = ENU = 'Interaction Log E&ntries',
                                 ESM = '&Movs. log interacci¢n',
                                 FRC = 'critures jour&nal interaction',
                                 ENC = 'Interaction Log E&ntries';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
        }
        // addafter(Statistics)
        // {
        //     action(Action1100768007)  //14005169  B2BUPG
        //     {

        //         CaptionML = ENU = 'Email Communication';
        //         RunObject = Page 14005169;
        //         RunPageView = SORTING(Type, "No.")
        //                           WHERE(Type = CONST(Contact));
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        // }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(MakePhoneCall)
        {
            CaptionML = ENU = 'Make &Phone Call',
                                 ESM = 'Reali&zar llamada',
                                 FRC = '&T‚l‚phoner',
                                 ENC = 'Make &Phone Call';
        }
        modify("Launch &Web Source")
        {
            CaptionML = ENU = 'Launch &Web Source',
                                 ESM = '&Lanzar enlace web',
                                 FRC = 'Lancer &recherche Web',
                                 ENC = 'Launch &Web Source';
        }
        modify("Create as")
        {
            CaptionML = ENU = 'Create as',
                                 ESM = 'Crear como',
                                 FRC = 'Cr‚er comme',
                                 ENC = 'Create as';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer',
                                 ESM = 'Cliente',
                                 FRC = 'Client',
                                 ENC = 'Customer';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor',
                                 ESM = 'Proveedor',
                                 FRC = 'Fournisseur',
                                 ENC = 'Vendor';
        }
        modify(Bank)
        {
            CaptionML = ENU = 'Bank',
                                 ESM = 'Banco',
                                 FRC = 'Banque',
                                 ENC = 'Bank';
        }
        modify("Link with existing")
        {
            CaptionML = ENU = 'Link with existing',
                                 ESM = 'Relacionar con',
                                 FRC = 'Lier avec existant',
                                 ENC = 'Link with existing';
        }
        modify(Action63)
        {
            CaptionML = ENU = 'Customer',
                                 ESM = 'Cliente',
                                 FRC = 'Client',
                                 ENC = 'Customer';
        }
        modify(Action64)
        {
            CaptionML = ENU = 'Vendor',
                                 ESM = 'Proveedor',
                                 FRC = 'Fournisseur',
                                 ENC = 'Vendor';
        }
        modify(Action65)
        {
            CaptionML = ENU = 'Bank',
                                 ESM = 'Banco',
                                 FRC = 'Banque',
                                 ENC = 'Bank';
        }
        modify("Create &Interaction")
        {
            CaptionML = ENU = 'Create &Interact',
                                 ESM = 'Crear &interacc.',
                                 FRC = 'Cr‚er &interact.',
                                 ENC = 'Create &Interact';
        }
        modify(NewSalesQuote)
        {
            CaptionML = ENU = 'New Sales Quote',
                                 ESM = 'Nueva cotizaci¢n venta',
                                 FRC = 'Nouveau devis de vente',
                                 ENC = 'New Sales Quote';
        }
        addlast("Link with existing")
        {
            action("Contact List")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Contact List';
                RunObject = Report 5050;
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
            }
            action("Contact - Company Summary")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Contact - Company Summary';
                RunObject = Report 5051;
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
            }
            action("Contact - Person Summary")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Contact - Person Summary';
                RunObject = Report 5053;
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
            }
            action("Contact Cover Sheet")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Contact Cover Sheet';
                RunObject = Report 5055;
                //  PromotedIsBig = true;  //B2BUPG
                Image = Report;
                // PromotedCategory = Report;   //B2BUPG
            }
        }
        modify("Contact Labels")
        {
            CaptionML = ENU = 'Contact Labels',
                                 ESM = 'Etiquetas contacto',
                                 FRC = 'tiquettes contact',
                                 ENC = 'Contact Labels';
            // PromotedIsBig = true;  //B2BUPG
        }
        modify("Questionnaire Handout")
        {
            CaptionML = ENU = 'Questionnaire Handout',
                                 ESM = 'Folleto cuestionario',
                                 FRC = 'Documentation questionnaire',
                                 ENC = 'Questionnaire Handout';
        }
        modify("Sales Cycle Analysis")
        {
            CaptionML = ENU = 'Sales Cycle Analysis',
                                 ESM = 'An lisis ciclo ventas',
                                 FRC = 'Analyse cycle de vente',
                                 ENC = 'Sales Cycle Analysis';
            // PromotedIsBig = true;  //B2BUPG
        }
    }



    var
        "--FP7--": Integer;
        UserPersonal: Record 2000000073;
        // Profile: Record 2000000072;  //B2BUPG
        User: Record 91;
        IsCompany: Boolean;
        IsSalesMgr: Boolean;
}
