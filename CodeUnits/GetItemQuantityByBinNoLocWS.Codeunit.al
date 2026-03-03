codeunit 50002 GetItemQuantityByBinNoLoc_WS
{
    // / Created Function GetItemQuantityByBinNoLocation
    // // Input: Bin Number, Location Code
    // // Output: ReturnString
    // // ReturnString consists of a semi-colon delimited Text[1000]
    // // Which contains the following fields where the Bin Code and Location is found on the Item table:
    // // 1.  Return Code
    // // 2.  Item Number
    // // 3.  Quantity
    // // 4.  UOM
    // // 5.  Item Description
    // 
    // WGS - SSI 1.01 - 12-23-2013 - REMOVE ZERO TOTALS FROM RETURN STRING


    trigger OnRun()
    begin
    end;


    procedure GetItemQuantityByBinNoLocation(BinNo: Text[50]; LocationCode: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        ItemRecord: Record Item;
        tempQuantity: Decimal;
        "Warehouse Entry": Record "Warehouse Entry";
    begin
        // ReturnString consists of a semi-colon delimited Text[1000]
        // Which contains the following fields where the Bin Code and Location is found on the Item table:
        // 1.  Return Code
        // 2.  Item Number
        // 3.  Quantity
        // 4.  UOM
        // 5.  Item Description

        BinContentRecord.SETRANGE("Location Code", LocationCode);
        BinContentRecord.SETRANGE("Bin Code", BinNo);

        IF BinContentRecord.FIND('-') THEN
            IF BinContentRecord."Bin Code" = BinNo THEN BEGIN

                REPEAT

                    "Warehouse Entry".SETRANGE("Location Code", LocationCode);
                    "Warehouse Entry".SETRANGE("Bin Code", BinContentRecord."Bin Code");
                    "Warehouse Entry".SETRANGE("Item No.", BinContentRecord."Item No.");

                    IF "Warehouse Entry".FIND('-') THEN
                        REPEAT

                            tempQuantity += "Warehouse Entry".Quantity;

                        UNTIL "Warehouse Entry".NEXT = 0;

                    //WGS - SSI 1.01 - Added Conditional - BEGIN
                    IF tempQuantity <> 0 THEN BEGIN
                        ReturnString := ReturnString + BinContentRecord."Item No." + ';';
                        ReturnString += FORMAT(tempQuantity, 0, 2) + ';';
                        ReturnString += "Warehouse Entry"."Unit of Measure Code" + ';';

                        tempQuantity := 0.0;

                        ItemRecord.SETRANGE("No.", BinContentRecord."Item No.");

                        IF ItemRecord.FIND('-') THEN BEGIN
                            ReturnString := ReturnString + ItemRecord.Description + ';';
                        END ELSE BEGIN
                            ReturnString := ReturnString + ';';
                        END;
                    END;
                //WGS - SSI 1.01 - Added Conditional - END

                UNTIL BinContentRecord.NEXT = 0;

            END;

        IF ReturnString = '' THEN
            ReturnString := '1';
    end;
}

