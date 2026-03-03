report 51000 "Test GetLotsByItemAndLocation"
{
    ProcessingOnly = true;

    dataset
    {
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

    trigger OnPreReport()
    var
        ItemNo: Code[50];
        BinCode: Code[20];
        LotNo: Code[20];
        Location: Text;
    begin
        // ItemNo := '00034000100255';
        //BinCode := '1130C3';
        //LotNo := '20140801';
        Location := 'BELLWOOD';
        ItemNo := '10028000011595'; //SKU- 01159
                                    //ItemNo :=  '072392902453'; //Sku - 90245
        BinCode := '0509C1';
        //  result :=  FORMAT(GetBinCodeQuantity.GetBinCodeQuantityByItemNo(ItemNo, Location) );
        //   MESSAGE(result);
        // result :=  FORMAT(GetBinCodeQuantity.GetLotsByItemAndLocation(ItemNo, Location) );
        // MESSAGE(result);
        // result :=  FORMAT(GetBinCodeQuantity.GetBinsByItemLotandLoc(ItemNo, Location, LotNo) );
        // MESSAGE(result);
        result := FORMAT(GetBinCodeQuantity.GetLotsByItemAndLocationBinCode(ItemNo, BinCode, Location));
        //  MESSAGE(result);
        //  result :=  FORMAT(GetBinCodeQuantity.CheckItemExists(ItemNo, Location) );
        //  MESSAGE(result);
        // result :=  FORMAT(GetBinCodeQuantity.GetInfoByItemBinLotLoc(ItemNo, BinCode, LotNo, Location) );
        MESSAGE(result);
    end;

    var
        GetBinCodeQuantity: Codeunit GetBinCodeQuantityByItemNo_WS;
        result: Text;
        PostIT: Codeunit PostChange_WS;
        ItemTracking: Codeunit GetItemByItemNo_WS;
}

