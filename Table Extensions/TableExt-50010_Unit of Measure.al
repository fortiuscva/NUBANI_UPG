tableextension 50010 UnitofMeasureExt extends "Unit of Measure"
{

    Caption = 'Unit of Measure';
    fields
    {
        modify("Code")
        {
            Caption = 'Code';

        }
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; "Pallet Per"; Decimal)
        {
            Description = 'NUB1.01';
        }
    }
    keys
    {

        

    }


}

