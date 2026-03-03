tableextension 50023 SalesLineArchiveExt extends "Sales Line Archive"
{
    // NU1.01,19-Feb-16,ST: Added new fields 50050/Commission Perc., 50051/Salesperson Code(flow field) to the table.
    // NUB1.02,04/24/19,ST: Modifications handled to track GMO fron item and use it on sales documents.
    //                        - Added field 50055/GMO.
    //                        - Added code in "No. - OnValidate()".
    Caption = 'Sales Line Archive';

   
    fields
    {
        modify("VAT %")
        {
            Caption = 'Tax %';
        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including Tax';
        }

        field(50050; "Commission Perc."; Decimal)
        {
            Caption = 'Commission Percentage';
            Description = 'NU1.01';
            Editable = false;
        }
        field(50051; "Salesperson Code"; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Header"."Salesperson Code" WHERE("No." = FIELD("Document No.")));
            Description = 'NU1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; GMO; Boolean)
        {
            Description = 'NUB1.02';
        }
    }

}

