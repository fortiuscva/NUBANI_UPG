codeunit 50003 GetQuantityByItemLocLot_WS
{
    // // Created Function GetQuantityByItemLocLot
    // // Input: Item Number, Location Code, Lot Number
    // // Output: ReturnString
    // // ReturnString consists of a single return value in a Text[1000] field.
    // // 1A.  Return Code of 1 is returned if the no match is found OTHERWISE
    // // 1B.  Quantity
    // // 2B.  UOM


    trigger OnRun()
    begin
    end;


    procedure GetQuantityByItemLocationLot(ItemNo: Text[50]; LocationCode: Text[50]; LotNo: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        "Warehouse Entry": Record "Warehouse Entry";
        tempQuantity: Integer;
    begin
        // ReturnString consists of a single return value in a Text[1000] field.
        // 1A.  Return Code of 1 is returned if the no match is found OTHERWISE
        // 1B.  Quantity
        // 2B.  UOM

        BinContentRecord.SETRANGE("Location Code", LocationCode);
        BinContentRecord.SETRANGE("Item No.", ItemNo);

        IF BinContentRecord.FIND('-') THEN
            REPEAT

                "Warehouse Entry".SETRANGE("Location Code", LocationCode);
                "Warehouse Entry".SETRANGE("Item No.", BinContentRecord."Item No.");
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

