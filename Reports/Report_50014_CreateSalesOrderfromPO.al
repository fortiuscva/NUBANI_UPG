namespace NubaniNubaniUPG.NubaniNubaniUPG;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;

report 50014 "Create Sales Order from PO"
{
    ApplicationArea = All;
    Caption = 'Create Sales Order from PO';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));

            trigger OnAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
                PurchaseHeader: Record "Purchase Header";
            begin
                if not IsHeaderCreated then begin
                    if CustomerNo = '' then
                        Error('Customer No. is required.');

                    if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then;
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
                    SalesHeader.Insert(true);

                    SalesHeader.Validate("Your Reference", PurchaseHeader."Your Reference");
                    SalesHeader.Modify(true);

                    LineNo := 10000;
                    IsHeaderCreated := true;
                end;

                // Create Sales Line from selected Purchase Line
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.Insert(true);

                SalesLine.Validate("Type", PurchaseLine."Type");
                SalesLine.Validate("No.", PurchaseLine."No.");
                SalesLine.Description := PurchaseLine.Description;
                SalesLine.Validate(Quantity, PurchaseLine.Quantity);
                SalesLine.Validate("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
                SalesLine.validate("Location Code", PurchaseLine."Location Code");
                SalesLine.Modify(true);

                LineNo += 10000;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No.';
                        TableRelation = Customer."No.";
                    }
                }
            }
        }
    }



    trigger OnPostReport()
    begin
        if IsHeaderCreated then
            Message('Sales Order No. %1 created for Customer %2.', SalesHeader."No.", CustomerNo)
        else
            Message('No lines were selected. Sales Order was not created.');
    end;

    var
        CustomerNo: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        IsHeaderCreated: Boolean;
}