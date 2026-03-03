namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50011 "sales order subform EXt" extends "Sales Order Subform"
{

    CaptionML = ENU = 'Lines',
               ESM = 'L¡neas',
               FRC = 'Lignes',
               ENC = 'Lines';
    layout
    {
        moveafter("IC Partner Code"; "Net Weight")
        addafter("Substitution Available")
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Commission Perc."; Rec."Commission Perc.")
            {
                ApplicationArea = All;
            }
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description Other',
                           ESM = 'Descripci¢n 2',
                           FRC = 'Description 2',
                           ENC = 'Description 2';

        }
        addafter("Description 2")
        {
            field("Qty.  Per Pallet"; Rec."Qty.  Per Pallet")
            {
                ApplicationArea = All;
            }
        }


        moveafter("Return Reason Code"; "Package Tracking No.")
        addafter(Quantity)
        {
            field(qtytohandle; qtytohandle)
            {
                CaptionML = ENU = 'Qty. to Handle';
                ApplicationArea = All;
                Editable = false;

            }
        }
        addafter(qtytohandle)
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
        modify(SalesPriceExist)
        {
            CaptionML = ENU = 'Sales Price Exists',
                           ESM = 'Existe precio venta',
                           FRC = 'Prix de vente existant',
                           ENC = 'Sales Price Exists';
            Editable = false;
            Visible = false;
        }
        addafter("Unit Price")
        {
            field(Each; Rec.Each)
            {
                ApplicationArea = All;
                DecimalPlaces = 2 : 4;
            }
        }
        addafter(Each)
        {
            field(GMO; Rec.GMO)
            {
                ApplicationArea = All;
            }
        }
        moveafter(GMO; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Tax Group Code")

        moveafter("Line Amount"; "Amount Including VAT")
        modify(SalesLineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists',
                           ESM = 'Existe dto. l¡nea venta',
                           FRC = 'Rem. ligne vente existante',
                           ENC = 'Sales Line Disc. Exists';
        }
        moveafter("Shipment Date"; "Outbound Whse. Handling Time")
        moveafter("Outbound Whse. Handling Time"; "Planned Shipment Date")
        moveafter("Planned Shipment Date"; "Shipping Time")
        moveafter("Shipping Time"; "Planned Delivery Date")
        modify("Planned Delivery Date")
        {
            QuickEntry = false;
        }
        addafter("Line No.")
        {
            field("Inner UPC"; Rec."Inner UPC")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by',
                                 ESM = 'Disponibilidad prod. por',
                                 FRC = 'Disponibilit‚ d article par',
                                 ENC = 'Item Availability by';
        }
        modify("<Action3>")
        {
            CaptionML = ENU = 'Event',
                                 ESM = 'Evento',
                                 FRC = 'v‚nement',
                                 ENC = 'Event';
        }
        modify(ItemAvailabilityByVariant)
        {
            CaptionML = ENU = 'Variant',
                                 ESM = 'Variante',
                                 FRC = 'Variante',
                                 ENC = 'Variant';
        }
        modify(ItemAvailabilityByLocation)
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
        addafter("BOM Level")
        {
            action("Check Avaliability")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Check Avaliability';
                Image = ViewDetails;

            }
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. &reserva',
                                 FRC = 'Entr‚es de r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        modify(SelectItemSubstitution)
        {
            CaptionML = ENU = 'Select Item Substitution',
                                 ESM = 'Seleccionar prod. alternativo',
                                 FRC = 'S‚lectionner la substitution d article',
                                 ENC = 'Select Item Substitution';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'D&imensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment',
                                 ESM = '&Asignaci¢n cargos prod.',
                                 FRC = '&Affectation frais annexes',
                                 ENC = 'Item Charge &Assignment';
        }
        modify(OrderPromising)
        {
            CaptionML = ENU = 'Order &Promising',
                                 ESM = 'Comprom&iso entrega',
                                 FRC = '&Promesse de livraison',
                                 ENC = 'Order &Promising';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order',
                                 ESM = 'Ensamblar para pedido',
                                 FRC = 'Assembler pour commande',
                                 ENC = 'Assemble to Order';
        }
        modify(AssembleToOrderLines)
        {
            CaptionML = ENU = 'Assemble-to-Order Lines',
                                 ESM = 'Ensamblar para l¡neas de pedido',
                                 FRC = 'Lignes Assembler pour commande',
                                 ENC = 'Assemble-to-Order Lines';
        }
        modify("Roll Up &Price")
        {
            CaptionML = ENU = 'Roll Up &Price',
                                 ESM = 'Revertir &precio',
                                 FRC = '&Prix relation',
                                 ENC = 'Roll Up &Price';
        }
        modify("Roll Up &Cost")
        {
            CaptionML = ENU = 'Roll Up &Cost',
                                 ESM = 'Distribuir &costo',
                                 FRC = '&Co–ts relation',
                                 ENC = 'Roll Up &Cost';
        }
        addafter("Roll Up &Cost")
        {
            action("Pop-&Up Notes")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Pop-&Up Notes';

            }
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(GetPrices)
        {
            CaptionML = ENU = 'Get Price',
                                 ESM = 'Tomar precio',
                                 FRC = 'Obtenir le prix',
                                 ENC = 'Get Price';
        }
        modify(GetLineDiscount)
        {
            CaptionML = ENU = 'Get Li&ne Discount',
                                 ESM = 'Tomar descuento l¡&nea',
                                 FRC = 'Obtenir l escompte de li&gne',
                                 ENC = 'Get Li&ne Discount';
        }
        modify(ExplodeBOM_Functions)
        {
            CaptionML = ENU = 'E&xplode BOM',
                                 ESM = '&Desplegar L.M.',
                                 FRC = '&clater nomenclature',
                                 ENC = 'E&xplode BOM';
        }
        modify("Insert Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Texts',
                                 ESM = 'Insertar &textos adicionales',
                                 FRC = 'Ins‚rer texte ‚tendu',
                                 ENC = 'Insert &Ext. Text';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve',
                                 ESM = '&Reservar',
                                 FRC = '&R‚server',
                                 ENC = '&Reserve';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking',
                                 ESM = '&Seg. pedido',
                                 FRC = '&Suivi de commande',
                                 ENC = 'Order &Tracking';
        }
        addlast("F&unctions")
        {
            action("Regular Items")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Regular Items';
                Image = ItemGroup;
                trigger OnAction()
                VAR
                    RegularItemsPage: Page "Regular Items";
                    SalesHeaderRecGbl: Record "Sales Header";
                BEGIN
                    //NUB1.01 Start
                    IF SalesHeaderRecGbl.GET(Rec."Document Type", Rec."Document No.") THEN
                        SalesHeaderRecGbl.TESTFIELD(Status, SalesHeader.Status::Open);

                    CLEAR(RegularItemsPage);
                    RegularItemsPage.SetValues(Rec."Document Type", Rec."Document No.");
                    RegularItemsPage.RUN;
                    //NUB1.01 End
                END;
            }
            action("Item Selection")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Item Selection';
                //Promoted = true;
                //PromotedIsBig = true;
                Image = ItemLines;
                //PromotedCategory = Process;
                trigger OnAction()
                VAR
                    ItemSelectionPage: Page "Item Selection";
                    SalesHeaderRecGbl: Record "Sales Header";
                BEGIN
                    //NUB1.01 Start
                    IF SalesHeaderRecGbl.GET(Rec."Document Type", Rec."Document No.") THEN
                        SalesHeaderRecGbl.TESTFIELD(Status, SalesHeader.Status::Open);

                    CLEAR(ItemSelectionPage);
                    ItemSelectionPage.SetValues(Rec."Document Type", Rec."Document No.");
                    ItemSelectionPage.RUN;
                    //NUB1.01 End
                END;
            }
        }
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder',
                                 ESM = '&Pedido',
                                 FRC = '&Commande',
                                 ENC = 'O&rder';
        }
        modify("Dr&op Shipment")
        {
            CaptionML = ENU = 'Dr&op Shipment',
                                 ESM = 'Env¡&o directo',
                                 FRC = '&Livraison directe',
                                 ENC = 'Dr&op Shipment';
        }
        modify("Purchase &Order")
        {
            CaptionML = ENU = 'Purchase &Order',
                                 ESM = 'Pedido de &compra',
                                 FRC = 'Bon de c&ommande',
                                 ENC = 'Purchase &Order';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order',
                                 ESM = '&Pedido especial',
                                 FRC = 'Commande sp‚ci&ale',
                                 ENC = 'Speci&al Order';
        }
        modify(OpenSpecialPurchaseOrder)
        {
            CaptionML = ENU = 'Purchase &Order',
                                 ESM = 'Pedido de &compra',
                                 FRC = 'Bon de c&ommande',
                                 ENC = 'Purchase &Order';
        }
        addlast("O&rder")
        {
            action(Action1900489704)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales History';
                trigger OnAction()
                begin
                    GetItemHistory;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    VAR
        resentry: Record 337;
    begin
        qtytohandle := 0;
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            resentry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
            resentry.SETRANGE("Source ID", Rec."Document No.");
            resentry.SETRANGE("Source Ref. No.", Rec."Line No.");
            resentry.CALCSUMS("Qty. to Handle (Base)");
            qtytohandle := ABS(resentry."Qty. to Handle (Base)");
        END;
    end;

    procedure GetItemHistory()
    begin
        LineLookupC.GetSalesLineHistory(Rec);
    end;

    var
        qtytohandle: Decimal;
        "--FP--": Integer;
        LineLookupC: Codeunit "Posting Doc.Line Reporting";
        "--FP7.0.15--": Integer;
        ItemCheckAvail: Codeunit 311;
        "--POPN--": Integer;
        // NotesCU: Codeunit 14005020;    //B2BUPG
        SalesHeader: Record "Sales Header";

}
