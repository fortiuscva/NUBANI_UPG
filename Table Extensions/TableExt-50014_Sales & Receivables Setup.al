tableextension 50014 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{

    Caption = 'Sales & Receivables Setup';
    fields
    {
        field(50000; "Days to Expire"; Integer)
        {
        }
        field(50001; "Stop Print Shipper"; Boolean)
        {
            Description = 'Stops printing Shipment Doc. on Ship & Invoice Post and print option only';
        }
        field(60000; "Repop Notes on Make Order"; Boolean)
        {
            Description = 'POPN5.12';
        }
    }


}

