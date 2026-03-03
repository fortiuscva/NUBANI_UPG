codeunit 50022 "Delete Bins"
{
    TableNo = "Delete Bins";

    trigger OnRun()
    begin
        BinRecGbl.RESET;
        BinRecGbl.SETRANGE(Code, Rec."Bin Code");
        IF BinRecGbl.FINDSET THEN
            REPEAT
                BinRecGbl.DELETE(TRUE);
            UNTIL BinRecGbl.NEXT = 0;
    end;

    var
        BinRecGbl: Record Bin;
}

