namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50010 "sales list Ext" extends "Sales List"
{
    CaptionML = ENU = 'Sales List',
               ESM = 'Lista documentos venta',
               FRC = 'Liste des ventes',
               ENC = 'Sales List';
    layout
    {
        addbefore("No.")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Sell-to Customer Name"; Status)
        addafter(Status)
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        addafter(Amount)
        {
            field("Lines Shipped Not Invoiced"; Rec."Lines Shipped Not Invoiced")
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
        // modify(Card)
        // {
        //     CaptionML = ENU = 'Card',
        //                          ESM = 'Ficha',
        //                          FRC = 'Fiche',
        //                          ENC = 'Card';
        // }
        addafter(ShowDocument)
        {
            group("&Print")
            {
                CaptionML = ENU = '&Print',
                                 ESM = '&Print',
                                 FRC = '&Print',
                                 ENC = '&Print';
            }
        }
        addlast("&Print")
        {
            action("Print Document")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Print Document';
            }
            action("Order Confirmation")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Order Confirmation',
                                 ESM = 'Order Confirmation',
                                 FRC = 'Order Confirmation',
                                 ENC = 'Order Confirmation';
                Image = Print;
            }
            action("Work Order")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Work Order',
                                 ESM = 'Work Order',
                                 FRC = 'Work Order',
                                 ENC = 'Work Order';
                Image = Print;

            }
        }
        modify("Sales Reservation Avail.")
        {
            CaptionML = ENU = 'Sales Reservation Avail.',
                                 ESM = 'Disponib. reserva venta',
                                 FRC = 'Dispo. r‚servation ventes',
                                 ENC = 'Sales Reservation Avail.';
        }
    }

    trigger OnOpenPage()
    begin
        //NUB1.01 Start
        IF EventsandSubscribers.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventsandSubscribers.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    END;

    Var
        FPText000: TextConst ENU = 'Order Confirmation only works on Order documents.';
        FPText001: TextConst ENU = 'Work Orders only works on Order documents.';
        DocPrint: Codeunit 229;
        FPText002: TextConst ENU = 'You must post Invoices to Print them.';
        FPText003: TextConst ENU = 'You must post Credit Memos to Print them.';
        ShowDocVisible: Boolean;
        UserMgt: Codeunit 5700;
        EventsandSubscribers: codeunit EventsandSubscribers;

}
