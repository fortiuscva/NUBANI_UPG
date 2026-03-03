namespace Nubani.Nubani;

using Microsoft.Finance.RoleCenters;
using Microsoft.Sales.Document;

pageextension 50059 "BookKeeper Role Center Ext" extends "Bookkeeper Role Center"
{
    CaptionML = ENU = 'Role Center',
               ESM = 'µrea de tareas',
               FRC = 'Tableau de bord',
               ENC = 'Role Centre';
    actions
    {
        addbefore("&Trial Balance")
        {
            action("Physical Inventory Journal")
            {
                ApplicationArea = All;
                RunObject = Page 392;
                // Promoted = false;  //B2BUPG
                // PromotedIsBig = true;
                Image = Report;
            }
            action("Payment Journal")
            {
                ApplicationArea = All;
                RunObject = Page 256;
                //Promoted = true;
                //PromotedIsBig = true;
                Image = PaymentJournal;
            }
            // action("G/L Register")  //10019 B2BUPG
            // {
            //     CaptionML = ENU = 'G/L Register',
            //                      ESM = 'Registro movs. contabilidad',
            //                      FRC = 'Registre GL',
            //                      ENC = 'G/L Register';
            //     RunObject = Report 10019;
            //     Image = GLRegisters;
            // }
            // action(Budget)   //10001 B2BUPG
            // {
            //     CaptionML = ENU = 'Budget';
            //     RunObject = Report 10001;
            // }
            // action(ChartofAccounts)  //10002 B2BUPG
            // {
            //     CaptionML = ENU = 'Chart of Accounts',
            //                      ESM = 'Cat logo de cuentas',
            //                      FRC = 'Plan comptable',
            //                      ENC = 'Chart of Accounts';
            //     RunObject = report 10002;
            // }

        }
        modify("Chart of Accounts")
        {
            CaptionML = ENU = 'Chart of Accounts',
                                 ESM = 'Cat logo de cuentas',
                                 FRC = 'Plan comptable',
                                 ENC = 'Chart of Accounts';
        }
        modify("&Trial Balance")
        {
            CaptionML = ENU = '&Trial Balance',
                                 ESM = '&Balance comprobaci¢n',
                                 FRC = 'Balance de v‚rifica&tion',
                                 ENC = '&Trial Balance';
        }
        modify("Bank &Detail Trial Balance")
        {
            CaptionML = ENU = 'Bank &Detail Trial Balance',
                                 ESM = '&Balance comprobaci¢n detalles bancarios',
                                 FRC = 'Balance de v‚rification bancaire &d‚taill‚e',
                                 ENC = 'Bank &Detail Trial Balance';
        }
        modify("T&rial Balance/Budget")
        {
            CaptionML = ENU = 'T&rial Balance/Budget',
                                 ESM = 'Bala&nce sumas y saldos/Ppto.',
                                 FRC = 'Balance de v‚&rification/budget',
                                 ENC = 'T&rial Balance/Budget';
        }
        modify("Trial Balance by &Period")
        {
            CaptionML = ENU = 'Trial Balance by &Period',
                                 ESM = 'Bal. s&umas y saldos/periodo',
                                 FRC = 'Balance de v‚rification par &p‚riode',
                                 ENC = 'Trial Balance by &Period';
        }
        // addafter("Trial Balance by &Period")
        // {
        //     action("Trial Balance, Spread Periods")  //10026 B2BUPG
        //     {
        //         CaptionML = ENU = 'Trial Balance, Spread Periods',
        //                          ESM = 'Balance comprob., period. extend.',
        //                          FRC = 'Bal. v‚rif. toutes les p‚riodes',
        //                          ENC = 'Trial Balance, Spread Periods';
        //         RunObject = Report 10026;
        //         Image = Report;
        //     }
        //     action("Closing Trial Balance")  //10003 B2BUPG
        //     {
        //         CaptionML = ENU = 'Closing Trial Balance',
        //                          ESM = 'Cierre del balance de comprobaci¢n',
        //                          FRC = 'Balance de v‚rification de fermeture',
        //                          ENC = 'Closing Trial Balance';
        //         RunObject = Report 10003;
        //         Image = Report;
        //     }
        //     action("Consol. Trial Balance")  //10007 B2BUPG
        //     {
        //         CaptionML = ENU = 'Consol. Trial Balance',
        //                          ESM = 'Balance comprobaci¢n consol.',
        //                          FRC = 'Balance de v‚rification consol.',
        //                          ENC = 'Consol. Trial Balance';
        //         RunObject = Report 10007;
        //         Image = Report;
        //     }
        //     action("Trial Balance Detail/Summary")  //10021 B2BUPG
        //     {
        //         CaptionML = ENU = 'Trial Balance Detail/Summary',
        //                          ESM = 'Balance compr./resumen',
        //                          FRC = 'Balance v‚rif. d‚tail/sommaire',
        //                          ENC = 'Trial Balance Detail/Summary';
        //         RunObject = Report 10021;
        //         Image = Report;
        //     }
        //     action("Trial Balance, per Global Dim.")  //10023 B2BUPG
        //     {
        //         CaptionML = ENU = 'Trial Balance, per Global Dim.',
        //                          ESM = 'Balance comprobaci¢n, por Dim. global',
        //                          FRC = 'Balance de v‚rification, par dimension globale',
        //                          ENC = 'Trial Balance, per Global Dim.';
        //         RunObject = Report 10023;
        //         Image = Report;
        //     }
        //     action("Trial Balance, Spread G. Dim.")  //10025 B2BUPG
        //     {
        //         CaptionML = ENU = 'Trial Balance, Spread G. Dim.',
        //                          ESM = 'Balance comprob., dimen. global extendida',
        //                          FRC = 'Balance v‚rif., dim. globale ‚tendue',
        //                          ENC = 'Trial Balance, Spread G. Dim.';
        //         RunObject = Report 10025;
        //         Image = Report;
        //     }
        // }
        modify("&Fiscal Year Balance")
        {
            CaptionML = ENU = '&Fiscal Year Balance',
                                 ESM = 'Saldo del e&jercicio',
                                 FRC = 'Solde exercice &financier',
                                 ENC = '&Fiscal Year Balance';
        }
        modify("Balance C&omp. . Prev. Year")
        {
            CaptionML = ENU = 'Balance C&omp. . Prev. Year',
                                 ESM = 'Comp. de sald&o - A¤o anterior',
                                 FRC = 'C&omparaison solde - exercice ant‚rieur',
                                 ENC = 'Balance C&omp. . Prev. Year';
        }
        addafter("Balance C&omp. . Prev. Year")
        {
            // action("Account Schedule Layout")  //10000 B2BUPG
            // {
            //     CaptionML = ENU = 'Account Schedule Layout',
            //                      ESM = 'Plantilla Estructura de Cuentas',
            //                      FRC = 'Disposition de tableau d analyse',
            //                      ENC = 'Account Schedule Layout';
            //     RunObject = Report 10000;
            //     Image = Report;
            // }
            // action("Account Schedule")
            // {
            //     CaptionML = ENU = 'Account Schedule',
            //                      ESM = 'Estructura de Cuentas',
            //                      FRC = 'Tableau d analyse',
            //                      ENC = 'Account Schedule';
            //     RunObject = Report 25;
            //     Image = Report;
            // } defined in higer version B2BUPG
            // action("Account Balances by GIFI Code")  //10004 B2BUPG
            // {
            //     CaptionML = ENU = 'Account Balances by GIFI Code',
            //                      ESM = 'Contrapartidas por c¢d. GIFI',
            //                      FRC = 'Solde des comptes par code IGRF',
            //                      ENC = 'Account Balances by GIFI Code';
            //     RunObject = Report 10004;
            //     Image = Report;
            // }
        }
        // modify("&Aged Accounts Receivable")
        // {
        //     CaptionML = ENU = 'Aged Accounts Receivable',
        //                          ESM = 'Antigedad cobros',
        //                          FRC = 'Comptes clients class‚s chronologiquement',
        //                          ENC = 'Aged Accounts Receivable';
        //    // RunObject = Report 10040;   //B2BUPG
        // }
        modify("Aged Accou&nts Payable")
        {
            CaptionML = ENU = 'Aged Accou&nts Payable',
                                 ESM = 'Antigedad pa&gos',
                                 FRC = 'Comptes four&nisseurs class‚s chronologiquement',
                                 ENC = 'Aged Accou&nts Payable';
            // RunObject = Report 10085;  //B2BUPG
            // Image = Report;  //B2BUPG
        }

        modify("Reconcile Customer and &Vendor Accounts")
        {
            CaptionML = ENU = 'Reconcile Cust. and &Vend. Accs',
                                 ESM = 'Reconc. c&tas. client./prov.',
                                 FRC = 'Rapprocher com&ptes clients et fournisseurs',
                                 ENC = 'Reconcile Cust. and &Vend. Accs';
        }
        addafter("Reconcile Customer and &Vendor Accounts")
        {
            // action("Sales Tax Details")  //10323 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Tax Details',
            //                      ESM = 'Detalles impuesto ventas',
            //                      FRC = 'D‚tails taxes de vente',
            //                      ENC = 'Sales Tax Details';
            //     RunObject = Report 10323;
            //     Image = Report;
            // }
            // action("Sales Tax Groups")  //10324 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Tax Groups',
            //                      ESM = 'Grupos impuesto ventas',
            //                      FRC = 'Groupes taxes de vente',
            //                      ENC = 'Sales Tax Groups';
            //     RunObject = Report 10324;
            //     Image = Report;
            // }
            // action("Sales Tax Jurisdictions")  //10325 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Tax Jurisdictions',
            //                      ESM = 'Jurisdicci¢n impuesto ventas',
            //                      FRC = 'Juridictions de taxe de vente',
            //                      ENC = 'Sales Tax Jurisdictions';
            //     RunObject = Report 10325;
            // }
            // action("Sales Tax Areas")   //10321 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Tax Areas',
            //                      ESM = 'µreas impuesto ventas',
            //                      FRC = 'R‚gions de taxe de vente',
            //                      ENC = 'Sales Tax Areas';
            //     RunObject = Report 10321;
            // }
            // action("Sales Tax Detail by Area")  //10322 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Tax Detail by Area',
            //                      ESM = 'Det. impto. vtas. por  rea',
            //                      FRC = 'D‚tails de la taxe de vente par r‚gion',
            //                      ENC = 'Sales Tax Detail by Area';
            //     RunObject = Report 10322;
            // }

            // action("Inventory Valuation")  //10139 B2BUPG
            // {
            //     CaptionML = ENU = 'Inventory Valuation',
            //                      ESM = 'Valuaci¢n de inventarios',
            //                      FRC = 'valuation des stocks',
            //                      ENC = 'Inventory Valuation';
            //     RunObject = Report 10139;
            //     Image = Report;
            // }
        }
        modify(Customers)
        {
            CaptionML = ENU = 'Customers',
                                 ESM = 'Clientes',
                                 FRC = 'Clients',
                                 ENC = 'Customers';
        }
        modify(CustomersBalance)
        {
            CaptionML = ENU = 'Balance',
                                 ESM = 'Saldo',
                                 FRC = 'Solde',
                                 ENC = 'Balance';
        }
        addafter(CustomersBalance)
        {
            // action(Collections)  //36630 B2BUPG
            // {

            //     RunObject = Page 36630;
            // }
            action("Customer Ledger Entries - 2022")
            {
                ApplicationArea = All;
                RunObject = Page "Customer Ledger Entries - 2022";
            }
        }
        modify(Vendors)
        {
            CaptionML = ENU = 'Vendors',
                                 ESM = 'Proveedores',
                                 FRC = 'Fournisseurs',
                                 ENC = 'Vendors';
        }
        modify(VendorsPaymentonHold)
        {
            CaptionML = ENU = 'Payment on Hold',
                                 ESM = 'Pago suspendido',
                                 FRC = 'Paiement en attente',
                                 ENC = 'Payment on Hold';
        }
        addafter(VendorsPaymentonHold)
        {
            action("Items - Admiin")
            {
                ApplicationArea = All;
                RunObject = Page "Item List- Admin";
            }
        }
        modify("VAT Statements")
        {
            CaptionML = ENU = 'VAT Statements',
                                 ESM = 'Declaraciones IVA',
                                 FRC = 'Relev‚s fiscaux',
                                 ENC = 'Tax Statements';
        }
        modify("Purchase Invoices")
        {
            CaptionML = ENU = 'Purchase Invoices',
                                 ESM = 'Facturas compra',
                                 FRC = 'Factures d achat',
                                 ENC = 'Purchase Invoices';
        }
        modify("Purchase Orders")
        {
            CaptionML = ENU = 'Purchase Orders',
                                 ESM = 'Pedidos compra',
                                 FRC = 'Bons de commande',
                                 ENC = 'Purchase Orders';
        }
        addafter("Purchase Orders")
        {
            action("Purchase Credit Memos")
            {
                ApplicationArea = All;
                RunObject = Page 147;
            }
        }
        modify("Sales Invoices")
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Sales Invoices',
                                 ESM = 'Facturas venta',
                                 FRC = 'Factures vente',
                                 ENC = 'Sales Invoices';
        }
        modify("Sales Orders")
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Sales Orders',
                                 ESM = 'Pedidos venta',
                                 FRC = 'Documents de vente',
                                 ENC = 'Sales Orders';
        }
        addafter("Sales Orders")
        {
            action("Sales Return Orders")
            {
                ApplicationArea = All;
                RunObject = Page 9304;
            }
            // action("Sales Order Shipment")  //36626 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Order Shipment',
            //                      ESM = 'Env¡o pedido venta',
            //                      FRC = 'Document de vente - Livraison',
            //                      ENC = 'Sales Order Shipment';
            //     RunObject = Page 36626;
            // }
            // action("Sales Order Invoice")  //36628 B2BUPG
            // {
            //     CaptionML = ENU = 'Sales Order Invoice',
            //                      ESM = 'Factura pedido venta',
            //                      FRC = 'Document de vente - Facturation',
            //                      ENC = 'Sales Order Invoice';
            //     RunObject = Page 36628;
            // }
            action("Sales Credit Memos")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
            }
            action(Journals)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Journals',
                                 ESM = 'Diarios',
                                 FRC = 'Journaux',
                                 ENC = 'Journals';
                Image = Journals;
            }
            action("Purchase Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Purchase Journals',
                                 ESM = 'Diarios de compras',
                                 FRC = 'Journaux d achat',
                                 ENC = 'Purchase Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
            }
            action("Sales Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales Journals',
                                 ESM = 'Diarios de ventas',
                                 FRC = 'Journaux de ventes',
                                 ENC = 'Sales Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
            }
        }
        modify(CashReceiptJournals)
        {
            CaptionML = ENU = 'Cash Receipt Journals',
                                 ESM = 'Diarios de cobros',
                                 FRC = 'Journaux des encaissements',
                                 ENC = 'Cash Receipt Journals';
        }
        modify(PaymentJournals)
        {
            CaptionML = ENU = 'Payment Journals',
                                 ESM = 'Diarios de pagos',
                                 FRC = 'Journaux des paiements',
                                 ENC = 'Payment Journals';
        }
        addafter(PaymentJournals)
        {
            action("IC General Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'IC General Journals',
                                 ESM = 'Diarios generales IC',
                                 FRC = 'Journaux g‚n‚raux IC',
                                 ENC = 'IC General Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(Intercompany),
                                        Recurring = CONST(false));
            }
        }
        modify(GeneralJournals)
        {
            CaptionML = ENU = 'General Journals',
                                 ESM = 'Diarios generales',
                                 FRC = 'Journaux g‚n‚raux',
                                 ENC = 'General Journals';
        }
        // addafter(GeneralJournals)
        // {
        // action(IntrastatJournals)
        // {
        //     ApplicationArea = All;
        //     CaptionML = ENU = 'Intrastat Journals',
        //                      ESM = 'Diarios Intrastat',
        //                      FRC = 'Journaux Intrastat',
        //                      ENC = 'Intrastat Journals';
        //     RunObject = Page 327;
        //     Image = Report;
        // }
        // group("Fixed Assets")
        // {
        //     CaptionML = ENU = 'Fixed Assets',
        //                      ESM = 'Activos fijos',
        //                      FRC = 'Immobilisations',
        //                      ENC = 'Fixed Assets';
        //     Image = FixedAssets;
        // }
        //}
        addafter(GeneralJournals)
        {
            action(FixedAssets)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Fixed Assets',
                                 ESM = 'Activos fijos',
                                 FRC = 'Immobilisations',
                                 ENC = 'Fixed Assets';
                RunObject = Page 5601;
            }
            action(Insurance)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Insurance',
                                 ESM = 'Seguros',
                                 FRC = 'Assurance',
                                 ENC = 'Insurance';
                RunObject = Page 5645;
            }
            action("Fixed Assets G/L Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Fixed Assets G/L Journals',
                                 ESM = 'Diarios generales A/F',
                                 FRC = 'Journaux grand livre immobilisations',
                                 ENC = 'Fixed Assets G/L Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
            }
            action("Fixed Assets Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Fixed Assets Journals',
                                 ESM = 'Diarios activos fijos',
                                 FRC = 'Journaux des immobilisations',
                                 ENC = 'Fixed Assets Journals';
                RunObject = Page 5633;
                RunPageView = WHERE(Recurring = CONST(false));
            }
            action("Fixed Assets Reclass. Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Fixed Assets Reclass. Journals',
                                 ESM = 'Diario reclasific. activos fijos',
                                 FRC = 'Journaux reclass. immobilisations',
                                 ENC = 'Fixed Assets Reclass. Journals';
                RunObject = Page 5640;
            }
            action("Insurance Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Insurance Journals',
                                 ESM = 'Diarios de seguros',
                                 FRC = 'Journaux d assurance',
                                 ENC = 'Insurance Journals';
                RunObject = Page 5655;
            }
            action(Action3)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Recurring General Journals',
                                 ESM = 'Diarios generales peri¢dicos',
                                 FRC = 'Journaux g‚n‚raux r‚currents',
                                 ENC = 'Recurring General Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
            }
            action("Recurring Fixed Asset Journals")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Recurring Fixed Asset Journals',
                                 ESM = 'Diarios activos peri¢dicos',
                                 FRC = 'Journaux r‚currents d immobilisations',
                                 ENC = 'Recurring Fixed Asset Journals';
                RunObject = Page 5633;
                RunPageView = WHERE(Recurring = CONST(true));
            }

        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents',
                                 ESM = 'Documentos hist¢ricos',
                                 FRC = 'Documents report‚s',
                                 ENC = 'Posted Documents';
        }
        modify("Posted Sales Shipments")
        {
            CaptionML = ENU = 'Posted Sales Shipments',
                                 ESM = 'Hist¢rico remisiones de venta',
                                 FRC = 'Livraisons vente report‚es',
                                 ENC = 'Posted Sales Shipments';
        }
        modify("Posted Sales Invoices")
        {
            CaptionML = ENU = 'Posted Sales Invoices',
                                 ESM = 'Hist¢rico facturas venta',
                                 FRC = 'Factures ventes report‚es',
                                 ENC = 'Posted Sales Invoices';
        }
        // addafter("Posted Sales Invoices")
        // {
        //     action("Posted Sales Inv. Split Scr")  //14005155 B2BUPG
        //     {
        //         CaptionML = ENU = 'Posted Sales Inv. Split Scr';
        //         RunObject = Page 14005155;
        //     }
        // }
        modify("Posted Return Receipts")
        {
            CaptionML = ENU = 'Posted Return Receipts',
                                 ESM = 'Hist¢ricos recep. devoluci¢n',
                                 FRC = 'R‚ceptions de retour report‚es',
                                 ENC = 'Posted Return Receipts';
        }
        modify("Posted Sales Credit Memos")
        {
            CaptionML = ENU = 'Posted Sales Credit Memos',
                                 ESM = 'Notas de cr‚dito ventas registradas',
                                 FRC = 'Notes cr‚dit ventes report‚es',
                                 ENC = 'Posted Sales Credit Memos';
        }
        // addafter("Posted Sales Credit Memos")
        // {
        //     action("Posted Sales CrM Split Scr")  //14005156 B2BUPG
        //     {
        //         CaptionML = ENU = 'Posted Sales CrM Split Scr';
        //         RunObject = Page 14005156;
        //     }
        // }
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
        // addafter("Posted Purchase Invoices")  //14005157 B2BUPG
        // {
        //     action("Posted Purch. Inv. Split Scr")
        //     {
        //         CaptionML = ENU = 'Posted Purch. Inv. Split Scr';
        //         RunObject = Page 14005157;
        //     }
        // }
        modify("Posted Return Shipments")
        {
            CaptionML = ENU = 'Posted Return Shipments',
                                 ESM = 'Hist¢rico env¡os devoluci¢n',
                                 FRC = 'Livraisons de retour report‚es',
                                 ENC = 'Posted Return Shipments';
        }
        modify("Posted Purchase Credit Memos")
        {
            CaptionML = ENU = 'Posted Purchase Credit Memos',
                                 ESM = 'Notas de cr‚dito compras registradas',
                                 FRC = 'Notes de cr‚dit achat report‚es',
                                 ENC = 'Posted Purchase Credit Memos';
        }
        // addafter("Posted Purchase Credit Memos")  //14005158 B2BUPG
        // {
        //     action("Posted Purch. CM Split Scr")
        //     {
        //         CaptionML = ENU = 'Posted Purch. CM Split Scr';
        //         RunObject = Page 14005158;
        //     }
        // }
        modify("Issued Reminders")
        {
            CaptionML = ENU = 'Issued Reminders',
                                 ESM = 'Recordatorios emitidos',
                                 FRC = 'Rappels ‚mis',
                                 ENC = 'Issued Reminders';
        }
        modify("Issued Fi. Charge Memos")
        {
            CaptionML = ENU = 'Issued Fi. Charge Memos',
                                 ESM = 'Docs. inter‚s emitidos',
                                 FRC = 'Notes de frais fin. ‚mis',
                                 ENC = 'Issued Fi. Charge Memos';
        }
        modify("G/L Registers")
        {
            CaptionML = ENU = 'G/L Registers',
                                 ESM = 'Registro movs. contabilidad',
                                 FRC = 'Registres GL',
                                 ENC = 'G/L Registers';
        }
        addafter("G/L Registers")
        {
            // action("Posted Deposit List")  //10147 B2BUPG
            // {
            //     CaptionML = ENU = 'Posted Deposit List',
            //                      ESM='Lista dep¢sitos reg.',
            //                      FRC='Liste d‚p“ts report‚s',
            //                      ENC='Posted Deposit List';
            //     RunObject = Page 10147;
            // }
            // action("Posted Bank Rec. List")  //10129 B2BUPG
            // {
            //     CaptionML = ENU = 'Posted Bank Rec. List',
            //                      ESM = 'Lista concil. registrada',
            //                      FRC = 'Liste rapprochement bancaire report‚',
            //                      ENC = 'Posted Bank Rec. List';
            //     RunObject = Page 10129;
            // }

        }
        addfirst("Cash Management")
        {
            action(BankAccounts)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Bank Accounts',
                                 ESM = 'Bancos',
                                 FRC = 'Comptes bancaires',
                                 ENC = 'Bank Accounts';
                RunObject = Page 371;
                Image = BankAccount;
            }
            // action(Deposit)  //36646 B2BUPG
            // {
            //     CaptionML = ENU = 'Deposit',
            //                      ESM = 'Dep¢sito',
            //                      FRC = 'D‚p“t',
            //                      ENC = 'Deposit';
            //     RunObject = Page 36646;
            //     Image = DepositSlip;
            // }
            // action("Bank Rec.")  //10124 B2BUPG
            // {
            //     CaptionML = ENU = 'Bank Rec.',
            //                      ESM = 'Conc. &banco',
            //                      FRC = 'Rapprochement bancaire',
            //                      ENC = 'Bank Rec.';
            //     RunObject = Page 10124;
            // }
        }
        modify("C&ustomer")
        {
            CaptionML = ENU = 'C&ustomer',
                                 ESM = '&Cliente',
                                 FRC = '&Client',
                                 ENC = 'C&ustomer';
        }
        modify("Sales &Invoice")
        {
            CaptionML = ENU = 'Sales &Invoice',
                                 ESM = '&Factura venta',
                                 FRC = '&Facture vente',
                                 ENC = 'Sales &Invoice';
        }
        modify("Sales Credit &Memo")
        {
            CaptionML = ENU = 'Sales Credit &Memo',
                                 ESM = 'Nota cr‚&dito venta',
                                 FRC = 'Note de cr‚dit de &vente',
                                 ENC = 'Sales Credit &Memo';
        }
        modify("Sales &Fin. Charge Memo")
        {
            CaptionML = ENU = 'Sales &Fin. Charge Memo',
                                 ESM = 'Doc. de in&ter‚s de ventas',
                                 FRC = '&Note de frais fin. de vente',
                                 ENC = 'Sales &Fin. Charge Memo';
        }
        modify("Sales &Reminder")
        {
            CaptionML = ENU = 'Sales &Reminder',
                                 ESM = '&Recordatorio venta',
                                 FRC = '&Rappel de vente',
                                 ENC = 'Sales &Reminder';
        }
        modify("&Vendor")
        {
            CaptionML = ENU = '&Vendor',
                                 ESM = 'Pro&veedor',
                                 FRC = '&Fournisseur',
                                 ENC = '&Vendor';
        }
        modify("&Purchase Invoice")
        {
            CaptionML = ENU = '&Purchase Invoice',
                                 ESM = '&Factura compra',
                                 FRC = '&Facture d achat',
                                 ENC = '&Purchase Invoice';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks',
                                 ESM = 'Tareas',
                                 FRC = 'Tƒches',
                                 ENC = 'Tasks';
        }
        modify("Cash Re&ceipt Journal")
        {
            CaptionML = ENU = 'Cash Re&ceipt Journal',
                                 ESM = '&Diario cobros',
                                 FRC = 'Journal des en&caissements',
                                 ENC = 'Cash Re&ceipt Journal';
        }
        modify("Payment &Journal")
        {
            CaptionML = ENU = 'Payment &Journal',
                                 ESM = 'Diario &pagos',
                                 FRC = '&Journal des paiements',
                                 ENC = 'Payment &Journal';
            //Promoted = true;
            //PromotedIsBig = true;
            // Image = PaymentJournal;  //B2BUPG
            //PromotedCategory = Report;
        }
        // addafter("Payment &Journal") 
        // {
        //     action("Bank Account Reconciliations")  //10120 B2BUPG
        //     {
        //         CaptionML = ENU = 'Bank Account Reconciliations',
        //                          ESM = 'Conciliaci¢n banco',
        //                          FRC = 'Rapprochements de comptes bancaires',
        //                          ENC = 'Bank Account Reconciliations';
        //         RunObject = Page 10120;
        //         Image = BankAccountRec;
        //     }
        // }
        modify("Adjust E&xchange Rates")
        {
            CaptionML = ENU = 'Adjust E&xchange Rates',
                                 ESM = 'A&justar tipos de cambio',
                                 FRC = 'Ajuster &taux de change',
                                 ENC = 'Adjust E&xchange Rates';
        }
        addafter("Adjust E&xchange Rates")
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
        modify("Post Inventor&y Cost to G/L")
        {
            CaptionML = ENU = 'Post Inventor&y Cost to G/L',
                                 ESM = 'Re&gis. variaci¢n inventario',
                                 FRC = 'Reporter le co–t des stocks au grand l&ivre',
                                 ENC = 'Post Inventor&y Cost to G/L';
        }
        modify("Calc. and Pos&t VAT Settlement")
        {
            CaptionML = ENU = 'Calc. and Pos&t VAT Settlement',
                                 ESM = 'Calc. y registrar li&q. IVA',
                                 FRC = 'Calculer et re&porter le relev‚ de TVA',
                                 ENC = 'Calc. and Pos&t Tax Settlement';
        }
        modify(Administration)
        {
            CaptionML = ENU = 'Administration',
                                 ESM = 'Administraci¢n',
                                 FRC = 'Administration',
                                 ENC = 'Administration';
        }

        modify("Sa&les && Receivables Setup")
        {
            CaptionML = ENU = 'Sa&les && Receivables Setup',
                                 ESM = 'Configuraci¢n venta&s y cobros',
                                 FRC = 'Configuration de&s ventes && des comptes … recevoir',
                                 ENC = 'Sa&les && Receivables Setup';
        }
        // addafter("Sa&les && Receivables Setup")
        // {
        //     action("Inventory to G/L Reconcile")   //10138 B2BUPG
        //     {
        //         CaptionML = ENU = 'Inventory to G/L Reconcile',
        //                          ESM = 'Existencias a concil. cont.',
        //                          FRC = 'Rapprocher inventaire avec GL',
        //                          ENC = 'Inventory to G/L Reconcile';
        //         RunObject = Report 10138;
        //     }
        // }
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
        // addafter("Navi&gate")  //10005 B2BUPG
        // {
        //     action("Export GIFI Info. to Excel")
        //     {
        //         CaptionML = ENU = 'Export GIFI Info. to Excel',
        //                          ESM = 'Exportar info. GIFI a Excel',
        //                          FRC = 'Exporter donn‚es IGRF vers fichier Excel',
        //                          ENC = 'Export GIFI Info. to Excel';
        //         RunObject = Report 10005;
        //     }
        // }

    }
}
