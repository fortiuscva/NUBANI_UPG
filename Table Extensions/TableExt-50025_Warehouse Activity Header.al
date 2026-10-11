tableextension 50025 WarehouseActivityHeaderExt extends "Warehouse Activity Header"
{

    // NUB1.01,06/23/17,SK: Added code in OnDelete() and declared global variables & Text Constants.
    // NUB1.02,10/22/18,SK: Addd new field as "Requested Delivery Date" & "Shipping Agent Code".
    // NUB1.03,02/19/19,SK: Added field as "Customer Name" & "Creation Date".
    Caption = 'Warehouse Activity Header';
    fields
    {
        field(50000; "Allow Backorder"; Boolean)
        {
        }
        field(50006; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            Description = 'NUB1.02';
        }
        field(50007; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Description = 'NUB1.02';
            TableRelation = "Shipping Agent";
        }
        field(50011; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Destination No.")));
            Description = 'NUB1.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Creation Date"; Date)
        {
            Description = 'NUB1.03';
        }
        field(50013; "NDS Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Salesperson Code" where("Document Type" = const(Order),
             "No." = field("Source No.")));
            Editable = false;
        }
        field(50014; "NDS Case Count"; Decimal)
        {
            Caption = 'Case Count';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity
                where("Document Type" = const(Order),
                      "Document No." = field("Source No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    trigger OnBeforeDelete()
    begin
        //NUB1.01 Start
        IF UserSetupRecGbl.GET(USERID) THEN
            IF NOT UserSetupRecGbl."Delete Pick Ticket" THEN
                ERROR(Text50001);
        //NUB1.01 End
    end;

    var
        "-NU1.01-": Integer;
        UserSetupRecGbl: Record "User Setup";
        Text50001: Label 'You are not authorized to delete the Pick Ticket. Contact the System Administrator.';

}

