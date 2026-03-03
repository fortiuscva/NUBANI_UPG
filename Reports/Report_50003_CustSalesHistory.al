report 50003 "Cust. Sales History"
{
    // NUB1.01,04/30/18,SK: Created New report.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/CustSalesHistory.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCountryRegionCode_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to County")
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header".Amount)
            {
            }
            column(AmountIncludingVAT_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(CompName; COMPANYNAME)
            {
            }

            trigger OnPreDataItem()
            begin
                "Sales Invoice Header".SetSecurityFilterOnSalesPerson;
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
}

