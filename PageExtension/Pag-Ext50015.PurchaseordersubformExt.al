namespace Nubani.Nubani;

using Microsoft.Purchases.Document;
using NubaniNubaniUPG.NubaniNubaniUPG;

pageextension 50015 "Purchase order subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
            ApplicationArea = All;
        }
        moveafter(Type; "Line No.")
        moveafter("No."; Description)
        moveafter(Description; "Description 2")

        addafter(Quantity)
        {
            field("Original Qty"; Rec."Original Qty")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Description 2"; "GST/HST")
        moveafter("Unit Price (LCY)"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Tax Area Code"; "Provincial Tax Area Code")
        moveafter("Provincial Tax Area Code"; "Tax Group Code")
        moveafter("Tax Group Code"; "Use Tax")
        modify("Promised Receipt Date")
        {
            Visible = true;
        }
        modify("Lead Time Calculation")
        {
            Visible = true;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = true;
        }
        moveafter("Promised Receipt Date"; "Order Date")
        moveafter("Order Date"; "Lead Time Calculation")
        moveafter("Planned Receipt Date"; "Inbound Whse. Handling Time")
        addafter("Expected Receipt Date")
        {
            field("Expected Receipt Time"; Rec."Expected Receipt Time")
            {
                ApplicationArea = All;
            }
        }
        //moveafter(ShortcutDimCode8; "IRS 1099 Liable")
        moveafter("Planned Receipt Date"; "Promised Receipt Date")



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
        modify("Event")
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
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries',
                                 ESM = 'Movs. &reserva',
                                 FRC = 'Entr‚es de r‚servation',
                                 ENC = 'Reservation Entries';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dime&nsiones',
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
        modify(ItemChargeAssignment)
        {
            CaptionML = ENU = 'Item Charge &Assignment',
                                 ESM = '&Asignaci¢n cargos prod.',
                                 FRC = '&Affectation frais annexes',
                                 ENC = 'Item Charge &Assignment';
        }
        addafter(ItemChargeAssignment)
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
        modify("E&xplode BOM")
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
                                 ESM = 'Se&guimiento pedido',
                                 FRC = '&Suivi de commande',
                                 ENC = 'Order &Tracking';
        }
        addafter(OrderTracking)
        {
            action("Update Item Description")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Update Item Description',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
                //Promoted = true;
                //PromotedIsBig = true;
                trigger OnAction()
                BEGIN
                    //NUB1.02 Start
                    Rec.UpdateItemDescription;
                    //NUB1.02 End
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
        modify("Sales &Order")
        {
            CaptionML = ENU = 'Sales &Order',
                                 ESM = '&Pedido venta',
                                 FRC = 'D&ocument de vente',
                                 ENC = 'Sales &Order';
        }
        modify("Speci&al Order")
        {
            CaptionML = ENU = 'Speci&al Order',
                                 ESM = '&Pedido especial',
                                 FRC = 'Commande sp‚ci&ale',
                                 ENC = 'Speci&al Order';
        }
        modify(Action1901038504)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Sales &Order',
                                 ESM = '&Pedido venta',
                                 FRC = 'D&ocument de vente',
                                 ENC = 'Sales &Order';
        }
        addlast("O&rder")
        {
            action(Action1900828904)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Purchase History';
            }
        }
        addlast(processing)
        {
            action(CreateSalesOrder)
            {
                Caption = 'Create Sales Order';
                ApplicationArea = All;
                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                begin
                    CurrPage.SetSelectionFilter(PurchaseLine);
                    Report.RunModal(Report::"Create Sales Order from PO", true, false, PurchaseLine);
                end;
            }
        }
    }

    var
        "--FP--": Integer;
    // LineLookupC: Codeunit 14005058;  //B2BUPG
    //NotesCU: Codeunit 14005020;  //B2BUPG

}
