namespace Nubani.Nubani;

using Microsoft.Finance.RoleCenters;

pageextension 50058 "Acc. Payables CoordinatorRCExt" extends "Acc. Payables Coordinator RC"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        modify("&Vendor - List")
        {
            CaptionML = ENU = '&Vendor - List',
                                 ESM = 'Pro&veedor - Listado',
                                 FRC = 'Four&nisseur - Liste',
                                 ENC = '&Vendor - List';
        }
        // addafter("&Vendor - List")
        // {
        //     action("Vendor - Listing")   //10106  B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor - Listing',
        //                          ESM = 'Proveedor - Listado',
        //                          FRC = 'Fournisseurs - Liste',
        //                          ENC = 'Vendor - Listing';
        //         RunObject = Report 10106;
        //         Image = Report;
        //     }
        // }
        modify("Vendor - &Balance to date")
        {
            CaptionML = ENU = 'Vendor - &Balance to date',
                                 ESM = 'Proveedor - &Saldo por fechas',
                                 FRC = 'Fournisseur - Solde … &ce jour',
                                 ENC = 'Vendor - &Balance to date';
        }
        // modify("Aged &Accounts Payable")  //10085 B2BUPG
        // {
        //     CaptionML = ENU = 'Aged Accounts Payable',
        //                          ESM = 'Antigedad pagos',
        //                          FRC = 'Comptes fournisseurs class‚s chronologiquement',
        //                          ENC = 'Aged Accounts Payable';
        //     RunObject = Report 10085;
        //     Image = Report;
        // }
        // addafter("Aged &Accounts Payable")
        // {
        //     action("Vendor Account Detail")  // 10103 B2BUPG
        //     {
        //         CaptionML = ENU = 'Vendor Account Detail',
        //                          ESM = 'Detalle cta. prov.',
        //                          FRC = 'D‚tail du compte fournisseur',
        //                          ENC = 'Vendor Account Detail';
        //         RunObject = Report 10103;
        //         Image = Report;
        //     } 
        //     action("Open Vendor Entries")   //10093 B2BUPG
        //     { 
        //         CaptionML = ENU = 'Open Vendor Entries',
        //                          ESM = 'Movs. pendientes de proveedor',
        //                          FRC = 'critures fournisseurs ouvertes',
        //                          ENC = 'Open Vendor Entries';
        //         RunObject = Report 10093;
        //         Image = Report;
        //     }
        // }
        modify("Vendor - &Purchase List")
        {
            CaptionML = ENU = 'Vendor - &Purchase List',
                                 ESM = 'P&roveedor - Lista compras',
                                 FRC = 'Fournisseur - &Liste d achats',
                                 ENC = 'Vendor - &Purchase List';
        }
        modify("Pa&yments on Hold")
        {
            CaptionML = ENU = 'Pa&yments on Hold',
                                 ESM = 'Pagos re&tenidos',
                                 FRC = 'Pa&iements en attente',
                                 ENC = 'Pa&yments on Hold';
        }
        // addafter("Pa&yments on Hold")  //10107 B2BUPG
        // {
        //     action("Vendor Purchase Statistics")
        //     {
        //         CaptionML = ENU = 'Vendor Purchase Statistics',
        //                          ESM = 'Estad. compras proveedor',
        //                          FRC = 'Statistiques d achat par fournisseur',
        //                          ENC = 'Vendor Purchase Statistics';
        //         RunObject = Report 10107;
        //         Image = Report;
        //     }
        //     action("Cash Requirem. by Due Date")  //10088 B2BUPG
        //     {
        //         CaptionML = ENU = 'Cash Requirem. by Due Date',
        //                          ESM = 'Req. efectivo por fecha venc.',
        //                          FRC = 'Besoin d encaisse par date d ‚ch‚ance',
        //                          ENC = 'Cash Requirem. by Due Date';
        //         RunObject = Report 10088;
        //         Image = Report;
        //     }
        // }
        /* modify("Vendor &Document Nos.")
        {
            CaptionML = ENU = 'Vendor &Document Nos.',
                                 ESM = '&N§ documento proveedor',
                                 FRC = 'Num‚ros de &documents du fournisseur',
                                 ENC = 'Vendor &Document Nos.';
        }
        modify("Purchase &Invoice Nos.")
        {
            CaptionML = ENU = 'Purchase &Invoice Nos.',
                                 ESM = 'N§ ser&ie fra. compra',
                                 FRC = 'Num‚ros de &factures d achat',
                                 ENC = 'Purchase &Invoice Nos.';
        }
        modify("Purchase &Credit Memo Nos.")
        {
            CaptionML = ENU = 'Purchase &Credit Memo Nos.',
                                 ESM = 'N§ serie nota cr‚dito &compra',
                                 FRC = 'Num‚ros de notes de cr‚dit d ac&hat',
                                 ENC = 'Purchase &Credit Memo Nos.';
        } */
        addafter("Pa&yments on Hold")  //10109 B2BUPG
        {
            // action("Vendor 1099 Div")
            // {
            //     CaptionML = ENU = 'Vendor 1099 Div',
            //                      ESM = 'Form. prov. 1099 Div',
            //                      FRC = 'Fournisseur div 1099',
            //                      ENC = 'Vendor 1099 Di'v;
            //     RunObject = Report 10109;
            //     Image = Report;
            // }
            // action("Vendor 1099 Information")  //10110 B2BUPG
            // {
            //     CaptionML = ENU = 'Vendor 1099 Information',
            //                      ESM = 'Inf. form. prov. 1099',
            //                      FRC = 'Fournisseur information 1099',
            //                      ENC = 'Vendor 1099 Information';
            //     RunObject = Report 10110;
            //     Image = Report;
            // } 
            // action("Vendor 1099 Int")   //10111 B2BUPG
            // {
            //     CaptionML = ENU = 'Vendor 1099 Int',
            //                      ESM = 'Form. prov. 1099 Int',
            //                      FRC = 'Fournisseur int 1099',
            //                      ENC = 'Vendor 1099 Int';
            //     RunObject = Report 10111;
            //     Image = Report;
            // }
            // action("Vendor 1099 Misc")  //10112 B2BUPG
            // {
            //     CaptionML = ENU = 'Vendor 1099 Misc',
            //                      ESM = 'Form. prov. 1099 Misc',
            //                      FRC = 'Fournisseur divers 1099',
            //                      ENC = 'Vendor 1099 Misc';
            //     RunObject = Report 10112;
            //     Image = Report;
            // }
            action(Customers)
            {
                ApplicationArea = All;
                RunObject = Page 22;
            }
            // action(Collections)  //36630 B2BUPG
            // {

            //     RunObject = Page 36630;
            // }
        }
        modify(Vendors)

        {
            CaptionML = ENU = 'Vendors',
                                 ESM = 'Proveedores',
                                 FRC = 'Fournisseurs',
                                 ENC = 'Vendors';
        }
        modify(VendorsBalance)
        {
            CaptionML = ENU = 'Balance',
                                 ESM = 'Saldo',
                                 FRC = 'Solde',
                                 ENC = 'Balance';
        }
        modify("Purchase Orders")
        {
            CaptionML = ENU = 'Purchase Orders',
                                 ESM = 'Pedidos compra',
                                 FRC = 'Bons de commande',
                                 ENC = 'Purchase Orders';
        }
        modify("Purchase Invoices")
        {
            CaptionML = ENU = 'Purchase Invoices',
                                 ESM = 'Facturas compra',
                                 FRC = 'Factures d achat',
                                 ENC = 'Purchase Invoices';
        }
        modify("Purchase Return Orders")
        {
            CaptionML = ENU = 'Purchase Return Orders',
                                 ESM = 'Devoluciones compra',
                                 FRC = 'Retours achat',
                                 ENC = 'Purchase Return Orders';
        }
        modify("Purchase Credit Memos")
        {
            CaptionML = ENU = 'Purchase Credit Memos',
                                 ESM = 'Notas de Cr‚dito de compra',
                                 FRC = 'Notes de cr‚dit d achat',
                                 ENC = 'Purchase Credit Memos';
        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts',
                                 ESM = 'Bancos',
                                 FRC = 'Comptes bancaires',
                                 ENC = 'Bank Accounts';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items',
                                 ESM = 'Productos',
                                 FRC = 'Articles',
                                 ENC = 'Items';
        }
        modify(PurchaseJournals)
        {
            CaptionML = ENU = 'Purchase Journals',
                                 ESM = 'Diarios de compras',
                                 FRC = 'Journaux d achat',
                                 ENC = 'Purchase Journals';
        }
        modify(PaymentJournals)
        {
            CaptionML = ENU = 'Payment Journals',
                                 ESM = 'Diarios de pagos',
                                 FRC = 'Journaux des paiements',
                                 ENC = 'Payment Journals';
        }
        modify(GeneralJournals)
        {
            CaptionML = ENU = 'General Journals',
                                 ESM = 'Diarios generales',
                                 FRC = 'Journaux g‚n‚raux',
                                 ENC = 'General Journals';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Purchase Receipts")
        {
            CaptionML = ENU = 'Posted Purchase Receipts',
                                 ESM = 'Hist¢ricos recepciones de compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Receipts';
        }
        modify("Posted Purchase Invoices")
        {
            CaptionML = ENU = 'Posted Purchase Invoices',
                                 ESM = 'Hist¢rico facturas compra',
                                 FRC = 'Factures d achat report‚es',
                                 ENC = 'Posted Purchase Invoices';
        }
        modify("Posted Purchase Credit Memos")
        {
            CaptionML = ENU = 'Posted Purchase Credit Memos',
                                 ESM = 'Notas de cr‚dito compras registradas',
                                 FRC = 'Notes de cr‚dit achat report‚es',
                                 ENC = 'Posted Purchase Credit Memos';
        }
        modify("Posted Return Shipments")
        {
            CaptionML = ENU = 'Posted Return Shipments',
                                 ESM = 'Hist¢rico env¡os devoluci¢n',
                                 FRC = 'Livraisons de retour report‚es',
                                 ENC = 'Posted Return Shipments';
        }
        modify("G/L Registers")
        {
            CaptionML = ENU = 'G/L Registers',
                                 ESM = 'Registro movs. contabilidad',
                                 FRC = 'Registres GL',
                                 ENC = 'G/L Registers';
        }
        modify("&Vendor")
        {
            CaptionML = ENU = '&Vendor',
                                 ESM = 'Pro&veedor',
                                 FRC = '&Fournisseur',
                                 ENC = '&Vendor';
        }
        modify("&Purchase Order")
        {
            CaptionML = ENU = '&Purchase Order',
                                 ESM = '&Pedido compra',
                                 FRC = '&Bon de commande',
                                 ENC = '&Purchase Order';
        }
        modify("Purchase &Invoice")
        {
            CaptionML = ENU = 'Purchase &Invoice',
                                 ESM = '&Factura compra',
                                 FRC = 'Facture &achat',
                                 ENC = 'Purchase &Invoice';
        }
        modify("Purchase Credit &Memo")
        {
            CaptionML = ENU = 'Purchase Credit &Memo',
                                 ESM = 'Nota cr‚dito co&mpra',
                                 FRC = 'Note de cr‚dit d &achat',
                                 ENC = 'Purchase Credit &Memo';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify("Payment &Journal")
        {
            CaptionML = ENU = 'Payment &Journal',
                                 ESM = '&Diario pagos',
                                 FRC = '&Journal des paiements',
                                 ENC = 'Payment &Journal';
        }
        modify("P&urchase Journal")
        {
            CaptionML = ENU = 'P&urchase Journal',
                                 ESM = 'Diario &compras',
                                 FRC = 'Jo&urnal des achats',
                                 ENC = 'P&urchase Journal';
        }
        addafter("P&urchase Journal")
        {
            // action("Reconcile AP to GL")  //10101 B2BUPG
            // {
            //     CaptionML = ENU = 'Reconcile AP to GL',
            //                      ESM = 'Conciliar ctas. pdtes. con cont.',
            //                      FRC = 'Rapprocher CF au GL',
            //                      ENC = 'Reconcile AP to GL';
            //     RunObject = Report 10101;
            //     Image = Report;
            // }
        }
        modify(Administration)
        {
            CaptionML = ENU = 'Administration',
                                 ESM = 'Administraci¢n',
                                 FRC = 'Administration',
                                 ENC = 'Administration';
        }
        modify("Purchases && Payables &Setup")
        {
            CaptionML = ENU = 'Purchases && Payables &Setup',
                                 ESM = 'Confi&guraci¢n compras y pagos',
                                 FRC = 'Configuration des achats && des compte&s … payer',
                                 ENC = 'Purchases && Payables &Setup';
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
        // addafter("Navi&gate")
        // {
        //     action("Credit Management")  //36630 B2BUPG
        //     {
        //         CaptionML = ENU = 'Credit Management',
        //                          ESM = 'Gesti¢n cr‚dito',
        //                          FRC = 'Gestion de cr‚dit',
        //                          ENC = 'Credit Management';
        //         RunObject = Page 36630;
        //     }
        //     action("Order Status")  //36631  B2BUPG
        //     {
        //         CaptionML = ENU = 'Order Status',
        //                          ESM = 'Estado pedido',
        //                          FRC = 'tat commande',
        //                          ENC = 'Order Status';
        //         RunObject = Page 36631;
        //     }
        // }
    }
}
