report 50060 "*** Update Warehouse Entry"
{
    Permissions = TableData "Warehouse Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") WHERE("Entry Type" = CONST(Sale), "Document Type" = CONST("Sales Shipment"), "Lot No." = FILTER(<> ''));
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord()
            begin
                WhsEntry.RESET;
                WhsEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
                WhsEntry.SETRANGE("Source No.", "Document No.");
                WhsEntry.SETRANGE("Item No.", "Item No.");
                WhsEntry.SETRANGE("Lot No.", "Lot No.");
                IF NOT (WhsEntry.ISEMPTY) THEN CurrReport.SKIP;

                ItemLedgEntry.SETRANGE("Item No.", "Item No.");
                ItemLedgEntry.SETRANGE("Lot No.", "Lot No.");
                ItemLedgEntry.CALCSUMS("Remaining Quantity");

                WhsEntry.RESET;
                WhsEntry.SETCURRENTKEY(
                  "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.",
                  "Serial No.", "Entry Type", Dedicated);
                WhsEntry.SETRANGE("Item No.", "Item No.");
                WhsEntry.SETRANGE("Lot No.", "Lot No.");

                WhsEntry.CALCSUMS(Quantity);
                IF WhsEntry.Quantity = ItemLedgEntry."Remaining Quantity" THEN CurrReport.SKIP;

                BinCode := '';
                TempWhsEntry.DELETEALL;

                IF WhsEntry.FINDSET THEN
                    REPEAT
                        IF WhsEntry."Bin Code" <> BinCode THEN BEGIN
                            BinCode := WhsEntry."Bin Code";
                            TempEntryNo += 1;
                            TempWhsEntry."Entry No." := TempEntryNo;
                            TempWhsEntry.Quantity := WhsEntry.Quantity;
                            TempWhsEntry."Bin Code" := WhsEntry."Bin Code";
                            TempWhsEntry."Unit of Measure Code" := WhsEntry."Unit of Measure Code";
                            TempWhsEntry."Expiration Date" := WhsEntry."Expiration Date";
                            TempWhsEntry.INSERT;

                        END ELSE BEGIN
                            TempWhsEntry.Quantity += WhsEntry.Quantity;
                            TempWhsEntry.MODIFY;
                        END;
                    UNTIL WhsEntry.NEXT = 0;

                TempWhsEntry.SETFILTER(Quantity, '>0');

                IF TempWhsEntry.COUNT = 1 THEN BEGIN
                    TempWhsEntry.FINDFIRST;
                    WhsEntry.INIT;
                    EntryNo += 1;
                    WhsEntry."Entry No." := EntryNo;
                    WhsEntry."Registering Date" := "Posting Date";
                    WhsEntry."Location Code" := "Location Code";
                    WhsEntry."Bin Code" := TempWhsEntry."Bin Code";
                    WhsEntry."Item No." := "Item No.";
                    WhsEntry.Quantity := -(ABS(Quantity));
                    WhsEntry."Qty. (Base)" := -(ABS(Quantity));
                    WhsEntry."Source Type" := DATABASE::"Sales Shipment Header";
                    WhsEntry."Source No." := "Document No.";
                    WhsEntry."Source Code" := 'SALES';
                    WhsEntry."Entry Type" := WhsEntry."Entry Type"::"Negative Adjmt.";
                    WhsEntry."Reference Document" := WhsEntry."Reference Document"::"Posted Shipment";
                    WhsEntry."Reference No." := "Document No.";
                    WhsEntry."Qty. per Unit of Measure" := 1;
                    WhsEntry."Unit of Measure Code" := TempWhsEntry."Unit of Measure Code";
                    WhsEntry."Lot No." := "Lot No.";
                    WhsEntry."Expiration Date" := TempWhsEntry."Expiration Date";
                    WhsEntry."User ID" := 'FIX';
                    WhsEntry.INSERT;
                END;
            end;

            trigger OnPreDataItem()
            begin
                ItemLedgEntry.SETCURRENTKEY(
                  "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
                WhsEntry.FINDLAST;
                EntryNo := WhsEntry."Entry No.";
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        BinCode: Code[20];
        EntryNo: Integer;
        ItemLedgEntry: Record "Item Ledger Entry";
        TempEntryNo: Integer;
        TempWhsEntry: Record "Warehouse Entry" temporary;
        WhsEntry: Record "Warehouse Entry";
}

