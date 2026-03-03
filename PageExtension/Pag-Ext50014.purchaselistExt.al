namespace Nubani.Nubani;

using Microsoft.Purchases.Document;

pageextension 50014 "purchase list Ext" extends "Purchase List"
{
    CaptionML = ENU = 'Purchase List',
               ESM = 'Lista documentos compra',
               FRC = 'Liste des achats',
               ENC = 'Purchase List';
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt Date")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
        /* addafter(Status)
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        } */
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
            action("&Print")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = '&Print',
                                 ESM = '&Print',
                                 FRC = '&Print',
                                 ENC = '&Print';
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Process;
                trigger OnAction()
                VAR
                    "--  FP  --": Integer;
                    DocPrint: Codeunit 229;
                    Usage: Option "Order Confirmation","Work Order";
                BEGIN
                    DocPrint.PrintPurchHeader(Rec);
                END;
            }
        }
        modify("Purchase Reservation Avail.")
        {
            CaptionML = ENU = 'Purchase Reservation Avail.',
                                 ESM = 'Reserva compra disp.',
                                 FRC = 'Dispo. r‚servation achats',
                                 ENC = 'Purchase Reservation Avail.';
        }
    }
    trigger OnOpenPage()
    begin
        BEGIN
            //FP
            //ShowDocVisible := ISSERVICETIER;
            //FP
        END;
    end;

    var
        ShowDocVisible: Boolean;
}
