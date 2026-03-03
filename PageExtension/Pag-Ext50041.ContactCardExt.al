namespace Nubani.Nubani;

using Microsoft.CRM.Contact;

pageextension 50041 "Contact Card Ext" extends "Contact Card"
{
    CaptionML = ENU = 'Contact Card',
               ESM = 'Ficha contacto',
               FRC = 'Fiche contact',
               ENC = 'Contact Card';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify(IntegrationCustomerNo)
        {
            CaptionML = ENU = 'Integration Customer No.',
                           ESM = 'N§ cliente integraci¢n',
                           FRC = 'Int‚gration Nø client',
                           ENC = 'Integration Customer No.';
        }

        moveafter(city; "Country/Region Code")
        moveafter("Country/Region Code"; "Post Code")
        moveafter("Post Code"; "Job Title")
        moveafter("Job Title"; "E-Mail")
        moveafter("E-Mail"; "Phone No.")
        addafter("Phone No.")
        {
            field("Extension No."; Rec."Extension No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Extension No."; "Mobile Phone No.")
        moveafter("Mobile Phone No."; "Fax No.")
        // addafter("Fax No.")
        // {
        //     part(Comments; Comments)  //14005182 B2BUPG
        //     {
        //         CaptionML = ENU =Comments;
        //         SubPageLink = "No." = FIELD("No."),
        //                     Table Name=CONST(Contact);
        //         PagePartID =14005182;
        //         Editable = TRUE;
        //         PartType =Page;
        //     }
        // }
        addafter("Fax No.")
        {
            part(ProfileLines; 5051)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Profile Lines';
                SubPageLink = "Contact No." = FIELD("No.");
                // PagePartID =5051;  //B2BUPG
                // PartType =Page;
            }
        }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication',
                           ESM = 'Comunicaci¢n',
                           FRC = 'Communications',
                           ENC = 'Communication';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
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
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
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
            // Image = ViewComments;  //B2BUPG
            PromotedCategory = Process;
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
        modify("Online Map")
        {
            CaptionML = ENU = 'Online Map',
                                 ESM = 'Online Map',
                                 FRC = 'Online Map',
                                 ENC = 'Online Map';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify("Oppo&rtunities")
        {
            CaptionML = ENU = 'Oppo&rtunities',
                                 ESM = '&Oportunidades',
                                 FRC = 'Oppo&rtunit‚s',
                                 ENC = 'Oppo&rtunities';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify(SalesQuotes)
        {
            CaptionML = ENU = 'Sales &Quotes',
                                 ESM = 'Co&tizaciones venta',
                                 FRC = 'De&vis',
                                 ENC = 'Sales &Quotes';
        }

        modify("Postponed &Interactions")
        {
            CaptionML = ENU = 'Postponed &Interactions',
                                 ESM = '&Interacciones aplazadas',
                                 FRC = '&Interactions report‚es',
                                  ENC = 'Postponed &Interactions';
        }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';


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
        // addafter(Statistics)  //14005169  B2BUPG
        // {
        //     action(Action1100768007)
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
        modify("Launch &Web Source")
        {
            CaptionML = ENU = 'Launch &Web Source',
                                 ESM = '&Lanzar enlace web',
                                 FRC = 'Lancer &recherche Web',
                                 ENC = 'Launch &Web Source';
        }
        modify("Print Cover &Sheet")
        {
            CaptionML = ENU = 'Print Cover &Sheet',
                                 ESM = '&Imprimir portada',
                                 FRC = 'Imprimer &page couverture',
                                 ENC = 'Print Cover &Sheet';
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
        modify(CreateCustomer)
        {
            CaptionML = ENU = 'Customer',
                                 ESM = 'Cliente',
                                 FRC = 'Client',
                                 ENC = 'Customer';
        }
        modify(CreateVendor)
        {
            CaptionML = ENU = 'Vendor',
                                 ESM = 'Proveedor',
                                 FRC = 'Fournisseur',
                                 ENC = 'Vendor';
        }
        modify(CreateBank)
        {
            CaptionML = ENU = 'Bank',
                                 ESM = 'Banco',
                                 FRC = 'Banque',
                                 ENC = 'Bank';
        }
        modify("Apply Template")
        {
            CaptionML = ENU = 'Apply Template',
                                 ESM = 'Aplicar plantilla',
                                 FRC = 'Appliquer le modŠle',
                                 ENC = 'Apply Template';
            // PromotedIsBig = true;   //B2BUPG
        }
        modify("Create &Interaction")
        {
            CaptionML = ENU = 'Create &Interact',
                                 ESM = 'Crear &interacc.',
                                 FRC = 'Cr‚er &interact.',
                                 ENC = 'Create &Interact';
        }
        modify(ContactCoverSheet)
        {
            CaptionML = ENU = 'Contact Cover Sheet',
                                 ESM = 'Portada de contacto',
                                 FRC = 'Bordereau d envoi de contact',
                                 ENC = 'Contact Cover Sheet';
            //  PromotedIsBig = true;  //B2BUPG
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
            action("Contact Labels")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Contact Labels';
                RunObject = Report 5056;
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
            }
        }
    }
}
