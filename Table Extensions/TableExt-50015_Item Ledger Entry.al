tableextension 50015 ItemLedgerEntryExt extends "Item Ledger Entry"
{

    Caption = 'Item Ledger Entry';
    fields
    {

        field(50000; "NUB Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            Description = 'NUB1.02';
            TableRelation = "Reason Code";
        }
    }
    keys
    {

        key(Key50001; "Posting Date", "Entry Type")
        {
        }
        key(Key50002; "Item No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Variant Code", "Posting Date")
        {
            SumIndexFields = "Remaining Quantity";
        }
        key(Key50003; "Item No.", "Location Code")
        {
        }
        key(Key50004; "Expiration Date")
        {
        }
    }
    procedure DrillDownOnEntries(var ValueEntryT: Record "Value Entry")
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        //FP
        ItemLedgEntry.RESET;
        ValueEntryT.COPYFILTER("Item No.", ItemLedgEntry."Item No.");
        ValueEntryT.COPYFILTER("Location Code", ItemLedgEntry."Location Code");
        ValueEntryT.COPYFILTER("Variant Code", ItemLedgEntry."Variant Code");
        ValueEntryT.COPYFILTER("Global Dimension 1 Code", ItemLedgEntry."Global Dimension 1 Code");
        ValueEntryT.COPYFILTER("Global Dimension 2 Code", ItemLedgEntry."Global Dimension 2 Code");
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Posting Date");
        ItemLedgEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
        PAGE.RUN(0, ItemLedgEntry, "Remaining Quantity");
    end;
}



