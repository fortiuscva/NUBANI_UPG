report 50077 "Delete Empty Bin Contents"
{
    // NUB1.01,08/02/18,ST: Created a temp. report to delete the bin contents which are not in use.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Bin Content"; "Bin Content")
        {
            CalcFields = "Pick Quantity (Base)", "Negative Adjmt. Qty. (Base)", "Put-away Quantity (Base)", "Positive Adjmt. Qty. (Base)", "Quantity (Base)";
            DataItemTableView = SORTING("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") ORDER(Ascending) WHERE(Default = CONST(false), "Quantity (Base)" = CONST(0), "Pick Quantity (Base)" = CONST(0), "Negative Adjmt. Qty. (Base)" = CONST(0), "Put-away Quantity (Base)" = CONST(0), "Positive Adjmt. Qty. (Base)" = CONST(0));
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord()
            begin
                DeleteBinContentVarGbl := TRUE;
                BinContent := "Bin Content";
                BinContent.CALCFIELDS(
                  "Quantity (Base)", "Pick Quantity (Base)", "Negative Adjmt. Qty. (Base)",
                  "Put-away Quantity (Base)", "Positive Adjmt. Qty. (Base)");
                IF (BinContent."Quantity (Base)" <> 0) OR (BinContent."Pick Quantity (Base)" <> 0) OR (BinContent."Negative Adjmt. Qty. (Base)" <> 0) OR
                   (BinContent."Put-away Quantity (Base)" <> 0) OR (BinContent."Positive Adjmt. Qty. (Base)" <> 0) OR (BinContent.Default) THEN
                    DeleteBinContentVarGbl := FALSE;
                IF DeleteBinContentVarGbl THEN BEGIN
                    DELETE(TRUE);
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Update in progress...');
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
        BinContent: Record "Bin Content";
        DeleteBinContentVarGbl: Boolean;
        Window: Dialog;
}

