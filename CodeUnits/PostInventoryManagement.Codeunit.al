codeunit 50008 PostInventoryManagement
{
    // // DJW New Function
    // // Called by Codeunit 50006 PostChange_WS


    trigger OnRun()
    begin
    end;


    procedure PostWarehouseInventory(ItemJournalLine: Record "Item Journal Line")
    var
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin


        // Verify that the New Record is in the table
        ItemJournalLine.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ItemJournalLine.SETRANGE("Bin Code", ItemJournalLine."Bin Code");
        ItemJournalLine.SETRANGE("New Bin Code", ItemJournalLine."New Bin Code");
        ItemJournalLine.SETRANGE("Posting Date", ItemJournalLine."Posting Date");

        // Post the record to the Item Journal-Post Batch Codeunit #23
        ItemJnlPostBatch.RUN(ItemJournalLine);
    end;
}

