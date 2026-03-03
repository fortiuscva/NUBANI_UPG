namespace Nubani.Nubani;

using Microsoft.Service.RoleCenters;

pageextension 50062 "Service Dispatcher RC Ext" extends "Service Dispatcher Role Center"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        modify("Service Ta&sks")
        {
            CaptionML = ENU = 'Service Ta&sks',
                                 ESM = '&Tareas de servicio',
                                 FRC = 'Tƒches de &service',
                                 ENC = 'Service Ta&sks';
        }
        modify("Service &Load Level")
        {
            CaptionML = ENU = 'Service &Load Level',
                                 ESM = 'Nive&l carga servicio',
                                 FRC = 'Services - Niveau de c&harge',
                                 ENC = 'Service &Load Level';
        }
        modify("Resource &Usage")
        {
            CaptionML = ENU = 'Resource &Usage',
                                 ESM = 'Cons&umo recurso',
                                 FRC = '&Utilisation ressource',
                                 ENC = 'Resource &Usage';
        }
        modify("Service I&tems Out of Warranty")
        {
            CaptionML = ENU = 'Service I&tems Out of Warranty',
                                 ESM = 'Prods. serv. fuera de &garant¡a',
                                 FRC = 'Ar&ticles de service hors garantie',
                                 ENC = 'Service I&tems Out of Warranty';
        }
        modify("Profit Service &Contracts")
        {
            CaptionML = ENU = 'Profit Service &Contracts',
                                 ESM = 'Ganancias &Contratos de Servicio',
                                 FRC = 'Profit - &Contrats de service',
                                 ENC = 'Profit Service &Contracts';
        }
        modify("Profit Service &Orders")
        {
            CaptionML = ENU = 'Profit Service &Orders',
                                 ESM = 'Ganancias Pedid&os de servicio',
                                 FRC = 'Profit - C&ommandes de service',
                                 ENC = 'Profit Service &Orders';
        }
        modify("Profit Service &Items")
        {
            CaptionML = ENU = 'Profit Service &Items',
                                 ESM = 'Ganancias Productos de serv&icio',
                                 FRC = 'Profit - Articles de serv&ice',
                                 ENC = 'Profit Service &Items';
        }
        addafter("Profit Service &Items")
        {
            action("Sales Orders")
            {
                ApplicationArea = All;
                RunObject = Page 9305;
            }
        }
        modify("Service Contract Quotes")
        {
            CaptionML = ENU = 'Service Contract Quotes',
                                 ESM = 'Cotizaciones Contrato de Servicio',
                                 FRC = 'Devis de contrat de service',
                                 ENC = 'Service Contract Quotes';
        }
        modify("Service Contracts")
        {
            CaptionML = ENU = 'Service Contracts',
                                 ESM = 'Contratos de Servicio',
                                 FRC = 'Contrats de services',
                                 ENC = 'Service Contracts';
        }
        modify("Service Quotes")
        {
            CaptionML = ENU = 'Service Quotes',
                                 ESM = 'Cotizaciones servicio',
                                 FRC = 'Devis de service',
                                 ENC = 'Service Quotes';
        }
        modify("Service Orders")
        {
            CaptionML = ENU = 'Service Orders',
                                 ESM = 'Pedidos servicio',
                                 FRC = 'Commandes de service',
                                 ENC = 'Service Orders';
        }
        modify("Standard Service Codes")
        {
            CaptionML = ENU = 'Standard Service Codes',
                                 ESM = 'C¢digos servicio est ndar',
                                 FRC = 'Codes de service standard',
                                 ENC = 'Standard Service Codes';
        }
        modify(Loaners)
        {
            CaptionML = ENU = 'Loaners',
                                 ESM = 'Prod. prestados',
                                 FRC = 'Articles de prˆt',
                                 ENC = 'Loaners';
        }
        modify(Customers)
        {
            CaptionML = ENU = 'Customers',
                                 ESM = 'Clientes',
                                 FRC = 'Clients',
                                 ENC = 'Customers';
        }
        modify("Service Items")
        {
            CaptionML = ENU = 'Service Items',
                                 ESM = 'Prods. servicio',
                                 FRC = 'Articles de service',
                                 ENC = 'Service Items';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items',
                                 ESM = 'Productos',
                                 FRC = 'Articles',
                                 ENC = 'Items';
        }
        modify("Item Journals")
        {
            CaptionML = ENU = 'Item Journals',
                                 ESM = 'Diarios de productos',
                                 FRC = 'Journaux d articles',
                                 ENC = 'Item Journals';
        }
        modify("Requisition Worksheets")
        {
            CaptionML = ENU = 'Requisition Worksheets',
                                 ESM = 'Hojas de demanda',
                                 FRC = 'Feuilles de r‚quisition',
                                 ENC = 'Requisition Worksheets';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Service Shipments")
        {
            CaptionML = ENU = 'Posted Service Shipments',
                                 ESM = 'Entregas de servicio registradas',
                                 FRC = 'Livraisons de service report‚es',
                                 ENC = 'Posted Service Shipments';
        }
        modify("Posted Service Invoices")
        {
            CaptionML = ENU = 'Posted Service Invoices',
                                 ESM = 'Facts. servicio regis.',
                                 FRC = 'Factures de service report‚es',
                                 ENC = 'Posted Service Invoices';
        }
        modify("Posted Service Credit Memos")
        {
            CaptionML = ENU = 'Posted Service Credit Memos',
                                 ESM = 'Notas de Cr‚dito servicio regis.',
                                 FRC = 'Notes de cr‚dit de service report‚es',
                                 ENC = 'Posted Service Credit Memos';
        }
        modify("Service Contract &Quote")
        {
            CaptionML = ENU = 'Service Contract &Quote',
                                 ESM = 'Coti&zaci¢n Contrato de Servicio',
                                 FRC = '&Devis contrat de service',
                                 ENC = 'Service Contract &Quote';
        }
        modify("Service &Contract")
        {
            CaptionML = ENU = 'Service &Contract',
                                 ESM = '&Contrato servicio',
                                 FRC = '&Contrat de service',
                                 ENC = 'Service &Contract';
        }
        modify("Service Q&uote")
        {
            CaptionML = ENU = 'Service Q&uote',
                                 ESM = 'Cotizaci¢n se&rvicio',
                                 FRC = '&Devis service',
                                 ENC = 'Service Q&uote';
        }
        modify("Service &Order")
        {
            CaptionML = ENU = 'Service &Order',
                                 ESM = 'Pedido &servicio',
                                 FRC = 'C&ommande service',
                                 ENC = 'Service &Order';
        }
        modify("Sales Or&der")
        {
            CaptionML = ENU = 'Sales Or&der',
                                 ESM = 'Pedido &venta',
                                 FRC = 'Document de &vente',
                                 ENC = 'Sales Or&der';
        }
        modify("Transfer &Order")
        {
            CaptionML = ENU = 'Transfer &Order',
                                 ESM = '&Ped. transfer.',
                                 FRC = '&Ordre de transfert',
                                 ENC = 'Transfer &Order';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify("Service Tas&ks")
        {
            CaptionML = ENU = 'Service Tas&ks',
                                 ESM = '&Tareas de servicio',
                                 FRC = 'Tƒches de ser&vice',
                                 ENC = 'Service Tas&ks';
        }
        modify("C&reate Contract Service Orders")
        {
            CaptionML = ENU = 'C&reate Contract Service Orders',
                                 ESM = '&Crear pedidos serv. contrato',
                                 FRC = 'C&r‚er des commandes de service de contrat',
                                 ENC = 'C&reate Contract Service Orders';
        }
        modify("Create Contract In&voices")
        {
            CaptionML = ENU = 'Create Contract In&voices',
                                 ESM = 'Crear &facturas contrato',
                                 FRC = 'Cr‚er des factures de &contrat',
                                 ENC = 'Create Contract In&voices';
        }
        modify("Post &Prepaid Contract Entries")
        {
            CaptionML = ENU = 'Post &Prepaid Contract Entries',
                                 ESM = 'R&egistrar movs. contr. anticipo',
                                 FRC = 'Reporter les ‚critures de contrat &pr‚pay‚es',
                                 ENC = 'Post &Prepaid Contract Entries';
        }
        modify("Order Pla&nning")
        {
            CaptionML = ENU = 'Order Pla&nning',
                                 ESM = 'P&lanificaci¢n de pedidos',
                                 FRC = 'Pla&nification de commande',
                                 ENC = 'Order Pla&nning';
        }
        modify(Administration)
        {
            CaptionML = ENU = 'Administration',
                                 ESM = 'Administraci¢n',
                                 FRC = 'Administration',
                                 ENC = 'Administration';
        }
        modify("St&andard Service Codes")
        {
            CaptionML = ENU = 'St&andard Service Codes',
                                 ESM = 'C¢di&gos servicio est ndar',
                                 FRC = 'Codes de serv&ice standard',
                                 ENC = 'St&andard Service Codes';
        }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify("Navi&gate")
        {
            CaptionML = ENU = 'Navi&gate',
                                 ESM = '&Navegar',
                                 FRC = 'Navi&guer',
                                 ENC = 'Navi&gate';
        }
        modify("Item &Tracing")
        {
            CaptionML = ENU = 'Item &Tracing',
                                 ESM = 'Segu&imiento productos',
                                 FRC = 'Rep‚rage d ar&ticle',
                                 ENC = 'Item &Tracing';
        }

    }
}
