tableextension 50029 LotNumbersbyBinBuffer extends "Lot Bin Buffer"
{

    Caption = 'Lot Numbers by Bin Buffer';
    fields
    {

        field(50000; "Available Qty. to Take"; Decimal)
        {
            Description = 'NUB1.01';
            Editable = false;
        }
    }

}

