namespace Nubani.Nubani;

using Microsoft.Sales.Customer;
pageextension 50001 "Customer Card Ext" extends "Customer Card"
{

    CaptionML = ENU = 'Customer Card',
               ESM = 'Ficha cliente',
               FRC = 'Fiche client',
               ENC = 'Customer Card';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G n ral',
                           ENC = 'General';
        }
        moveafter(City; County)
        addafter("Primary Contact No.")
        {
            field("Collection Comments"; Rec."Collection Comments")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Search Name")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }

        modify("Fax No.")
        {
            Importance = Promoted;
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing',
                           ESM = 'Facturaci¢n',
                           FRC = 'Facturation',
                           ENC = 'Invoicing';
        }
        moveafter("Copy Sell-to Addr. to Qte From"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")

        moveafter("Tax Area Code"; "VAT Registration No.")

        addafter("Tax Exemption No.")
        {
            field("Cert Expiration Date"; Rec."Cert Expiration Date")
            {
                ApplicationArea = All;
            }
        }



        modify(Payments)
        {
            CaptionML = ENU = 'Payments',
                           ESM = 'Pagos',
                           FRC = 'Paiements',
                           ENC = 'Payments';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping',
                           ESM = 'Env¡o',
                           FRC = 'Exp dition',
                           ENC = 'Shipping';
        }
        modify("Customized Calendar")
        {
            CaptionML = ENU = 'Customized Calendar',
                           ESM = 'Calendario personalizado',
                           FRC = 'Calendrier personnalis',
                           ENC = 'Customized Calendar';
        }


        addafter("Check Date Format")
        {
            field("VAT Registration No.2"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
        }
        movebefore(SalesHistSelltoFactBox; CustomerStatisticsFactBox)
        modify(SalesHistSelltoFactBox)
        {
            Visible = true;
        }
        moveafter(SalesHistSelltoFactBox; SalesHistBilltoFactBox)
        modify(SalesHistBilltoFactBox)
        {
            Visible = false;
        }
        moveafter(Control1907829707; Control1905767507)
        moveafter(Control1905767507; Control1900383207)

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
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                    ESM = 'Dimensiones',
                                    FRC = 'Dimensions',
                                    ENC = 'Dimensions';
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
                                 ENC = 'Ship-&to Addresses]';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'C&ontact',
                                 ESM = '&Contacto',
                                 FRC = 'C&ontact',
                                 ENC = 'C&ontact';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }

        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        modify(Action76)
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
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics',
                                 ESM = 'Estad¡sticas documentos',
                                 FRC = 'Statistiques critures',
                                 ENC = 'Entry Statistics';
        }
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
        modify(Action82)
        {
            CaptionML = ENU = 'S&ales',
                                 ESM = 'Ve&ntas',
                                 FRC = 'V&entes',
                                 ENC = 'S&ales';
        }
        modify("Invoice &Discounts")
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
        modify(DiscountLines)
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
        modify("&Jobs")
        {
            CaptionML = ENU = '&Jobs',
                                 ESM = 'Pro&yectos',
                                 FRC = '&Projets',
                                 ENC = '&Jobs';
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
        modify(NewSalesCreditMemo)
        {
            CaptionML = ENU = 'Sales Credit Memo',
                                 ESM = 'Nota cr dito venta',
                                 FRC = 'Note de cr dit de vente',
                                 ENC = 'Sales Credit Memo';
        }
        modify(NewSalesReturnOrder)
        {
            CaptionML = ENU = 'Sales Return Order',
                                 ESM = 'Devoluci¢n venta',
                                 FRC = 'Retour vente',
                                 ENC = 'Sales Return Order';
        }
        modify(NewServiceQuote)
        {
            CaptionML = ENU = 'Service Quote',
                                 ESM = 'Cotizaci¢n servicio',
                                 FRC = 'Devis service',
                                 ENC = 'Service Quote';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(ApplyTemplate)
        {
            CaptionML = ENU = 'Apply Template',
                                 ESM = 'Aplicar plantilla',
                                 FRC = 'Appliquer le modŠle',
                                 ENC = 'Apply Template';
            Promoted = false;
        }

        modify("Sales Journal")
        {
            Promoted = false;
        }
        // addlast("&Customer")
        // {
        /*   action("&Quick Edit Customers") // 14004982 B2BUPG
          {
              ApplicationArea = All;
              CaptionML = ENU = '&Quick Edit Customers';
              RunObject = Page 14004982;
              // Promoted = false;
              Image = EditList;
              //  PromotedCategory = Process;
          }  */
        /*   action("Email Communication") //14005169 B2BUPG
          {
              CaptionML = ENU = 'Email Communication';
              RunObject = Page 14005169;
              RunPageView = SORTING(Type, "No.")
                                WHERE(Type = CONST(Customer));
              RunPageLink = "No." = FIELD("No.");
              Image = SendAsPDF;
              Promoted = true;
              PromotedCategory = Process;
          } */
        //}
        addafter("Ledger E&ntries")
        {
            action("Ledger Entries &Descending")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Ledger Entries &Descending';
                Promoted = false;
                //  PromotedIsBig =true; //B2BUPG
                Image = EntriesList;
                //PromotedCategory = Process; //B2BUPG
            }
        }
        addafter("Entry Statistics")
        {
            /* action("Customer &Order Status") //10025 B2BUPG
            {
                CaptionML = ENU = 'Customer &Order Status';
                RunObject = Page 10025;
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                Image = StatisticsDocument;
                PromotedCategory = Process;
            } */
        }
        addafter("Item &Tracking Entries")
        {
            action("Pop-Up Note Entry")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-Up Note Entry';
                Image = Note;
            }
        }
        addafter("Pop-Up Note Entry")
        {
            /* action("Pop-&Up Notes") //14005018  B2BUPG
            {
                CaptionML = ENU = 'Pop-&Up Notes';
                RunObject = Page 14005018;
                RunPageView = SORTING(Type, "Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                                  WHERE(Type = CONST(Customer),
                                        Effective = CONST(true),
                                        Expired = CONST(false));
                RunPageLink = "Vend/Cust No." = FIELD("No.");
                Image = Note;
            } */
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
            action("&View Sales History") //14005135  B2BUPG
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
            /*  action("View Credit &History")  //14005136 B2BUPG
             {
                 CaptionML = ENU = 'View Credit &History';
                 RunObject = Page 14005136;
                 RunPageLink = "Sell-to Customer No." = FIELD(No.);
                 Image = View;
             } */

            action("&Print Invoice and CM History")
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Print Invoice and CM History';
                Image = Print;
            }
        }
        // addlast("F&unctions")
        // {
        /*  action("Cash Applied") //10041 B2BUPG
         {
             CaptionML = ENU = 'Cash Applied';
             RunObject = Report 10041;
             Promoted = false;
             Image = Report;
             //PromotedCategory = Report;
         } */
        /*   action("Open Customer Entries")  //10053 B2BUPG
          {
              CaptionML = ENU = 'Open Customer Entries';
              RunObject = Report 10053;
              Promoted = true;
              Image = Report;
              PromotedCategory = Report;
          } */
        /*  action("Customer Statement")  //10072 B2BUPG
         {
             CaptionML = ENU = 'Customer Statement';
             RunObject = Report 10072;
             // Promoted = false;
             Image = Report;
             //   PromotedCategory = Report;
         } */
        /* action("Customer/Item Statistics") //10048 B2BUPG
        {
            CaptionML = ENU = 'Customer/Item Statistics';
            RunObject = Report 10048;
            // Promoted =false;
            Image = Report;
            // PromotedCategory = Report;
        } */
        /* action("Customer Jobs (Cost)")  //10213 B2BUPG
        {
            CaptionML = ENU = 'Customer Jobs (Cost)';
            RunObject = Report 10213;
            // Promoted =false;
            Image = Report;
            // PromotedCategory = Report;
        } */
        /*  action("Customer Jobs (Price)")  //10214 B2BUPG
         {
             CaptionML = ENU = 'Customer Jobs (Price)';
             RunObject = Report 10214;
             // Promoted =false;
             Image = Report;
             // PromotedCategory = Report;
         } */
        /* action("Shipment Performance")   //14005138 B2BUPG
        {
            CaptionML = ENU = 'Shipment Performance';
            RunObject = Report 14005138;
            Promoted = true;
            Image = Report;
            PromotedCategory = Report;
        } */
        /* action("Customer Sales History")   //14005136 B2BUPG
        {
            CaptionML = ENU = 'Customer Sales History';
            RunObject = Report 14005136;
            Image = Report;
        } */
        // }

    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.TESTFIELD("Global Dimension 1 Code"); //NUB1.01
    end;

    var
        "--FP--": Integer;
        CustLedgerEntryT: Record 21;
        OK: Boolean;
        "--POPN--": Integer;
        // grenote: Record 14005020; //B2BUPG
        EntryNo: Integer;
    // NotesT: Record 14005020;  //B2BUPG
}
