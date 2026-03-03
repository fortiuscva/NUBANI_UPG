namespace Nubani.Nubani;

using Microsoft.Sales.Customer;

pageextension 50002 CustomerListExt extends "Customer List"
{
    CaptionML = ENU = 'Customer List',
               ESM = 'Lista de clientes',
               FRC = 'Liste des clients',
               ENC = 'Customer List';
    layout
    {
        modify("No.")
        {
            Style = AttentionAccent;
            StyleExpr = CustomerFlag;
        }

        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
        }
        addafter(Address)
        {
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address 2")
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
        }
        addafter(City)
        {
            field(County; Rec.County)
            {
                CaptionML = ENU = 'State',
                           ESM = 'Provincia',
                           FRC = 'Comt',
                           ENC = 'Province/State';
                ApplicationArea = All;
            }
        }
        moveafter(County; "Post Code")
        addafter("Country/Region Code")
        {
            field("Collection Comments"; Rec."Collection Comments")
            {
                ApplicationArea = All;
            }
        }
        addafter("Balance (LCY)")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Global Dimension 1 Code")
        {
            field("Customer Type Desc."; Rec."Customer Type Desc.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer Type Desc.")
        {
            field("Cert Expiration Date"; Rec."Cert Expiration Date")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Cert Expiration Date"; "Location Code")
        moveafter("Location Code"; Contact)
        addafter(Contact)
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
        modify("Search Name")
        {
            Visible = false;
        }
        addafter("Credit Limit (LCY)")
        {
            field("Pct. of Credit Limit"; "Pct. of Credit Limit")
            {
                // ExtendedDatatype = Ratio;
                // SourceExpr ="Pct of Credit Limit";
                // MinValue = 0;
                // MaxValue = 100;
                ApplicationArea = all;
            }
        }
        // addfirst(factboxes)
        // {
        //     part("Customer Comments";10008)  //B2BUPG
        //     {
        //         SubPageLink = "Table Name"=CONST(Customer), "No."=FIELD("No.");
        //         PartType =Page;
        //     } 
        // }

        moveafter(CustomerStatisticsFactBox; SalesHistSelltoFactBox)
        moveafter(SalesHistSelltoFactBox; SalesHistBilltoFactBox)
        modify(SalesHistBilltoFactBox)
        {
            Visible = false;
        }
        modify(SalesHistSelltoFactBox)
        {
            Visible = TRUE;
        }


    }
    actions
    {
        modify("&Customer")
        {
            CaptionML = ENU = '&Customer',
                                 ESM = '&Cliente',
                                 FRC = '&Client',
                                 ENC = '&Customer';
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
        modify(DimensionsSingle)
        {
            CaptionML = ENU = 'Dimensions-Single',
                                 ESM = 'Dimensiones-Individual',
                                 FRC = 'Dimensions - Simples',
                                 ENC = 'Dimensions-Single';
        }
        modify(DimensionsMultiple)
        {
            CaptionML = ENU = 'Dimensions-&Multiple',
                                 ESM = 'Dimensiones-&M£ltiple',
                                 FRC = 'Dimensions - &Multiples',
                                 ENC = 'Dimensions-&Multiple';
        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts',
                                 ESM = 'Bancos',
                                 FRC = 'Comptes bancaires',
                                 ENC = 'Bank Accounts';
        }
        modify(ShipToAddresses)
        {
            CaptionML = ENU = 'Ship-&to Addresses',
                                 ESM = 'Di&recci¢n env¡o',
                                 FRC = '&Adresse (destinataire)',
                                 ENC = 'Ship-&to Addresses';
        }
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact',
                                 ESM = '&Contacto',
                                 FRC = 'C&ontact',
                                 ENC = 'C&ontact';
        }
        // addlast(Dimensions)
        // {
        /*  action("&Quick Edit Customers") //14004982 B2BUPG
         {
             CaptionML = ENU = '&Quick Edit Customers';
             RunObject = Page 14004982;
             //Promoted =false;
             Image = EditList;
             //PromotedCategory = Process;
         } */
        /*  action(Action1100768007) //14005169 B2BUPG
         {

             CaptionML = ENU = 'Email Communication';
             RunObject = Page 14005169;
             RunPageView = SORTING(Type, "No.")
                               WHERE(Type = CONST(Customer));
             RunPageLink = "No." = FIELD("No.");
             Image = SendAsPDF;
         } */
        // }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify(CustomerLedgerEntries)
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        addbefore(Statistics)
        {
            action(Action1240070000)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Ledger Entries &Descending';
                Image = LedgerEntries;
            }

        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            //PromotedIsBig = true; //B2BUPG
        }
        modify("S&ales")
        {
            CaptionML = ENU = 'S&ales',
                                 ESM = 'Ve&ntas',
                                 FRC = 'V&entes',
                                 ENC = 'S&ales';
            Promoted = true;
            // Image = sales; //B2BUPG
            PromotedCategory = Process;
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics',
                                 ESM = 'Estad¡sticas documentos',
                                 FRC = 'Statistiques critures',
                                 ENC = 'Entry Statistics';
        }
        //  addafter("Entry Statistics")
        //  {
        /*  action(Action1100768001)  //10025 B2BUPG
         {

             CaptionML = ENU = 'Customer &Order Status';
             RunObject = Page 10025;
             RunPageLink = "No." = FIELD("No.");
             Promoted = true;
             Image = StatisticsDocument;
             PromotedCategory = Process;
         } */
        //  }
        modify("Statistics by C&urrencies")
        {
            CaptionML = ENU = 'Statistics by C&urrencies',
                                 ESM = 'Estad¡sticas por di&visas',
                                 FRC = 'Statistiques par d&evises',
                                 ENC = 'Statistics by C&urrencies';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries',
                                 ESM = 'Movs. &seguim. prod.',
                                 FRC = 'critures de &tra‡abilit',
                                 ENC = 'Item &Tracking Entries';
        }
        addlast(History)
        {
            action(Action1100768003)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-Up Note Entry';
                Image = Note;
            }
            /* action(Action1100768004)
             {

                  CaptionML = ENU = 'Pop-&Up Notes';  //14005018 B2BUPG
                 RunObject = Page 14005018;
                 RunPageView = SORTING(Type, "Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                                   WHERE(Type = CONST(Customer),
                                         Effective = CONST(true),
                                         Expired = CONST(false));
                 RunPageLink = " Vend/Cust No." = FIELD(No.);
                 Image = Note; 
             }*/
        }
        modify(Action24)
        {
            CaptionML = ENU = 'S&ales',
                                 ESM = 'Ve&ntas',
                                 FRC = 'V&entes',
                                 ENC = 'S&ales';
        }
        modify(Sales_InvoiceDiscounts)
        {
            CaptionML = ENU = 'Invoice &Discounts',
                                 ESM = 'Dto. &factura',
                                 FRC = '&Escomptes facture',
                                 ENC = 'Invoice &Discounts';
        }
        modify(PriceLists)
        {
            CaptionML = ENU = 'Prices',
                                 ESM = 'Precios',
                                 FRC = 'Prix',
                                 ENC = 'Prices';
        }
        modify(Prices_InvoiceDiscounts)
        {
            CaptionML = ENU = 'Line Discounts',
                                ESM = 'Descuentos l¡nea',
                                 FRC = 'Ligne Escomptes',
                                 ENC = 'Line Discounts';
        }
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages',
                                 ESM = 'Porcentajes &anticipo',
                                 FRC = 'Pour&centages paiement anticip',
                                 ENC = 'Prepa&yment Percentages';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify(Quotes)
        {
            CaptionML = ENU = 'Quotes',
                                 ESM = 'Cotizaciones',
                                 FRC = 'Devis',
                                 ENC = 'Quotes';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders',
                                 ESM = 'Pedidos',
                                 FRC = 'Commandes',
                                 ENC = 'Orders';
        }
        addafter(Orders)
        {
            action(Invoice)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Invoice';
                RunObject = Page 9301;
                RunPageView = SORTING("Sell-to Customer No.");
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
            }
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders',
                                 ESM = 'Devoluciones',
                                 FRC = 'Retours',
                                 ENC = 'Return Orders';
        }
        modify("Issued Documents")
        {
            CaptionML = ENU = 'Issued Documents',
                                 ESM = 'Documentos emitidos',
                                 FRC = 'Documents mis',
                                 ENC = 'Issued Documents';
        }
        modify("Issued &Reminders")
        {
            CaptionML = ENU = 'Issued &Reminders',
                                    ESM = 'A&visos emitidos',
                                    FRC = '&Rappels mis',
                                    ENC = 'Issued &Reminders';
        }
        modify("Issued &Finance Charge Memos")
        {
            CaptionML = ENU = 'Issued &Finance Charge Memos',
                                 ESM = 'Docs. de &inter s emitidos',
                                 FRC = 'Notes de frais &financiers mises',
                                 ENC = 'Issued &Finance Charge Memos';
        }
        modify("Blanket Orders")
        {
            CaptionML = ENU = 'Blanket Orders',
                                 ESM = 'Pedidos abiertos',
                                 FRC = 'Commandes permanentes',
                                 ENC = 'Blanket Orders';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service',
                                 ESM = 'Servicio',
                                 FRC = 'Service',
                                 ENC = 'Service';
        }
        modify("Service Orders")
        {
            CaptionML = ENU = 'Service Orders',
                                 ESM = 'Pedidos servicio',
                                 FRC = 'Commandes de service',
                                 ENC = 'Service Orders';
        }
        modify("Ser&vice Contracts")
        {
            CaptionML = ENU = 'Ser&vice Contracts',
                                 ESM = 'Con&tratos de Servicio',
                                 FRC = 'Contrats de ser&vices',
                                 ENC = 'Ser&vice Contracts';
        }
        modify("Service &Items")
        {
            CaptionML = ENU = 'Service &Items',
                                 ESM = '&Productos servicio',
                                 FRC = 'Ar&ticles de service',
                                 ENC = 'Service &Items';
        }
        addafter("Service &Items")
        {
            action("&Print Invoice and Credit Hist")
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Print Invoice and Credit Hist';
                Image = Print;
            }
        }
        addafter("&Print Invoice and Credit Hist")
        {
            action(Action1100768005)  //14005135 B2BUPG
            {
                ApplicationArea = All;

                CaptionML = ENU = '&View Sales History';
                RunObject = Page "Recent Sales History";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = View;
                PromotedCategory = Process;
            }
            /*   action(Action1100768006)  //14005136  B2BUPG
              {
                  CaptionML = ENU = 'View Credit &History';
                  RunObject = Page 14005136;
                  RunPageLink = "Sell-to Customer No." = FIELD("No.");
                  Image = View;
              } */
        }
        modify(NewSalesBlanketOrder)
        {
            CaptionML = ENU = 'Blanket Sales Order',
                                 ESM = 'Pedido abierto venta',
                                 FRC = 'Commande permanente ventes',
                                 ENC = 'Blanket Sales Order';
        }
        modify(NewSalesQuote)
        {
            CaptionML = ENU = 'Sales Quote',
                                 ESM = 'Cotizaci¢n venta',
                                 FRC = 'Devis',
                                 ENC = 'Sales Quote';
        }
        modify(NewSalesInvoice)
        {
            CaptionML = ENU = 'Sales Invoice',
                                 ESM = 'Factura venta',
                                 FRC = 'Facture de vente',
                                 ENC = 'Sales Invoice';
        }
        modify(NewSalesOrder)
        {
            CaptionML = ENU = 'Sales Order',
                                 ESM = 'Pedido venta',
                                 FRC = 'Document de vente',
                                 ENC = 'Sales Order';
        }
        modify(Reminder)
        {
            CaptionML = ENU = 'Reminder',
                                 ESM = 'Recordatorio',
                                 FRC = 'Rappel',
                                 ENC = 'Reminder';
        }
        modify("Sales Journal")
        {
            Promoted = false;
        }
        modify(General)
        {
            CaptionML = ENU = 'General',
                                 ESM = 'General',
                                 FRC = 'G n ral',
                                 ENC = 'General';
        }
        modify("Customer Register")
        {
            CaptionML = ENU = 'Customer Register',
                                 ESM = 'Registro movs. cliente',
                                 FRC = 'Registre des clients',
                                 ENC = 'Customer Register';
            // RunObject = Report 10046; //B2BUPG
        }
        // addafter("Customer Register")
        // {
        /* action("Sales Dashboard")  //14005159 B2BUPG
        {
            CaptionML = ENU = 'Sales Dashboard';
            RunObject = Report 14005159;
            Promoted = true;
        } */
        // }
        modify("Customer - Top 10 List")
        {
            CaptionML = ENU = 'Customer - Top 10 List',
                                 ESM = 'Cliente - Listado 10 mejores',
                                 FRC = 'Client - Liste des 10 meilleurs',
                                 ENC = 'Customer - Top 10 List';
            //RunObject = Report 10062;  //B2BUPG

        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales',
                                 ESM = 'Ventas',
                                 FRC = 'Ventes',
                                 ENC = 'Sales';
        }
        modify("Customer - Order Summary")
        {
            CaptionML = ENU = 'Customer - Order Summary',
                                 ESM = 'Cliente - Total pedidos',
                                 FRC = 'Client - Sommaire de commande',
                                 ENC = 'Customer - Order Summary';
        }
        modify("Customer - Order Detail")
        {
            CaptionML = ENU = 'Customer - Order Detail',
                                 ESM = 'Cliente - L¡neas pedidos',
                                 FRC = 'Client - D‚tail de commande',
                                 ENC = 'Customer - Order Detail';
        }
        modify("Customer - Sales List")
        {
            CaptionML = ENU = 'Customer - Sales List',
                                 ESM = 'Lista ventas - cliente',
                                 FRC = 'Client - Liste des ventes',
                                 ENC = 'Customer - Sales List';
        }
        modify("Sales Statistics")
        {
            CaptionML = ENU = 'Sales Statistics',
                                 ESM = 'Estad¡sticas ventas',
                                 FRC = 'Statistiques de ventes',
                                 ENC = 'Sales Statistics';
            // RunObject = Report 10047;  //B2BUPG
        }
        modify(ReportCustomerDetailTrial)
        {
            CaptionML = ENU = 'Customer - Detail Trial Bal.',
                                 ESM = 'Cliente - Movimientos',
                                 FRC = 'Client - Balance de v rification d taill e',
                                 ENC = 'Customer - Detail Trial Bal.';

        }
        modify(Statement)
        {
            CaptionML = ENU = 'Statement',
                                 ESM = 'Estado de cuenta',
                                 FRC = 'Relev',
                                  ENC = 'Statement';
        }
        modify(ReportAgedAccountsReceivable)
        {
            CaptionML = ENU = 'Aged Accounts Receivable',
                                 ESM = 'Antigedad cobros',
                                 FRC = 'Comptes clients class s chronologiquement',
                                 ENC = 'Aged Accounts Receivable';
            // RunObject = Report 10040;  //B2BUPG
        }
        modify(ReportCustomerBalanceToDate)
        {
            CaptionML = ENU = 'Customer - Balance to Date',
                                 ESM = 'Cliente - Saldo por fechas',
                                 FRC = 'Client - Solde … ce jour',
                                 ENC = 'Customer - Balance to Date';
        }
        modify(ReportCustomerTrialBalance)
        {
            CaptionML = ENU = 'Customer - Trial Balance',
                                    ESM = 'Cliente - Balance sumas y saldos',
                                    FRC = 'Client - Balance de v rification',
                                    ENC = 'Customer - Trial Balance';
        }
        modify(ReportCustomerPaymentReceipt)
        {
            CaptionML = ENU = 'Customer - Payment Receipt',
                                 ESM = 'Clientes - Recepci¢n pago',
                                 FRC = 'Client - Re‡u de paiement',
                                 ENC = 'Customer - Payment Receipt';
        }
        // addafter(ReportCustomerPaymentReceipt)
        // {
        /*  action("Shipment Performance")  //14005138 B2BUPG
         {
             CaptionML = ENU = 'Shipment Performance';
             RunObject = Report 14005138;
             Promoted = true;
             Image = Report;
             PromotedCategory = Report;
         } */

        /*   action("Customer Sales History")  //14005136 B2BUPG
          {
              CaptionML = ENU = 'Customer Sales History';
              RunObject = Report 14005136;
              Promoted = true;
              Image = Report;
              PromotedCategory = Report;
          } */
        /* action("Commission Report")  //B2BUPG
        {
            CaptionML = ENU = 'Commission Report';
            RunObject = Report 14005150;
            Promoted = true;
            Image = Report2;
            PromotedCategory = Report;
        } */
        //  }

    }

    VAR
        CustLedgerEntryT: Record 21;
        Ok: Boolean;
        "--FP--": Integer;
        UserPersonal: Record 2000000073;
        //Profile: Record 2000000072;
        User: Record 91;
        "Pct. of Credit Limit": Decimal;
        CustomerFlag: Boolean;
        "--POPN--": Integer;
        //grenote: Record 14005020;  //B2BUPG
        EntryNo: Integer;
    // NotesT: Record 14005020;  //B2BUPG

}
