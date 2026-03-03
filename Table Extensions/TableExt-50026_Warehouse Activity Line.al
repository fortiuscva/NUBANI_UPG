tableextension 50026 WarehouseActivityLineExt extends "Warehouse Activity Line"
{
    // //FP6.2  Added the ability to handle quantity over the quantity if
    //          Qty. to handle" falls within the tolerances set in Defaults setup.
    // 
    // ----------------------------------------------------------------------------
    // 
    // NUB1.01 ???
    // 
    // NUB1.02,12/30/13,OAS: Filter for lot when checking bin available.

    Caption = 'Warehouse Activity Line';
    fields
    {
        modify(Quantity)
        {
            Caption = 'Quantity';
            trigger OnAfterValidate()
            begin
                VALIDATE("Qty. to Handle", (Quantity - "Qty. Handled"));
            end;
        }
        modify("Bin Code")
        {
            Caption = 'Bin Code';
            trigger OnAfterValidate()
            var
                Text_BinQty: Label 'The %1 %2 exceeds the quantity available to pick %3 of the %4.';
            begin

            end;
        }
        field(50000; "Pick Qty."; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50006; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            Description = 'NUB1.02';
        }
    }
    procedure CheckIfTaxable(pSalesLineT: Record "Sales Line"): Boolean
    var
        TaxAreaLineT: Record "Tax Area Line";
        TaxDetailT: Record "Tax Detail";
        lvIsTaxable: Boolean;
    begin
        //FP
        TaxAreaLineT.SETRANGE("Tax Area", pSalesLineT."Tax Area Code");
        IF TaxAreaLineT.FIND('-') THEN
            REPEAT
                TaxDetailT.SETRANGE("Tax Jurisdiction Code", TaxAreaLineT."Tax Jurisdiction Code");
                TaxDetailT.SETRANGE("Tax Group Code", pSalesLineT."Tax Group Code");
                TaxDetailT.SETFILTER("Effective Date", '<=%1', WORKDATE);
                IF TaxDetailT.FIND('-') THEN
                    REPEAT
                        IF TaxDetailT."Tax Below Maximum" <> 0 THEN
                            lvIsTaxable := TRUE;
                    UNTIL (TaxDetailT.NEXT = 0) OR (lvIsTaxable = TRUE);
            UNTIL (TaxAreaLineT.NEXT = 0) OR (lvIsTaxable = TRUE);

        EXIT(lvIsTaxable);
    end;

    var
        "-  FP6.2  -": Integer;
        SalesHT: Record "Sales Header";
        SalesLT: Record "Sales Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        TestQty: Decimal;
        ToleratedQty: Decimal;
        WhseShipHeaderT: Record "Warehouse Shipment Header";
        WhseShipLineT: Record "Warehouse Shipment Line";
        ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";

}

