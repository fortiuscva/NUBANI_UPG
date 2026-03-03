tableextension 50013 ItemExt extends Item
{

    Caption = 'Item';
    fields
    {
        field(50000; "Unit Count"; Decimal)
        {
        }
        field(50003; "Inner UPC"; Text[20])
        {
            Description = 'NUB1.02 to use this field only in Sales Order.';
        }
        field(50006; "Item Selection"; Boolean)
        {
            Description = 'NUB1.01 To use this field only in Sales Order -> Item Selection process.';
        }
        field(50011; "Picture 2"; BLOB)
        {
            Caption = 'Picture 2';
            SubType = Bitmap;
        }
        field(50016; "Qty.  Per Pallet"; Decimal)
        {
            Description = 'NUB1.04';
        }
        field(50017; GMO; Boolean)
        {
        }
        field(60003; "Temp Blocked"; Boolean)
        {
            Description = 'FP';
        }
        field(60041; "Auto Enter Serial No. Master"; Boolean)
        {
            Description = 'FP';
        }
        field(60133; "Inventory on Date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Lot No." = FIELD("Lot No. Filter"), "Serial No." = FIELD("Serial No. Filter"), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Inventory As Of';
            DecimalPlaces = 0 : 5;
            Description = 'Same as Inventory Field with Date Filter Added';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60134; "Commission %"; Decimal)
        {
            Caption = 'Commission %';
            DecimalPlaces = 0 : 5;
        }

        /*field(14004410; "Check For Note"; Boolean)
        {
            Description = 'POPN';
        }
        field(14004411; "Pop-UP Notes"; Boolean)
        {
            //CalcFormula = Exist(note WHERE("No." = FIELD("No."), Type = FILTER("Customer" | "Vendor" | "Item"), Expired = CONST(false), Effective = CONST(true)));//B2BUpg
            Description = 'POPN';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14004412; "Make Note"; Boolean)
        {
            Description = 'POPN6.2';
        }*///B2BUPG
    }

}

