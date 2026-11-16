report 51015 "Create Purchase Order From SO"
{
    ApplicationArea = All;
    Caption = 'Create Purchase Order from Sales Order';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = where("Document Type" = const(Order));

            RequestFilterFields = "Document No.", "Line No.";

            trigger OnPreDataItem()
            begin
                if VendorNo = '' then
                    Error('Vendor No. is required.');

                if SalesLine.IsEmpty() then
                    Error('No Sales Order lines were selected.');
            end;

            trigger OnAfterGetRecord()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                // Validate that all selected lines belong to
                // the same Sales Order.
                if not IsHeaderCreated then begin
                    if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesLine."Document No.") then;

                    // Create Purchase Order Header
                    PurchaseHeader.Init();
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                    PurchaseHeader.Validate("Buy-from Vendor No.", VendorNo);
                    PurchaseHeader.Insert(true);

                    // Transfer Sales Order No. to Your Reference
                    PurchaseHeader.Validate("Your Reference", SalesLine."Document No.");
                    PurchaseHeader.Modify(true);
                    LineNo := 10000;
                    IsHeaderCreated := true;
                end;

                // Create Purchase Line
                PurchaseLine.Init();
                PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                PurchaseLine."Document No." := PurchaseHeader."No.";
                PurchaseLine."Line No." := LineNo;
                PurchaseLine.Insert(true);

                PurchaseLine.Validate(Type, SalesLine.Type);
                PurchaseLine.Validate("No.", SalesLine."No.");
                PurchaseLine.Description := SalesLine.Description;
                PurchaseLine.Validate(Quantity, SalesLine.Quantity);
                PurchaseLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                PurchaseLine.Validate("Location Code", SalesLine."Location Code");
                PurchaseLine.Validate("Variant Code", SalesLine."Variant Code");
                PurchaseLine.Modify(true);
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

                    field(VendorNo; VendorNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor No.';
                        TableRelation = Vendor."No.";
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        if IsHeaderCreated then
            Message('Purchase Order No. %1 created for Vendor %2.', PurchaseHeader."No.", VendorNo)
        else
            Message('No Sales Order lines were selected. Purchase Order was not created.');
    end;

    var
        VendorNo: Code[20];
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        SourceSalesOrderNo: Code[20];
        LineNo: Integer;
        IsHeaderCreated: Boolean;
}
