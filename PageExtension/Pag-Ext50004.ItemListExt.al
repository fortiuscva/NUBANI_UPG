namespace Nubani.Nubani;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Picture;

pageextension 50004 "Item List Ext" extends "Item List"
{
    Editable = true;
    CaptionML = ENU = 'Item List',
        ESM = 'Lista de productos',
        FRC = 'Liste des articles',
        ENC = 'Item List';
    layout
    {
        addafter(Description)
        {
            field(GMO; Rec.GMO)
            {
                ApplicationArea = All;
            }
            field("Inner UPC"; Rec."Inner UPC")
            {
                ApplicationArea = All;
            }
            field("Qty.  Per Pallet"; Rec."Qty.  Per Pallet")
            {
                ApplicationArea = All;
            }
        }
        modify("Substitutes Exist")
        {
            Visible = FALSE;
        }
        modify("Assembly BOM")
        {
            Visible = FALSE;
        }
        moveafter("Assembly BOM"; InventoryField)
        addafter(InventoryField)
        {
            field("Inventory on Date"; Rec."Inventory on Date")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
        }
        modify("Production BOM No.")
        {
            Visible = FALSE;
        }
        modify("Routing No.")
        {
            Visible = FALSE;
        }
        moveafter("Standard Cost"; "Unit Price")
        addafter("Last Direct Cost")
        {
            field("Unit Count"; Rec."Unit Count")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Unit Count"; "Base Unit of Measure")
        moveafter("Base Unit of Measure"; "Cost is Adjusted")
        modify("Search Description")
        {
            CaptionML = ENU = 'SKU',
                           ESM = 'Descripci¢n alias',
                           FRC = 'Description de recherche',
                           ENC = 'Search Description';
            Visible = false;
        }

        addfirst(factboxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
            part(Control1100796006; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100796005; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(LotNumbersByBin; "NUB Lot Numb. By Bin Factbox")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Lot Numbers By Bin';
                SubPageLink = "Item No." = FIELD("No.");
            }
        }
    }
    actions
    {
        modify(Availability)
        {
            CaptionML = ENU = 'Availability',
                                 ESM = 'Disponibilidad',
                                 FRC = 'Disponibilit‚',
                                 ENC = 'Availability';
        }
        modify("Items b&y Location")
        {
            CaptionML = ENU = 'Items b&y Location',
                                 ESM = 'Prods. por &almac‚n',
                                 FRC = 'Articles &par emplacement',
                                 ENC = 'Items b&y Location';
        }
        modify("&Item Availability by")
        {
            CaptionML = ENU = '&Item Availability by',
                                 ESM = '&Disponibilidad prod. por',
                                 FRC = 'Disponibilit‚ d &article par',
                                 ENC = '&Item Availability by';
        }
        modify("<Action5>")
        {
            CaptionML = ENU = 'Event',
                                 ESM = 'Evento',
                                 FRC = 'v‚nement',
                                 ENC = 'Event';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period',
                                 ESM = 'Periodo',
                                 FRC = 'P‚riode',
                                 ENC = 'Period';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant',
                                 ESM = 'Variante',
                                 FRC = 'Variante',
                                 ENC = 'Variant';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location',
                                 ESM = 'Almac‚n',
                                 FRC = 'Emplacement',
                                 ENC = 'Location';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level',
                                 ESM = 'Nivel L.M.',
                                 FRC = 'Niveau nomenclature',
                                 ENC = 'BOM Level';
        }
        modify("&Units of Measure")
        {
            CaptionML = ENU = '&Units of Measure',
                                 ESM = '&Unidades medida',
                                 FRC = '&Unit‚s de mesure',
                                 ENC = '&Units of Measure';
        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants',
                                 ESM = 'Va&riantes',
                                 FRC = 'Va&riantes',
                                 ENC = 'Va&riants';
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
        modify("Substituti&ons")
        {
            CaptionML = ENU = 'Substituti&ons',
                                 ESM = 'Sustitu&ciones',
                                 FRC = 'Articles de su&bstitution',
                                 ENC = 'Substituti&ons';
        }
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts',
                                 ESM = 'Te&xtos adicionales',
                                 FRC = 'Texte ‚&tendu',
                                 ENC = 'E&xtended Text';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations',
                                 ESM = 'Traducciones',
                                 FRC = 'Traductions',
                                 ENC = 'Translations';
        }

        modify(Identifiers)
        {
            CaptionML = ENU = 'Identifiers',
                                 ESM = 'Identificadores',
                                 FRC = 'Identificateurs',
                                 ENC = 'Identifiers';
        }
        addafter(Identifiers)
        {
            action(Action1100768002)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-Up Note Entry';
                Image = Note;

            }
        }
        // addafter(Action1100768002)
        // {
        /*   action(Action1100768003)  //14005018 B2BUPG
          {

              CaptionML = ENU = 'Pop-&Up Notes';
              RunObject = Page 14005018;
              RunPageView = SORTING(Type, "Vend/Cust No.", "No.", Effective, Expired, " Sales Documents", "Purchase Documents")
                                WHERE(Type = FILTER(Customer | Vendor | Item),
                                      Effective = CONST(true),
                                      Expired = CONST(false));
              RunPageLink = "No." = FIELD("No.");
              Image = Note;
          } */
        //}
        modify("Assembly/Production")
        {
            CaptionML = ENU = 'Assembly/Production',
                                 ESM = 'Ensamblado/producci¢n',
                                 FRC = 'Assemblage/Production',
                                 ENC = 'Assembly/Production';
        }
        modify(Structure)
        {
            CaptionML = ENU = 'Structure',
                                 ESM = 'Estructura',
                                 FRC = 'Structure',
                                 ENC = 'Structure';
        }
        modify("Cost Shares")
        {
            CaptionML = ENU = 'Cost Shares',
                                 ESM = 'Partes costos',
                                 FRC = 'Co–ts totaux',
                                 ENC = 'Cost Shares';
        }
        modify(Assembly)
        {
            CaptionML = ENU = 'Assemb&ly',
                                 ESM = 'Ensam&blado',
                                 FRC = 'Assemb&lage',
                                 ENC = 'Assemb&ly';
        }
        modify("<Action32>")
        {
            CaptionML = ENU = 'Assembly BOM',
                                 ESM = 'L.M. de ensamblado',
                                 FRC = 'Nomenclature d assemblage',
                                 ENC = 'Assembly BOM';
        }
        modify("Where-Used")
        {
            CaptionML = ENU = 'Where-Used',
                                 ESM = 'Puntos-de-uso',
                                 FRC = 'Cas d emploi',
                                 ENC = 'Where-Used';
        }
        modify("Calc. Stan&dard Cost")
        {
            CaptionML = ENU = 'Calc. Stan&dard Cost',
                                 ESM = 'Calcular costo est n&dar',
                                 FRC = 'Calculer co–t stan&dard',
                                 ENC = 'Calc. Stan&dard Cost';
        }
        modify("Calc. Unit Price")
        {
            CaptionML = ENU = 'Calc. Unit Price',
                                 ESM = 'Calc. precio unitario',
                                 FRC = 'Calculer prix unitaire',
                                 ENC = 'Calc. Unit Price';
        }
        modify(Production)
        {
            CaptionML = ENU = 'Production',
                                 ESM = 'Producci¢n',
                                 FRC = 'Fabrication',
                                 ENC = 'Production';
        }
        modify("Production BOM")
        {
            CaptionML = ENU = 'Production BOM',
                                 ESM = 'L.M. producci¢n',
                                 FRC = 'Nomenclature de production',
                                 ENC = 'Production BOM';
        }
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'E&ntries';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        modify("&Reservation Entries")
        {
            CaptionML = ENU = '&Reservation Entries',
                                 ESM = 'Movs. &reserva',
                                 FRC = 'critures &r‚servation',
                                 ENC = '&Reservation Entries';
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries',
                                 ESM = 'Movs. inventario f¡&sico',
                                 FRC = 'critures du grand livre de l inventaire physique',
                                 ENC = '&Phys. Inventory Ledger Entries';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries',
                                 ESM = 'Movs. &valor',
                                 FRC = 'critures &valeur',
                                 ENC = '&Value Entries';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries',
                                 ESM = 'Movs. &seguim. prod.',
                                 FRC = 'critures de &tra‡abilit‚',
                                 ENC = 'Item &Tracking Entries';
        }
        modify("&Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries',
                                 ESM = 'Movs. &almac‚n',
                                 FRC = '&critures d entrep“t',
                                 ENC = '&Warehouse Entries';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            //promotedisBig = True;
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics',
                                 ESM = 'Estad¡sticas documentos',
                                 FRC = 'Statistiques ‚critures',
                                 ENC = 'Entry Statistics';
        }
        modify("T&urnover")
        {
            CaptionML = ENU = 'T&urnover',
                                 ESM = 'An &lisis',
                                 FRC = 'Ro&ulement',
                                 ENC = 'T&urnover';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        // addafter("Co&mments")
        // {
        /* action("&Quick Edit Items")  //14004984 B2BUPG
        {
            CaptionML = ENU = '&Quick Edit Items';
            RunObject = Page 14004984;
            Promoted = false;
            Image = EditList;
            PromotedCategory = Process;
        } */
        // }
        modify(Sales)
        {
            CaptionML = ENU = 'S&ales',
                                 ESM = 'Ve&ntas',
                                 FRC = 'V&entes',
                                 ENC = 'S&ales';
        }
        // modify(Prices)
        // {
        //     CaptionML = ENU = 'Prices',
        //                          ESM = 'Tarifas',
        //                          FRC = 'Prix',
        //                          ENC = 'Prices';
        // }
        // modify("Line Discounts")
        // {
        //     CaptionML = ENU = 'Line Discounts',
        //                          ESM = 'Descuentos l¡nea',
        //                          FRC = 'Ligne Escomptes',
        //                          ENC = 'Line Discounts';
        // }
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages',
                                 ESM = 'Porcentajes &anticipo',
                                 FRC = 'Pour&centages paiement anticip‚',
                                 ENC = 'Prepa&yment Percentages';
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
            CaptionML = ENU = 'Returns Orders',
                                 ESM = 'Devoluciones',
                                 FRC = 'Retours',
                                 ENC = 'Returns Orders';
        }
        addafter("Return Orders")
        {
            action("Sales History")  //14005135 B2BUPG
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales History';
                RunObject = Page "Recent Sales History";
                RunPageView = SORTING(Type, "No.");
                RunPageLink = "No." = FIELD("No."),
                               Type = CONST(Item);
                Promoted = true;
                PromotedIsBig = true;
                Image = History;
                PromotedCategory = Process;
            }
            /*   action("History-Credit Memos")  //14005136 B2BUPG
              {
                  CaptionML = ENU = 'History-Credit Memos';
                  RunObject = Page 14005136;
                  RunPageView = SORTING(Type, "No.");
                  RunPageLink = "No." = FIELD("No."),
                                    Type = CONST(Item);
                  Image = History;
                  PromotedCategory = Process;
              } */

        }
        modify(Purchases)
        {
            CaptionML = ENU = '&Purchases',
                                 ESM = '&Compras',
                                 FRC = '&Achats',
                                 ENC = '&Purchases';
        }
        modify("Ven&dors")
        {
            CaptionML = ENU = 'Ven&dors',
                                 ESM = 'Provee&dores',
                                 FRC = '&Fournisseurs',
                                 ENC = 'Ven&dors';
        }

        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        modify("&Bin Contents")
        {
            CaptionML = ENU = '&Bin Contents',
                                 ESM = 'Contenidos u&bicaci¢n',
                                 FRC = 'C&ontenu de la zone',
                                 ENC = '&Bin Contents';
        }
        modify("Stockkeepin&g Units")
        {
            CaptionML = ENU = 'Stockkeepin&g Units',
                                 ESM = '&Uds. de almacenam.',
                                 FRC = 'Unit‚s de stoc&k',
                                 ENC = 'Stockkeepin&g Units';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service',
                                 ESM = 'Servicio',
                                 FRC = 'Service',
                                 ENC = 'Service';
        }
        modify("Ser&vice Items")
        {
            CaptionML = ENU = 'Ser&vice Items',
                                 ESM = 'Prods. &servicio',
                                 FRC = '&Articles de service',
                                 ENC = 'Ser&vice Items';
        }
        modify(Troubleshooting)
        {
            CaptionML = ENU = 'Troubleshooting',
                                 ESM = 'Soluci¢n de problemas',
                                 FRC = 'D‚pannage',
                                 ENC = 'Troubleshooting';
        }
        modify("Troubleshooting Setup")
        {
            CaptionML = ENU = 'Troubleshooting Setup',
                                 ESM = 'Config. detecci¢n errores',
                                 FRC = 'Configuration d‚pannage',
                                 ENC = 'Troubleshooting Setup';
        }
        modify(Resources)
        {
            CaptionML = ENU = 'Resources',
                                 ESM = 'Recursos',
                                 FRC = 'Ressources',
                                 ENC = 'Resources';
        }
        modify("Resource &Skills")
        {
            CaptionML = ENU = 'Resource &Skills',
                                 ESM = '&Cualificaciones',
                                 FRC = '&Comp‚tences de la ressource',
                                 ENC = 'Resource &Skills';
        }
        modify("Skilled R&esources")
        {
            CaptionML = ENU = 'Skilled R&esources',
                                 ESM = '&Recursos',
                                 FRC = '&Ressources comp‚tentes',
                                 ENC = 'Skilled R&esources';
        }
        // addafter("Skilled R&esources")
        // {
        /*   action(Action1100768006)  //14005138 B2BUPG
          {

              CaptionML = ENU = 'Purchase History';
              RunObject = Page 14005138;
              RunPageView = SORTING(Type, "No.");
              RunPageLink = Type = CONST(Item),
                                "No." = FIELD("No.");
              Promoted = true;
              PromotedIsBig = true;
              Image = History;
              PromotedCategory = Process;
          } */

        /*  action("History-Credit Memos")  //14005140 B2BUPG
         {
             CaptionML = ENU = 'History-Credit Memos';
             RunObject = Page 14005140;
             RunPageView = SORTING(Type, "No.");
             RunPageLink = Type = CONST(Item),
                               "No." = FIELD("No.");
             Image = History;
         } */
        // }
        modify(Functions)
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("&Create Stockkeeping Unit")
        {
            CaptionML = ENU = '&Create Stockkeeping Unit',
                                 ESM = '&Crear unidad de almacenam.',
                                 FRC = '&Cr‚er unit‚ de stock',
                                 ENC = '&Create Stockkeeping Unit';
        }
        modify("C&alculate Counting Period")
        {
            CaptionML = ENU = 'C&alculate Counting Period',
                                 ESM = 'Ca&lcular periodo recuento',
                                 FRC = 'C&alculer p‚riode d inventaire',
                                 ENC = 'C&alculate Counting Period';
        }
        // modify(Sales_Prices)
        // {
        //     CaptionML = ENU = 'Sales Prices',
        //                          ESM = 'Precios de venta',
        //                          FRC = 'Prix de vente',
        //                          ENC = 'Sales Prices';
        // }
        // modify(Sales_LineDiscounts)
        // {
        //     CaptionML = ENU = 'Sales Line Discounts',
        //                          ESM = 'Descuentos l¡nea de ventas',
        //                          FRC = 'Escomptes de ligne de vente',
        //                          ENC = 'Sales Line Discounts';
        // }
        modify("Requisition Worksheet")
        {
            CaptionML = ENU = 'Requisition Worksheet',
                                 ESM = 'Hoja de demanda',
                                 FRC = 'Feuille de r‚quisition',
                                 ENC = 'Requisition Worksheet';
            Promoted = false;
        }
        modify("Item Journal")
        {
            CaptionML = ENU = 'Item Journal',
                                 ESM = 'Diario productos',
                                 FRC = 'Journal article',
                                 ENC = 'Item Journal';
            Promoted = false;
        }
        modify("Item Reclassification Journal")
        {
            CaptionML = ENU = 'Item Reclassification Journal',
                                 ESM = 'Diario reclasificaci¢n producto',
                                 FRC = 'Journal de reclassements d articles',
                                 ENC = 'Item Reclassification Journal';
        }
        modify("Item Tracing")
        {
            CaptionML = ENU = 'Item Tracing',
                                 ESM = 'Seguim. prod.',
                                 FRC = 'Rep‚rage d article',
                                 ENC = 'Item Tracing';
        }
        modify("Adjust Item Cost/Price")
        {
            CaptionML = ENU = 'Adjust Item Cost/Price',
                                 ESM = 'Modificar precios/costos de productos',
                                 FRC = 'Ajuster co–t et prix article',
                                 ENC = 'Adjust Item Cost/Price';
        }
        modify("Adjust Cost - Item Entries")
        {
            CaptionML = ENU = 'Adjust Cost - Item Entries',
                                 ESM = 'Valorar existencias - movs. producto',
                                 FRC = 'Articles - Ajuster les co–ts',
                                 ENC = 'Adjust Cost - Item Entries';
            Promoted = false;
        }
        // modify(Item)
        // {
        //     CaptionML = ENU = 'Item';

        // }
        // addfirst(Item)
        // {
        //     action("Item Reports")
        //     {
        //         ApplicationArea = All;
        //         CaptionML = ENU = 'Item Reports';
        //         Image = PrintReport;
        //     }
        // }
        modify("Inventory - List")
        {
            CaptionML = ENU = 'Inventory - List',
                                 ESM = 'Existencias - Listado',
                                 FRC = 'Inventaire - Liste',
                                 ENC = 'Inventory - List';
            //RunObject = Report 10143;  //B2BUPG
        }
        modify("Item/Vendor Catalog")
        {
            CaptionML = ENU = 'Item/Vendor Catalog',
                                 ESM = 'Producto - Lista proveedores',
                                 FRC = 'Catalogue article/fournisseur',
                                 ENC = 'Item/Vendor Catalogue';
            //RunObject = Report 10164;  //B2BUPG
        }
        modify("Phys. Inventory List")
        {
            CaptionML = ENU = 'Phys. Inventory List',
                                 ESM = 'Lista inventario f¡sico',
                                 FRC = 'Liste de l inventaire physique',
                                 ENC = 'Phys. Inventory List';
            //RunObject = Report 722;  //B2BUPG
        }
        // modify("Price List")
        // {
        //     CaptionML = ENU = 'Price List',
        //                          ESM = 'Lista de precios',
        //                          FRC = 'Liste de prix',
        //                          ENC = 'Price List';
        //     //RunObject = Report 10148;  //B2BUPG
        //     Promoted = true;
        //     //Image = Report;   //B2BUPG
        //     PromotedCategory = Report;
        // }
        modify("Inventory Cost and Price List")
        {
            CaptionML = ENU = 'Inventory Cost and Price List',
                                 ESM = 'Lista de precios y costos',
                                 FRC = 'Co–t de l inventaire et liste de prix',
                                 ENC = 'Inventory Cost and Price List';
            //RunObject = Report 10142;  //B2BUPG
        }
        // addafter("Inventory Cost and Price List")
        // {
        /*   action("Inventory Valuation w/Detail")  //14005151 B2BUPG
          {
              CaptionML = ENU = 'Inventory Valuation w/Detail';
              RunObject = Report 14005151;
              Promoted = true;
              PromotedIsBig = true;
              Image = Report;
              PromotedCategory = Report;
          } */
        // }
        modify("Inventory - Top 10 List")
        {
            CaptionML = ENU = 'Inventory - Top 10 List',
                                 ESM = 'Existencias - Listado 10 mejores',
                                 FRC = 'Inventaire - Liste des 10 meilleurs',
                                 ENC = 'Inventory - Top 10 List';
            //RunObject = Report 10162;  //B2BUPG
        }
        modify("Where-Used (Top Level)")
        {
            CaptionML = ENU = 'Where Used (Top Level)',
                                 ESM = 'Puntos de uso (nivel superior)',
                                 FRC = 'Cas d emploi (multi-niveau)',
                                 ENC = 'Where Used (Top Level)';
            //RunObject = Report 99000757;  //B2BUPG
            //image = Report;
        }
        modify("Quantity Explosion of BOM")
        {

            CaptionML = ENU = 'Quantity Explosion of BOM',
                                 ESM = 'Despliegue cantidad en L.M.',
                                 FRC = 'Explosion de la quantit‚ de nomenclature',
                                 ENC = 'Quantity Explosion of BOM';
            //RunObject = Report 99000753;   //B2BUPG
        }
        modify("Compare List")
        {
            CaptionML = ENU = 'Compare List',
                                 ESM = 'Lista comparaci¢n',
                                 FRC = 'Liste de comparaison',
                                 ENC = 'Compare List';
            // RunObject = Report 99000758;  //B2BUPG
        }
        modify("Item Register - Quantity")
        {
            CaptionML = ENU = 'Item Register - Quantity',
                                 ESM = 'Registro prod. - cdad.',
                                 FRC = 'Registre d articles - Quantit‚',
                                 ENC = 'Item Register - Quantity';
            // RunObject = Report 10144;  //B2BUPG
            Promoted = false;
        }
        modify("Inventory - Transaction Detail")
        {
            CaptionML = ENU = 'Inventory - Transaction Detail',
                                 ESM = 'Existencias - Movimientos',
                                 FRC = 'Inventaire - D‚tail de transaction',
                                 ENC = 'Inventory - Transaction Detail';
            //RunObject = Report 10136; //B2BUPG
        }

        modify("Inventory Purchase Orders")
        {
            CaptionML = ENU = 'Inventory Purchase Orders',
                                 ESM = 'Producto - Pedidos compra',
                                 FRC = 'Bons de commande d inventaire',
                                 ENC = 'Inventory Purchase Orders';
            // RunObject = Report 10156;   //B2BUPG
            Promoted = false;
        }
        // modify("Inventory - Sales Statistics")
        // {
        //     CaptionML = ENU = 'Inventory - Sales Statistics',
        //                          ESM = 'Existencias - Estad¡sticas ventas',
        //                          FRC = 'Inventaire - Statistiques de ventes',
        //                          ENC = 'Inventory - Sales Statistics';
        //     //RunObject = Report 10135;   //B2BUPG
        //     Promoted = false;
        // }//B2BUPG
        modify("Assemble to Order - Sales")
        {
            CaptionML = ENU = 'Assemble to Order - Sales',
                                 ESM = 'Ensamblar para pedido - Ventas',
                                 FRC = 'Assembler pour commande - Ventes',
                                  ENC = 'Assemble to Order - Sales';
            // RunObject = Report 915;  //B2BUPG
            //  Image = Report;
            // PromotedCategory = Report;
        }
        modify("Inventory - Customer Sales")
        {
            CaptionML = ENU = 'Inventory - Customer Sales',
                                 ESM = 'Producto - Ventas clientes',
                                 FRC = 'Inventaire - Ventes client',
                                 ENC = 'Inventory - Customer Sales';
            // RunObject = Report 10145;  //B2BUPG
        }
        modify("Inventory - Vendor Purchases")
        {
            CaptionML = ENU = 'Inventory - Vendor Purchases',
                                 ESM = 'Producto - Compras proveedores',
                                 FRC = 'Inventaire - Achats fournisseur',
                                 ENC = 'Inventory - Vendor Purchases';
            // RunObject = Report 10113;  //B2BUPG
            // image = report;
        }
        modify("Inventory - Reorders")
        {
            CaptionML = ENU = 'Inventory - Reorders',
                                 ESM = 'Producto - Reorden',
                                 FRC = 'Inventaire - R‚approvisionnement',
                                 ENC = 'Inventory - Reorders';
            // RunObject = Report 717; //B2BUPG
        }
        modify("Inventory - Sales Back Orders")
        {
            CaptionML = ENU = 'Inventory - Sales Back Orders',
                                 ESM = 'Productos - Pedidos por servir',
                                 FRC = 'Inventaire - Commandes en retard',
                                 ENC = 'Inventory - Sales Back Orders';
            // RunObject = Report 718;  //B2BUPG
            Promoted = false;
        }
        modify("Inventory - Cost Variance")
        {
            CaptionML = ENU = 'Inventory - Cost Variance',
                                 ESM = 'Existencias - Variaci¢n del costo',
                                 FRC = 'Inventaire : volution des co–ts',
                                 ENC = 'Inventory - Cost Variance';
            // RunObject = Report 721;  //B2BUPG
            // Image = ItemCosts;
            // PromotedCategory = Report;
        }
        modify("Inventory Valuation")
        {
            CaptionML = ENU = 'Inventory Valuation',
                                 ESM = 'Valuaci¢n de inventarios',
                                 FRC = 'valuation de l inventaire',
                                 ENC = 'Inventory Valuation';
            //RunObject = Report 10139;  //B2BUPG
            Promoted = true;
        }
        modify("Invt. Valuation - Cost Spec.")
        {
            CaptionML = ENU = 'Invt. Valuation - Cost Spec.',
                                 ESM = 'Valorac. exist.-especif. costo',
                                 FRC = 'valuation des stocks - Sp‚cification co–t',
                                 ENC = 'Invt. Valuation - Cost Spec.';
        }
        modify("Inventory Valuation - WIP")
        {
            CaptionML = ENU = 'Inventory Valuation - WIP',
                                 ESM = 'Valuaci¢n de inventarios - WIP',
                                 FRC = 'valuation de l inventaire d en-cours',
                                 ENC = 'Inventory Valuation - WIP';
        }
        modify("Item Register - value")
        {
            CaptionML = ENU = 'Item Register - Value',
                                 ESM = 'Registro movs. prods. - valor',
                                 FRC = 'Registre d article - Valeur',
                                 ENC = 'Item Register - Value';
        }
        modify("Item Charges - Specification")
        {
            CaptionML = ENU = 'Item Charges - Specification',
                                 ESM = 'Cargos prod. - especificaci¢n',
                                 FRC = 'Frais annexes - Sp‚cification',
                                 ENC = 'Item Charges - Specification';
        }
        modify("Item Age Composition - Quantity")
        {
            CaptionML = ENU = 'Item Age Composition - Qty.',
                                 ESM = 'Composici¢n antig. prod.-cdad',
                                 FRC = 'Anciennet‚ d article - Qt‚',
                                 ENC = 'Item Age Composition - Qty.';
        }
        modify("Item Age Composition - Value")
        {
            CaptionML = ENU = 'Item Age Composition - Value',
                                 ESM = 'Composici¢n antig. prod.-valor',
                                 FRC = 'Anciennet‚ d article - Valeur',
                                 ENC = 'Item Age Composition - Value';
        }
        modify("Item Expiration - Quantity")
        {
            CaptionML = ENU = 'Item Expiration - Quantity',
                                 ESM = 'Caducidad producto - Cantidad',
                                 FRC = 'Expiration d article - Quantit‚',
                                 ENC = 'Item Expiration - Quantity';
        }
        modify("Cost Shares Breakdown")
        {
            CaptionML = ENU = 'Cost Shares Breakdown',
                                 ESM = 'An lisis partes costos',
                                 FRC = 'Ventilation des partages de co–ts',
                                 ENC = 'Cost Shares Breakdown';
        }
        modify("Detailed Calculation")
        {
            CaptionML = ENU = 'Detailed Calculation',
                                 ESM = 'C lculo detallado',
                                 FRC = 'Calcul d‚taill‚',
                                 ENC = 'Detailed Calculation';
        }
        modify("Rolled-up Cost Shares")
        {
            CaptionML = ENU = 'Rolled-up Cost Shares',
                                 ESM = 'Parte costos distrib.',
                                 FRC = 'Co–t actions d ensemble',
                                 ENC = 'Rolled-up Cost Shares';
        }
        modify("Single-Level Cost Shares")
        {
            CaptionML = ENU = 'Single-Level Cost Shares',
                                 ESM = 'Parte costos a un nivel',
                                 FRC = 'Co–t actions … niveau unique',
                                 ENC = 'Single-Level Cost Shares';
        }

        modify("Inventory Availability")
        {
            CaptionML = ENU = 'Inventory Availability',
                                 ESM = 'Disponibilidad existencias',
                                 FRC = 'Disponibilit‚ de l inventaire',
                                 ENC = 'Inventory Availability';
            // RunObject = Report 10131;  //B2BUPG
            // Promoted = true;
            // Image = Report;
            // PromotedCategory = Report;
        }
        // addafter("Inventory Availability")
        // {
        //     action("Item Turnover")
        //     {
        //         CaptionML = ENU = 'Item Turnover',
        //                          ESM = 'An lisis producto',
        //                          FRC = 'Rotation d articles',
        //                          ENC = 'Item Turnover';
        //        // RunObject = Report 10146; //B2BUPG
        //         Promoted = false;
        //         Image = Report;
        //        // PromotedCategory = Report;  //B2BUPG
        //     }
        // }
        addafter("Item Turnover")
        {
            /* action("Inventory Valuation Report")   //14005151  B2BUPG
            {
                CaptionML = ENU = 'Inventory Valuation Report';
                RunObject = Report 14005151;
                Promoted = true;
                Image = Report2;
                PromotedCategory = Report;
            } */
            action("SKU Label")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
                trigger OnAction()
                VAR
                    Item: Record Item;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(Item);
                    REPORT.RUNMODAL(REPORT::"Item SKU Label", TRUE, FALSE, Item);
                END;
            }
        }
        modify(Action29)
        {
            CaptionML = ENU = 'Where-Used',
                                 ESM = 'Puntos-de-uso',
                                 FRC = 'Cas d emploi',
                                 ENC = 'Where-Used';
        }
        modify("Returns Orders")
        {
            CaptionML = ENU = 'Return Orders',
                                 ESM = 'Devoluciones',
                                 FRC = 'Retours',
                                 ENC = 'Return Orders';
        }


    }
    var
        "--POPN--": Integer;
        // greNote: Record 14005020;  //B2BUPG
        EntryNo: Integer;
    // NotesT: Record 14005020;  //B2BUPG
}