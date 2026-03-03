codeunit 60000 EventsandSubscribers
{
    trigger OnRun()
    begin

    end;


    // OBJECT Codeunit 22 Item Jnl.-Post Line

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        //NUB1.01 Start
        IF NewItemLedgEntry."Reason Code" <> '' THEN
            NewItemLedgEntry."Reason Code" := ItemJournalLine."Reason Code";
        //NUB1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertPhysInvtLedgEntry', '', false, false)]

    local procedure OnBeforeInsertPhysInvtLedgEntry(var PhysInventoryLedgerEntry: Record "Phys. Inventory Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; LastSplitItemJournalLine: Record "Item Journal Line")
    var

        ItemJnlLine: Record "Item Journal Line";
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
    begin
        //XferCustomFields.ItemJnlLineTOPhysInvtLedgEntry(ItemJnlLine, PhysInvtLedgEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; var ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemJnlLine: Record "Item Journal Line";

    begin
        //XferCustomFields.ItemJnlLineTOValueEntry(ItemJnlLine, ValueEntry);
    end;
    // OBJECT Codeunit 22 Item Jnl.-Post Line

    //OBJECT Codeunit 23 Item Jnl.-Post Batch
    //OBJECT Codeunit 23 Item Jnl.-Post Batch

    //OBJECT Codeunit 23 Item Jnl.-Post Batch


    //OBJECT Codeunit 80 Sales-Post


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader', '', false, false)]
    local procedure OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    begin

        //NUB1.01 Start
        SalesShptHeader."Assigned User ID" := USERID;
        SalesShptHeader."Created Date & Time" := CURRENTDATETIME; //NUB1.02
        //NUB1.01 End
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertPostedHeadersOnAfterCalcShouldInsertInvoiceHeader', '', false, false)]
    local procedure OnInsertPostedHeadersOnAfterCalcShouldInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var ShouldInsertInvoiceHeader: Boolean)
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        //NUB1.01 Start
        SalesInvHeader."Assigned User ID" := SalesHeader."Assigned User ID";
        //NUB1.01 End
    end;


    //OBJECT Codeunit 80 Sales-Post




    //OBJECT Codeunit 6501 Item Tracking Data Collection
    PROCEDURE CreateEntrySummaryFEFO(Location: Record Location; ItemNo: Code[20]; VariantCode: Code[10]; UseExpDates: Boolean);
    BEGIN
        InitEntrySummaryFEFO;
        LastSummaryEntryNo := 0;
        StrictExpirationPosting := ItemTrackingMgt.StrictExpirationPosting(ItemNo);

        SummarizeInventoryFEFO(Location, ItemNo, VariantCode, UseExpDates);
        IF UseExpDates THEN
            SummarizeAdjustmentBinFEFO(Location, ItemNo, VariantCode);
    END;

    PROCEDURE InsertEntrySummaryFEFO(LotNo: Code[20]; SerialNo: Code[20]; ExpirationDate: Date);
    var

        HasExpiredItems: Boolean;
    BEGIN
        IF (NOT StrictExpirationPosting) OR (ExpirationDate >= WORKDATE) THEN BEGIN
            TempGlobalEntrySummaryFEFO.INIT;
            TempGlobalEntrySummaryFEFO."Entry No." := LastSummaryEntryNo + 1;
            TempGlobalEntrySummaryFEFO."Serial No." := SerialNo;
            TempGlobalEntrySummaryFEFO."Lot No." := LotNo;
            TempGlobalEntrySummaryFEFO."Expiration Date" := ExpirationDate;
            TempGlobalEntrySummaryFEFO.INSERT;
            LastSummaryEntryNo := TempGlobalEntrySummaryFEFO."Entry No.";
        END ELSE
            HasExpiredItems := TRUE;
    END;

    PROCEDURE InitEntrySummaryFEFO();
    BEGIN
        TempGlobalEntrySummaryFEFO.DELETEALL;
        TempGlobalEntrySummaryFEFO.RESET;
        TempGlobalEntrySummaryFEFO.SETCURRENTKEY("Lot No.", "Serial No.");
    END;


    LOCAL PROCEDURE SummarizeInventoryFEFO(Location: Record Location; ItemNo: Code[20]; VariantCode: Code[10]; HasExpirationDate: Boolean);
    VAR
        ItemLedgEntry: Record "Item Ledger Entry";
    BEGIN
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
        ItemLedgEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SETRANGE("Variant Code", VariantCode);
        ItemLedgEntry.SETRANGE(Positive, TRUE);
        IF HasExpirationDate THEN
            ItemLedgEntry.SETFILTER("Expiration Date", '<>%1', 0D)
        ELSE
            ItemLedgEntry.SETRANGE("Expiration Date", 0D);
        ItemLedgEntry.SETRANGE("Location Code", Location.Code);
        IF ItemLedgEntry.ISEMPTY THEN
            EXIT;

        IF ItemLedgEntry.FINDSET THEN
            REPEAT
                IF NOT EntrySummaryFEFOExists(ItemLedgEntry."Lot No.", ItemLedgEntry."Serial No.") THEN
                    InsertEntrySummaryFEFO(ItemLedgEntry."Lot No.", ItemLedgEntry."Serial No.", ItemLedgEntry."Expiration Date");
            UNTIL ItemLedgEntry.NEXT = 0;
    END;

    PROCEDURE EntrySummaryFEFOExists(LotNo: Code[20]; SerialNo: Code[20]): Boolean;
    BEGIN
        TempGlobalEntrySummaryFEFO.SETRANGE("Lot No.", LotNo);
        TempGlobalEntrySummaryFEFO.SETRANGE("Serial No.", SerialNo);
        EXIT(TempGlobalEntrySummaryFEFO.FINDSET);
    END;

    LOCAL PROCEDURE SummarizeAdjustmentBinFEFO(Location: Record Location; ItemNo: Code[20]; VariantCode: Code[10]);
    VAR
        WhseEntry: Record "Warehouse Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExpirationDate: Date;
        EntriesExist: Boolean;
        WhseItemTrackingSetup: Record "Item Tracking Setup" temporary;
    BEGIN
        IF Location."Adjustment Bin Code" = '' THEN
            EXIT;

        WhseEntry.RESET;
        WhseEntry.SETCURRENTKEY("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
        WhseEntry.SETRANGE("Item No.", ItemNo);
        WhseEntry.SETRANGE("Bin Code", Location."Adjustment Bin Code");
        WhseEntry.SETRANGE("Location Code", Location.Code);
        WhseEntry.SETRANGE("Variant Code", VariantCode);
        IF WhseEntry.ISEMPTY THEN
            EXIT;

        IF WhseEntry.FINDSET THEN
            REPEAT
                IF NOT EntrySummaryFEFOExists(WhseEntry."Lot No.", WhseEntry."Serial No.") THEN BEGIN
                    ExpirationDate :=
                      ItemTrackingMgt.WhseExistingExpirationDate(
                        WhseEntry."Item No.", WhseEntry."Variant Code", Location, WhseItemTrackingSetup, EntriesExist);

                    IF NOT EntriesExist THEN
                        ExpirationDate := 0D;

                    InsertEntrySummaryFEFO(WhseEntry."Lot No.", WhseEntry."Serial No.", ExpirationDate);
                END;
            UNTIL WhseEntry.NEXT = 0;
    END;

    PROCEDURE FindFirstEntrySummaryFEFO(VAR EntrySummary: Record "Entry Summary"): Boolean;
    BEGIN
        TempGlobalEntrySummaryFEFO.RESET;
        TempGlobalEntrySummaryFEFO.SETCURRENTKEY("Expiration Date");

        IF NOT TempGlobalEntrySummaryFEFO.FIND('-') THEN
            EXIT(FALSE);

        EntrySummary := TempGlobalEntrySummaryFEFO;
        EXIT(TRUE);
    END;

    PROCEDURE FindNextEntrySummaryFEFO(VAR EntrySummary: Record "Entry Summary"): Boolean;
    var
        TempGlobalEntrySummaryFEFO: record "Entry Summary";
    BEGIN
        IF TempGlobalEntrySummaryFEFO.NEXT = 0 THEN
            EXIT(FALSE);

        EntrySummary := TempGlobalEntrySummaryFEFO;
        EXIT(TRUE);
    END;

    PROCEDURE GetHasExpiredItems(): Boolean;


    BEGIN
        EXIT(HasExpiredItems);
    END;

    PROCEDURE GetResultMessageForExpiredItem(): Text[100];
    BEGIN
        IF HasExpiredItems THEN
            EXIT(Text012);
        EXIT('');
    END;


    //OBJECT Codeunit 6501 Item Tracking Data Collection


    // Object codeunit 7323 "Whse.-Act.-Post (Yes/No)"

    PROCEDURE ManualInvtPickPost(PostedSourceTypePar: Integer; PostedSourceNoPar: Code[20]);
    BEGIN
        ManualInvtPickPostVarGbl := TRUE;
        PostedSourceTypeVarGbl := PostedSourceTypePar;
        PostedSourceNoVarGbl := PostedSourceNoPar;
    END;
    // Object codeunit 7323 "Whse.-Act.-Post (Yes/No)"


    //codeunit 6500 "Item Tracking Management"

    PROCEDURE CallItemTrackingEntryForm(SourceType: option ,Customer,Vendor,Item; SourceNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20]; SerialNo: Code[20]; LotNo: Code[20]; LocationCode: Code[10])
    var
        ItemLedgEntry: record "Item Ledger Entry";
        TempItemLedgEntry: record "Item Ledger Entry";
        Item: record Item;
        Window: Dialog;
        Text004: label 'Counting records...';

    begin

        Window.OPEN(Text004);

        IF SourceNo <> '' THEN BEGIN
            ItemLedgEntry.SETCURRENTKEY("Source Type", "Source No.", "Item No.", "Variant Code");
            ItemLedgEntry.SETRANGE("Source No.", SourceNo);
            ItemLedgEntry.SETRANGE("Source Type", SourceType);
        END ELSE
            ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code");

        IF LocationCode <> '' THEN
            ItemLedgEntry.SETRANGE("Location Code", LocationCode);

        IF ItemNo <> '' THEN BEGIN
            Item.GET(ItemNo);
            Item.TESTFIELD("Item Tracking Code");
            ItemLedgEntry.SETRANGE("Item No.", ItemNo);
        END;
        IF SourceType = 0 THEN
            ItemLedgEntry.SETRANGE("Variant Code", VariantCode);
        IF SerialNo <> '' THEN
            ItemLedgEntry.SETRANGE("Serial No.", SerialNo);
        IF LotNo <> '' THEN
            ItemLedgEntry.SETRANGE("Lot No.", LotNo);

        IF ItemLedgEntry.FINDSET THEN
            REPEAT
                IF (ItemLedgEntry."Serial No." <> '') OR (ItemLedgEntry."Lot No." <> '') THEN BEGIN
                    TempItemLedgEntry := ItemLedgEntry;
                    TempItemLedgEntry.INSERT;
                END
            UNTIL ItemLedgEntry.NEXT = 0;
        Window.CLOSE;
        PAGE.RUNMODAL(PAGE::"Item Tracking Entries", TempItemLedgEntry);
    end;



    //codeunit 6500 "Item Tracking Management"


    ///Tables .......///tables

    ///table 8 Language
    procedure GetUserLanguage(Code: code[10])
    begin
        CLEAR(LanguageGrec);
        LanguageGrec.SETRANGE("Windows Language ID", GLOBALLANGUAGE);
        IF LanguageGrec.FINDFIRST THEN;
        LanguageGrec.SETRANGE("Windows Language ID");

    end;

    procedure GetLanguageID(LanguageCode: code[10]): Integer
    begin

        CLEAR(LanguageGrec);
        IF LanguageCode <> '' THEN
            IF LanguageGrec.GET(LanguageCode) THEN
                EXIT(LanguageGrec."Windows Language ID");
        LanguageGrec."Windows Language ID" := GLOBALLANGUAGE;
        EXIT(LanguageGrec."Windows Language ID");

    end;
    ///table 8 Language
    //table 110 "Sales Shipment Header"  PROCEDURE StartTrackingSite

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Header", 'OnBeforeStartTrackingSite', '', false, false)]
    local procedure OnBeforeStartTrackingSite(var SalesShipmentHeader: Record "Sales Shipment Header"; var IsHandled: Boolean)
    var
        PackageTrackingNo: Text[30];
    begin
        IsHandled := true;

        IF PackageTrackingNo = '' THEN
#pragma warning disable AL0432
            PackageTrackingNo := SalesShipmentHeader."Package Tracking No.";
#pragma warning restore AL0432

    END;
    //table 110 "Sales Shipment Header"  PROCEDURE StartTrackingSite

    //table 112 "Sales Invoice Header"  and  table 110 "Sales Shipment Header"  PROCEDURE StartTrackingSite ///table 114 "Sales Cr.Memo Header"
    procedure GetSalesPersonFilter(): Code[10]
    begin
        EXIT(GetSalesPersonFilter2(USERID));
    end;

    procedure GetSalesPersonFilter2(UserCode: Code[50]): Code[20]
    begin

        //NUB1.01 Start
        IF UserSetup.GET(UserCode) AND (UserCode <> '') THEN
            IF UserSetup."Salespers./Purch. Code" <> '' THEN
                SalesUserSalesPerson := UserSetup."Salespers./Purch. Code";
        EXIT(SalesUserSalesPerson);
        //NUB1.01 Ens

    end;
    //table 112 "Sales Invoice Header"  and  table 110 "Sales Shipment Header"  PROCEDURE StartTrackingSite ///table 114 "Sales Cr.Memo Header"





    ///Warehouse Activity Line
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnValidateBinCodeOnAfterCalcQtyAvailBase', '', true, true)]
    local procedure "Warehouse Activity Line_OnValidateBinCodeOnAfterCalcQtyAvailBase"
   (
       var WarehouseActivityLine: Record "Warehouse Activity Line";
       QtyAvailBase: Decimal;
       NewBinCode: Code[20]
   )
    begin
        IF WarehouseActivityLine."Lot No." <> '' THEN
            BinContent.SETFILTER("Lot No. Filter", WarehouseActivityLine."Lot No."); // NUB1.02
    end;


    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnBeforeCheckExceedQtyAvailBase', '', true, true)]
    local procedure "Warehouse Activity Line_OnBeforeCheckExceedQtyAvailBase"
    (
        var WarehouseActivityLine: Record "Warehouse Activity Line";
        QtyAvailBase: Decimal;
        NewBinCode: Code[20];
        var IsHandled: Boolean
    )
    var
        Text_BinQty: Label 'The %1 %2 exceeds the quantity available to pick %3 of the %4.';
    begin
        IsHandled := true;

        if (QtyAvailBase < WarehouseActivityLine."Qty. Outstanding (Base)") and not WarehouseActivityLine."Assemble to Order" then begin
            ERROR(Text_BinQty, WarehouseActivityLine.FieldCaption("Qty. Outstanding (Base)"), WarehouseActivityLine."Qty. Outstanding (Base)",
                   QtyAvailBase, BinContent.TableCaption());
            // NUB1.02 - end

            WarehouseActivityLine."Bin Code" := NewBinCode;
            WarehouseActivityLine.MODIFY;
        end;
    end;

    ///Warehouse Activity Line

    //codeunit 99000855 "Planning-Get Parameters"


    procedure AssignToArray(VAR ParamArray: ARRAY[15] OF Boolean; Bool1: Boolean; Bool2: Boolean; Bool3: Boolean; Bool4: Boolean; Bool5: Boolean; Bool6: Boolean; Bool7: Boolean; Bool8: Boolean; Bool9: Boolean; Bool10: Boolean; Bool11: Boolean; Bool12: Boolean; Bool13: Boolean; Bool14: Boolean; Bool15: Boolean)
    begin

        ParamArray[1] := Bool1;
        ParamArray[2] := Bool2;
        ParamArray[3] := Bool3;
        ParamArray[4] := Bool4;
        ParamArray[5] := Bool5;
        ParamArray[6] := Bool6;
        ParamArray[7] := Bool7;
        ParamArray[8] := Bool8;
        ParamArray[9] := Bool9;
        ParamArray[10] := Bool10;
        ParamArray[11] := Bool11;
        ParamArray[12] := Bool12;
        ParamArray[13] := Bool13;
        ParamArray[14] := Bool14;
        ParamArray[15] := Bool15;

    end;



    procedure SetUpPlanningControls(ReorderingPolicy: Enum "Reordering Policy"; IncludeInventory: Boolean; VAR TimeBucketEnabled: Boolean; VAR SafetyLeadTimeEnabled: Boolean; VAR SafetyStockQtyEnabled: Boolean; VAR ReorderPointEnabled: Boolean; VAR ReorderQuantityEnabled: Boolean; VAR MaximumInventoryEnabled: Boolean; VAR MinimumOrderQtyEnabled: Boolean; VAR MaximumOrderQtyEnabled: Boolean; VAR OrderMultipleEnabled: boolean; VAR IncludeInventoryEnabled: Boolean; var ReschedulingPeriodEnabled: Boolean; var LotAccumulationPeriodEnabled: Boolean; var DampenerPeriodEnabled: Boolean; var DampenerQuantityEnabled: Boolean; OverflowLevelEnabled: boolean)
    var
        ParamArray: ARRAY[15] OF Boolean;
    begin

        CASE ReorderingPolicy OF
            ReorderingPolicy::" ":
                AssignToArray(ParamArray, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE);
            ReorderingPolicy::"Fixed Reorder Qty.":
                AssignToArray(ParamArray, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE);
            ReorderingPolicy::"Maximum Qty.":
                AssignToArray(ParamArray, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE);
            ReorderingPolicy::Order:
                AssignToArray(ParamArray, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE);
            ReorderingPolicy::"Lot-for-Lot":
                AssignToArray(ParamArray, FALSE, TRUE, IncludeInventory, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE);
        END;

        TimeBucketEnabled := ParamArray[1];
        SafetyLeadTimeEnabled := ParamArray[2];
        SafetyStockQtyEnabled := ParamArray[3];
        ReorderPointEnabled := ParamArray[4];
        ReorderQuantityEnabled := ParamArray[5];
        MaximumInventoryEnabled := ParamArray[6];
        MinimumOrderQtyEnabled := ParamArray[7];
        MaximumOrderQtyEnabled := ParamArray[8];
        OrderMultipleEnabled := ParamArray[9];
        IncludeInventoryEnabled := ParamArray[10];
        ReschedulingPeriodEnabled := ParamArray[11];
        LotAccumulationPeriodEnabled := ParamArray[12];
        DampenerPeriodEnabled := ParamArray[13];
        DampenerQuantityEnabled := ParamArray[14];
        OverflowLevelEnabled := ParamArray[15];
    end;

    //codeunit 99000855 "Planning-Get Parameters"


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TESTFIELD("Salesperson Code");
            SalesHeader.TESTFIELD("Requested Delivery Date");
            SalesHeader.TESTFIELD("Shipping Agent Code");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnAfterUpdateWhseActivHeader, '', false, false)]
    local procedure "Create Inventory Pick/Movement_OnAfterUpdateWhseActivHeader"(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request"; Location: Record Location)
    var
        SalesHeader: Record "Sales Header";
    begin
        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Order" then begin
            SalesHeader.GET(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");
            WarehouseActivityHeader."Requested Delivery Date" := SalesHeader."Requested Delivery Date";  //NUB1.02
            WarehouseActivityHeader."Shipping Agent Code" := SalesHeader."Shipping Agent Code"; //NUB1.02
        end;
        WarehouseActivityHeader."Creation Date" := TODAY; //NUB1.04
    end;

    [EventSubscriber(ObjectType::Page, Page::"Lot Numbers by Bin FactBox", OnFillTempTableOnAfterPopulateLotNosByBinCodeFields, '', false, false)]
    local procedure "Lot Numbers by Bin FactBox_OnFillTempTableOnAfterPopulateLotNosByBinCodeFields"(var LotBinBuffer: Record "Lot Bin Buffer"; var LotNosByBinCode: Query "Lot Numbers by Bin")
    var
        BinContentRecGbl: Record "Bin Content";
    begin

        BinContentRecGbl.RESET;
        BinContentRecGbl.SETRANGE("Location Code", LotBinBuffer."Location Code");
        BinContentRecGbl.SETRANGE("Bin Code", LotBinBuffer."Bin Code");
        BinContentRecGbl.SETRANGE("Item No.", LotBinBuffer."Item No.");
        BinContentRecGbl.SETRANGE("Variant Code", LotBinBuffer."Variant Code");
        //BinContentRecGbl.SETRANGE("Unit of measure code","Unit of Measure Code");
        BinContentRecGbl.SETRANGE("Lot No. Filter", LotNosByBinCode.Lot_No);
        IF BinContentRecGbl.FINDFIRST THEN BEGIN
            LotBinBuffer."Available Qty. to Take" := BinContentRecGbl.CalcQtyAvailToTake(0);
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var Item: Record Item; var xItem: Record Item)
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        Commit();
        Item."Base Unit of Measure" := 'CASE';
        Item."Gen. Prod. Posting Group" := 'HERSHEY';
        Item."Inventory Posting Group" := 'ITEM';
        Item."Tax Group Code" := 'NONTAXABLE';
        Item."Item Tracking Code" := 'LOT';
        Item."Lot Nos." := 'LOT';
        Item."Costing Method" := Item."Costing Method"::FIFO;
        Item."Order Tracking Policy" := Item."Order Tracking Policy"::None;
        Item."Replenishment System" := Item."Replenishment System"::Purchase;
        Item."Flushing Method" := Item."Flushing Method"::Manual;

        if not ItemUnitOfMeasure.Get(Item."No.", Item."Base Unit of Measure") then begin
            ItemUnitOfMeasure.Init();
            if item.IsTemporary then
                ItemUnitOfMeasure."Item No." := item."No."
            else
                ItemUnitOfMeasure."Item No." := item."No.";
            ItemUnitOfMeasure.Code := item."Base Unit of Measure";
            ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
            ItemUnitOfMeasure.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterInitRecord, '', false, false)]
    local procedure OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Assigned User ID" := USERID;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, "Item No.", false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Item Journal Line")
    begin
        if Rec."Journal Template Name" = 'RECLASS' then
            Rec."New Location Code" := Rec."Location Code";
    end;

    var
        myInt: Integer;
        LanguageGrec: Record Language;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        StrictExpirationPosting: Boolean;
        LastSummaryEntryNo: Integer;
        TempGlobalEntrySummaryFEFO: record "Entry Summary";
        ItemTrackingDataCollection: codeunit "Item Tracking Data Collection";
        HasExpiredItems: Boolean;
        Text012: Label '\\Some items were not included in the pick due to their expiration date.';
        "-NUB1.01-": Integer;
        ManualInvtPickPostVarGbl: Boolean;
        PostedSourceTypeVarGbl: Integer;
        PostedSourceNoVarGbl: Code[20];
        "--NUB1.01--": TextConst;
        Text50000: label 'Do you want to post the %1?';
        UserSetup: record "User Setup";
        SalesUserSalesPerson: Code[20];
        BinContent: Record "Bin Content";
        //XferCustomFields: codeunit "Transfer Custom Fields";
        HasGotSalesUserSetup: Boolean;
        SalesUserRespCenter: code[10];
        UserLocation: code[10];
        CompanyInfo: Record "Company Information";
}