codeunit 50101 "NUB Item Tracking Data Collect"
{
    Permissions = TableData "Item Entry Relation" = rd,
                  TableData "Value Entry Relation" = rd;

    trigger OnRun()
    begin
    end;

    var
        TempGlobalReservEntry: Record "Reservation Entry" temporary;
        TempGlobalAdjustEntry: Record "Reservation Entry" temporary;
        TempGlobalEntrySummary: Record "Entry Summary" temporary;
        TempGlobalChangedEntrySummary: Record "Entry Summary" temporary;
        CurrItemTrackingCode: Record "Item Tracking Code";
        TempGlobalTrackingSpec: Record "Tracking Specification" temporary;
        CurrBinCode: Code[20];
        LastSummaryEntryNo: Integer;
        LastReservEntryNo: Integer;
        FullGlobalDataSetExists: Boolean;
        SkipLot: Boolean;
        DirectTransfer: Boolean;
        HideValidationDialog: Boolean;

#pragma warning disable AA0074
        Text004: Label 'Counting records...';
#pragma warning restore AA0074
        AvailabilityWarningsMsg: Label 'The data used for availability calculation has been updated.\There are availability warnings on one or more lines.';
        NoAvailabilityWarningsMsg: Label 'The data used for availability calculation has been updated.\There are no availability warnings.';
        ListTxt: Label '%1 List', Comment = '%1 - field caption';
#pragma warning disable AA0074
        AvailabilityText: Label '%1 %2 - Availability', Comment = '%1 - tracking field caption, %2 - field value';
        Text011: Label 'Item Tracking - Select Entries';
#pragma warning restore AA0074
        PartialGlobalDataSetExists: Boolean;
#pragma warning disable AA0074
        Text013: Label 'Neutralize consumption/output';
#pragma warning restore AA0074
        LotNoBySNNotFoundErr: Label 'A lot number could not be found for serial number %1.', Comment = '%1 - serial number.';
        PackageNoBySNNotFoundErr: Label 'A package number could not be found for serial number %1.', Comment = '%1 - serial number.';
        Text009: Label '%1 List';

    procedure SelectLotSerialNo(VAR TrackingSpecification: Record "Tracking Specification" TEMPORARY; SearchForSupply: Boolean; CurrentSignFactor: Integer; LookupMode: option "Serial No.","Lot No."; MaxQuantity: Decimal): Decimal
    var
        ItemTrackingSummaryForm: Page "Item Tracking Summary";
        RemQty: Decimal;
        InsufficientTracking: Boolean;
        SalesLineLRec: Record "Sales Line";
        ItemLRec: Record Item;
        NextReservEntryRec: Record "Reservation Entry";
        ReservEntry: Record "Reservation Entry";
        NextReserEntryNo: Integer;
    begin

        IF NOT FullGlobalDataSetExists THEN BEGIN
            ReservEntry.RESET;
            ReservEntry.SETRANGE("Source Type", 37);
            ReservEntry.SETRANGE("Source Subtype", 1);
            ReservEntry.SETRANGE("Source ID", TrackingSpecification."Source ID");
            ReservEntry.SETRANGE("Source Ref. No.", TrackingSpecification."Source Ref. No.");
            ReservEntry.SETRANGE(Positive, FALSE);
            ReservEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
            ReservEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");
            ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Surplus);
            ReservEntry.DELETEALL;
            RetrieveLookupData(TrackingSpecification, TRUE);
        END;

        TempGlobalReservEntry.RESET;
        TempGlobalEntrySummary.RESET;




        // Select the proper key on form
        TempGlobalEntrySummary.SETCURRENTKEY("Expiration Date");
        TempGlobalEntrySummary.SETFILTER("Expiration Date", '<>%1', 0D);
        IF TempGlobalEntrySummary.ISEMPTY THEN
            TempGlobalEntrySummary.SETCURRENTKEY("Lot No.", "Serial No.");
        TempGlobalEntrySummary.SETRANGE("Expiration Date");
        ItemTrackingSummaryForm.SETTABLEVIEW(TempGlobalEntrySummary);

        TempGlobalEntrySummary.SETCURRENTKEY("Lot No.", "Serial No.");
        CASE LookupMode OF
            LookupMode::"Serial No.":
                BEGIN
                    IF TrackingSpecification."Lot No." <> '' THEN
                        TempGlobalEntrySummary.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
                    TempGlobalEntrySummary.SETRANGE("Serial No.", TrackingSpecification."Serial No.");
                    IF TempGlobalEntrySummary.FINDFIRST THEN
                        ItemTrackingSummaryForm.SETRECORD(TempGlobalEntrySummary);
                    TempGlobalEntrySummary.SETFILTER("Serial No.", '<>%1', '');
                    TempGlobalEntrySummary.SETFILTER("Table ID", '<>%1', 0);
                    ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(Text009, TempGlobalReservEntry.FIELDCAPTION("Serial No."));
                END;
            LookupMode::"Lot No.":
                BEGIN
                    IF TrackingSpecification."Serial No." <> '' THEN
                        TempGlobalEntrySummary.SETRANGE("Serial No.", TrackingSpecification."Serial No.")
                    ELSE
                        TempGlobalEntrySummary.SETRANGE("Serial No.", '');
                    TempGlobalEntrySummary.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
                    IF TempGlobalEntrySummary.FINDFIRST THEN
                        ItemTrackingSummaryForm.SETRECORD(TempGlobalEntrySummary);
                    TempGlobalEntrySummary.SETFILTER("Lot No.", '<>%1', '');
                    TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '> %1', 0); //NUB1.02
                    ItemTrackingSummaryForm.CAPTION := STRSUBSTNO(Text009, TempGlobalEntrySummary.FIELDCAPTION("Lot No."));
                END;
        END;

        ItemTrackingSummaryForm.SetCurrentBinAndItemTrkgCode(CurrBinCode, CurrItemTrackingCode);
        ItemTrackingSummaryForm.SetSources(TempGlobalReservEntry, TempGlobalEntrySummary);
        ItemTrackingSummaryForm.LOOKUPMODE(SearchForSupply);
        ItemTrackingSummaryForm.SetSelectionMode(FALSE);

        RemQty := MaxQuantity;
        InsufficientTracking := FALSE;
        IF TempGlobalEntrySummary.FINDSET THEN BEGIN
            REPEAT
                RemQty -= TempGlobalEntrySummary."Total Available Quantity";
            UNTIL (TempGlobalEntrySummary.NEXT = 0) OR (RemQty <= 0);
            IF RemQty > 0 THEN
                InsufficientTracking := TRUE;
            TempGlobalEntrySummary.FINDFIRST;
        END ELSE
            InsufficientTracking := TRUE;

        SalesLineLRec.RESET;
        IF SalesLineLRec.GET(TrackingSpecification."Source Subtype", TrackingSpecification."Source ID", TrackingSpecification."Source Ref. No.") THEN;

        IF ItemLRec.GET(TrackingSpecification."Item No.") THEN;

        IF InsufficientTracking THEN BEGIN
            MESSAGE('Quantity Error - please specify Lots Manually in Sales Order %1 for sales line %2', TrackingSpecification."Source ID", TrackingSpecification."Source Ref. No.");
            MaxQuantity := 0;
        END ELSE BEGIN
            RemQty := MaxQuantity;

            IF TempGlobalEntrySummary.FINDSET THEN BEGIN
                REPEAT

                    RemQty -= TempGlobalEntrySummary."Total Available Quantity";
                    IF NextReservEntryRec.FINDLAST THEN
                        NextReserEntryNo := NextReservEntryRec."Entry No." + 1
                    ELSE
                        NextReserEntryNo := 1;

                    ReservEntry.INIT;
                    ReservEntry."Entry No." := NextReserEntryNo;
                    ReservEntry."Item No." := TrackingSpecification."Item No.";
                    ReservEntry."Location Code" := TrackingSpecification."Location Code";
                    ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                    ReservEntry."Creation Date" := WORKDATE;
                    ReservEntry."Created By" := USERID;
                    ReservEntry.Positive := FALSE;
                    ReservEntry."Source Type" := 37;
                    ReservEntry."Source Subtype" := 1;
                    ReservEntry."Source ID" := TrackingSpecification."Source ID";
                    ReservEntry."Source Ref. No." := TrackingSpecification."Source Ref. No.";
                    ReservEntry."Qty. per Unit of Measure" := TrackingSpecification."Qty. per Unit of Measure";

                    IF RemQty > 0 THEN
                        ReservEntry.VALIDATE("Quantity (Base)", (CurrentSignFactor * TempGlobalEntrySummary."Total Available Quantity"))
                    ELSE
                        ReservEntry.VALIDATE("Quantity (Base)", (CurrentSignFactor * (RemQty + TempGlobalEntrySummary."Total Available Quantity")));

                    //   {
                    //   IF RemQty > 0 THEN
                    //                     ReservEntry.VALIDATE("Quantity (Base)", (CurrentSignFactor * TempGlobalEntrySummary."Total Available Quantity"))
                    //                 ELSE
                    //                     ReservEntry.VALIDATE("Quantity (Base)", (CurrentSignFactor * (RemQty + TempGlobalEntrySummary."Total Available Quantity")));
                    //   }

                    ReservEntry."Serial No." := TempGlobalEntrySummary."Serial No.";
                    ReservEntry."Lot No." := TempGlobalEntrySummary."Lot No.";
                    ReservEntry."Shipment Date" := SalesLineLRec."Shipment Date";
                    ReservEntry.UpdateItemTracking;
                    ReservEntry.INSERT;
                UNTIL (TempGlobalEntrySummary.NEXT = 0) OR (RemQty <= 0);
            END;
        END;
        EXIT(MaxQuantity);
    end;

    procedure RetrieveLookupData(var TempTrackingSpecification: Record "Tracking Specification" temporary; FullDataSet: Boolean)
    begin
        RetrieveLookupData(TempTrackingSpecification, FullDataSet, IsolationLevel::Default);
    end;

    local procedure RetrieveLookupData(var TempTrackingSpecification: Record "Tracking Specification" temporary; FullDataSet: Boolean; ReservEntryReadIsolation: IsolationLevel)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
        TempTrackingSpecification2: Record "Tracking Specification" temporary;
        LotNo, PackageNo : Code[50];
    begin
        LastSummaryEntryNo := 0;
        LastReservEntryNo := 2147483647;
        TempTrackingSpecification2 := TempTrackingSpecification;
        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.DeleteAll();
        TempGlobalEntrySummary.Reset();
        TempGlobalEntrySummary.DeleteAll();

        ReservEntry.Reset();
        ReservEntry.ReadIsolation := ReservEntryReadIsolation;
        ReservEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Item Tracking");
        ReservEntry.SetRange("Item No.", TempTrackingSpecification."Item No.");
        ReservEntry.SetRange("Variant Code", TempTrackingSpecification."Variant Code");
        ReservEntry.SetRange("Location Code", TempTrackingSpecification."Location Code");
        ReservEntry.SetFilter("Item Tracking", '<>%1', ReservEntry."Item Tracking"::None);
        OnRetrieveLookupDataOnAfterReservEntrySetFilters(ReservEntry, TempTrackingSpecification);
        if ReservEntry.FindSet() then
            repeat
                TempReservEntry := ReservEntry;
                if CanIncludeReservEntryToTrackingSpec(TempReservEntry) then
                    TempReservEntry.Insert();
            until ReservEntry.Next() = 0;

        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Entry No.");
        ItemLedgEntry.SetRange("Item No.", TempTrackingSpecification."Item No.");
        ItemLedgEntry.SetRange("Variant Code", TempTrackingSpecification."Variant Code");
        ItemLedgEntry.SetRange(Open, true);
        ItemLedgEntry.SetRange("Location Code", TempTrackingSpecification."Location Code");

        OnRetrieveLookupDataOnBeforeTransferToTempRec(TempTrackingSpecification, TempReservEntry, ItemLedgEntry, FullDataSet);

        LotNo := '';
        PackageNo := '';
        if FullDataSet then begin
            TransferReservEntryToTempRec(TempReservEntry, TempTrackingSpecification);
            TransferItemLedgToTempRec(ItemLedgEntry, TempTrackingSpecification);
        end else
            if TempTrackingSpecification.FindSet() then
                repeat
                    ItemLedgEntry.ClearTrackingFilter();
                    TempReservEntry.ClearTrackingFilter();

                    if (TempTrackingSpecification."Lot No." <> '') and (TempTrackingSpecification."Lot No." <> LotNo) then begin
                        LotNo := TempTrackingSpecification."Lot No.";
                        ItemLedgEntry.SetRange("Lot No.", TempTrackingSpecification."Lot No.");
                        TempReservEntry.SetRange("Lot No.", TempTrackingSpecification."Lot No.");
                        TransferReservEntryToTempRec(TempReservEntry, TempTrackingSpecification);
                        TransferItemLedgToTempRec(ItemLedgEntry, TempTrackingSpecification);
                    end;

                    ItemLedgEntry.ClearTrackingFilter();
                    TempReservEntry.ClearTrackingFilter();
                    if (TempTrackingSpecification."Package No." <> '') and (TempTrackingSpecification."Package No." <> PackageNo) then begin
                        PackageNo := TempTrackingSpecification."Package No.";
                        ItemLedgEntry.SetRange("Package No.", TempTrackingSpecification."Package No.");
                        TempReservEntry.SetRange("Package No.", TempTrackingSpecification."Package No.");
                        TransferReservEntryToTempRec(TempReservEntry, TempTrackingSpecification);
                        TransferItemLedgToTempRec(ItemLedgEntry, TempTrackingSpecification);
                    end;

                    OnRetrieveLookupDataOnAfterBuildNonSerialDataSet(TempTrackingSpecification, ItemLedgEntry, TempReservEntry);

                    if (TempTrackingSpecification."Lot No." = '') and (TempTrackingSpecification."Package No." = '') and (TempTrackingSpecification."Serial No." <> '') then begin
                        ItemLedgEntry.SetTrackingFilterFromSpec(TempTrackingSpecification);
                        TempReservEntry.SetTrackingFilterFromSpec(TempTrackingSpecification);
                        TransferReservEntryToTempRec(TempReservEntry, TempTrackingSpecification);
                        TransferItemLedgToTempRec(ItemLedgEntry, TempTrackingSpecification);
                    end;
                until TempTrackingSpecification.Next() = 0;

        OnRetrieveLookupDataOnAfterTransferToTempRec(TempGlobalEntrySummary, TempTrackingSpecification, ItemLedgEntry, LastSummaryEntryNo);

        TempGlobalEntrySummary.Reset();
        UpdateCurrentPendingQty();
        TempTrackingSpecification := TempTrackingSpecification2;

        PartialGlobalDataSetExists := true;
        FullGlobalDataSetExists := FullDataSet;
        AdjustForDoubleEntriesForManufacturing();
        AdjustForDoubleEntriesForJobs();

        OnAfterRetrieveLookupData(TempTrackingSpecification, FullDataSet, TempGlobalReservEntry, TempGlobalEntrySummary);
    end;

    local procedure AdjustForDoubleEntriesForJobs()
    begin
        TempGlobalAdjustEntry.Reset();
        TempGlobalAdjustEntry.DeleteAll();

        TempGlobalTrackingSpec.Reset();
        TempGlobalTrackingSpec.DeleteAll();

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Reservation Status", TempGlobalReservEntry."Reservation Status"::Prospect);
        TempGlobalReservEntry.SetRange("Source Type", Database::"Job Journal Line");
        TempGlobalReservEntry.SetRange("Source Subtype", 0); // Job Journal
        if TempGlobalReservEntry.IsEmpty() then  // No journal lines with reservation exists
            exit;

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Source Type", Database::"Job Planning Line");
        TempGlobalReservEntry.SetRange("Source Subtype", 2);
        if TempGlobalReservEntry.FindSet() then
            repeat
                // Sum up per job planning line per lot/sn
                SumUpTempTrkgSpec(TempGlobalTrackingSpec, TempGlobalReservEntry);
            until TempGlobalReservEntry.Next() = 0;

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Reservation Status", TempGlobalReservEntry."Reservation Status"::Prospect);
        TempGlobalReservEntry.SetRange("Source Type", Database::"Job Journal Line");
        TempGlobalReservEntry.SetRange("Source Subtype", 0);

        if TempGlobalReservEntry.FindSet() then
            repeat
                // Sum up per qty. line per lot/sn
                RelateJobJnlLineToTempTrkgSpec(TempGlobalReservEntry, TempGlobalTrackingSpec);
            until TempGlobalReservEntry.Next() = 0;

        InsertAdjustmentEntries();
    end;

    procedure SumUpTempTrkgSpec(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservEntry: Record "Reservation Entry")
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        TempTrackingSpecification.SetSourceFilter(
          ReservEntry."Source Type", ReservEntry."Source Subtype", ReservEntry."Source ID", ReservEntry."Source Ref. No.", false);
        TempTrackingSpecification.SetSourceFilter(ReservEntry."Source Batch Name", ReservEntry."Source Prod. Order Line");
        TempTrackingSpecification.SetTrackingFilterFromReservEntry(ReservEntry);
        if TempTrackingSpecification.FindFirst() then begin
            TempTrackingSpecification."Quantity (Base)" += ReservEntry."Quantity (Base)";
            OnBeforeTempTrackingSpecificationModify(TempTrackingSpecification, ReservEntry);
            TempTrackingSpecification.Modify();
        end else begin
            ItemTrackingMgt.CreateTrackingSpecification(ReservEntry, TempTrackingSpecification);
            if not ReservEntry.Positive then               // To avoid inserting existing entry when both sides of the reservation
                TempTrackingSpecification."Entry No." *= -1; // are handled.
            TempTrackingSpecification.Insert();
        end;
    end;

    local procedure AdjustForDoubleEntriesForManufacturing()
    begin
        TempGlobalAdjustEntry.Reset();
        TempGlobalAdjustEntry.DeleteAll();

        TempGlobalTrackingSpec.Reset();
        TempGlobalTrackingSpec.DeleteAll();

        // Check if there is any need to investigate:
        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Reservation Status", TempGlobalReservEntry."Reservation Status"::Prospect);
        TempGlobalReservEntry.SetRange("Source Type", Database::"Item Journal Line");
        TempGlobalReservEntry.SetRange("Source Subtype", 5, 6); // Consumption, Output
        if TempGlobalReservEntry.IsEmpty() then  // No journal lines with consumption or output exist
            exit;

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Source Type", 5406); // Database::"Prod. Order Line"
        TempGlobalReservEntry.SetRange("Source Subtype", 3); // Released order
        if TempGlobalReservEntry.FindSet() then
            repeat
                // Sum up per prod. order line per lot/sn
                SumUpTempTrkgSpec(TempGlobalTrackingSpec, TempGlobalReservEntry);
            until TempGlobalReservEntry.Next() = 0;

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Source Type", 5407); // Database::"Prod. Order Component"
        TempGlobalReservEntry.SetRange("Source Subtype", 3); // Released order
        if TempGlobalReservEntry.FindSet() then
            repeat
                // Sum up per prod. order component per lot/sn
                SumUpTempTrkgSpec(TempGlobalTrackingSpec, TempGlobalReservEntry);
            until TempGlobalReservEntry.Next() = 0;

        TempGlobalReservEntry.Reset();
        TempGlobalReservEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        TempGlobalReservEntry.SetRange("Reservation Status", TempGlobalReservEntry."Reservation Status"::Prospect);
        TempGlobalReservEntry.SetRange("Source Type", Database::"Item Journal Line");
        TempGlobalReservEntry.SetRange("Source Subtype", 5, 6); // Consumption, Output

        if TempGlobalReservEntry.FindSet() then
            repeat
                // Sum up per Component line per lot/sn
                RelateJnlLineToTempTrkgSpec(TempGlobalReservEntry, TempGlobalTrackingSpec);
            until TempGlobalReservEntry.Next() = 0;

        InsertAdjustmentEntries();
    end;

    local procedure InsertAdjustmentEntries()
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    begin
        TempGlobalAdjustEntry.Reset();
        if not TempGlobalAdjustEntry.FindSet() then
            exit;

        TempTrackingSpecification.Init();
        TempTrackingSpecification.Insert();
        repeat
            CreateEntrySummary(TempTrackingSpecification, TempGlobalAdjustEntry); // TrackingSpecification is a dummy record
            TempGlobalReservEntry := TempGlobalAdjustEntry;
            TempGlobalReservEntry.Insert();
        until TempGlobalAdjustEntry.Next() = 0;
    end;

    local procedure UpdateCurrentPendingQty()
    var
        TempLastGlobalEntrySummary: Record "Entry Summary" temporary;
        IsHandled: Boolean;
    begin
        TempGlobalChangedEntrySummary.Reset();
        TempGlobalChangedEntrySummary.SetTrackingKey();
        if TempGlobalChangedEntrySummary.FindSet() then
            repeat
                IsHandled := false;
                OnUpdateCurrentPendingQtyOnLoop(TempGlobalChangedEntrySummary, CurrBinCode, TempGlobalEntrySummary, IsHandled);
                if not IsHandled then begin
                    if TempGlobalChangedEntrySummary.HasNonSerialTracking() then begin
                        // only last record with Lot Number updates Summary
                        if not TempGlobalChangedEntrySummary.HasSameNonSerialTracking(TempLastGlobalEntrySummary) then
                            FindLastGlobalEntrySummary(TempGlobalChangedEntrySummary, TempLastGlobalEntrySummary);
                        SkipLot := not (TempGlobalChangedEntrySummary."Entry No." = TempLastGlobalEntrySummary."Entry No.");
                    end;
                    UpdateTempSummaryWithChange(TempGlobalChangedEntrySummary);
                end;
            until TempGlobalChangedEntrySummary.Next() = 0;
    end;

    procedure TransferReservEntryToTempRec(var TempReservEntry: Record "Reservation Entry" temporary; var TrackingSpecification: Record "Tracking Specification" temporary)
    var
        IsHandled: Boolean;
    begin
        if TempReservEntry.FindSet() then
            repeat
                if not TempGlobalReservEntry.Get(TempReservEntry."Entry No.", TempReservEntry.Positive) then begin
                    TempGlobalReservEntry := TempReservEntry;
                    TempGlobalReservEntry."Transferred from Entry No." := 0;
                    IsHandled := false;
                    OnAfterTransferReservEntryToTempRec(TempGlobalReservEntry, TempReservEntry, TrackingSpecification, IsHandled);
                    if not IsHandled then begin
                        TempGlobalReservEntry.Insert();
                        CreateEntrySummary(TrackingSpecification, TempGlobalReservEntry);
                    end;
                end;
            until TempReservEntry.Next() = 0;
    end;

    local procedure CanIncludeReservEntryToTrackingSpec(TempReservEntry: Record "Reservation Entry" temporary) Result: Boolean
    var
        SalesLine: Record "Sales Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCanIncludeReservEntryToTrackingSpec(TempReservEntry, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if (TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Prospect) and
               (TempReservEntry."Source Type" = Database::"Sales Line") and
               (TempReservEntry."Source Subtype" = 2)
        then begin
            SalesLine.SetLoadFields("Shipment No.");
            SalesLine.Get(TempReservEntry."Source Subtype", TempReservEntry."Source ID", TempReservEntry."Source Ref. No.");
            if SalesLine."Shipment No." <> '' then
                exit(false);
        end;

        exit(true);
    end;

    procedure TransferItemLedgToTempRec(var ItemLedgEntry: Record "Item Ledger Entry"; var TrackingSpecification: Record "Tracking Specification" temporary)
    var
        IsHandled: Boolean;
    begin
        ItemLedgEntry.SetLoadFields(
          "Entry No.", "Item No.", "Variant Code", Positive, "Location Code", "Serial No.", "Lot No.", "Package No.",
          "Remaining Quantity", "Warranty Date", "Expiration Date");
        OnTransferItemLedgToTempRecOnBeforeFindSetItemLedgerEntry(ItemLedgEntry);
        if ItemLedgEntry.FindSet() then
            repeat
                if ItemLedgEntry.TrackingExists() and
                   not TempGlobalReservEntry.Get(-ItemLedgEntry."Entry No.", ItemLedgEntry.Positive)
                then begin
                    TempGlobalReservEntry.Init();
                    TempGlobalReservEntry."Entry No." := -ItemLedgEntry."Entry No.";
                    TempGlobalReservEntry."Reservation Status" := TempGlobalReservEntry."Reservation Status"::Surplus;
                    TempGlobalReservEntry.Positive := ItemLedgEntry.Positive;
                    TempGlobalReservEntry."Item No." := ItemLedgEntry."Item No.";
                    TempGlobalReservEntry."Variant Code" := ItemLedgEntry."Variant Code";
                    TempGlobalReservEntry."Location Code" := ItemLedgEntry."Location Code";
                    TempGlobalReservEntry."Quantity (Base)" := ItemLedgEntry."Remaining Quantity";
                    TempGlobalReservEntry."Source Type" := Database::"Item Ledger Entry";
                    TempGlobalReservEntry."Source Ref. No." := ItemLedgEntry."Entry No.";
                    TempGlobalReservEntry.CopyTrackingFromItemLedgEntry(ItemLedgEntry);
                    if TempGlobalReservEntry.Positive then begin
                        TempGlobalReservEntry."Warranty Date" := ItemLedgEntry."Warranty Date";
                        TempGlobalReservEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
                        TempGlobalReservEntry."Expected Receipt Date" := 0D
                    end else
                        TempGlobalReservEntry."Shipment Date" := DMY2Date(31, 12, 9999);

                    IsHandled := false;
                    OnTransferItemLedgToTempRecOnBeforeInsert(TempGlobalReservEntry, ItemLedgEntry, TrackingSpecification, IsHandled);
                    if not IsHandled then begin
                        TempGlobalReservEntry.Insert();
                        CreateEntrySummary(TrackingSpecification, TempGlobalReservEntry);
                    end;
                end;
            until ItemLedgEntry.Next() = 0;
    end;

    local procedure CreateEntrySummary(TrackingSpecification: Record "Tracking Specification" temporary; TempReservEntry: Record "Reservation Entry" temporary)
    begin
        CreateEntrySummary2(TrackingSpecification, TempReservEntry, true);
        CreateEntrySummary2(TrackingSpecification, TempReservEntry, false);

        OnAfterCreateEntrySummary(TrackingSpecification, TempGlobalEntrySummary);
    end;

    local procedure CreateEntrySummary2(TempTrackingSpecification: Record "Tracking Specification" temporary; TempReservEntry: Record "Reservation Entry" temporary; SerialNoLookup: Boolean)
    var
        LateBindingManagement: Codeunit "Late Binding Management";
        DoInsert: Boolean;
    begin
        OnBeforeCreateEntrySummary2(TempGlobalEntrySummary, TempReservEntry, TempTrackingSpecification);

        TempGlobalEntrySummary.Reset();
        TempGlobalEntrySummary.SetTrackingKey();

        if SerialNoLookup then begin
            if TempReservEntry."Serial No." = '' then
                exit;

            TempGlobalEntrySummary.SetTrackingFilterFromReservEntry(TempReservEntry);
        end else begin
            if not TempReservEntry.NonSerialTrackingExists() then
                exit;

            TempGlobalEntrySummary.SetRange("Serial No.", '');
            TempGlobalEntrySummary.SetNonSerialTrackingFilterFromReservEntry(TempReservEntry);
            if TempReservEntry."Serial No." <> '' then
                TempGlobalEntrySummary.SetRange("Table ID", 0)
            else
                TempGlobalEntrySummary.SetFilter("Table ID", '<>%1', 0);
        end;
        OnCreateEntrySummary2OnAfterSetFilters(TempGlobalEntrySummary, TempReservEntry);

        // If no summary exists, create new record
        if not TempGlobalEntrySummary.FindFirst() then begin
            TempGlobalEntrySummary.Init();
            TempGlobalEntrySummary."Entry No." := LastSummaryEntryNo + 1;
            LastSummaryEntryNo := TempGlobalEntrySummary."Entry No.";

            if not SerialNoLookup and (TempReservEntry."Serial No." <> '') then
                TempGlobalEntrySummary."Table ID" := 0 // Mark as summation
            else
                TempGlobalEntrySummary."Table ID" := TempReservEntry."Source Type";
            if SerialNoLookup then
                TempGlobalEntrySummary."Serial No." := TempReservEntry."Serial No."
            else
                TempGlobalEntrySummary."Serial No." := '';
            TempGlobalEntrySummary."Lot No." := TempReservEntry."Lot No.";
            OnCreateEntrySummary2OnAfterAssignTrackingFromReservEntry(TempGlobalEntrySummary, TempReservEntry);
            TempGlobalEntrySummary."Non Serial Tracking" := TempGlobalEntrySummary.HasNonSerialTracking();
            TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
            OnBeforeUpdateBinContent(TempGlobalEntrySummary, TempReservEntry, CurrBinCode, CurrItemTrackingCode);
            UpdateBinContent(TempGlobalEntrySummary);

            // If consumption/output fill in double entry value here:
            TempGlobalEntrySummary."Double-entry Adjustment" :=
              MaxDoubleEntryAdjustQty(TempTrackingSpecification, TempGlobalEntrySummary);

            OnCreateEntrySummary2OnAfterSetDoubleEntryAdjustment(TempGlobalEntrySummary, TempReservEntry);

            DoInsert := true;
        end;

        // Sum up values
        if TempReservEntry.Positive then begin
            TempGlobalEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
            TempGlobalEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
            OnAfterSetTempGlobalEntrySummaryExpirationDate(TempGlobalEntrySummary, TempReservEntry);
            if TempReservEntry."Entry No." < 0 then begin // The record represents an Item ledger entry
                TempGlobalEntrySummary."Non-specific Reserved Qty." +=
                  LateBindingManagement.NonSpecificReservedQtyExceptForSource(-TempReservEntry."Entry No.", TempTrackingSpecification);
                TempGlobalEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
            end;
            if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                TempGlobalEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
        end else begin
            TempGlobalEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
            if TempReservEntry.HasSamePointerWithSpec(TempTrackingSpecification) then begin
                if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                    TempGlobalEntrySummary."Current Reserved Quantity" -= TempReservEntry."Quantity (Base)";
                if TempReservEntry."Entry No." > 0 then // The record represents a reservation entry
                    TempGlobalEntrySummary."Current Requested Quantity" -= TempReservEntry."Quantity (Base)";
            end;
        end;

        // Update available quantity on the record
        OnCreateEntrySummary2OnBeforeInsertOrModify(TempGlobalEntrySummary, TempReservEntry, TempTrackingSpecification);

        TempGlobalEntrySummary.UpdateAvailable();
        if DoInsert then
            TempGlobalEntrySummary.Insert()
        else
            TempGlobalEntrySummary.Modify();

        OnAfterCreateEntrySummary2(TempGlobalEntrySummary, TempReservEntry);
    end;

    local procedure UpdateTempSummaryWithChange(var TempChangedEntrySummary: Record "Entry Summary" temporary)
    var
        LastEntryNo: Integer;
        SumOfSNPendingQuantity: Decimal;
        SumOfSNRequestedQuantity: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeUpdateTempSummaryWithChange(TempChangedEntrySummary, CurrBinCode, TempGlobalEntrySummary, IsHandled);
        if IsHandled then
            exit;

        TempGlobalEntrySummary.Reset();
        LastEntryNo := TempGlobalEntrySummary.GetLastEntryNo();

        TempGlobalEntrySummary.SetTrackingKey();
        OnUpdateTempSummaryWithChangeOnAfterSetCurrentKey(TempGlobalEntrySummary, TempChangedEntrySummary);
        if TempChangedEntrySummary."Serial No." <> '' then begin
            TempGlobalEntrySummary.SetTrackingFilterFromEntrySummary(TempChangedEntrySummary);
            if TempGlobalEntrySummary.FindFirst() then begin
                TempGlobalEntrySummary."Current Pending Quantity" := TempChangedEntrySummary."Current Pending Quantity" -
                  TempGlobalEntrySummary."Current Requested Quantity";
                TempGlobalEntrySummary.UpdateAvailable();
                TempGlobalEntrySummary.Modify();
            end else begin
                TempGlobalEntrySummary := TempChangedEntrySummary;
                TempGlobalEntrySummary."Entry No." := LastEntryNo + 1;
                LastEntryNo := TempGlobalEntrySummary."Entry No.";
                TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
                UpdateBinContent(TempGlobalEntrySummary);
                TempGlobalEntrySummary.UpdateAvailable();
                TempGlobalEntrySummary.Insert();
            end;

            if TempChangedEntrySummary.HasNonSerialTracking() and not SkipLot then begin
                TempGlobalEntrySummary.SetFilter("Serial No.", '<>%1', '');
                TempGlobalEntrySummary.SetNonSerialTrackingFilterFromEntrySummary(TempChangedEntrySummary);
                TempGlobalEntrySummary.CalcSums("Current Pending Quantity", "Current Requested Quantity");
                SumOfSNPendingQuantity := TempGlobalEntrySummary."Current Pending Quantity";
                SumOfSNRequestedQuantity := TempGlobalEntrySummary."Current Requested Quantity";
            end;
        end;

        if TempChangedEntrySummary.HasNonSerialTracking() and not SkipLot then begin
            TempGlobalEntrySummary.SetRange("Serial No.", '');
            TempGlobalEntrySummary.SetNonSerialTrackingFilterFromEntrySummary(TempChangedEntrySummary);

            if TempChangedEntrySummary."Serial No." <> '' then
                TempGlobalEntrySummary.SetRange("Table ID", 0)
            else
                TempGlobalEntrySummary.SetFilter("Table ID", '<>%1', 0);

            if TempGlobalEntrySummary.FindFirst() then begin
                if TempChangedEntrySummary."Serial No." <> '' then begin
                    TempGlobalEntrySummary."Current Pending Quantity" := SumOfSNPendingQuantity;
                    TempGlobalEntrySummary."Current Requested Quantity" := SumOfSNRequestedQuantity;
                end else
                    TempGlobalEntrySummary."Current Pending Quantity" := TempChangedEntrySummary."Current Pending Quantity" -
                      TempGlobalEntrySummary."Current Requested Quantity";

                OnUpdateTempSummaryWithChangeOnAfterCalcCurrentPendingQuantity(TempChangedEntrySummary, TempGlobalEntrySummary);
                TempGlobalEntrySummary.UpdateAvailable();
                TempGlobalEntrySummary.Modify();
            end else begin
                TempGlobalEntrySummary := TempChangedEntrySummary;
                TempGlobalEntrySummary."Entry No." := LastEntryNo + 1;
                TempGlobalEntrySummary."Serial No." := '';
                if TempChangedEntrySummary."Serial No." <> '' then // Mark as summation
                    TempGlobalEntrySummary."Table ID" := 0
                else
                    TempGlobalEntrySummary."Table ID" := Database::"Tracking Specification";
                TempGlobalEntrySummary."Bin Active" := CurrBinCode <> '';
                UpdateBinContent(TempGlobalEntrySummary);
                TempGlobalEntrySummary.UpdateAvailable();
                TempGlobalEntrySummary.Insert();
            end;
        end;
    end;

    procedure SetCurrentBinAndItemTrkgCode(BinCode: Code[20]; ItemTrackingCode: Record "Item Tracking Code")
    var
        xBinCode: Code[20];
    begin
        xBinCode := CurrBinCode;
        CurrBinCode := BinCode;
        CurrItemTrackingCode := ItemTrackingCode;

        if xBinCode <> BinCode then
            if PartialGlobalDataSetExists then
                RefreshBinContent(TempGlobalEntrySummary);

        OnAfterSetCurrentBinAndItemTrkgCode(xBinCode, CurrBinCode, CurrItemTrackingCode, FullGlobalDataSetExists, PartialGlobalDataSetExists);
    end;


    local procedure UpdateBinContent(var TempEntrySummary: Record "Entry Summary" temporary)
    var
        WarehouseEntry: Record "Warehouse Entry";
        WhseItemTrackingSetup: Record "Item Tracking Setup";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnUpdateBinContentOnBeforeUpdateBinContent(TempEntrySummary, CurrItemTrackingCode, IsHandled, TempGlobalReservEntry);
        if IsHandled then
            exit;

        if CurrBinCode = '' then
            exit;

        CurrItemTrackingCode.TestField(Code);

        WarehouseEntry.Reset();
        WarehouseEntry.SetCurrentKey(
          "Item No.", "Bin Code", "Location Code", "Variant Code",
          "Unit of Measure Code", "Lot No.", "Serial No.", "Package No.");
        WarehouseEntry.SetRange("Item No.", TempGlobalReservEntry."Item No.");
        WarehouseEntry.SetRange("Bin Code", CurrBinCode);
        WarehouseEntry.SetRange("Location Code", TempGlobalReservEntry."Location Code");
        WarehouseEntry.SetRange("Variant Code", TempGlobalReservEntry."Variant Code");
        WhseItemTrackingSetup.CopyTrackingFromItemTrackingCodeWarehouseTracking(CurrItemTrackingCode);
        WhseItemTrackingSetup.CopyTrackingFromEntrySummary(TempEntrySummary);
        WarehouseEntry.SetTrackingFilterFromItemTrackingSetupIfRequiredIfNotBlank(WhseItemTrackingSetup);

        IsHandled := false;
        OnUpdateBinContentOnBeforeCalcSumsQtyBase(TempEntrySummary, WarehouseEntry, IsHandled);
        if IsHandled then
            exit;

        WarehouseEntry.CalcSums("Qty. (Base)");

        TempEntrySummary."Bin Content" := WarehouseEntry."Qty. (Base)";
    end;

    local procedure RefreshBinContent(var TempEntrySummary: Record "Entry Summary" temporary)
    begin
        TempEntrySummary.Reset();
        if TempEntrySummary.FindSet() then
            repeat
                if CurrBinCode <> '' then
                    UpdateBinContent(TempEntrySummary)
                else
                    TempEntrySummary."Bin Content" := 0;
                TempEntrySummary.Modify();
            until TempEntrySummary.Next() = 0;
    end;

    procedure RelateJnlLineToTempTrkgSpec(var ReservEntry: Record "Reservation Entry"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemTrackingSetup: Record "Item Tracking Setup";
        RemainingQty: Decimal;
        AdjustQty: Decimal;
        QtyOnJnlLine: Decimal;
    begin
        // Pre-check
        ReservEntry.TestField("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.TestField("Source Type", Database::"Item Journal Line");
        if not (ReservEntry."Source Subtype" in [5, 6]) then
            ReservEntry.FieldError("Source Subtype");

        if not ItemJnlLine.Get(ReservEntry."Source ID",
             ReservEntry."Source Batch Name", ReservEntry."Source Ref. No.")
        then
            exit;

        if (ItemJnlLine."Order Type" <> ItemJnlLine."Order Type"::Production) or
           (ItemJnlLine."Order No." = '') or
           (ItemJnlLine."Order Line No." = 0)
        then
            exit;

        // Buffer fields are used as follows:
        // "Buffer Value1" : Summed up quantity on journal line(s)
        // "Buffer Value2" : Adjustment needed to neutralize double entries

        ItemTrackingSetup.CopyTrackingFromReservEntry(ReservEntry);
        if FindRelatedParentTrkgSpec(ItemJnlLine, TempTrackingSpecification, ItemTrackingSetup) then begin
            RemainingQty := TempTrackingSpecification."Quantity (Base)" + TempTrackingSpecification."Buffer Value2";
            QtyOnJnlLine := ReservEntry."Quantity (Base)";
            ReservEntry."Transferred from Entry No." := Abs(TempTrackingSpecification."Entry No.");
            ReservEntry.Modify();

            if (RemainingQty <> 0) and (RemainingQty * QtyOnJnlLine > 0) then
                if Abs(QtyOnJnlLine) <= Abs(RemainingQty) then
                    AdjustQty := -QtyOnJnlLine
                else
                    AdjustQty := -RemainingQty;

            TempTrackingSpecification."Buffer Value1" += QtyOnJnlLine;
            TempTrackingSpecification."Buffer Value2" += AdjustQty;
            TempTrackingSpecification.Modify();
            AddToAdjustmentEntryDataSet(ReservEntry, AdjustQty);
        end;
    end;

    local procedure FindRelatedParentTrkgSpec(ItemJnlLine: Record "Item Journal Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary; ItemTrackingSetup: Record "Item Tracking Setup"): Boolean
    begin
        ItemJnlLine.TestField("Order Type", ItemJnlLine."Order Type"::Production);
        TempTrackingSpecification.Reset();
        case ItemJnlLine."Entry Type" of
            ItemJnlLine."Entry Type"::Consumption:
                begin
                    if ItemJnlLine."Prod. Order Comp. Line No." = 0 then
                        exit;
                    TempTrackingSpecification.SetSourceFilter(5407, 3, ItemJnlLine."Order No.", ItemJnlLine."Prod. Order Comp. Line No.", false); // Database::"Prod. Order Component"
                    TempTrackingSpecification.SetSourceFilter('', ItemJnlLine."Order Line No.");
                end;
            ItemJnlLine."Entry Type"::Output:
                begin
                    TempTrackingSpecification.SetSourceFilter(5406, 3, ItemJnlLine."Order No.", -1, false); // Database::"Prod. Order Line"
                    TempTrackingSpecification.SetSourceFilter('', ItemJnlLine."Order Line No.");
                end;
        end;
        TempTrackingSpecification.SetTrackingFilterFromItemTrackingSetup(ItemTrackingSetup);
        OnFindRelatedParentTrkgSpecOnAfterSetFilters(TempTrackingSpecification, ItemJnlLine);
        exit(TempTrackingSpecification.FindFirst());
    end;

    procedure RelateJobJnlLineToTempTrkgSpec(var ReservEntry: Record "Reservation Entry"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        JobJnlLine: Record "Job Journal Line";
        ItemTrackingSetup: Record "Item Tracking Setup";
        RemainingQty: Decimal;
        AdjustQty: Decimal;
        QtyOnJnlLine: Decimal;
    begin
        // Pre-check
        ReservEntry.TestField("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.TestField("Source Type", Database::"Job Journal Line");
        if not (ReservEntry."Source Subtype" = 0) then
            ReservEntry.FieldError("Source Subtype");

        if not JobJnlLine.Get(ReservEntry."Source ID",
             ReservEntry."Source Batch Name", ReservEntry."Source Ref. No.")
        then
            exit;

        // Buffer fields are used as follows:
        // "Buffer Value1" : Summed up quantity on journal line(s)
        // "Buffer Value2" : Adjustment needed to neutralize double entries

        ItemTrackingSetup.CopyTrackingFromReservEntry(ReservEntry);
        if FindRelatedJobParentTrkgSpec(JobJnlLine, TempTrackingSpecification, ItemTrackingSetup) then begin
            RemainingQty := TempTrackingSpecification."Quantity (Base)" + TempTrackingSpecification."Buffer Value2";
            QtyOnJnlLine := ReservEntry."Quantity (Base)";
            ReservEntry."Transferred from Entry No." := Abs(TempTrackingSpecification."Entry No.");
            ReservEntry.Modify();

            if (RemainingQty <> 0) and (RemainingQty * QtyOnJnlLine > 0) then
                if Abs(QtyOnJnlLine) <= Abs(RemainingQty) then
                    AdjustQty := -QtyOnJnlLine
                else
                    AdjustQty := -RemainingQty;
            TempTrackingSpecification."Buffer Value1" += QtyOnJnlLine;
            TempTrackingSpecification."Buffer Value2" += AdjustQty;
            TempTrackingSpecification.Modify();
            AddToAdjustmentEntryDataSet(ReservEntry, AdjustQty);
        end;
    end;

    local procedure FindRelatedJobParentTrkgSpec(JobJnlLine: Record "Job Journal Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary; ItemTrackingSetup: Record "Item Tracking Setup"): Boolean
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        if JobPlanningLine.Get(JobJnlLine."Job No.", JobJnlLine."Job Task No.", JobJnlLine."Job Planning Line No.") then begin
            TempTrackingSpecification.Reset();
            TempTrackingSpecification.SetSourceFilter(
            Database::"Job Planning Line", 2, JobJnlLine."Job No.", JobPlanningLine."Job Contract Entry No.", false);
            TempTrackingSpecification.SetSourceFilter('', 0);
            TempTrackingSpecification.SetTrackingFilterFromItemTrackingSetup(ItemTrackingSetup);
            exit(TempTrackingSpecification.FindFirst());
        end;
    end;

    local procedure AddToAdjustmentEntryDataSet(var ReservEntry: Record "Reservation Entry"; AdjustQty: Decimal)
    begin
        if AdjustQty = 0 then
            exit;

        TempGlobalAdjustEntry := ReservEntry;
        TempGlobalAdjustEntry."Source Type" := -ReservEntry."Source Type";
        TempGlobalAdjustEntry.Description := CopyStr(Text013, 1, MaxStrLen(TempGlobalAdjustEntry.Description));
        TempGlobalAdjustEntry."Quantity (Base)" := AdjustQty;
        TempGlobalAdjustEntry."Entry No." := LastReservEntryNo; // Use last entry no as offset to avoid inserting existing entry
        LastReservEntryNo -= 1;
        TempGlobalAdjustEntry.Insert();
    end;



    local procedure MaxDoubleEntryAdjustQty(var TempItemTrackLineChanged: Record "Tracking Specification" temporary; var ChangedEntrySummary: Record "Entry Summary" temporary): Decimal
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemTrackingSetup: Record "Item Tracking Setup";
    begin
        if not (TempItemTrackLineChanged."Source Type" = Database::"Item Journal Line") then
            exit;

        if not (TempItemTrackLineChanged."Source Subtype" in [5, 6]) then
            exit;

        if not ItemJnlLine.Get(TempItemTrackLineChanged."Source ID",
             TempItemTrackLineChanged."Source Batch Name", TempItemTrackLineChanged."Source Ref. No.")
        then
            exit;

        TempGlobalTrackingSpec.Reset();
        ItemTrackingSetup.CopyTrackingFromEntrySummary(ChangedEntrySummary);
        if FindRelatedParentTrkgSpec(ItemJnlLine, TempGlobalTrackingSpec, ItemTrackingSetup) then
            exit(-TempGlobalTrackingSpec."Quantity (Base)" - TempGlobalTrackingSpec."Buffer Value2");
    end;

    local procedure FindLastGlobalEntrySummary(var GlobalChangedEntrySummary: Record "Entry Summary"; var LastGlobalEntrySummary: Record "Entry Summary")
    var
        TempGlobalChangedEntrySummary2: Record "Entry Summary" temporary;
    begin
        TempGlobalChangedEntrySummary2 := GlobalChangedEntrySummary;
        GlobalChangedEntrySummary.SetNonSerialTrackingFilterFromEntrySummary(GlobalChangedEntrySummary);
        if GlobalChangedEntrySummary.FindLast() then
            LastGlobalEntrySummary := GlobalChangedEntrySummary;
        GlobalChangedEntrySummary.Copy(TempGlobalChangedEntrySummary2);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateEntrySummary(TrackingSpecification: Record "Tracking Specification"; var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateEntrySummary2(var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempGlobalReservEntry: Record "Reservation Entry" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRetrieveLookupData(var TrackingSpecification: Record "Tracking Specification"; FullDataSet: Boolean; var TempGlobalReservEntry: Record "Reservation Entry" temporary; var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTransferReservEntryToTempRec(var GlobalReservEntry: Record "Reservation Entry"; ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCanIncludeReservEntryToTrackingSpec(TempReservEntry: Record "Reservation Entry" temporary; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateEntrySummary2(var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempReservationEntry: Record "Reservation Entry" temporary; TrackingSpecification: Record "Tracking Specification")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTempTrackingSpecificationModify(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateBinContent(var TempEntrySummary: Record "Entry Summary" temporary; var TempReservationEntry: Record "Reservation Entry" temporary; var CurrBinCode: Code[20]; var CurrItemTrackingCode: Record "Item Tracking Code")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRetrieveLookupDataOnBeforeTransferToTempRec(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempReservationEntry: Record "Reservation Entry" temporary; var ItemLedgerEntry: Record "Item Ledger Entry"; var FullDataSet: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "Reservation Entry" temporary; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnRetrieveLookupDataOnAfterBuildNonSerialDataSet(var TempTrackingSpecification: Record "Tracking Specification" temporary; var ItemLedgEntry: Record "Item Ledger Entry"; var TempReservEntry: Record "Reservation Entry" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateEntrySummary2OnAfterAssignTrackingFromReservEntry(var TempGlobalEntrySummary: Record "Entry Summary" temporary; TempReservEntry: Record "Reservation Entry" temporary);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateEntrySummary2OnAfterSetFilters(var TempGlobalEntrySummary: Record "Entry Summary"; var TempReservEntry: Record "Reservation Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateEntrySummary2OnAfterSetDoubleEntryAdjustment(var TempGlobalEntrySummary: Record "Entry Summary"; var TempReservEntry: Record "Reservation Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateEntrySummary2OnBeforeInsertOrModify(var TempGlobalEntrySummary: Record "Entry Summary" temporary; TempReservEntry: Record "Reservation Entry" temporary; TrackingSpecification: Record "Tracking Specification")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateTempSummaryWithChangeOnAfterSetCurrentKey(var TempGlobalEntrySummary: Record "Entry Summary"; var ChangedEntrySummary: Record "Entry Summary")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateBinContentOnBeforeCalcSumsQtyBase(var TempEntrySummary: Record "Entry Summary"; var WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindRelatedParentTrkgSpecOnAfterSetFilters(var TempTrackingSpecification: Record "Tracking Specification"; ItemJnlLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRetrieveLookupDataOnAfterReservEntrySetFilters(var ReservEntry: Record "Reservation Entry"; TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRetrieveLookupDataOnAfterTransferToTempRec(var TempEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary; var ItemLedgEntry: Record "Item Ledger Entry"; var LastSummaryEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateTempSummaryWithChangeOnAfterCalcCurrentPendingQuantity(var TempChangedEntrySummary: Record "Entry Summary" temporary; var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateCurrentPendingQtyOnLoop(var TempGlobalChangedEntrySummary: Record "Entry Summary" temporary; CurrBinCode: Code[20]; var TempGlobalEntrySummary: Record "Entry Summary" temporary; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateTempSummaryWithChange(var TempChangedEntrySummary: Record "Entry Summary" temporary; CurrBinCode: Code[20]; var TempGlobalEntrySummary: Record "Entry Summary" temporary; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetCurrentBinAndItemTrkgCode(xBinCode: Code[20]; BinCode: Code[20]; CurrItemTrackingCode: Record "Item Tracking Code"; var FullGlobalDataSetExists: Boolean; var PartialGlobalDataSetExists: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateBinContentOnBeforeUpdateBinContent(var TempEntrySummary: Record "Entry Summary" temporary; ItemTrackingCode: Record "Item Tracking Code"; var IsHandled: Boolean; var TempGlobalReservationEntry: Record "Reservation Entry" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferItemLedgToTempRecOnBeforeFindSetItemLedgerEntry(var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetTempGlobalEntrySummaryExpirationDate(TempGlobalEntrySummary: Record "Entry Summary" temporary; TempReservEntry: Record "Reservation Entry" temporary)
    begin
    end;
}

