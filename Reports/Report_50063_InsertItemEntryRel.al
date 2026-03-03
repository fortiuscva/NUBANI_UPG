report 50063 "*** Insert Item Entry Rel"
{
    ProcessingOnly = true;

    dataset
    {
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
                    field(PONo; PONo)
                    {
                        ApplicationArea = All;
                        Caption = 'PO No.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF PONo = '' THEN ERROR('Enter a PO No.');
        PurchHeader.GET(PurchHeader."Document Type"::Order, PONo);
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Document No.", PONo);
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETFILTER("No.", '<>%1', '');
    end;

    var
        PONo: Code[20];
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}

