namespace NubaniNubaniUPG.NubaniNubaniUPG;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Tracking;

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
                CopyReservations(PurchaseLine, SalesLine);
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

    local procedure CopyReservations(PurchLine: Record "Purchase Line"; SalesLine: Record "Sales Line")
    var
        FromReservEntry: Record "Reservation Entry";
        ToReservEntry: Record "Reservation Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
    begin
        FromReservEntry.Reset();
        FromReservEntry.SetRange("Source Type", Database::"Purchase Line");
        FromReservEntry.SetRange("Source ID", PurchLine."Document No.");
        FromReservEntry.SetRange("Source Ref. No.", PurchLine."Line No.");
        FromReservEntry.SetRange("Source Subtype", 1);
        if not FromReservEntry.FindSet() then
            exit;

        repeat
            Clear(ToReservEntry);
            ToReservEntry."Lot No." := FromReservEntry."Lot No.";
            ToReservEntry."Serial No." := FromReservEntry."Serial No.";
            ToReservEntry."Expiration Date" := FromReservEntry."Expiration Date";
            ToReservEntry."Reservation Status" := FromReservEntry."Reservation Status";

            CreateReservEntry.CreateReservEntryFor(
                Database::"Sales Line",
                1, SalesLine."Document No.", '',
                0, SalesLine."Line No.",
                SalesLine."Qty. per Unit of Measure", Abs(FromReservEntry.Quantity),
                Abs(FromReservEntry."Quantity (Base)"), ToReservEntry);

            CreateReservEntry.SetDates(0D, FromReservEntry."Expiration Date");
            CreateReservEntry.CreateEntry(
                SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code",
                SalesLine.Description, 0D, SalesLine."Shipment Date", 0,
                ToReservEntry."Reservation Status");

        until FromReservEntry.Next() = 0;
    end;
}