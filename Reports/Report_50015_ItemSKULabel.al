report 50015 "Item SKU Label"
{
    // NUB1.01,10/25/19,SK: Created new report.
    //         10/30/19,SK: Adjusted the report layout as user required.
    //         11/11/19,SK: Adjusted the report layout as user required.
    // NUB1.02,03/05/2020,SK: Adjusted the font at report layout as user required.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/ItemSKULabel.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE(Blocked = CONST(false));
            RequestFilterFields = "No.";
            column(No_Item; Item."No.")
            {
            }
            column(SearchDescription_Item; Item."Search Description")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(BB_Caption; BB_CaptionLbl)
            {
            }
            column(LotNoVar; LotNoVar)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LotNumberByBinQuery.SETRANGE(Item_No, "No.");
                LotNumberByBinQuery.OPEN;

                WHILE LotNumberByBinQuery.READ DO BEGIN
                    TempWarehouseEntryGRec.INIT;
                    TempWarehouseEntryGRec."Entry No." += 1;
                    TempWarehouseEntryGRec."Item No." := LotNumberByBinQuery.Item_No;
                    TempWarehouseEntryGRec."Lot No." := LotNumberByBinQuery.Lot_No;
                    TempWarehouseEntryGRec.INSERT;
                END;

                TempWarehouseEntryGRec.SETCURRENTKEY("Lot No.");
                IF TempWarehouseEntryGRec.FINDSET THEN BEGIN
                    REPEAT
                        IF PrevLotNo <> TempWarehouseEntryGRec."Lot No." THEN BEGIN
                            PrevLotNo := TempWarehouseEntryGRec."Lot No.";
                            IF LotNoVar <> '' THEN
                                LotNoVar := LotNoVar + ',' + COPYSTR(TempWarehouseEntryGRec."Lot No.", 5, 2) + '/' + COPYSTR(TempWarehouseEntryGRec."Lot No.", 1, 4)
                            ELSE
                                LotNoVar := COPYSTR(TempWarehouseEntryGRec."Lot No.", 5, 2) + '/' + COPYSTR(TempWarehouseEntryGRec."Lot No.", 1, 4)
                        END;
                    UNTIL TempWarehouseEntryGRec.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                LotNumberByBinQuery.CLOSE;
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
        BB_CaptionLbl: Label 'B B ';
        LotNumberByBinQuery: Query "Lot Numbers by Bin";
        LotNoVar: Code[1024];
        PrevLotNo: Code[20];
        TempWarehouseEntryGRec: Record "Warehouse Entry" temporary;


    procedure GetLotNumberByBins()
    begin
    end;
}

