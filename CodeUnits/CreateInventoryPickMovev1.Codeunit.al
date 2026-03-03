codeunit 50000 "Create Inventory Pick/Move v1"
{
    // NUB1.01,5/1/13,OAS: Copy of C7322; includes customizations.
    // 
    // NUB1.02,SP3166,12/19/13,Ak: Code to pick the Bin by Bin Ranking.
    // NUB1.03,10/22/18,SK: Added code at "GetSourceDocHeader", "UpdateWhseActivHeader" & "CreatePickOrMoveFromSales" to "Requested Delivery Date" & "Shipping Agent Code", delcared global variables.
    // NUB1.04,02/19/19,SK: Added code to update "Creation Date" as TODAY while creating Inventory Pick.
    // NUB1.05,11/09/20,ST: Uncommented changes to stop creating a pick like for the same item if there is a open pick.
    //                       - Modified code in "CreatePickOrMoveFromSales".

    Permissions = TableData "Whse. Item Tracking Line" = rimd;
    TableNo = "Warehouse Activity Header";

    trigger OnRun()
    begin
        WhseActivHeader := Rec;
        Code;
        Rec := WhseActivHeader;
    end;

    var
        WhseRequest: Record "Warehouse Request";
        WhseActivHeader: Record "Warehouse Activity Header";
        Text000: Label 'There is nothing to handle.';
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        Location: Record Location;
        Item: Record Item;
        TempReservEntry: Record "Reservation Entry" temporary;
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        ProdHeader: Record "Production Order";
        AssemblyHeader: Record "Assembly Header";
        WMSMgt: Codeunit "WMS Management";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        PostingDate: Date;
        VendorDocNo: Code[35];
        NextLineNo: Integer;
        LastTempHandlingSpecNo: Integer;
        HideDialog: Boolean;
        SNRequired: Boolean;
        LNRequired: Boolean;
        Text001: Label 'Quantity available to pick is not sufficient to fulfill shipping advise %1 for sales line with Document Type %2, Document No. %3, Line No. %4.';
        CheckLineExist: Boolean;
        AutoCreation: Boolean;
        LineCreated: Boolean;
        CompleteShipment: Boolean;
        PrintDocument: Boolean;
        ShowError: Boolean;
        Text002: Label 'Quantity available to pick is not sufficient to fulfill shipping advise %1 for transfer line with Document No. %2, Line No. %3.';
        IsInvtMovement: Boolean;
        IsBlankInvtMovement: Boolean;
        Text003: Label '%1 activity no. %2 has been created.';
        Text004: Label 'Do you want to create Inventory Movement?';
        FromBinCode: Code[20];
        HasExpiredItems: Boolean;
        ExpiredItemMessageText: Text[100];
        ATOInvtMovementsCreated: Integer;
        TotalATOInvtMovementsToBeCreated: Integer;
        "-NUB1.03-": Integer;
        ReqDelDateVarGbl: Date;
        ShipAgentCodeVarGbl: Code[30];

    local procedure "Code"()
    begin
        WhseActivHeader.TESTFIELD("No.");
        WhseActivHeader.TESTFIELD("Location Code");

        IF NOT HideDialog THEN
            IF NOT GetWhseRequest(WhseRequest) THEN
                EXIT;

        GetSourceDocHeader;
        UpdateWhseActivHeader(WhseRequest);

        CASE WhseRequest."Source Document" OF
            WhseRequest."Source Document"::"Purchase Order":
                CreatePickOrMoveFromPurchase(PurchHeader);
            WhseRequest."Source Document"::"Purchase Return Order":
                CreatePickOrMoveFromPurchase(PurchHeader);
            WhseRequest."Source Document"::"Sales Order":
                CreatePickOrMoveFromSales(SalesHeader);
            WhseRequest."Source Document"::"Sales Return Order":
                CreatePickOrMoveFromSales(SalesHeader);
            WhseRequest."Source Document"::"Outbound Transfer":
                CreatePickOrMoveFromTransfer(TransferHeader);
            WhseRequest."Source Document"::"Prod. Consumption":
                CreatePickOrMoveFromProduction(ProdHeader);
            WhseRequest."Source Document"::"Assembly Consumption":
                CreatePickOrMoveFromAssembly(AssemblyHeader);
        END;

        // NUB1.01 - start
        IF LineCreated THEN BEGIN
            WhseActivHeader."Allow Backorder" := SalesHeader."Allow Backorder";
            WhseActivHeader.MODIFY;
        END ELSE
            // NUB1.01 - end
            IF NOT AutoCreation THEN
                MESSAGE(Text000 + ExpiredItemMessageText);
    end;

    local procedure GetWhseRequest(var WhseRequest: Record "Warehouse Request"): Boolean
    begin
        WhseRequest.FILTERGROUP := 2;
        WhseRequest.SETRANGE(Type, WhseRequest.Type::Outbound);
        WhseRequest.SETRANGE("Location Code", WhseActivHeader."Location Code");
        WhseRequest.SETRANGE("Document Status", WhseRequest."Document Status"::Released);
        IF WhseActivHeader."Source Document" <> WhseActivHeader."Source Document"::" " THEN
            WhseRequest.SETRANGE("Source Document", WhseActivHeader."Source Document")
        ELSE
            IF WhseActivHeader.Type = WhseActivHeader.Type::"Invt. Movement" THEN
                WhseRequest.SETFILTER("Source Document", '%1|%2|%3',
                  WhseActivHeader."Source Document"::"Prod. Consumption",
                  WhseActivHeader."Source Document"::"Prod. Output",
                  WhseActivHeader."Source Document"::"Assembly Consumption");
        IF WhseActivHeader."Source No." <> '' THEN
            WhseRequest.SETRANGE("Source No.", WhseActivHeader."Source No.");
        WhseRequest.SETRANGE("Completely Handled", FALSE);
        WhseRequest.FILTERGROUP := 0;
        IF PAGE.RUNMODAL(PAGE::"Source Documents", WhseRequest, WhseRequest."Source No.") = ACTION::LookupOK THEN
            EXIT(TRUE);
    end;

    local procedure GetSourceDocHeader()
    begin
        CASE WhseRequest."Source Document" OF
            WhseRequest."Source Document"::"Purchase Order":
                BEGIN
                    PurchHeader.GET(PurchHeader."Document Type"::Order, WhseRequest."Source No.");
                    PostingDate := PurchHeader."Posting Date";
                    VendorDocNo := PurchHeader."Vendor Invoice No.";
                END;
            WhseRequest."Source Document"::"Purchase Return Order":
                BEGIN
                    PurchHeader.GET(PurchHeader."Document Type"::"Return Order", WhseRequest."Source No.");
                    PostingDate := PurchHeader."Posting Date";
                    VendorDocNo := PurchHeader."Vendor Cr. Memo No.";
                END;
            WhseRequest."Source Document"::"Sales Order":
                BEGIN
                    SalesHeader.GET(SalesHeader."Document Type"::Order, WhseRequest."Source No.");
                    PostingDate := SalesHeader."Posting Date";
                    ReqDelDateVarGbl := SalesHeader."Requested Delivery Date";  //NUB1.02
                    ShipAgentCodeVarGbl := SalesHeader."Shipping Agent Code"; //NUB1.02
                END;
            WhseRequest."Source Document"::"Sales Return Order":
                BEGIN
                    SalesHeader.GET(SalesHeader."Document Type"::"Return Order", WhseRequest."Source No.");
                    PostingDate := SalesHeader."Posting Date";
                END;
            WhseRequest."Source Document"::"Outbound Transfer":
                BEGIN
                    TransferHeader.GET(WhseRequest."Source No.");
                    PostingDate := TransferHeader."Posting Date";
                END;
            WhseRequest."Source Document"::"Prod. Consumption":
                BEGIN
                    ProdHeader.GET(WhseRequest."Source Subtype", WhseRequest."Source No.");
                    PostingDate := WORKDATE;
                END;
            WhseRequest."Source Document"::"Assembly Consumption":
                BEGIN
                    AssemblyHeader.GET(WhseRequest."Source Subtype", WhseRequest."Source No.");
                    PostingDate := AssemblyHeader."Posting Date";
                END;
        END;
    end;

    local procedure UpdateWhseActivHeader(WhseRequest: Record "Warehouse Request")
    begin
        IF WhseActivHeader."Source Document" = WhseActivHeader."Source Document"::" " THEN BEGIN
            WhseActivHeader."Source Document" := WhseRequest."Source Document";
            WhseActivHeader."Source Type" := WhseRequest."Source Type";
            WhseActivHeader."Source Subtype" := WhseRequest."Source Subtype";
        END ELSE
            WhseActivHeader.TESTFIELD("Source Document", WhseRequest."Source Document");
        IF WhseActivHeader."Source No." = '' THEN
            WhseActivHeader."Source No." := WhseRequest."Source No."
        ELSE
            WhseActivHeader.TESTFIELD("Source No.", WhseRequest."Source No.");

        WhseActivHeader."Destination Type" := WhseRequest."Destination Type";
        WhseActivHeader."Destination No." := WhseRequest."Destination No.";
        WhseActivHeader."External Document No." := WhseRequest."External Document No.";
        WhseActivHeader."Shipment Date" := WhseRequest."Shipment Date";
        WhseActivHeader."Posting Date" := PostingDate;
        WhseActivHeader."External Document No.2" := VendorDocNo;
        WhseActivHeader."Requested Delivery Date" := ReqDelDateVarGbl; //NUB1.02
        WhseActivHeader."Shipping Agent Code" := ShipAgentCodeVarGbl; //NUB1.02
        WhseActivHeader."Creation Date" := TODAY; //NUB1.04
        GetLocation(WhseRequest."Location Code");
    end;

    local procedure CreatePickOrMoveFromPurchase(PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT SetFilterPurchLine(PurchLine, PurchHeader) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;

        FindNextLineNo;

        REPEAT
            IF NOT FindPickOrMoveLine(DATABASE::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.", 0) THEN BEGIN
                NewWhseActivLine.INIT;
                NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
                NewWhseActivLine."No." := WhseActivHeader."No.";
                IF Location."Bin Mandatory" THEN
                    NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                NewWhseActivLine."Source Type" := DATABASE::"Purchase Line";
                NewWhseActivLine."Source Subtype" := PurchLine."Document Type".AsInteger();
                NewWhseActivLine."Source No." := PurchLine."Document No.";
                NewWhseActivLine."Source Line No." := PurchLine."Line No.";
                NewWhseActivLine."Location Code" := PurchLine."Location Code";
                NewWhseActivLine."Bin Code" := PurchLine."Bin Code";
                NewWhseActivLine."Item No." := PurchLine."No.";
                NewWhseActivLine."Variant Code" := PurchLine."Variant Code";
                NewWhseActivLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                NewWhseActivLine."Qty. per Unit of Measure" := PurchLine."Qty. per Unit of Measure";
                NewWhseActivLine.Description := PurchLine.Description;
                NewWhseActivLine."Description 2" := PurchLine."Description 2";
                NewWhseActivLine."Due Date" := PurchLine."Expected Receipt Date";
                IF PurchLine."Document Type" = PurchLine."Document Type"::Order THEN BEGIN
                    NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Purchase Order";
                    RemQtyToPickBase := -PurchLine."Qty. to Receive (Base)";
                END ELSE BEGIN
                    NewWhseActivLine."Source Document" :=
                      NewWhseActivLine."Source Document"::"Purchase Return Order";
                    RemQtyToPickBase := PurchLine."Return Qty. to Ship (Base)";
                END;

                PurchLine.CALCFIELDS("Reserved Quantity");
                CreatePickOrMoveLine(
                  NewWhseActivLine, RemQtyToPickBase, PurchLine."Outstanding Qty. (Base)", PurchLine."Reserved Quantity" <> 0);
            END;
        UNTIL PurchLine.NEXT = 0;
    end;

    local procedure SetFilterPurchLine(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"): Boolean
    begin
        PurchLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETRANGE("Drop Shipment", FALSE);
        IF NOT CheckLineExist THEN
            PurchLine.SETRANGE("Location Code", WhseActivHeader."Location Code");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN
            PurchLine.SETFILTER("Qty. to Receive", '<%1', 0)
        ELSE
            PurchLine.SETFILTER("Return Qty. to Ship", '>%1', 0);
        EXIT(PurchLine.FIND('-'));
    end;

    local procedure CreatePickOrMoveFromSales(SalesHeader: Record "Sales Header")
    var
        WhsActLine_Qty: Record "Warehouse Activity Line";
        SalesLine: Record "Sales Line";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT SetFilterSalesLine(SalesLine, SalesHeader) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;
        CompleteShipment := TRUE;

        FindNextLineNo;

        REPEAT
            // NUB1.01 - commented IF
            IF NOT FindPickOrMoveLine(DATABASE::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", SalesLine."Line No.", 0) THEN BEGIN  //NUB1.05
                NewWhseActivLine.INIT;
                NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
                NewWhseActivLine."No." := WhseActivHeader."No.";
                IF Location."Bin Mandatory" THEN
                    NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                NewWhseActivLine."Source Type" := DATABASE::"Sales Line";
                NewWhseActivLine."Source Subtype" := SalesLine."Document Type".AsInteger();
                NewWhseActivLine."Source No." := SalesLine."Document No.";
                NewWhseActivLine."Source Line No." := SalesLine."Line No.";
                NewWhseActivLine."Location Code" := SalesLine."Location Code";
                NewWhseActivLine."Bin Code" := SalesLine."Bin Code";
                NewWhseActivLine."Item No." := SalesLine."No.";
                NewWhseActivLine."Variant Code" := SalesLine."Variant Code";
                NewWhseActivLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                NewWhseActivLine."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
                NewWhseActivLine.Description := SalesLine.Description;
                NewWhseActivLine."Description 2" := SalesLine."Description 2";
                NewWhseActivLine."Due Date" := SalesLine."Planned Shipment Date";
                NewWhseActivLine."Shipping Advice" := SalesHeader."Shipping Advice";
                NewWhseActivLine."Shipping Agent Code" := SalesLine."Shipping Agent Code";
                NewWhseActivLine."Shipping Agent Service Code" := SalesLine."Shipping Agent Service Code";
                NewWhseActivLine."Shipment Method Code" := SalesHeader."Shipment Method Code";
                NewWhseActivLine."Requested Delivery Date" := SalesLine."Requested Delivery Date"; //NUB1.01

                // NUB1.01 - start
                WhsActLine_Qty.RESET;
                WhsActLine_Qty.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                WhsActLine_Qty.SETRANGE("Source Type", 37);
                WhsActLine_Qty.SETRANGE("Source No.", SalesLine."Document No.");
                WhsActLine_Qty.SETRANGE("Source Line No.", SalesLine."Line No.");
                WhsActLine_Qty.CALCSUMS("Qty. Outstanding (Base)");
                // NUB1.01 - start

                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
                    NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Sales Order";
                    RemQtyToPickBase := SalesLine."Lot Qty" - WhsActLine_Qty."Qty. Outstanding (Base)"; // NUB1.01
                END ELSE BEGIN
                    NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Sales Return Order";
                    RemQtyToPickBase := -SalesLine."Return Qty. to Receive (Base)";
                END;

                SalesLine.CALCFIELDS("Reserved Quantity");
                CreatePickOrMoveLine(
                  NewWhseActivLine, RemQtyToPickBase, SalesLine."Outstanding Qty. (Base)", SalesLine."Reserved Quantity" <> 0);
                IF NewWhseActivLine."Lot No." = '' THEN BEGIN
                    RemQtyToPickBase := 1;
                    IF NewWhseActivLine.DELETE THEN;
                END;

                IF SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Complete THEN
                    IF RemQtyToPickBase < 0 THEN BEGIN
                        IF AutoCreation THEN BEGIN
                            IF WhseActivHeader.DELETE(TRUE) THEN
                                LineCreated := FALSE;
                            SalesLine.FINDLAST;
                        END ELSE
                            ERROR(Text001, SalesHeader."Shipping Advice", SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                    END ELSE
                        IF (RemQtyToPickBase = 0) AND NOT CompleteShipment THEN BEGIN
                            IF ShowError THEN
                                ERROR(Text001, SalesHeader."Shipping Advice", SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");

                            IF WhseActivHeader.DELETE(TRUE) THEN;
                            LineCreated := FALSE;
                            SalesLine.FINDLAST;
                        END;
            END; // NUB1.01 //NUB1.05
        UNTIL SalesLine.NEXT = 0;
    end;

    local procedure SetFilterSalesLine(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"): Boolean
    begin
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Location Code");
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Drop Shipment", FALSE);
        IF NOT CheckLineExist THEN
            SalesLine.SETRANGE("Location Code", WhseActivHeader."Location Code");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            SalesLine.SETFILTER("Qty. to Ship", '>%1', 0)
        ELSE
            SalesLine.SETFILTER("Return Qty. to Receive", '<%1', 0);
        EXIT(SalesLine.FIND('-'));
    end;

    local procedure CreatePickOrMoveFromTransfer(TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT SetFilterTransferLine(TransferLine, TransferHeader) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;
        CompleteShipment := TRUE;

        FindNextLineNo;

        REPEAT
            IF NOT FindPickOrMoveLine(DATABASE::"Transfer Line", 0, TransferLine."Document No.", TransferLine."Line No.", 0) THEN BEGIN
                NewWhseActivLine.INIT;
                NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
                NewWhseActivLine."No." := WhseActivHeader."No.";
                IF Location."Bin Mandatory" THEN
                    NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                NewWhseActivLine."Source Type" := DATABASE::"Transfer Line";
                NewWhseActivLine."Source Subtype" := 0;
                NewWhseActivLine."Source No." := TransferLine."Document No.";
                NewWhseActivLine."Source Line No." := TransferLine."Line No.";
                NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Outbound Transfer";
                NewWhseActivLine."Location Code" := TransferLine."Transfer-from Code";
                NewWhseActivLine."Bin Code" := TransferLine."Transfer-from Bin Code";
                NewWhseActivLine."Item No." := TransferLine."Item No.";
                NewWhseActivLine."Variant Code" := TransferLine."Variant Code";
                NewWhseActivLine."Unit of Measure Code" := TransferLine."Unit of Measure Code";
                NewWhseActivLine."Qty. per Unit of Measure" := TransferLine."Qty. per Unit of Measure";
                NewWhseActivLine.Description := TransferLine.Description;
                NewWhseActivLine."Description 2" := TransferLine."Description 2";
                NewWhseActivLine."Due Date" := TransferLine."Shipment Date";
                NewWhseActivLine."Shipping Advice" := TransferHeader."Shipping Advice";
                RemQtyToPickBase := TransferLine."Qty. to Ship (Base)";

                TransferLine.CALCFIELDS("Reserved Quantity Outbnd.");
                CreatePickOrMoveLine(
                  NewWhseActivLine, RemQtyToPickBase,
                  TransferLine."Outstanding Qty. (Base)", TransferLine."Reserved Quantity Outbnd." <> 0);

                IF TransferHeader."Shipping Advice" = TransferHeader."Shipping Advice"::Complete THEN
                    IF RemQtyToPickBase > 0 THEN BEGIN
                        IF AutoCreation THEN BEGIN
                            WhseActivHeader.DELETE(TRUE);
                            LineCreated := FALSE;
                            TransferLine.FINDLAST;
                        END ELSE
                            ERROR(Text002, TransferHeader."Shipping Advice", TransferLine."Document No.", TransferLine."Line No.");
                    END ELSE
                        IF (RemQtyToPickBase = 0) AND NOT CompleteShipment THEN BEGIN
                            IF ShowError THEN
                                ERROR(Text002, TransferHeader."Shipping Advice", TransferLine."Document No.", TransferLine."Line No.");

                            IF WhseActivHeader.DELETE(TRUE) THEN;
                            LineCreated := FALSE;
                            TransferLine.FINDLAST;
                        END;
            END;
        UNTIL TransferLine.NEXT = 0;
    end;

    local procedure SetFilterTransferLine(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"): Boolean
    begin
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        TransferLine.SETRANGE("Derived From Line No.", 0);
        IF NOT CheckLineExist THEN
            TransferLine.SETRANGE("Transfer-from Code", WhseActivHeader."Location Code");
        TransferLine.SETFILTER("Qty. to Ship", '>%1', 0);
        EXIT(TransferLine.FIND('-'));
    end;

    local procedure CreatePickOrMoveFromProduction(ProdOrder: Record "Production Order")
    var
        ProdOrderComp: Record "Prod. Order Component";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT SetFilterProductionLine(ProdOrderComp, ProdOrder) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;

        FindNextLineNo;

        REPEAT
            IF NOT
               FindPickOrMoveLine(
                 DATABASE::"Prod. Order Component", ProdOrderComp.Status.AsInteger(), ProdOrderComp."Prod. Order No.", ProdOrderComp."Prod. Order Line No.", ProdOrderComp."Line No.")
            THEN BEGIN
                NewWhseActivLine.INIT;
                NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
                NewWhseActivLine."No." := WhseActivHeader."No.";
                IF Location."Bin Mandatory" THEN
                    NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                NewWhseActivLine."Source Type" := DATABASE::"Prod. Order Component";
                NewWhseActivLine."Source Subtype" := ProdOrderComp.Status.AsInteger();
                NewWhseActivLine."Source No." := ProdOrderComp."Prod. Order No.";
                NewWhseActivLine."Source Line No." := ProdOrderComp."Prod. Order Line No.";
                NewWhseActivLine."Source Subline No." := ProdOrderComp."Line No.";
                NewWhseActivLine."Location Code" := ProdOrderComp."Location Code";
                NewWhseActivLine."Bin Code" := ProdOrderComp."Bin Code";
                NewWhseActivLine."Item No." := ProdOrderComp."Item No.";
                NewWhseActivLine."Variant Code" := ProdOrderComp."Variant Code";
                NewWhseActivLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                NewWhseActivLine."Qty. per Unit of Measure" := ProdOrderComp."Qty. per Unit of Measure";
                NewWhseActivLine.Description := ProdOrderComp.Description;
                NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Prod. Consumption";
                NewWhseActivLine."Due Date" := ProdOrderComp."Due Date";
                RemQtyToPickBase := ProdOrderComp."Expected Qty. (Base)" - ProdOrderComp."Qty. Picked (Base)";

                ProdOrderComp.CALCFIELDS("Reserved Quantity");
                CreatePickOrMoveLine(
                  NewWhseActivLine, RemQtyToPickBase, RemQtyToPickBase, ProdOrderComp."Reserved Quantity" <> 0);
            END;
        UNTIL ProdOrderComp.NEXT = 0;
    end;

    local procedure CreatePickOrMoveFromAssembly(AsmHeader: Record "Assembly Header")
    var
        AssemblyLine: Record "Assembly Line";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT SetFilterAssemblyLine(AssemblyLine, AsmHeader) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;

        IF WhseActivHeader.Type = WhseActivHeader.Type::"Invt. Pick" THEN // no support for inventory pick on assembly
            EXIT;

        FindNextLineNo;

        REPEAT
            IF NOT
               FindPickOrMoveLine(
                 DATABASE::"Assembly Line", AssemblyLine."Document Type".AsInteger(), AssemblyLine."Document No.", AssemblyLine."Line No.", 0)
            THEN BEGIN
                NewWhseActivLine.INIT;
                NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
                NewWhseActivLine."No." := WhseActivHeader."No.";
                IF Location."Bin Mandatory" THEN
                    NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
                NewWhseActivLine."Source Type" := DATABASE::"Assembly Line";
                NewWhseActivLine."Source Subtype" := AssemblyLine."Document Type".AsInteger();
                NewWhseActivLine."Source No." := AssemblyLine."Document No.";
                NewWhseActivLine."Source Line No." := AssemblyLine."Line No.";
                NewWhseActivLine."Source Subline No." := 0;
                NewWhseActivLine."Location Code" := AssemblyLine."Location Code";
                NewWhseActivLine."Bin Code" := AssemblyLine."Bin Code";
                NewWhseActivLine."Item No." := AssemblyLine."No.";
                NewWhseActivLine."Variant Code" := AssemblyLine."Variant Code";
                NewWhseActivLine."Unit of Measure Code" := AssemblyLine."Unit of Measure Code";
                NewWhseActivLine."Qty. per Unit of Measure" := AssemblyLine."Qty. per Unit of Measure";
                NewWhseActivLine.Description := AssemblyLine.Description;
                NewWhseActivLine."Source Document" := NewWhseActivLine."Source Document"::"Assembly Consumption";
                NewWhseActivLine."Due Date" := AssemblyLine."Due Date";
                RemQtyToPickBase := AssemblyLine."Quantity (Base)" - AssemblyLine."Remaining Quantity (Base)" +
                  AssemblyLine."Quantity to Consume (Base)" - AssemblyLine."Qty. Picked (Base)";

                AssemblyLine.CALCFIELDS("Reserved Quantity");
                CreatePickOrMoveLine(
                  NewWhseActivLine, RemQtyToPickBase, RemQtyToPickBase, AssemblyLine."Reserved Quantity" <> 0);
            END;
        UNTIL AssemblyLine.NEXT = 0;
    end;

    local procedure SetFilterProductionLine(var ProdOrderComp: Record "Prod. Order Component"; ProdOrder: Record "Production Order"): Boolean
    begin
        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        IF NOT CheckLineExist THEN
            ProdOrderComp.SETRANGE("Location Code", WhseActivHeader."Location Code");
        ProdOrderComp.SETRANGE("Planning Level Code", 0);
        IF IsInvtMovement THEN BEGIN
            ProdOrderComp.SETFILTER("Bin Code", '<>%1', '');
            ProdOrderComp.SETFILTER("Flushing Method", '%1|%2|%3',
              ProdOrderComp."Flushing Method"::Manual,
              ProdOrderComp."Flushing Method"::"Pick + Forward",
              ProdOrderComp."Flushing Method"::"Pick + Backward");
        END ELSE
            ProdOrderComp.SETRANGE("Flushing Method", ProdOrderComp."Flushing Method"::Manual);
        ProdOrderComp.SETFILTER("Remaining Quantity", '>0');
        EXIT(ProdOrderComp.FIND('-'));
    end;

    local procedure SetFilterAssemblyLine(var AssemblyLine: Record "Assembly Line"; AsmHeader: Record "Assembly Header"): Boolean
    begin
        AssemblyLine.SETRANGE("Document Type", AsmHeader."Document Type");
        AssemblyLine.SETRANGE("Document No.", AsmHeader."No.");
        AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
        IF NOT CheckLineExist THEN
            AssemblyLine.SETRANGE("Location Code", WhseActivHeader."Location Code");
        IF IsInvtMovement THEN
            AssemblyLine.SETFILTER("Bin Code", '<>%1', '');
        AssemblyLine.SETFILTER("Remaining Quantity", '>0');
        EXIT(AssemblyLine.FIND('-'));
    end;

    local procedure FindPickOrMoveLine(SourceType: Option; SourceSubType: Option; SourceNo: Code[20]; SourceLineNo: Integer; SourceSubLineNo: Integer): Boolean
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
        WhseActivLine.SETRANGE("Source Type", SourceType);
        WhseActivLine.SETRANGE("Source Subtype", SourceSubType);
        WhseActivLine.SETRANGE("Source No.", SourceNo);
        WhseActivLine.SETRANGE("Source Line No.", SourceLineNo);
        WhseActivLine.SETRANGE("Source Subline No.", SourceSubLineNo);
        EXIT(NOT WhseActivLine.ISEMPTY);
    end;

    local procedure FindNextLineNo()
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        IF IsInvtMovement THEN
            WhseActivLine.SETRANGE("Activity Type", WhseActivLine."Activity Type"::"Invt. Movement")
        ELSE
            WhseActivLine.SETRANGE("Activity Type", WhseActivLine."Activity Type"::"Invt. Pick");
        WhseActivLine.SETRANGE("No.", WhseActivHeader."No.");
        IF WhseActivLine.FINDLAST THEN
            NextLineNo := WhseActivLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;
    end;

    local procedure CreatePickOrMoveLine(NewWhseActivLine: Record "Warehouse Activity Line"; var RemQtyToPickBase: Decimal; OutstandingQtyBase: Decimal; ReservationExists: Boolean)
    var
        ReservationEntry: Record "Reservation Entry";
        ATOSalesLine: Record "Sales Line";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        QtyAvailToPickBase: Decimal;
        ITQtyToPickBase: Decimal;
        QtyToTrackBase: Decimal;
        EntriesExist: Boolean;
        ItemTrackingSetup: Record "Item Tracking Setup";
    begin
        IF ReservationExists THEN
            CalcRemQtyToPickOrMoveBase(NewWhseActivLine, OutstandingQtyBase, RemQtyToPickBase);
        IF RemQtyToPickBase <= 0 THEN
            EXIT;

        QtyAvailToPickBase := CalcInvtAvailability(NewWhseActivLine);
        IF WMSMgt.GetATOSalesLine(
             NewWhseActivLine."Source Type", NewWhseActivLine."Source Subtype", NewWhseActivLine."Source No.",
             NewWhseActivLine."Source Line No.", ATOSalesLine)
        THEN
            QtyAvailToPickBase += ATOSalesLine.QtyToAsmBaseOnATO;

        IF RemQtyToPickBase > QtyAvailToPickBase THEN BEGIN
            RemQtyToPickBase := QtyAvailToPickBase;
            CompleteShipment := FALSE;
        END;

        IF RemQtyToPickBase > 0 THEN BEGIN
            //ItemTrackingMgt.CheckWhseItemTrkgSetup(NewWhseActivLine."Item No.", SNRequired, LNRequired, FALSE);//B2BUPG
            ItemTrackingMgt.CheckWhseItemTrkgSetup(NewWhseActivLine."Item No.");
            IF SNRequired OR LNRequired THEN BEGIN
                IF IsBlankInvtMovement THEN
                    ItemTrackingMgt.SumUpItemTracking(TempReservEntry, TempHandlingSpecification, TRUE, TRUE)
                ELSE BEGIN
                    SetFilterReservEntry(ReservationEntry, NewWhseActivLine);
                    ItemTrackingMgt.SumUpItemTracking(ReservationEntry, TempHandlingSpecification, TRUE, TRUE);
                END;
                IF PickOrMoveAccordingToFEFO(NewWhseActivLine."Location Code") OR
                   PickStrictExpirationPosting(NewWhseActivLine."Item No.")
                THEN BEGIN
                    QtyToTrackBase := RemQtyToPickBase;
                    IF UndefinedItemTrkg(QtyToTrackBase) THEN
                        CreateTempHandlingSpec(
                          NewWhseActivLine."Item No.",
                          NewWhseActivLine."Variant Code",
                          QtyToTrackBase);
                END;

                TempHandlingSpecification.RESET;
                IF TempHandlingSpecification.FIND('-') THEN
                    REPEAT
                        ITQtyToPickBase := ABS(TempHandlingSpecification."Qty. to Handle (Base)");
                        IF ITQtyToPickBase > 0 THEN BEGIN
                            NewWhseActivLine."Serial No." := TempHandlingSpecification."Serial No.";
                            NewWhseActivLine."Lot No." := TempHandlingSpecification."Lot No.";
                            IF (NewWhseActivLine."Lot No." <> '') OR (NewWhseActivLine."Serial No." <> '') THEN
                                NewWhseActivLine."Expiration Date" :=
                                //   ItemTrackingMgt.ExistingExpirationDate(NewWhseActivLine."Item No.",
                                //     NewWhseActivLine."Variant Code", NewWhseActivLine."Lot No.", NewWhseActivLine."Serial No.",
                                //     FALSE, EntriesExist);//B2BUPG
                                    ItemTrackingMgt.ExistingExpirationDate(NewWhseActivLine."Item No.",
                                    NewWhseActivLine."Variant Code", ItemTrackingSetup,
                                    FALSE, EntriesExist);

                            IF Location."Bin Mandatory" THEN BEGIN
                                // find Take qty. for bin code of source line
                                IF (NewWhseActivLine."Bin Code" <> '') AND (NOT IsInvtMovement OR IsBlankInvtMovement) THEN
                                    InsertPickOrMoveBinWhseActLine(
                                      NewWhseActivLine, NewWhseActivLine."Bin Code", FALSE, ITQtyToPickBase);

                                // Invt. movement without document has to be created
                                IF IsBlankInvtMovement THEN
                                    ITQtyToPickBase := 0;

                                // find Take qty. for default bin
                                IF ITQtyToPickBase > 0 THEN
                                    InsertPickOrMoveBinWhseActLine(NewWhseActivLine, '', TRUE, ITQtyToPickBase);

                                // find Take qty. for other bins
                                IF ITQtyToPickBase > 0 THEN
                                    InsertPickOrMoveBinWhseActLine(NewWhseActivLine, '', FALSE, ITQtyToPickBase);
                                IF (ITQtyToPickBase = 0) AND IsInvtMovement AND NOT IsBlankInvtMovement THEN
                                    SynchronizeWhseItemTracking(TempHandlingSpecification);
                            END ELSE
                                IF ITQtyToPickBase > 0 THEN
                                    InsertShelfWhseActivLine(NewWhseActivLine, ITQtyToPickBase);

                            RemQtyToPickBase :=
                              RemQtyToPickBase + ITQtyToPickBase +
                              TempHandlingSpecification."Qty. to Handle (Base)";
                        END;
                        NewWhseActivLine."Serial No." := '';
                        NewWhseActivLine."Lot No." := '';
                    UNTIL (TempHandlingSpecification.NEXT = 0) OR (RemQtyToPickBase = 0);
            END;

            IF Location."Bin Mandatory" THEN BEGIN
                // find Take qty. for bin code of source line
                IF (RemQtyToPickBase > 0) AND
                   (NewWhseActivLine."Bin Code" <> '') AND
                   (NOT IsInvtMovement OR IsBlankInvtMovement) AND
                   (NOT HasExpiredItems)
                THEN
                    InsertPickOrMoveBinWhseActLine(
                      NewWhseActivLine, NewWhseActivLine."Bin Code", FALSE, RemQtyToPickBase);

                // Invt. movement without document has to be created
                IF IsBlankInvtMovement THEN
                    RemQtyToPickBase := 0;

                // find Take qty. for default bin
                IF (RemQtyToPickBase > 0) AND (NOT HasExpiredItems) THEN
                    InsertPickOrMoveBinWhseActLine(NewWhseActivLine, '', TRUE, RemQtyToPickBase);

                // find Take qty. for other bins
                IF (RemQtyToPickBase > 0) AND (NOT HasExpiredItems) THEN
                    InsertPickOrMoveBinWhseActLine(NewWhseActivLine, '', FALSE, RemQtyToPickBase)
            END ELSE
                IF (RemQtyToPickBase > 0) AND (NOT HasExpiredItems) THEN
                    InsertShelfWhseActivLine(NewWhseActivLine, RemQtyToPickBase);
        END;
    end;

    local procedure CalcRemQtyToPickOrMoveBase(NewWhseActivLine: Record "Warehouse Activity Line"; OutstandingQtyBase: Decimal; var RemQtyToPickBase: Decimal)
    var
        ATOSalesLine: Record "Sales Line";
        MaxQtyToPickBase: Decimal;
    begin
        MaxQtyToPickBase :=
  OutstandingQtyBase -
    //   WMSMgt.CalcLineReservedQtyNotonInvt(
    //     "Source Type", "Source Subtype", "Source No.",
    //     "Source Line No.", "Source Subline No.",
    //     ("Shipping Advice" = "Shipping Advice"::Complete));
    WMSMgt.CalcLineReservedQtyNotonInvt(NewWhseActivLine."Source Type", NewWhseActivLine."Source Subtype", NewWhseActivLine."Source No.",
    NewWhseActivLine."Source Line No.", NewWhseActivLine."Source Subline No.");
        IF WMSMgt.GetATOSalesLine(NewWhseActivLine."Source Type", NewWhseActivLine."Source Subtype", NewWhseActivLine."Source No.", NewWhseActivLine."Source Line No.", ATOSalesLine) THEN
            MaxQtyToPickBase += ATOSalesLine.QtyAsmRemainingBaseOnATO;

        IF RemQtyToPickBase > MaxQtyToPickBase THEN
            RemQtyToPickBase := MaxQtyToPickBase;
    end;

    local procedure InsertPickOrMoveBinWhseActLine(NewWhseActivLine: Record "Warehouse Activity Line"; BinCode: Code[20]; DefaultBin: Boolean; var RemQtyToPickBase: Decimal)
    var
        FromBinContent: Record "Bin Content";
        QtyToPickBase: Decimal;
        QtyAvailToPickBase: Decimal;
    begin
        CreateATOPickLine(NewWhseActivLine, BinCode, RemQtyToPickBase);
        IF RemQtyToPickBase = 0 THEN
            EXIT;

        FromBinContent.SETCURRENTKEY("Bin Ranking", Default, "Location Code", "Item No.", "Variant Code", "Bin Code");   //NUB1.01
        FromBinContent.ASCENDING(FALSE);          //NUB1.02
        FromBinContent.SETFILTER("Bin Ranking", '<>%1', 1);       //NUB1.02
        FromBinContent.SETRANGE(Default, DefaultBin);
        FromBinContent.SETRANGE("Location Code", NewWhseActivLine."Location Code");
        FromBinContent.SETRANGE("Item No.", NewWhseActivLine."Item No.");
        FromBinContent.SETRANGE("Variant Code", NewWhseActivLine."Variant Code");

        // IF (BinCode <> '') AND NOT IsInvtMovement THEN     //NUB1.02 commented out this line and line below.
        //   SETRANGE("Bin Code",BinCode);

        IF (NewWhseActivLine."Bin Code" <> '') AND IsInvtMovement THEN
            // not movement within the same bin
            FromBinContent.SETFILTER("Bin Code", '<>%1', NewWhseActivLine."Bin Code");

        IF IsBlankInvtMovement THEN BEGIN
            // inventory movement without source document, created from Internal Movement
            FromBinContent.SETRANGE("Bin Code", FromBinCode);
            FromBinContent.SETRANGE(Default);
        END;

        IF NewWhseActivLine."Serial No." <> '' THEN
            FromBinContent.SETRANGE("Serial No. Filter", NewWhseActivLine."Serial No.");
        IF NewWhseActivLine."Lot No." <> '' THEN
            FromBinContent.SETRANGE("Lot No. Filter", NewWhseActivLine."Lot No.");
        IF FromBinContent.FIND('-') THEN
            REPEAT
                QtyAvailToPickBase := FromBinContent.CalcQtyAvailToPick(0);
                IF RemQtyToPickBase < QtyAvailToPickBase THEN
                    QtyAvailToPickBase := RemQtyToPickBase;
                IF QtyAvailToPickBase > 0 THEN BEGIN
                    IF SNRequired THEN BEGIN
                        QtyAvailToPickBase := ROUND(QtyAvailToPickBase, 1, '<');
                        QtyToPickBase := 1;
                    END ELSE
                        QtyToPickBase := QtyAvailToPickBase;

                    MakeHeader;

                    REPEAT
                        MakeLine(NewWhseActivLine, FromBinContent."Bin Code", QtyToPickBase, RemQtyToPickBase);
                        QtyAvailToPickBase := QtyAvailToPickBase - QtyToPickBase;
                    UNTIL QtyAvailToPickBase <= 0;
                END;
            UNTIL (FromBinContent.NEXT = 0) OR (RemQtyToPickBase = 0);
    end;

    local procedure InsertShelfWhseActivLine(NewWhseActivLine: Record "Warehouse Activity Line"; var RemQtyToPickBase: Decimal)
    var
        QtyToPickBase: Decimal;
    begin
        CreateATOPickLine(NewWhseActivLine, '', RemQtyToPickBase);
        IF RemQtyToPickBase = 0 THEN
            EXIT;

        IF SNRequired THEN BEGIN
            RemQtyToPickBase := ROUND(RemQtyToPickBase, 1, '<');
            QtyToPickBase := 1;
        END ELSE
            QtyToPickBase := RemQtyToPickBase;

        MakeHeader;

        REPEAT
            MakeLine(NewWhseActivLine, '', QtyToPickBase, RemQtyToPickBase);
        UNTIL RemQtyToPickBase = 0;
    end;

    local procedure CalcInvtAvailability(WhseActivLine: Record "Warehouse Activity Line"): Decimal
    var
        Item2: Record Item;
        WhseActivLine2: Record "Warehouse Activity Line";
        WhseAvailMgt: Codeunit "Warehouse Availability Mgt.";
        QtyAssgndtoPick: Decimal;
        LineReservedQty: Decimal;
        QtyReservedOnPickShip: Decimal;
        QtyOnDedicatedBins: Decimal;
        QtyBlocked: Decimal;
        WhseItemTrackingSetup: Record "Item Tracking Setup" temporary;
    begin
        GetItem(WhseActivLine."Item No.");
        Item2 := Item;
        Item2.SETRANGE("Location Filter", WhseActivLine."Location Code");
        Item2.SETRANGE("Variant Filter", WhseActivLine."Variant Code");
        Item2.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
        QtyAssgndtoPick := WhseAvailMgt.CalcQtyAssgndtoPick(Location, WhseActivLine."Item No.", WhseActivLine."Variant Code", '');
        //QtyOnDedicatedBins := WhseAvailMgt.CalcQtyOnDedicatedBins("Location Code", "Item No.", "Variant Code", '', '');//B2BUPG
        QtyOnDedicatedBins := WhseAvailMgt.CalcQtyOnDedicatedBins(WhseActivLine."Location Code", WhseActivLine."Item No.", WhseActivLine."Variant Code");
        QtyBlocked :=
           // WhseAvailMgt.CalcQtyOnBlockedITOrOnBlockedOutbndBins("Location Code", "Item No.", "Variant Code", '', '', FALSE, FALSE);//B2BUPG
           WhseAvailMgt.CalcQtyOnBlockedITOrOnBlockedOutbndBins(WhseActivLine."Location Code", WhseActivLine."Item No.", WhseActivLine."Variant Code", WhseItemTrackingSetup);
        LineReservedQty :=
            //   WhseAvailMgt.CalcLineReservedQtyOnInvt(
            //     "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.", TRUE, '', '', WhseActivLine2);//B2BUPG
            WhseAvailMgt.CalcLineReservedQtyOnInvt(
            WhseActivLine."Source Type", WhseActivLine."Source Subtype", WhseActivLine."Source No.", WhseActivLine."Source Line No.", WhseActivLine."Source Subline No.", TRUE, WhseActivLine2);
        QtyReservedOnPickShip :=
          WhseAvailMgt.CalcReservQtyOnPicksShips(WhseActivLine."Location Code", WhseActivLine."Item No.", WhseActivLine."Variant Code", WhseActivLine2);
        EXIT(
          Item2.Inventory - ABS(Item2."Reserved Qty. on Inventory") - QtyAssgndtoPick - QtyOnDedicatedBins - QtyBlocked +
          LineReservedQty + QtyReservedOnPickShip);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode <> Location.Code THEN BEGIN
            IF LocationCode = '' THEN
                Location.GetLocationSetup('', Location)
            ELSE
                Location.GET(LocationCode);
        END;
    end;

    local procedure GetShelfNo(ItemNo: Code[20]): Code[10]
    begin
        GetItem(ItemNo);
        EXIT(Item."Shelf No.");
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        IF ItemNo <> Item."No." THEN
            Item.GET(ItemNo);
    end;

    procedure SetWhseRequest(NewWhseRequest: Record "Warehouse Request"; SetHideDialog: Boolean)
    begin
        WhseRequest := NewWhseRequest;
        HideDialog := SetHideDialog;
        LineCreated := FALSE;
    end;


    procedure CheckSourceDoc(NewWhseRequest: Record "Warehouse Request"): Boolean
    var
        PurchLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
        TransferLine: Record "Transfer Line";
        ProdOrderComp: Record "Prod. Order Component";
        AssemblyLine: Record "Assembly Line";
    begin
        WhseRequest := NewWhseRequest;
        IF Location.RequireShipment(WhseRequest."Location Code") THEN
            EXIT(FALSE);

        GetSourceDocHeader;
        CheckLineExist := TRUE;
        CASE WhseRequest."Source Document" OF
            WhseRequest."Source Document"::"Purchase Order":
                EXIT(SetFilterPurchLine(PurchLine, PurchHeader));
            WhseRequest."Source Document"::"Purchase Return Order":
                EXIT(SetFilterPurchLine(PurchLine, PurchHeader));
            WhseRequest."Source Document"::"Sales Order":
                EXIT(SetFilterSalesLine(SalesLine, SalesHeader));
            WhseRequest."Source Document"::"Sales Return Order":
                EXIT(SetFilterSalesLine(SalesLine, SalesHeader));
            WhseRequest."Source Document"::"Outbound Transfer":
                EXIT(SetFilterTransferLine(TransferLine, TransferHeader));
            WhseRequest."Source Document"::"Prod. Consumption":
                EXIT(SetFilterProductionLine(ProdOrderComp, ProdHeader));
            WhseRequest."Source Document"::"Assembly Consumption":
                EXIT(SetFilterAssemblyLine(AssemblyLine, AssemblyHeader));
        END;
    end;


    procedure AutoCreatePickOrMove(var WhseActivHeaderNew: Record "Warehouse Activity Header")
    begin
        WhseActivHeader := WhseActivHeaderNew;
        CheckLineExist := FALSE;
        AutoCreation := TRUE;
        GetLocation(WhseRequest."Location Code");

        CASE WhseRequest."Source Document" OF
            WhseRequest."Source Document"::"Purchase Order":
                CreatePickOrMoveFromPurchase(PurchHeader);
            WhseRequest."Source Document"::"Purchase Return Order":
                CreatePickOrMoveFromPurchase(PurchHeader);
            WhseRequest."Source Document"::"Sales Order":
                CreatePickOrMoveFromSales(SalesHeader);
            WhseRequest."Source Document"::"Sales Return Order":
                CreatePickOrMoveFromSales(SalesHeader);
            WhseRequest."Source Document"::"Outbound Transfer":
                CreatePickOrMoveFromTransfer(TransferHeader);
            WhseRequest."Source Document"::"Prod. Consumption":
                CreatePickOrMoveFromProduction(ProdHeader);
            WhseRequest."Source Document"::"Assembly Consumption":
                CreatePickOrMoveFromAssembly(AssemblyHeader);
        END;

        IF LineCreated THEN BEGIN
            WhseActivHeader."Allow Backorder" := SalesHeader."Allow Backorder"; // NUB1.01
            WhseActivHeader.MODIFY;
            WhseActivHeaderNew := WhseActivHeader;
        END;
    end;


    procedure SetReportGlobals(PrintDocument2: Boolean; ShowError2: Boolean)
    begin
        PrintDocument := PrintDocument2;
        ShowError := ShowError2;
    end;

    local procedure SetFilterReservEntry(var ReservationEntry: Record "Reservation Entry"; WhseActivLine: Record "Warehouse Activity Line")
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
        ReservationEntry.SETRANGE("Source ID", WhseActivLine."Source No.");
        IF WhseActivLine."Source Type" = DATABASE::"Prod. Order Component" THEN
            ReservationEntry.SETRANGE("Source Ref. No.", WhseActivLine."Source Subline No.")
        ELSE
            ReservationEntry.SETRANGE("Source Ref. No.", WhseActivLine."Source Line No.");
        ReservationEntry.SETRANGE("Source Type", WhseActivLine."Source Type");
        ReservationEntry.SETRANGE("Source Subtype", WhseActivLine."Source Subtype");
        IF WhseActivLine."Source Type" = DATABASE::"Prod. Order Component" THEN
            ReservationEntry.SETRANGE("Source Prod. Order Line", WhseActivLine."Source Line No.");
        ReservationEntry.SETRANGE(Positive, FALSE);
    end;


    procedure SetInvtMovement(InvtMovement: Boolean)
    begin
        IsInvtMovement := InvtMovement;
    end;

    local procedure PickOrMoveAccordingToFEFO(LocationCode: Code[10]): Boolean
    begin
        GetLocation(LocationCode);

        EXIT(Location."Pick According to FEFO" AND (SNRequired OR LNRequired));
    end;


    procedure UndefinedItemTrkg(var QtyToTrackBase: Decimal): Boolean
    begin
        QtyToTrackBase := QtyToTrackBase + ItemTrackedQuantity('', '');

        EXIT(QtyToTrackBase > 0);
    end;

    local procedure ItemTrackedQuantity(LotNo: Code[20]; SerialNo: Code[20]): Decimal
    var

    begin
        TempHandlingSpecification.RESET;
        IF (LotNo = '') AND (SerialNo = '') THEN
            IF TempHandlingSpecification.ISEMPTY THEN
                EXIT(0);

        IF SerialNo <> '' THEN BEGIN
            TempHandlingSpecification.SETCURRENTKEY("Lot No.", "Serial No.");
            TempHandlingSpecification.SETRANGE("Serial No.", SerialNo);
            IF TempHandlingSpecification.ISEMPTY THEN
                EXIT(0);

            EXIT(1);
        END;

        IF LotNo <> '' THEN BEGIN
            TempHandlingSpecification.SETCURRENTKEY("Lot No.", "Serial No.");
            TempHandlingSpecification.SETRANGE("Lot No.", LotNo);
            IF TempHandlingSpecification.ISEMPTY THEN
                EXIT(0);
        END;

        TempHandlingSpecification.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
          "Source Prod. Order Line", "Source Ref. No.");
        IF LotNo <> '' THEN
            TempHandlingSpecification.SETRANGE("Lot No.", LotNo);
        TempHandlingSpecification.CALCSUMS("Qty. to Handle (Base)");
        EXIT(TempHandlingSpecification."Qty. to Handle (Base)");
    end;

    local procedure CreateTempHandlingSpec(ItemNo: Code[20]; VariantCode: Code[10]; TotalQtytoPickBase: Decimal)
    var
        EntrySummary: Record "Entry Summary";
        FromBinContent: Record "Bin Content";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
        TotalAvailQtyToPickBase: Decimal;
        RemQtyToPickBase: Decimal;
        QtyToPickBase: Decimal;
        QtyTracked: Decimal;
        EventsandSubscribers: codeunit EventsandSubscribers;
    begin
        FromBinContent.RESET;
        FromBinContent.SETRANGE("Location Code", Location.Code);
        FromBinContent.SETRANGE("Item No.", ItemNo);
        FromBinContent.SETRANGE("Variant Code", VariantCode);
        IF FromBinContent.ISEMPTY THEN
            EXIT;

        //ItemTrackingDataCollection.CreateEntrySummaryFEFO(Location, ItemNo, VariantCode, TRUE);//B2BUPG
        EventsandSubscribers.CreateEntrySummaryFEFO(Location, ItemNo, VariantCode, TRUE);

        //IF ItemTrackingDataCollection.FindFirstEntrySummaryFEFO(EntrySummary) THEN BEGIN//B2BUPG
        if EventsandSubscribers.FindFirstEntrySummaryFEFO(EntrySummary) THEN BEGIN
            InitTempHandlingSpec;
            RemQtyToPickBase := TotalQtytoPickBase;

            REPEAT
                IF EntrySummary."Expiration Date" <> 0D THEN BEGIN
                    QtyTracked := ItemTrackedQuantity(EntrySummary."Lot No.", EntrySummary."Serial No.");

                    IF NOT ((EntrySummary."Serial No." <> '') AND (QtyTracked > 0)) THEN BEGIN
                        TotalAvailQtyToPickBase := 0;
                        FromBinContent.SETRANGE("Serial No. Filter", EntrySummary."Serial No.");
                        FromBinContent.SETRANGE("Lot No. Filter", EntrySummary."Lot No.");
                        IF FromBinContent.FINDSET THEN
                            REPEAT
                                TotalAvailQtyToPickBase += FromBinContent.CalcQtyAvailToPick(0);
                            UNTIL (FromBinContent.NEXT = 0) OR (TotalAvailQtyToPickBase >= RemQtyToPickBase);

                        TotalAvailQtyToPickBase := TotalAvailQtyToPickBase - QtyTracked;
                        QtyToPickBase := 0;

                        IF TotalAvailQtyToPickBase > 0 THEN
                            IF TotalAvailQtyToPickBase >= RemQtyToPickBase THEN BEGIN
                                QtyToPickBase := RemQtyToPickBase;
                                RemQtyToPickBase := 0
                            END ELSE BEGIN
                                QtyToPickBase := TotalAvailQtyToPickBase;
                                RemQtyToPickBase := RemQtyToPickBase - QtyToPickBase;
                            END;

                        IF QtyToPickBase > 0 THEN
                            InsertTempHandlingSpec(
                              Location.Code, ItemNo, VariantCode, EntrySummary, QtyToPickBase);
                    END;
                END;
            //UNTIL NOT ItemTrackingDataCollection.FindNextEntrySummaryFEFO(EntrySummary) OR (RemQtyToPickBase = 0);
            UNTIL NOT EventsandSubscribers.FindNextEntrySummaryFEFO(EntrySummary) OR (RemQtyToPickBase = 0);
        END;
        // HasExpiredItems := ItemTrackingDataCollection.GetHasExpiredItems;//B2BUPG
        HasExpiredItems := EventsandSubscribers.GetHasExpiredItems;
        //ExpiredItemMessageText := ItemTrackingDataCollection.GetResultMessageForExpiredItem;
        ExpiredItemMessageText := EventsandSubscribers.GetResultMessageForExpiredItem();
    end;

    local procedure InitTempHandlingSpec()
    begin
        TempHandlingSpecification.RESET;
        IF TempHandlingSpecification.FINDLAST THEN
            LastTempHandlingSpecNo := TempHandlingSpecification."Entry No."
        ELSE
            LastTempHandlingSpecNo := 0;
    end;

    local procedure InsertTempHandlingSpec(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]; EntrySummary: Record "Entry Summary"; QuantityBase: Decimal)
    begin
        TempHandlingSpecification.INIT;
        TempHandlingSpecification."Entry No." := LastTempHandlingSpecNo + 1;
        TempHandlingSpecification."Location Code" := LocationCode;
        TempHandlingSpecification."Item No." := ItemNo;
        TempHandlingSpecification."Variant Code" := VariantCode;
        TempHandlingSpecification."Lot No." := EntrySummary."Lot No.";
        TempHandlingSpecification."Serial No." := EntrySummary."Serial No.";
        TempHandlingSpecification."Expiration Date" := EntrySummary."Expiration Date";
        TempHandlingSpecification.VALIDATE("Quantity (Base)", -QuantityBase);
        TempHandlingSpecification.INSERT;
        LastTempHandlingSpecNo := TempHandlingSpecification."Entry No.";
    end;

    local procedure SetFilterInternalMomement(var InternalMovementLine: Record "Internal Movement Line"; InternalMovementHeader: Record "Internal Movement Header"): Boolean
    begin
        InternalMovementLine.SETRANGE("No.", InternalMovementHeader."No.");
        InternalMovementLine.SETFILTER("Qty. (Base)", '>0');
        EXIT(InternalMovementLine.FIND('-'));
    end;


    procedure CreateInvtMvntWithoutSource(var InternalMovementHeader: Record "Internal Movement Header")
    var
        InternalMovementLine: Record "Internal Movement Line";
        NewWhseActivLine: Record "Warehouse Activity Line";
        RemQtyToPickBase: Decimal;
    begin
        IF NOT CONFIRM(Text004, FALSE) THEN
            EXIT;

        IsInvtMovement := TRUE;
        IsBlankInvtMovement := TRUE;

        InternalMovementHeader.TESTFIELD("Location Code");

        IF NOT SetFilterInternalMomement(InternalMovementLine, InternalMovementHeader) THEN BEGIN
            IF NOT HideDialog THEN
                MESSAGE(Text000);
            EXIT;
        END;

        // creating Inventory Movement Header
        CLEAR(WhseActivHeader);
        WhseActivHeader.Type := WhseActivHeader.Type::"Invt. Movement";
        WhseActivHeader.INSERT(TRUE);
        WhseActivHeader.VALIDATE("Location Code", InternalMovementHeader."Location Code");
        WhseActivHeader.VALIDATE("Posting Date", InternalMovementHeader."Due Date");
        WhseActivHeader.VALIDATE("Assigned User ID", InternalMovementHeader."Assigned User ID");
        WhseActivHeader.VALIDATE("Assignment Date", InternalMovementHeader."Assignment Date");
        WhseActivHeader.VALIDATE("Assignment Time", InternalMovementHeader."Assignment Time");
        WhseActivHeader.MODIFY;

        FindNextLineNo;

        REPEAT
            NewWhseActivLine.INIT;
            NewWhseActivLine."Activity Type" := WhseActivHeader.Type;
            NewWhseActivLine."No." := WhseActivHeader."No.";
            InternalMovementLine.TESTFIELD("Location Code");
            GetLocation(InternalMovementLine."Location Code");
            IF Location."Bin Mandatory" THEN
                NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
            NewWhseActivLine."Location Code" := InternalMovementLine."Location Code";
            InternalMovementLine.TESTFIELD("From Bin Code");
            FromBinCode := InternalMovementLine."From Bin Code";
            InternalMovementLine.TESTFIELD("To Bin Code");
            NewWhseActivLine."Bin Code" := InternalMovementLine."To Bin Code";
            NewWhseActivLine."Item No." := InternalMovementLine."Item No.";
            NewWhseActivLine."Variant Code" := InternalMovementLine."Variant Code";
            NewWhseActivLine."Unit of Measure Code" := InternalMovementLine."Unit of Measure Code";
            NewWhseActivLine."Qty. per Unit of Measure" := InternalMovementLine."Qty. per Unit of Measure";
            NewWhseActivLine.Description := InternalMovementLine.Description;
            NewWhseActivLine."Due Date" := InternalMovementLine."Due Date";
            RemQtyToPickBase := InternalMovementLine."Qty. (Base)";

            PrepareItemTrackingFromWhseIT(InternalMovementLine);
            CreatePickOrMoveLine(NewWhseActivLine, RemQtyToPickBase, RemQtyToPickBase, FALSE);
        UNTIL InternalMovementLine.NEXT = 0;

        IF NextLineNo = 10000 THEN
            ERROR(Text000);

        MoveWhseComments(InternalMovementHeader, WhseActivHeader."No.");
        InternalMovementHeader.DELETE(TRUE);

        MESSAGE(Text003, WhseActivHeader.Type, WhseActivHeader."No.");
    end;

    local procedure PrepareItemTrackingFromWhseIT(InternalMovementLine: Record "Internal Movement Line")
    var
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
        EntryNo: Integer;
    begin
        // function recopies warehouse item tracking into temporary item tracking table
        // when Invt. Movement is created from Internal Movement
        TempReservEntry.RESET;
        TempReservEntry.DELETEALL;

        WhseItemTrackingLine.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name");
        WhseItemTrackingLine.SETRANGE("Source Type", DATABASE::"Internal Movement Line");
        WhseItemTrackingLine.SETRANGE("Source ID", InternalMovementLine."No.");
        WhseItemTrackingLine.SETRANGE("Source Ref. No.", InternalMovementLine."Line No.");

        IF WhseItemTrackingLine.FIND('-') THEN
            REPEAT
                TempReservEntry.TRANSFERFIELDS(WhseItemTrackingLine);
                EntryNo += 1;
                TempReservEntry."Entry No." := EntryNo;
                TempReservEntry.Positive := FALSE;
                TempReservEntry."Reservation Status" := TempReservEntry."Reservation Status"::Surplus;
                TempReservEntry.VALIDATE("Quantity (Base)", -TempReservEntry."Quantity (Base)");
                TempReservEntry.UpdateItemTracking;
                TempReservEntry.INSERT;
            UNTIL WhseItemTrackingLine.NEXT = 0;
    end;

    local procedure SynchronizeWhseItemTracking(var TrackingSpecification: Record "Tracking Specification")
    var
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
        EntryNo: Integer;
    begin
        // documents which have defined item tracking - table 337 will have to synchronize these records with 6550 table for invt. movement
        IF WhseItemTrackingLine.FINDLAST THEN
            EntryNo := WhseItemTrackingLine."Entry No.";
        EntryNo += 1;
        CLEAR(WhseItemTrackingLine);
        WhseItemTrackingLine.TRANSFERFIELDS(TrackingSpecification);
        WhseItemTrackingLine.VALIDATE("Quantity (Base)", ABS(WhseItemTrackingLine."Quantity (Base)"));
        WhseItemTrackingLine.VALIDATE("Qty. to Invoice (Base)", ABS(WhseItemTrackingLine."Qty. to Invoice (Base)"));
        WhseItemTrackingLine."Entry No." := EntryNo;
        WhseItemTrackingLine.INSERT;
    end;


    procedure MoveWhseComments(InternalMovementHeader: Record "Internal Movement Header"; InvtMovementNo: Code[20])
    var
        WhseCommentLine: Record "Warehouse Comment Line";
        WhseCommentLine2: Record "Warehouse Comment Line";
    begin
        WhseCommentLine.SETRANGE("Table Name", WhseCommentLine."Table Name"::"Internal Movement");
        WhseCommentLine.SETRANGE("No.", InternalMovementHeader."No.");
        WhseCommentLine.LOCKTABLE;

        IF WhseCommentLine.FIND('-') THEN BEGIN
            REPEAT
                WhseCommentLine2.INIT;
                WhseCommentLine2 := WhseCommentLine;
                WhseCommentLine2."Table Name" := WhseCommentLine2."Table Name"::"Whse. Activity Header";
                WhseCommentLine2.Type := WhseCommentLine.Type::"Invt. Movement";
                WhseCommentLine2."No." := InvtMovementNo;
                WhseCommentLine2.INSERT;
            UNTIL WhseCommentLine.NEXT = 0;
            WhseCommentLine.DELETEALL;
        END;
    end;


    procedure GetExpiredItemMessage(): Text[100]
    begin
        EXIT(ExpiredItemMessageText);
    end;

    local procedure PickStrictExpirationPosting(ItemNo: Code[20]): Boolean
    begin
        EXIT(ItemTrackingMgt.StrictExpirationPosting(ItemNo) AND (SNRequired OR LNRequired));
    end;

    local procedure MakeHeader()
    begin
        IF AutoCreation AND NOT LineCreated THEN BEGIN
            WhseActivHeader."No." := '';
            WhseActivHeader.INSERT(TRUE);
            UpdateWhseActivHeader(WhseRequest);
            NextLineNo := 10000;
            COMMIT;
        END;
    end;

    local procedure MakeLine(var NewWhseActivLine: Record "Warehouse Activity Line"; TakeBinCode: Code[20]; QtyToPickBase: Decimal; var RemQtyToPickBase: Decimal)
    var
        PlaceBinCode: Code[20];
    begin
        PlaceBinCode := NewWhseActivLine."Bin Code";

        NewWhseActivLine."No." := WhseActivHeader."No.";
        NewWhseActivLine."Line No." := NextLineNo;
        IF Location."Bin Mandatory" THEN BEGIN
            NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Take;
            NewWhseActivLine."Bin Code" := TakeBinCode;
        END ELSE
            NewWhseActivLine."Shelf No." := GetShelfNo(NewWhseActivLine."Item No.");
        NewWhseActivLine.Quantity := NewWhseActivLine.CalcQty(QtyToPickBase);
        NewWhseActivLine."Qty. (Base)" := QtyToPickBase;
        NewWhseActivLine."Qty. Outstanding" := NewWhseActivLine.Quantity;
        NewWhseActivLine."Qty. Outstanding (Base)" := NewWhseActivLine."Qty. (Base)";
        NewWhseActivLine."Qty. to Handle" := NewWhseActivLine.Quantity; // NUB1.01
        NewWhseActivLine."Qty. to Handle (Base)" := NewWhseActivLine."Qty. (Base)"; // NUB1.01
        RemQtyToPickBase := RemQtyToPickBase - QtyToPickBase;
        IF NewWhseActivLine."Lot No." <> '' THEN    ////
            NewWhseActivLine.INSERT;

        IF Location."Bin Mandatory" AND IsInvtMovement THEN BEGIN
            // Place Action for inventory movement
            NextLineNo := NextLineNo + 10000;
            NewWhseActivLine."Line No." := NextLineNo;
            NewWhseActivLine."Action Type" := NewWhseActivLine."Action Type"::Place;
            NewWhseActivLine."Bin Code" := PlaceBinCode;
            NewWhseActivLine.INSERT;
        END;

        LineCreated := TRUE;
        NextLineNo := NextLineNo + 10000;
    end;

    local procedure CreateATOPickLine(NewWhseActivLine: Record "Warehouse Activity Line"; BinCode: Code[20]; var RemQtyToPickBase: Decimal)
    var
        ATOSalesLine: Record "Sales Line";
        AsmHeader: Record "Assembly Header";
        AssemblySetup: Record "Assembly Setup";
        ReservationEntry: Record "Reservation Entry";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
        QtyToAsmBase: Decimal;
        QtyToPickBase: Decimal;
        MovementsCreated: Integer;
        TotalMovementsCreated: Integer;
        WhseItemTrackingSetup: Record "Item Tracking Setup" temporary;
    begin
        IF (NOT IsInvtMovement) AND
           WMSMgt.GetATOSalesLine(NewWhseActivLine."Source Type",
             NewWhseActivLine."Source Subtype",
             NewWhseActivLine."Source No.",
             NewWhseActivLine."Source Line No.",
             ATOSalesLine)
        THEN BEGIN
            ATOSalesLine.AsmToOrderExists(AsmHeader);
            IF (NewWhseActivLine."Serial No." <> '') OR (NewWhseActivLine."Lot No." <> '') THEN BEGIN
                AssemblyHeaderReserve.FilterReservFor(ReservationEntry, AsmHeader);
                ReservationEntry.SETRANGE("Serial No.", NewWhseActivLine."Serial No.");
                ReservationEntry.SETRANGE("Lot No.", NewWhseActivLine."Lot No.");
                ReservationEntry.SETRANGE(Positive, TRUE);
                IF ItemTrackingMgt.SumUpItemTracking(ReservationEntry, TempTrackingSpecification, TRUE, TRUE) THEN
                    QtyToAsmBase := ABS(TempTrackingSpecification."Qty. to Handle (Base)");
            END ELSE
                QtyToAsmBase := ATOSalesLine.QtyToAsmBaseOnATO;
            QtyToPickBase := QtyToAsmBase -
              //WMSMgt.CalcQtyBaseOnATOInvtPick(ATOSalesLine, NewWhseActivLine."Serial No.", NewWhseActivLine."Lot No.");//B2BUPG
              WMSMgt.CalcQtyBaseOnATOInvtPick(ATOSalesLine, WhseItemTrackingSetup);
            IF QtyToPickBase > 0 THEN BEGIN
                MakeHeader;
                IF Location."Bin Mandatory" AND (BinCode = '') THEN
                    ATOSalesLine.GetATOBin(Location, BinCode);
                NewWhseActivLine."Assemble to Order" := TRUE;
                MakeLine(NewWhseActivLine, BinCode, QtyToPickBase, RemQtyToPickBase);

                AssemblySetup.GET;
                IF AssemblySetup."Create Movements Automatically" THEN BEGIN
                    AsmHeader.CreateInvtMovement(TRUE, PrintDocument, ShowError, MovementsCreated, TotalMovementsCreated);
                    ATOInvtMovementsCreated += MovementsCreated;
                    TotalATOInvtMovementsToBeCreated += TotalMovementsCreated;
                END;
            END;
        END;
    end;


    procedure GetATOMovementsCounters(var MovementsCreated: Integer; var TotalMovementsCreated: Integer)
    begin
        MovementsCreated := ATOInvtMovementsCreated;
        TotalMovementsCreated := TotalATOInvtMovementsToBeCreated;
    end;
}

