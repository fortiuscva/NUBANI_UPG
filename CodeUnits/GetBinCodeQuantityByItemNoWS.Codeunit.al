codeunit 50001 GetBinCodeQuantityByItemNo_WS
{
    // // DJW 02-20-2012 Begin
    // // Created Function GetBinCodeQuantityByItemNoLocation
    // // Input: Item Number, Location Code
    // // Output: ReturnString
    // // ReturnString consists of a semi-colon delimited Text[1000]
    // // Which contains the following fields where the Item Number and Location is found on the Item table:
    // // 1.  Return Code
    // // 2.  Bin Code
    // // 3.  Quantity
    // 
    // // WLB 08-15-2013
    // // Redesign using NAV 2013 Queries.
    // // GetLotsByItemAndLocation returns the available lots from the Warehouse Entry table.
    // // GetBinsByItemLotAndLoc returns the available bins from the Warehouse Entry table.
    // 
    // // WGS 12-11-2013
    // //Added GetBinCodeQuantityByItemNoBinCode function to filter on entered Bin Code as
    // 
    // // WGS 1/27/2014
    // Added Support to Exclude Product out on pick during movement


    trigger OnRun()
    var
        BinContentRecord: Record "Bin Content";
    begin
    end;

    var
        qryLotsByItemAndLocation: Query "WMS-LotsByItemAndLocation";
        WarehouseActivityLine: Record "Warehouse Activity Line";


    procedure GetBinCodeQuantityByItemNo(ItemNumber: Text[50]; LocationCode: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        tempQuantity: Decimal;
        "Warehouse Entry": Record "Warehouse Entry";
        WarehouseActivityLine: Record "Warehouse Activity Line";
        tempQuantityPicks: Decimal;
    begin
        // ReturnString consists of a semi-colon delimited Text[1000]
        // Which contains the following fields where the Item Number and Location is found on the Item table:
        // 1.  Return Code
        // 2.  Bin Code
        // 3.  Quantity
        // 4.  UOM
        // 5.  Quantity - Quantity on Pick


        BinContentRecord.SETRANGE("Location Code", LocationCode);
        BinContentRecord.SETRANGE("Item No.", ItemNumber);

        IF BinContentRecord.FIND('-') THEN
            REPEAT

                ReturnString += BinContentRecord."Bin Code" + ';';

                "Warehouse Entry".SETRANGE("Location Code", LocationCode);
                "Warehouse Entry".SETRANGE("Bin Code", BinContentRecord."Bin Code");
                "Warehouse Entry".SETRANGE("Item No.", BinContentRecord."Item No.");

                IF "Warehouse Entry".FIND('-') THEN
                    REPEAT

                        tempQuantity += "Warehouse Entry"."Qty. (Base)";

                    UNTIL "Warehouse Entry".NEXT = 0;

                //WGS - BEGIN
                WarehouseActivityLine.SETRANGE("Location Code", LocationCode);
                WarehouseActivityLine.SETRANGE("Bin Code", BinContentRecord."Bin Code");
                WarehouseActivityLine.SETRANGE("Item No.", BinContentRecord."Item No.");

                IF WarehouseActivityLine.FIND('-') THEN
                    REPEAT

                        tempQuantityPicks += WarehouseActivityLine.Quantity;

                    UNTIL WarehouseActivityLine.NEXT = 0;

                //WGS - END

                ReturnString += FORMAT(tempQuantity, 0, 2) + ';';

                ReturnString += "Warehouse Entry"."Unit of Measure Code" + ';';

                ReturnString += FORMAT(tempQuantity - tempQuantityPicks, 0, 2) + ';';

                tempQuantity := 0.0;

                //WGS - BEGIN
                tempQuantityPicks := 0.0;
            //WGS - END


            UNTIL BinContentRecord.NEXT = 0;


        IF ReturnString = '' THEN
            ReturnString := '1';
    end;


    procedure GetLotsByItemAndLocation(ItemNumber: Code[20]; LocationCode: Code[10]) ReturnString: Text[1000]
    var
        qryLotsByItemAndLocation: Query "WMS-LotsByItemAndLocation";
        pickQty: Decimal;
    begin

        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Item_No, ItemNumber);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Location_Code, LocationCode);

        qryLotsByItemAndLocation.OPEN;

        WHILE qryLotsByItemAndLocation.READ DO BEGIN
            pickQty := 0;
            ReturnString += qryLotsByItemAndLocation.Lot_No + ';';
            ReturnString += FORMAT(qryLotsByItemAndLocation.Expiration_Date) + ';';
            ReturnString += qryLotsByItemAndLocation.Bin_Code + ';';
            //WGS - BEGIN
            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base, 0, 2) + ';';
            //WGS - END
            ReturnString += qryLotsByItemAndLocation.Description + ';';
            ReturnString += qryLotsByItemAndLocation.Unit_of_Measure_Code + ';';


            //WGS - BEGIN
            WarehouseActivityLine.RESET;
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Item No.", qryLotsByItemAndLocation.Item_No);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Location Code", qryLotsByItemAndLocation.Location_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Bin Code", qryLotsByItemAndLocation.Bin_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Lot No.", qryLotsByItemAndLocation.Lot_No);
            IF WarehouseActivityLine.FIND('-') THEN
                REPEAT

                    pickQty += WarehouseActivityLine.Quantity;

                UNTIL WarehouseActivityLine.NEXT = 0;


            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base - pickQty, 0, 2) + ';';
            //WGS - END

        END;

        qryLotsByItemAndLocation.CLOSE;
    end;


    procedure GetBinsByItemLotAndLoc(ItemNumber: Code[20]; LocationCode: Code[10]; LotNo: Code[20]) ReturnString: Text[1000]
    var
        qryLotsByItemAndLocation: Query "WMS-LotsByItemAndLocation";
        pickQty: Decimal;
    begin

        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Item_No, ItemNumber);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Location_Code, LocationCode);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Lot_No, LotNo);

        qryLotsByItemAndLocation.OPEN;

        WHILE qryLotsByItemAndLocation.READ DO BEGIN
            pickQty := 0;
            ReturnString += qryLotsByItemAndLocation.Lot_No + ';';
            ReturnString += FORMAT(qryLotsByItemAndLocation.Expiration_Date) + ';';
            ReturnString += qryLotsByItemAndLocation.Bin_Code + ';';
            //WGS - BEGIN
            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base, 0, 2) + ';';
            //WGS - END
            ReturnString += qryLotsByItemAndLocation.Description + ';';
            ReturnString += qryLotsByItemAndLocation.Unit_of_Measure_Code + ';';

            //WGS - BEGIN
            WarehouseActivityLine.RESET;
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Item No.", qryLotsByItemAndLocation.Item_No);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Location Code", qryLotsByItemAndLocation.Location_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Bin Code", qryLotsByItemAndLocation.Bin_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Lot No.", qryLotsByItemAndLocation.Lot_No);
            IF WarehouseActivityLine.FIND('-') THEN
                REPEAT

                    pickQty += WarehouseActivityLine.Quantity;

                UNTIL WarehouseActivityLine.NEXT = 0;



            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base - pickQty, 0, 2) + ';';
            //WGS - END


        END;

        qryLotsByItemAndLocation.CLOSE;
    end;


    procedure GetLotsByItemAndLocationBinCode(ItemNumber: Text[50]; BinCode: Text[20]; LocationCode: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        tempQuantity: Decimal;
        "Warehouse Entry": Record "Warehouse Entry";
        pickQty: Decimal;
    begin
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Item_No, ItemNumber);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Location_Code, LocationCode);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Bin_Code, BinCode);

        qryLotsByItemAndLocation.OPEN;

        WHILE qryLotsByItemAndLocation.READ DO BEGIN
            pickQty := 0;
            ReturnString += qryLotsByItemAndLocation.Lot_No + ';';
            ReturnString += FORMAT(qryLotsByItemAndLocation.Expiration_Date) + ';';
            ReturnString += qryLotsByItemAndLocation.Bin_Code + ';';
            //WGS - BEGIN
            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base, 0, 2) + ';';
            //WGS - END
            ReturnString += qryLotsByItemAndLocation.Description + ';';
            ReturnString += qryLotsByItemAndLocation.Unit_of_Measure_Code + ';';

            //WGS - BEGIN
            WarehouseActivityLine.RESET;
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Item No.", qryLotsByItemAndLocation.Item_No);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Location Code", qryLotsByItemAndLocation.Location_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Bin Code", qryLotsByItemAndLocation.Bin_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Lot No.", qryLotsByItemAndLocation.Lot_No);
            IF WarehouseActivityLine.FIND('-') THEN
                REPEAT

                    pickQty += WarehouseActivityLine.Quantity;

                UNTIL WarehouseActivityLine.NEXT = 0;



            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base - pickQty, 0, 2) + ';';
            //WGS - END
        END;

        qryLotsByItemAndLocation.CLOSE;
    end;


    procedure CheckItemExists(ItemNo: Text; LocationCode: Text) exists: Boolean
    var
        BinContentRecord: Record "Bin Content";
    begin
        BinContentRecord.SETRANGE("Location Code", LocationCode);
        BinContentRecord.SETRANGE("Item No.", ItemNo);
        exists := NOT BinContentRecord.ISEMPTY;
    end;


    procedure GetInfoByItemBinLotLoc(ItemNumber: Text[50]; BinCode: Text[20]; LotNo: Text[20]; LocationCode: Text[50]) ReturnString: Text[1000]
    var
        BinContentRecord: Record "Bin Content";
        tempQuantity: Decimal;
        "Warehouse Entry": Record "Warehouse Entry";
        pickQty: Decimal;
    begin
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Item_No, ItemNumber);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Location_Code, LocationCode);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Bin_Code, BinCode);
        qryLotsByItemAndLocation.SETFILTER(qryLotsByItemAndLocation.Lot_No, LotNo);


        qryLotsByItemAndLocation.OPEN;

        WHILE qryLotsByItemAndLocation.READ DO BEGIN
            pickQty := 0;
            ReturnString += qryLotsByItemAndLocation.Lot_No + ';';
            ReturnString += FORMAT(qryLotsByItemAndLocation.Expiration_Date) + ';';
            ReturnString += qryLotsByItemAndLocation.Bin_Code + ';';
            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base, 0, 2) + ';';
            ReturnString += qryLotsByItemAndLocation.Description + ';';
            ReturnString += qryLotsByItemAndLocation.Unit_of_Measure_Code + ';';

            //WGS - BEGIN
            WarehouseActivityLine.RESET;
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Item No.", qryLotsByItemAndLocation.Item_No);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Location Code", qryLotsByItemAndLocation.Location_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Bin Code", qryLotsByItemAndLocation.Bin_Code);
            WarehouseActivityLine.SETFILTER(WarehouseActivityLine."Lot No.", qryLotsByItemAndLocation.Lot_No);
            IF WarehouseActivityLine.FIND('-') THEN
                REPEAT

                    pickQty += WarehouseActivityLine.Quantity;

                UNTIL WarehouseActivityLine.NEXT = 0;



            ReturnString += FORMAT(qryLotsByItemAndLocation.Sum_Qty_Base - pickQty, 0, 2) + ';';
            //WGS - END


        END;

        qryLotsByItemAndLocation.CLOSE;
    end;
}

