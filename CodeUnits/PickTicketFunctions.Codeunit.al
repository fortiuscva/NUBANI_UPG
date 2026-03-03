codeunit 50021 PickTicketFunctions
{

    trigger OnRun()
    begin
    end;


    procedure doesPickTicketExist(PickTicketNo: Text; LocationCode: Text) exists: Boolean
    var
        PickTicket: Record "Warehouse Activity Line";
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        exists := NOT PickTicket.ISEMPTY;
    end;


    procedure doesPickTicketItemExist(PickTicketNo: Text; ItemNo: Text; LocationCode: Text) exists: Boolean
    var
        PickTicket: Record "Warehouse Activity Line";
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        exists := NOT PickTicket.ISEMPTY;
    end;


    procedure doesPickTicketItemLotExist(PickTicketNo: Text; ItemNo: Text; LotNo: Text; LocationCode: Text) exists: Boolean
    var
        PickTicket: Record "Warehouse Activity Line";
        ExpDate: Date;
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF NOT EVALUATE(ExpDate, LotNo) THEN BEGIN
            ExpDate := 0D;
        END;
        PickTicket.SETRANGE("Expiration Date", ExpDate);


        exists := NOT PickTicket.ISEMPTY;
    end;


    procedure doesPickTicketItemLotBinExist(PickTicketNo: Text; ItemNo: Text; LotNo: Text; BinNo: Text; LocationCode: Text) exists: Boolean
    var
        PickTicket: Record "Warehouse Activity Line";
        ExpDate: Date;
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF NOT EVALUATE(ExpDate, LotNo) THEN BEGIN
            ExpDate := 0D;
        END;
        PickTicket.SETRANGE("Expiration Date", ExpDate);
        PickTicket.SETRANGE("Bin Code", BinNo);
        exists := NOT PickTicket.ISEMPTY;
    end;


    procedure getItemDescription(itemNo: Text) description: Text
    var
        ItemRec: Record Item;
    begin
        ItemRec.SETRANGE("No.", itemNo);
        IF ItemRec.FIND('-') THEN BEGIN
            description := ItemRec.Description;
        END;
    end;


    procedure getLotsByPickTicketItem(PickTicketNo: Text; ItemNo: Text; LocationCode: Text) Lots: Text[1000]
    var
        PickTicket: Record "Warehouse Activity Line";
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF PickTicket.FIND('-') THEN BEGIN
            REPEAT
                Lots += FORMAT(PickTicket."Expiration Date") + ';';
            UNTIL PickTicket.NEXT = 0;
        END;

        IF PickTicket.ISEMPTY THEN
            Lots := '';
    end;


    procedure getPicketTicketItemBinLotPickQuantity(PickTicketNo: Text; ItemNo: Text; LotNo: Text; BinNo: Text; LocationCode: Text) PickQty: Decimal
    var
        PickTicket: Record "Warehouse Activity Line";
        ExpDate: Date;
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF NOT EVALUATE(ExpDate, LotNo) THEN BEGIN
            ExpDate := 0D;
        END;
        PickTicket.SETRANGE("Expiration Date", ExpDate);
        PickTicket.SETRANGE("Bin Code", BinNo);

        IF PickTicket.FIND('-') THEN BEGIN
            REPEAT
                PickQty += PickTicket."Pick Qty.";
            UNTIL PickTicket.NEXT = 0;
        END;

        IF PickTicket.ISEMPTY THEN
            PickQty := -1;
    end;


    procedure getPicketTicketItemBinLotQuantity(PickTicketNo: Text; ItemNo: Text; LotNo: Text; BinNo: Text; LocationCode: Text) Quantity: Decimal
    var
        PickTicket: Record "Warehouse Activity Line";
        ExpDate: Date;
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF NOT EVALUATE(ExpDate, LotNo) THEN BEGIN
            ExpDate := 0D;
        END;
        PickTicket.SETRANGE("Expiration Date", ExpDate);
        PickTicket.SETRANGE("Bin Code", BinNo);

        IF PickTicket.FIND('-') THEN BEGIN
            REPEAT
                Quantity += PickTicket.Quantity;
            UNTIL PickTicket.NEXT = 0;
        END;

        IF PickTicket.ISEMPTY THEN
            Quantity := -1;
    end;


    procedure setPicketTicketItemBinLotQuantity(PickTicketNo: Text; ItemNo: Text; LotNo: Text; BinNo: Text; pickQty: Decimal; LocationCode: Text)
    var
        PickTicket: Record "Warehouse Activity Line";
        ExpDate: Date;
    begin
        PickTicket.SETRANGE("Location Code", LocationCode);
        PickTicket.SETRANGE("No.", PickTicketNo);
        PickTicket.SETRANGE("Item No.", ItemNo);
        IF NOT EVALUATE(ExpDate, LotNo) THEN BEGIN
            ExpDate := 0D;
        END;
        PickTicket.SETRANGE("Expiration Date", ExpDate);
        PickTicket.SETRANGE("Bin Code", BinNo);
        IF PickTicket.FINDFIRST THEN BEGIN
            PickTicket."Pick Qty." := pickQty;
            PickTicket.MODIFY
        END
    end;
}

