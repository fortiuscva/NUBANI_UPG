report 50065 "Update Reason Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/UpdateReasonCode.rdl';
   UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER("Positive Adjmt." | "Negative Adjmt."));

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Item Ledger Entry"."Entry No.");
                ValueEntryRec.RESET;
                ValueEntryRec.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                ValueEntryRec.SETFILTER("Reason Code", '<>%1', '');
                IF ValueEntryRec.FINDFIRST THEN BEGIN
                    "Item Ledger Entry"."Reason Code" := ValueEntryRec."Reason Code";
                    "Item Ledger Entry".MODIFY;

                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('Completed');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('###1##########');
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
        ValueEntryRec: Record "Value Entry";
        Window: Dialog;
}

