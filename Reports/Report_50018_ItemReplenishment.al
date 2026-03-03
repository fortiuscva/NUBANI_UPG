report 50018 "Item Replenishment"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/ItemReplenishment.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Description";
            RequestFilterHeading = 'No.,SKU';
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Sku_Item; Item."Search Description")
            {
            }
            dataitem("Bin Content"; "Bin Content")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Location Code", "Bin Code";
                column(BinCode_BinContent; "Bin Content"."Bin Code")
                {
                }
                column(PickQty_BinContent; "Bin Content"."Pick Qty.")
                {
                }
                dataitem("Warehouse Entry"; "Warehouse Entry")
                {
                    DataItemLink = "Location Code" = FIELD("Location Code"), "Bin Code" = FIELD("Bin Code"), "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"), "Unit of Measure Code" = FIELD("Unit of Measure Code");
                    DataItemTableView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated) ORDER(Ascending);
                    column(LotNo_WHEntry; "Warehouse Entry"."Lot No.")
                    {
                    }
                    column(ExpirationDate_WHEntry; "Warehouse Entry"."Expiration Date")
                    {
                    }
                    column(Quantity_WHEntry; "Warehouse Entry".Quantity)
                    {
                    }
                }
            }
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
}

