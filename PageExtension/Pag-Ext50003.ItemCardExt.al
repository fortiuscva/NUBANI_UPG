namespace Nubani.Nubani;

using Microsoft.Inventory.Item;

pageextension 50003 "Item Card Ext" extends "Item Card"
{
    CaptionML = ENU = 'Item Card',
               ESM = 'Ficha producto',
               FRC = 'Fiche d article',
               ENC = 'Item Card';
    layout
    {
        addlast(Item)
        {
            field("Unit Count"; Rec."Unit Count")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Count field.', Comment = '%';
            }
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'SKU',
                           ESM = 'Descripci¢n alias',
                           FRC = 'Description de recherche',
                           ENC = 'Search Description';
        }
        addafter("Search Description")
        {
            field(GMO; Rec.GMO)
            {
                ApplicationArea = All;
            }
        }
        addafter(GMO)
        {
            field("Inner UPC"; Rec."Inner UPC")
            {
                ApplicationArea = all;
            }
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description Other',
                           ESM = 'Descripci¢n 2',
                           FRC = 'Description 2',
                           ENC = 'Description 2';
            Visible = true;
            Importance = Standard;
        }
        moveafter("Base Unit of Measure"; "Net Weight")
        addafter("Net Weight")
        {
            field("Qty.  Per Pallet"; Rec."Qty.  Per Pallet")
            {
                ApplicationArea = All;
            }
        }

        modify(Inventory)
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.',
                           ESM = 'N§ estante',
                           FRC = 'Nø de tablette',
                           ENC = 'Shelf No.';
        }
        modify("Qty. on Purch. Order")
        {
            Visible = false;
        }
        modify("Qty. on Sales Order")
        {
            Visible = false;
        }
        // modify(Blocked)
        // {
        //     Editable = false;
        // }

        modify(Replenishment)
        {
            CaptionML = ENU = 'Replenishment',
                           ESM = 'Reposici¢n',
                           FRC = 'R‚approvisionnement',
                           ENC = 'Replenishment';
        }
        modify(Purchase)
        {
            CaptionML = ENU = 'Purchase',
                           ESM = 'Compra',
                           FRC = 'Achat',
                           ENC = 'Purchase';
        }
        modify(Replenishment_Production)
        {
            CaptionML = ENU = 'Production',
                           ESM = 'Producci¢n',
                           FRC = 'Fabrication',
                           ENC = 'Production';
        }
        modify(Replenishment_Assembly)
        {
            CaptionML = ENU = 'Assembly',
                           ESM = 'Ensamblado',
                           FRC = 'Assemblage',
                           ENC = 'Assembly';
        }
        modify(Planning)
        {
            CaptionML = ENU = 'Planning',
                           ESM = 'Planificaci¢n',
                           FRC = 'Planification',
                           ENC = 'Planning';
        }
        modify(LotForLotParameters)
        {
            CaptionML = ENU = 'Lot-for-Lot Parameters',
                           ESM = 'Par metros de lote a lote',
                           FRC = 'ParamŠtres Lot pour lot',
                           ENC = 'Lot-for-Lot Parameters';
        }
        modify(ReorderPointParameters)
        {
            CaptionML = ENU = 'Reorder-Point Parameters',
                           ESM = 'Par metros de punto de pedido',
                           FRC = 'ParamŠtres Point de commande',
                           ENC = 'Reorder-Point Parameters';
        }
        modify(OrderModifiers)
        {
            CaptionML = ENU = 'Order Modifiers',
                           ESM = 'Modificadores de pedido',
                           FRC = 'Modificateur ordre',
                           ENC = 'Order Modifiers';
        }
        modify(ForeignTrade)
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        modify(ItemTracking)
        {
            CaptionML = ENU = 'Item Tracking',
                           ESM = 'Seguim. prod.',
                           FRC = 'Suivi d article',
                           ENC = 'Item Tracking';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse',
                           ESM = 'Almac‚n',
                           FRC = 'Entrep“t',
                           ENC = 'Warehouse';
        }
        modify(Control1900383207)
        {
            Visible = false;
        }
        addlast("Prices & Sales")
        {
            field("Commission %"; Rec."Commission %")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
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
        }
    }
    actions
    {
        modify("&Units of Measure")
        {
            CaptionML = ENU = '&Units of Measure',
                                 ESM = '&Unidades medida',
                                 FRC = '&Unit s de mesure',
                                 ENC = '&Units of Measure';
        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants',
                                 ESM = 'Va&riantes',
                                 FRC = 'Va&riantes',
                                 ENC = 'Va&riants';
        }
        addafter("Va&riants")
        {
            /*  action("&Quick Edit Items")  //14004984  B2BUPG
             {
                 CaptionML = ENU = '&Quick Edit Items';
                 RunObject = Page 14004984;
                 //  Promoted = false;
                 Image = EditList;
                 //    PromotedCategory = Process;
             } */
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
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
                                 FRC = 'Texte &tendu',
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
            action("Pop-Up Note Entry")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-Up Note Entry';
                Image = Note;
            }
        }
        // addafter("Pop-Up Note Entry")
        // {
        /*  action("Pop-&Up Notes")   //14005018 B2BUPG
         {
             CaptionML = ENU = 'Pop-&Up Notes';
             RunObject = Page 14005018;
             RunPageView = SORTING(Type, " Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                               WHERE(Type = FILTER(Customer | Vendor | Item),
                                     Effective = CONST(true),
                                     Expired = CONST(false));
             RunPageLink = "No." = FIELD("No.");
             Image = Note;
         } */
        //  }
        modify(Availability)
        {
            CaptionML = ENU = 'Availability',
                                 ESM = 'Disponibilidad',
                                 FRC = 'Disponibilit',
                                 ENC = 'Availability';
        }
        modify(ItemsByLocation)
        {
            CaptionML = ENU = 'Items b&y Location',
                                 ESM = 'Prods. por &almac n',
                                 FRC = 'Articles &par emplacement',
                                 ENC = 'Items b&y Location';
        }
        modify(ItemAvailabilityBy)
        {
            CaptionML = ENU = '&Item Availability by',
                                 ESM = '&Disponibilidad prod. por',
                                 FRC = 'Disponibilit d &article par',
                                 ENC = '&Item Availability by';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period',
                                 ESM = 'Periodo',
                                 FRC = 'P riode',
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
                                 ESM = 'Almac n',
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
        modify(History)
        {
            CaptionML = ENU = 'History',
                                 ESM = 'Historial',
                                 FRC = 'Historique',
                                 ENC = 'History';
        }
        modify(Entries)
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
                                 FRC = 'critures &r servation',
                                 ENC = '&Reservation Entries';
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries',
                                 ESM = 'Movs. &inventario f¡sico',
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
                                 FRC = 'critures de &tra‡abilit',
                                 ENC = 'Item &Tracking Entries';
        }
        modify("&Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries',
                                 ESM = 'Movs. &almac n',
                                 FRC = '&critures d entre t',
                                ENC = '&Warehouse Entries';
        }
        modify("Application Worksheet")
        {
            CaptionML = ENU = 'Application Worksheet',
                                 ESM = 'Hoja liquidaci¢n',
                                 FRC = 'Feuille de travail Affectation',
                                 ENC = 'Application Worksheet';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics',
                                 ESM = 'Estad¡sticas documentos',
                                 FRC = 'Statistiques critures',
                                 ENC = 'Entry Statistics';
        }
        modify("T&urnover")
        {
            CaptionML = ENU = 'T&urnover',
                                    ESM = 'An&lisis',
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
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages',
                                 ESM = 'Porcentajes &anticipo',
                                 FRC = 'Pour&centages paiement anticip',
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
            CaptionML = ENU = 'Return Orders',
                                 ESM = 'Devoluciones',
                                 FRC = 'Retours',
                                 ENC = 'Return Orders';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'S&ales',
                                 ESM = 'Ve&ntas',
                                 FRC = 'V&entes',
                                 ENC = 'S&ales';
        }

        modify(BOMStructure)
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
                                 FRC = 'Co ts totaux',
                                 ENC = 'Cost Shares';
        }
        modify(Assembly)
        {
            CaptionML = ENU = 'Assemb&ly',
                                 ESM = 'Ensa&mblado',
                                 FRC = 'Assemb&lage',
                                 ENC = 'Assemb&ly';
        }
        modify("Assembly BOM")
        {
            CaptionML = ENU = 'Assembly BOM',
                                 ESM = 'L.M. de ensamblado',
                                FRC = 'Nomenclature d assemblage',
                                 ENC = 'Assembly BOM]';
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
                                 ESM = 'Calcular costo est n&dar',
                                 FRC = 'Calculer co t stan&dard',
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
        modify(Navigation_Warehouse)
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
                                 ESM = 'Uds. de almace&nam.',
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
        modify("Resource Skills")
        {
            CaptionML = ENU = 'Resource Skills',
                                 ESM = 'Habilidades recurso',
                                 FRC = 'Comp‚tences de la ressource',
                                 ENC = 'Resource Skills';
        }
        modify("Skilled Resources")
        {
            CaptionML = ENU = 'Skilled Resources',
                                 ESM = 'Recursos cualificados',
                                 FRC = 'Ressources comp‚tentes',
                                 ENC = 'Skilled Resources';
        }
        // addafter("Skilled Resources")
        // {
        /*  action("History-Credit Memos")  //14005140 B2BUPG
         {
             CaptionML = ENU = 'History-Credit Memos';
             RunObject = Page 14005140;
             RunPageView = SORTING(Type, " No.");
             RunPageLink = Type = CONST(Item),
                              " No." = FIELD("No.");
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
        modify(CalculateCountingPeriod)
        {
            CaptionML = ENU = 'C&alculate Counting Period',
                                 ESM = 'Ca&lcular periodo recuento',
                                 FRC = 'C&alculer p‚riode d inventaire',
                                 ENC = 'C&alculate Counting Period';
        }
        modify(ApplyTemplate)
        {
            CaptionML = ENU = 'Apply Template',
                                 ESM = 'Aplicar plantilla',
                                 FRC = 'Appliquer le modŠle',
                                 ENC = 'Apply Template';
            Promoted = false;
        }
        modify("Requisition Worksheet")
        {
            Promoted = false;
        }
        modify("Item Journal")
        {
            Promoted = false;
        }
        modify("Item Reclassification Journal")
        {
            Promoted = false;
        }
        modify("Item Tracing")
        {
            Promoted = false;
        }
        addlast(Functions)
        {
            action("History Sales")  //14005135 B2BUPG
            {
                ApplicationArea = All;
                CaptionML = ENU = 'History Sales';
                RunObject = Page "Recent Sales History";
                RunPageView = SORTING(Type, "No.");
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = History;
                PromotedCategory = Process;
                RunPageMode = View;
            }
            /* action("History Purchases")  //50056 B2BUPG
            {
                CaptionML = ENU = 'History Purchases';
                RunObject = Page 50056;
                RunPageView = SORTING(Type, "No.");
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = History;
                PromotedCategory = Process;
                RunPageMode = View;
            } */
            /*  action("Item Turnover")  //10146 B2BUPG
             {
                 CaptionML = ENU = 'Item Turnover';
                 RunObject = Report 10146;
                 Promoted = false;
                 Image = Report;
                 PromotedCategory = Report;
             } */
            /* action("Item Transaction Detail")  //10136  B2BUPG
            {
                CaptionML = ENU = 'Item Transaction Detail';
                RunObject = Report 10136;
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
            } */
            /*  action("Serial Number Status/Aging")  // 10162 B2BUPG
             {
                 CaptionML = ENU = 'Serial Number Status/Aging';
                 RunObject = Report 10162;
                 Promoted = false;
                 Image = Report;
                 PromotedCategory = Report;
             } */
            /*  action("Issue History")  //10140 B2BUPG
             {
                 CaptionML = ENU = 'Issue History';
                 RunObject = Report 10140;
                 Promoted = false;
                 Image = Report;
                 PromotedCategory = Report;
             } */
            /*  action("Costed Bill of Materials")  //10171 B2BUPG
             {
                 CaptionML = ENU = 'Costed Bill of Materials';
                 RunObject = Report 10171;
                 Promoted = false;
                 Image = Report;
                 PromotedCategory = Report;
             } */
            /*   action("Item Sales by Customer")  //10145 B2BUPG
              {
                  CaptionML = ENU = 'Item Sales by Customer';
                  RunObject = Report 10145;
                  Promoted = false;
                  Image = Report;
                  PromotedCategory = Report;
              } */
            /* action("Picking List by Item")  //10152 B2BUPG
            {
                CaptionML = ENU = 'Picking List by Item';
                RunObject = Report 10152;
                Promoted = false;
                Image = Report;
                PromotedCategory = Report;
            } */
            /* action("Sales Order Status")  //10158 B2BUPG
            {
                CaptionML = ENU = 'Sales Order Status';
                RunObject = Report 10158;
                Promoted = false;
                Image = Report;
                PromotedCategory = Report;
            } */
            /*  action("Serial Number Sold History")  //10160 B2BUPG
             {
                 CaptionML = ENU = 'Serial Number Sold History';
                 RunObject = Report 10160;
                 Promoted = false;
                 Image = Report;
                 PromotedCategory = Report;
             } */
            /* action("Vendor Purchases by Item")  //10163 B2BUPG
            {
                CaptionML = ENU = 'Vendor Purchases by Item';
                RunObject = Report 10163;
                Promoted = false;
                Image = Report;
                PromotedCategory = Report;
            } */
            /* action("Item/Vendor Catalog")   //10164  B2BUPG
            {
                CaptionML = ENU = 'Item/Vendor Catalog';
                RunObject = Report 10164;
                Promoted = false;
                Image = Report;
                PromotedCategory = Report;
            } */
            /* action("Purchase Order Status")  //10156 B2BUPG
            {
                CaptionML = ENU = 'Purchase Order Status';
                RunObject = Report 10156;
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
            } */
            action("SKU Label ")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
                trigger OnAction()
                VAR
                    "Item": Record Item;
                BEGIN
                    CurrPage.SETSELECTIONFILTER(Item);
                    REPORT.RUNMODAL(REPORT::"Item SKU Label", TRUE, FALSE, Item);
                END;
            }
        }
        modify("<Action110>")
        {
            CaptionML = ENU = 'Event',
                                 ESM = 'Evento',
                                 FRC = 'v‚nement',
                                 ENC = 'Event';
        }
    }
    var
        "--FP--": Integer;
        // PostDocCU: Codeunit 14005058;  //B2BUPG
        // greNote: Record 14005020;      //B2BUPG
        EntryNo: Integer;
    // NotesT: Record 14005020;       //B2BUPG
}
