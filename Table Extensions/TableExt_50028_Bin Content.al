tableextension 50028 BinContentExt extends "Bin Content"
{
    //  NUB1.01,SP3166,12/19/13,Ak: Added new key by Bin Ranking.
    Caption = 'Bin Content';
    fields
    {
        modify("Location Code")
        {
            Caption = 'Location Code';

            //Unsupported feature: Property Modification (NotBlank) on ""Location Code"(Field 1)".

        }
        modify("Zone Code")
        {
            Caption = 'Zone Code';

            //Unsupported feature: Property Modification (NotBlank) on ""Zone Code"(Field 2)".


            //Unsupported feature: Property Modification (Editable) on ""Zone Code"(Field 2)".

        }
        modify("Bin Code")
        {
            TableRelation = IF ("Zone Code" = FILTER('')) Bin.Code WHERE("Location Code" = FIELD("Location Code")) ELSE IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"), "Zone Code" = FIELD("Zone Code"));
            Caption = 'Bin Code';

            //Unsupported feature: Property Modification (NotBlank) on ""Bin Code"(Field 3)".

        }
        modify("Item No.")
        {
            Caption = 'Item No.';

            //Unsupported feature: Property Modification (NotBlank) on ""Item No."(Field 4)".

        }
        modify("Bin Type Code")
        {
            Caption = 'Bin Type Code';

            //Unsupported feature: Property Modification (Editable) on ""Bin Type Code"(Field 10)".

        }
        modify("Warehouse Class Code")
        {
            Caption = 'Warehouse Class Code';

            //Unsupported feature: Property Modification (Editable) on ""Warehouse Class Code"(Field 11)".

        }
        modify("Block Movement")
        {
            Caption = 'Block Movement';
            OptionCaption = ' ,Inbound,Outbound,All';

            //Unsupported feature: Property Modification (OptionString) on ""Block Movement"(Field 12)".

        }
        modify("Min. Qty.")
        {
            Caption = 'Min. Qty.';
        }
        modify("Max. Qty.")
        {
            Caption = 'Max. Qty.';
        }
        modify("Bin Ranking")
        {
            Caption = 'Bin Ranking';

            //Unsupported feature: Property Modification (Editable) on ""Bin Ranking"(Field 21)".

        }
        modify(Quantity)
        {

            //Unsupported feature: Property Modification (CalcFormula) on "Quantity(Field 26)".

            Caption = 'Quantity';

            //Unsupported feature: Property Modification (Editable) on "Quantity(Field 26)".

        }
        modify("Pick Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Pick Qty."(Field 29)".

            Caption = 'Pick Qty.';

            //Unsupported feature: Property Modification (Editable) on ""Pick Qty."(Field 29)".

        }
        modify("Neg. Adjmt. Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Neg. Adjmt. Qty."(Field 30)".

            Caption = 'Neg. Adjmt. Qty.';

            //Unsupported feature: Property Modification (Editable) on ""Neg. Adjmt. Qty."(Field 30)".

        }
        modify("Put-away Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Put-away Qty."(Field 31)".

            Caption = 'Put-away Qty.';

            //Unsupported feature: Property Modification (Editable) on ""Put-away Qty."(Field 31)".

        }
        modify("Pos. Adjmt. Qty.")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Pos. Adjmt. Qty."(Field 32)".

            Caption = 'Pos. Adjmt. Qty.';

            //Unsupported feature: Property Modification (Editable) on ""Pos. Adjmt. Qty."(Field 32)".

        }
        modify("Fixed")
        {
            Caption = 'Fixed';
        }
        modify("Cross-Dock Bin")
        {
            Caption = 'Cross-Dock Bin';
        }
        modify(Default)
        {
            Caption = 'Default';
        }
        modify("Quantity (Base)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Quantity (Base)"(Field 50)".

            Caption = 'Quantity (Base)';



        }
        modify("Pick Quantity (Base)")
        {

            Caption = 'Pick Quantity (Base)';

        }
        modify("Negative Adjmt. Qty. (Base)")
        {

            Caption = 'Negative Adjmt. Qty. (Base)';


        }
        modify("Put-away Quantity (Base)")
        {

            Caption = 'Put-away Quantity (Base)';

            //Unsupported feature: Property Modification (Editable) on ""Put-away Quantity (Base)"(Field 53)".

        }
        modify("Positive Adjmt. Qty. (Base)")
        {

            Caption = 'Positive Adjmt. Qty. (Base)';

        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Qty. per Unit of Measure")
        {
            Caption = 'Qty. per Unit of Measure';

        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';



        }
        modify("Lot No. Filter")
        {
            Caption = 'Lot No. Filter';
        }
        modify("Serial No. Filter")
        {
            Caption = 'Serial No. Filter';
        }
        modify(Dedicated)
        {
            Caption = 'Dedicated';

        }
    }
    keys
    {


        key(Key50000; "Bin Ranking", Default, "Location Code", "Item No.", "Variant Code", "Bin Code")
        {
        }
    }


}










































