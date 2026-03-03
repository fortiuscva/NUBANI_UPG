reportextension 50000 "NUB Picking List Ext" extends "Picking List"//5752
{
    RDLCLayout = './Reports/Layout/Report5752_PickingList.rdl';
    dataset
    {

        // Add changes to dataitems and columns here
        add(WhseActLine)
        {
            column(BinOrder_Bin; BinRec."Bin Order")
            {
            }
            column(Warehouse_Activity_Line__Weight;
            WeightVar)
            {
            }
            column(WhseActLineExpirationDate; WhseActLineExpDate)
            {
            }
            column(TotalWtVarGbl; TotalWtVarGbl)
            {
            }
            column(TotalQtyBseVarGbl; TotalQtyBseVarGbl)
            {
            }
        }
        add("Warehouse Activity Header")
        {
            column(PickNo; '*' + "Warehouse Activity Header"."No." + '*')
            {
            }
            column(PickNoBarcode; EncodeBarcode("Warehouse Activity Header"."No."))
            {
            }
            column(SOQtyVarGbl; SOQtyVarGbl)
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustNo; CustNo)
            {
            }
            column(SalesHead_No; "Warehouse Activity Header"."Source No.")
            {
            }
            column(NoofLines_WhseActivHeader; "Warehouse Activity Header"."No. of Lines")
            {
            }
        }
        modify("Warehouse Activity Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                //NUB1.01 Start
                CLEAR(TotalWtVarGbl);
                CLEAR(TotalQtyBseVarGbl);
                //NUB1.01 End
                CLEAR(CustNo);
                CLEAR(CustName);
                IF "Destination Type" = "Destination Type"::Customer THEN BEGIN
                    IF CustRec.GET("Destination No.") THEN BEGIN
                        CustNo := CustRec."No.";
                        CustName := CustRec.Name;
                    END;
                END ELSE IF "Destination Type" = "Destination Type"::"Sales Order" THEN BEGIN
                    SalesHead.RESET;
                    SalesHead.SETRANGE("No.", "Warehouse Activity Header"."Destination No.");
                    IF SalesHead.FINDFIRST THEN BEGIN
                        IF CustRec.GET(SalesHead."Sell-to Customer No.") THEN BEGIN
                            CustNo := CustRec."No.";
                            CustName := CustRec.Name;
                        END;
                    END;
                END;
                //NUB1.02 Start
                CLEAR(SOQtyVarGbl);
                SalesLineRecGbl.RESET;
                SalesLineRecGbl.SETRANGE("Document No.", "Source No.");
                SalesLineRecGbl.SETFILTER(Quantity, '<>%1', 0);
                IF SalesLineRecGbl.FINDSET THEN BEGIN
                    SalesLineRecGbl.CALCSUMS(Quantity);
                    SOQtyVarGbl := SalesLineRecGbl.Quantity;
                END;
                //NUB1.02 End
            end;
        }
        modify(WhseActLine)
        {
            trigger OnAfterAfterGetRecord()
            begin
                CLEAR(WeightVar);
                IF ItemRec.GET(WhseActLine."Item No.") THEN
                    WeightVar := WhseActLine.Quantity * ItemRec."Net Weight";

                CLEAR(WhseActLineExpDate);
                ILERec.RESET;
                ILERec.SETRANGE("Item No.", WhseActLine."Item No.");
                ILERec.SETRANGE("Lot No.", WhseActLine."Lot No.");
                IF ILERec.FINDFIRST THEN BEGIN
                    WhseActLineExpDate := ILERec."Expiration Date";
                END;
                IF "Bin Code" <> '' THEN BEGIN
                    BinRec.GET("Location Code", "Bin Code");
                END ELSE
                    BinRec.RESET;
                //NUB1.01 Start
                TotalWtVarGbl += WeightVar;
                TotalQtyBseVarGbl += "Qty. (Base)";
                //NUB1.01 End
            end;
        }
    }
    var
        TotalWtVarGbl: Decimal;
        TotalQtyBseVarGbl: Decimal;
        SOQtyVarGbl: Decimal;
        SalesLineRecGbl: Record "Sales Line";
        WeightVar: Decimal;
        ItemRec: Record Item;
        BinRec: Record Bin;
        CustNo: Code[20];
        CustName: Text;
        CustRec: Record Customer;
        SalesHead: Record "Sales Header";
        WhseActLineExpDate: Date;
        ILERec: Record "Item Ledger Entry";

    local procedure EncodeBarcode(InputTxt: Text): Text
    var
        BarcodeString: Text;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
    begin
        // Declare the barcode provider using the barcode provider interface and enum
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;

        // Declare the font using the barcode symbology enum
        BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";

        // Set data string source
        BarcodeString := '*' + InputTxt + '*';

        // Validate the input. This method is not available for 2D provider
        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);

        // Encode the data string to the barcode font
        exit(BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology));
    end;

}