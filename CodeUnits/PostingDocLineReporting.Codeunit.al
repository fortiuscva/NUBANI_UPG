codeunit 60001 "Posting Doc.Line Reporting"
{
    // Renumbered from 14005058


    trigger OnRun()
    begin
    end;

    procedure GetSalesLineHistory(SalesLineT: Record "Sales Line")
    var
        SalesInvoiceHistory: Record "Sales Invoice Line";
        SalesInvoiceLinePage: Page "Recent Sales History";
        SalesInvoiceLinePageAll: Page "Recent Sales History(All)";
    begin
        SalesInvoiceHistory.SETCURRENTKEY("Sell-to Customer No.", Type, "No.", "Posting Date");
        SalesInvoiceHistory.SETRANGE("Sell-to Customer No.", SalesLineT."Sell-to Customer No.");
        SalesInvoiceHistory.SETRANGE(Type, SalesLineT.Type);
        SalesInvoiceHistory.SETRANGE("No.", SalesLineT."No.");
        IF SalesInvoiceHistory.FIND('-') THEN BEGIN
            SalesInvoiceLinePage.SETTABLEVIEW(SalesInvoiceHistory);
            SalesInvoiceLinePage.EDITABLE := FALSE;
            SalesInvoiceLinePage.RUN;
        END ELSE BEGIN
            SalesInvoiceHistory.RESET;
            SalesInvoiceHistory.SETCURRENTKEY(Type, "No.");
            SalesInvoiceHistory.SETRANGE(Type, SalesLineT.Type);
            SalesInvoiceHistory.SETRANGE("No.", SalesLineT."No.");
            IF SalesInvoiceHistory.FIND('-') THEN BEGIN
                SalesInvoiceLinePageAll.SETTABLEVIEW(SalesInvoiceHistory);
                SalesInvoiceLinePageAll.EDITABLE := FALSE;
                SalesInvoiceLinePageAll.RUN;
            END ELSE
                ERROR('This item was not found in history.');
        END;
    end;

    procedure GetPurchLineHistory(PurchLineT: Record "Purchase Line")
    var
        PurchInvoiceHistory: Record "Purch. Inv. Line";
        PurchInvoiceLinePage: Page "Recent Purch. History";
        PurchInvoiceLinePageAll: Page "Recent Purch. History(All)";
    begin
        PurchInvoiceHistory.SETCURRENTKEY("Buy-from Vendor No.", Type, "No.", "Posting Date");
        PurchInvoiceHistory.SETRANGE("Buy-from Vendor No.", PurchLineT."Buy-from Vendor No.");
        PurchInvoiceHistory.SETRANGE(Type, PurchLineT.Type);
        PurchInvoiceHistory.SETRANGE("No.", PurchLineT."No.");
        IF PurchInvoiceHistory.FIND('-') THEN BEGIN
            PurchInvoiceLinePage.SETTABLEVIEW(PurchInvoiceHistory);
            PurchInvoiceLinePage.EDITABLE := FALSE;
            PurchInvoiceLinePage.RUN;
        END ELSE BEGIN
            PurchInvoiceHistory.RESET;
            PurchInvoiceHistory.SETCURRENTKEY(Type, "No.");
            PurchInvoiceHistory.SETRANGE(Type, PurchLineT.Type);
            PurchInvoiceHistory.SETRANGE("No.", PurchLineT."No.");
            IF PurchInvoiceHistory.FIND('-') THEN BEGIN
                PurchInvoiceLinePageAll.SETTABLEVIEW(PurchInvoiceHistory);
                PurchInvoiceLinePageAll.EDITABLE := FALSE;
                PurchInvoiceLinePageAll.RUN;
            END ELSE
                ERROR('This item was not found in history.');
        END;
    end;

    procedure GetPurchHistReq(ReqWorkSheetT: Record "Requisition Line")
    var
        PurchInvoiceHistory: Record "Purch. Inv. Line";
        PurchInvoiceLinePage: Page "Recent Purch. History";
        PurchInvoiceLinePageAll: Page "Recent Purch. History(All)";
    begin
        PurchInvoiceHistory.SETCURRENTKEY("Buy-from Vendor No.", Type, "No.", "Posting Date");
        PurchInvoiceHistory.SETRANGE("Buy-from Vendor No.", ReqWorkSheetT."Vendor No.");
        PurchInvoiceHistory.SETRANGE(Type, ReqWorkSheetT.Type);
        PurchInvoiceHistory.SETRANGE("No.", ReqWorkSheetT."No.");
        IF PurchInvoiceHistory.FIND('-') THEN BEGIN
            PurchInvoiceLinePage.SETTABLEVIEW(PurchInvoiceHistory);
            PurchInvoiceLinePage.EDITABLE := FALSE;
            PurchInvoiceLinePage.RUN;
        END ELSE BEGIN
            PurchInvoiceHistory.RESET;
            PurchInvoiceHistory.SETCURRENTKEY(Type, "No.");
            PurchInvoiceHistory.SETRANGE(Type, ReqWorkSheetT.Type);
            PurchInvoiceHistory.SETRANGE("No.", ReqWorkSheetT."No.");
            IF PurchInvoiceHistory.FIND('-') THEN BEGIN
                PurchInvoiceLinePageAll.SETTABLEVIEW(PurchInvoiceHistory);
                PurchInvoiceLinePageAll.EDITABLE := FALSE;
                PurchInvoiceLinePageAll.RUN;
            END ELSE
                ERROR('This item was not found in history.');
        END;
    end;
}

