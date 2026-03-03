namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50021 "posted sales  shpt. subform" extends "Posted Sales Shpt. Subform"
{
    CaptionML = ENU = 'Lines',
               ESM = 'L¡neas',
               FRC = 'Lignes',
               ENC = 'Lines';
    // InsertAllowed = false;  //B2BUPG
    // DeleteAllowed = false;
    layout
    {
        modify("No.")
        {
            Editable = FALSE;
        }
        modify("Variant Code")
        {
            Editable = FALSE;
        }
        modify(Description)
        {
            Editable = FALSE;
        }
        addafter(Description)
        {
            field("Qty.  Per Pallet"; Rec."Qty.  Per Pallet")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Return Reason Code"; "Package Tracking No.")
        modify("Location Code")
        {
            Editable = FALSE;
        }
        modify(Quantity)
        {
            Editable = FALSE;
        }
        modify("Unit of Measure Code")
        {
            Editable = FALSE;
        }
        modify("Unit of Measure")
        {
            Editable = FALSE;
        }
        modify("Quantity Invoiced")
        {
            Editable = FALSE;
        }
        modify("Job No.")
        {
            Editable = FALSE;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = FALSE;
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        // addbefore("Order Tra&cking")
        // {
        //     action("&Track Package")
        //     {
        //         CaptionML = ENU = '&Track Package',
        //                          ESM = 'Seguimiento pa&quete',
        //                          FRC = '&Retracer livraison',
        //                          ENC = '&Track Package';
        //         Image = ItemTracking;
        //         trigger OnAction()
        //         BEGIN
        //             StartTrackingSite;
        //         END;
        //     }
        // }//B2BUPG
        modify("Order Tra&cking")
        {
            CaptionML = ENU = 'Order Tra&cking',
                                 ESM = '&Seguimiento pedido',
                                 FRC = '&Suivi de commande',
                                 ENC = 'Order Tra&cking';
        }
        modify(UndoShipment)
        {
            CaptionML = ENU = '&Undo Shipment',
                                 ESM = '&Deshacer env¡o',
                                 FRC = '&Annuler livraison',
                                 ENC = '&Undo Shipment';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(ItemTrackingEntries)
        {
            CaptionML = ENU = 'Item &Tracking Entries',
                                 ESM = 'Movs. &seguim. prod.',
                                 FRC = 'critures de &tra‡abilit‚',
                                 ENC = 'Item &Tracking Entries';
        }
        modify("Assemble-to-Order")
        {
            CaptionML = ENU = 'Assemble-to-Order',
                                 ESM = 'Ensamblar para pedido',
                                 FRC = 'Assembler pour commande',
                                 ENC = 'Assemble-to-Order';
        }
        modify(ItemInvoiceLines)
        {
            CaptionML = ENU = 'Item Invoice &Lines',
                                 ESM = '&L¡n. factura productos',
                                 FRC = '&Lignes de facture d article',
                                 ENC = 'Item Invoice &Lines';
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"Shipment Line - Edit", Rec);
        EXIT(FALSE);
    end;
}
