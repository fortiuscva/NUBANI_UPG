report 50027 "Update Sell-To Cust.Name in SI"
{
    // NUB1.01,08/24/17,SK: Created new report.

    Permissions = TableData "Sales Invoice Line" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Sell-to Customer No.") ORDER(Ascending) WHERE("NUB Sell-to Customer Name" = FILTER(= ''));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF CustRecGbl.GET("Sales Invoice Line"."Sell-to Customer No.") THEN;

                "NUB Sell-to Customer Name" := CustRecGbl.Name;
                CountVar += 1;
                MODIFY;
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

    trigger OnPostReport()
    begin
        IF CountVar > 0 THEN
            MESSAGE('Updated Successfully');
    end;

    var
        CustRecGbl: Record Customer;
        CountVar: Integer;
}

