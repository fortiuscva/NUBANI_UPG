report 50016 "Warehouse Shipping Status"
{
    // NUB1.01,12/04/19,SK: Created new report.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/WarehouseShippingStatus.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Shipment Date", "Sell-to Customer No.";
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(PalletsSpaces_SalesHeader; "Sales Header"."Pallets Spaces")
            {
            }
            column(ShippingStatus_SalesHeader; "Sales Header"."Shipping Status")
            {
            }
            column(ShipmentMethodCode_SalesHeader; "Sales Header"."Shipment Method Code")
            {
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
            }
            column(CasesVarGbl; CasesVarGbl)
            {
            }
            column(TimeAllotted; TimeAllotted)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(CasesVarGbl);
                CLEAR(TimeAllotted);

                SalesLineRecGbl.RESET;
                SalesLineRecGbl.SETRANGE("Document Type", SalesLineRecGbl."Document Type"::Order);
                SalesLineRecGbl.SETRANGE("Document No.", "No.");
                SalesLineRecGbl.SETRANGE(Type, SalesLineRecGbl.Type::Item);
                SalesLineRecGbl.CALCSUMS(Quantity);
                CasesVarGbl := SalesLineRecGbl.Quantity;
                TimeAllotted := CasesVarGbl / 250;
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
        SalesLineRecGbl: Record "Sales Line";
        CasesVarGbl: Decimal;
        TimeAllotted: Decimal;
}

