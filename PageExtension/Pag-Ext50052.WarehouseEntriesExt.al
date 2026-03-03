namespace Nubani.Nubani;

using Microsoft.Warehouse.Ledger;

pageextension 50052 "Warehouse Entries Ext" extends "Warehouse Entries"
{
    CaptionML = ENU = 'Warehouse Entries',
               ESM = 'Movimientos almac‚n',
               FRC = 'critures d entrep“t',
               ENC = 'Warehouse Entries';

    actions
    {
        addafter("Package No. Information Card")
        {
            action("Update Quantity")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                VAR
                    WhseEntryRecLcl: Record "Warehouse Entry";
                BEGIN
                    WhseEntryRecLcl.RESET;
                    WhseEntryRecLcl.SETRANGE("Entry No.", Rec."Entry No.");
                    WhseEntryRecLcl.FINDFIRST;
                    REPORT.RUNMODAL(REPORT::"Change Quantity on Warehouse", TRUE, FALSE, WhseEntryRecLcl);
                END;
            }

        }
    }
}
