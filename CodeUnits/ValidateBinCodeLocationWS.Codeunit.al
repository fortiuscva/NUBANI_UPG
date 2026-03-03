codeunit 50005 ValidateBinCodeLocation_WS
{
    // // Created Function ValidateBinCodeLocation
    // // Input:  Bin Code, Location Code
    // // Output: ReturnString
    // // ReturnString consists of a single return value in a Text[1000] field.
    // // 1.  Return Code.  Value of '0' means that the Bin Code + Location Code combination
    // //    was found on the items table.  Value of '1' means that it was not.


    trigger OnRun()
    begin
    end;


    procedure ValidateBinCodeLocation(NewBinCode: Text[50]; LocationCode: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
    begin
        // ReturnString consists of a single return value in a Text[1000] field.
        // 1.  Return Code.  Value of '0' means that the Bin Code + Location Code combination
        //    was found on the items table.  Value of '1' means that it was not.

        BinContentRecord.SETRANGE("Location Code", LocationCode);

        IF BinContentRecord.FIND('-') THEN
            REPEAT
                IF (BinContentRecord."Bin Code" = NewBinCode) THEN BEGIN

                    ReturnString := '0';
                END;

            UNTIL BinContentRecord.NEXT = 0;

        IF ReturnString = '' THEN
            ReturnString := '1';
    end;
}

