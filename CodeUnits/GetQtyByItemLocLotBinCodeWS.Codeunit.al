codeunit 50004 GetQtyByItemLocLotBinCode_WS
{
    // // Created Function GetQuantityByItemLocBinCode
    // // Input: Item Number, Location Code, BinCode
    // // Output: ReturnString
    // // ReturnString consists of a single return value in a Text[1000] field.
    // // Which contains the following fields where the Item Number Location and Lot No are found on the Item table:
    // // 1.  Return Code
    // // 2.  Quantity
    // // 3.  UOM


    trigger OnRun()
    begin
    end;


    procedure GetQuantityByItemLocBinCode(ItemNo: Text[50]; LocationCode: Text[50]; BinCode: Text[50]; LotNo: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        "Warehouse Entry": Record "Warehouse Entry";
        tempQuantity: Integer;
    begin
        // ReturnString consists of a single return value in a Text[1000] field.
        // Which contains the following fields where the Item Number Location and Lot No are found on the Item table:
        // 1.  Return Code
        // 2.  Quantity
        // 3.  UOM

        BinContentRecord.SETRANGE("Location Code", LocationCode);

        BinContentRecord.SETRANGE("Bin Code", BinCode);

        BinContentRecord.SETRANGE("Item No.", ItemNo);


        IF BinContentRecord.FIND('-') THEN
            REPEAT


                "Warehouse Entry".SETRANGE("Location Code", LocationCode);
                "Warehouse Entry".SETRANGE("Bin Code", BinContentRecord."Bin Code");
                "Warehouse Entry".SETRANGE("Item No.", BinContentRecord."Item No.");

                IF LotNo <> '' THEN
                    "Warehouse Entry".SETRANGE("Lot No.", LotNo);


                IF "Warehouse Entry".FIND('-') THEN
                    REPEAT

                        tempQuantity += "Warehouse Entry".Quantity;

                    UNTIL "Warehouse Entry".NEXT = 0;


                ReturnString += FORMAT(tempQuantity, 0, 2) + ';';

                tempQuantity := 0.0;
                ReturnString += BinContentRecord."Unit of Measure Code" + ';';

            UNTIL BinContentRecord.NEXT = 0;


        IF ReturnString = '' THEN
            ReturnString := '1';
    end;
}

