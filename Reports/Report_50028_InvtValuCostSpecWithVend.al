report 50028 "Invt.Valu.Cost Spec.With Vend."
{
    // NUB1.01,08/24/17,SK: Save as the report from 5801.
    //                      Added new group by "Vendor No.".
    //                      Added code in "Integer - OnAfterGetRecord()".
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/InvtValuCostSpecWithVend.rdl';

    Caption = 'Invt. Valuation - Cost Spec.';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(AsOfValuationDate; STRSUBSTNO(Text000, FORMAT(ValuationDate)))
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Description_Item; Description)
            {
            }
            column(TotalCost; ResultForTotalCost)
            {
                AutoFormatType = 1;
            }
            column(VendorNo_Item; Item."Vendor No.")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(= 0));
                column(AvgCost; ResultForAvgCost)
                {
                    AutoFormatType = 2;
                }
                column(RemainingQty; ResultForRemainingQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UnitCost1; ResultForUnitCost[1])
                {
                    AutoFormatType = 2;
                }
                column(UnitCost2; ResultForUnitCost[2])
                {
                    AutoFormatType = 2;
                }
                column(UnitCost3; ResultForUnitCost[3])
                {
                    AutoFormatType = 2;
                }
                column(UnitCost4; ResultForUnitCost[4])
                {
                    AutoFormatType = 2;
                }
                column(UnitCost5; ResultForUnitCost[5])
                {
                    AutoFormatType = 2;
                }
                column(TotalCostTotal1; ResultForTotalCostTotal[1])
                {
                    AutoFormatType = 1;
                }
                column(TotalCostTotal2; ResultForTotalCostTotal[2])
                {
                    AutoFormatType = 1;
                }
                column(TotalCostTotal3; ResultForTotalCostTotal[3])
                {
                    AutoFormatType = 1;
                }
                column(TotalCostTotal4; ResultForTotalCostTotal[4])
                {
                    AutoFormatType = 1;
                }
                column(TotalCostTotal5; ResultForTotalCostTotal[5])
                {
                    AutoFormatType = 1;
                }
                column(NoOfEntries1; NoOfEntries[1])
                {
                }
                column(NoOfEntries2; NoOfEntries[2])
                {
                }
                column(NoOfEntries3; NoOfEntries[3])
                {
                }
                column(NoOfEntries4; NoOfEntries[4])
                {
                }
                column(NoOfEntries5; NoOfEntries[5])
                {
                }
                column(EntryTypeDescription1; EntryTypeDescription[1])
                {
                }
                column(EntryTypeDescription2; EntryTypeDescription[2])
                {
                }
                column(EntryTypeDescription3; EntryTypeDescription[3])
                {
                }
                column(EntryTypeDescription4; EntryTypeDescription[4])
                {
                }
                column(EntryTypeDescription5; EntryTypeDescription[5])
                {
                }

                trigger OnAfterGetRecord()
                var
                    ItemLedgerEntry: Record "Item Ledger Entry";
                begin
                    ClearTotals;

                    ItemLedgerEntry.SETFILTER("Item No.", Item."No.");
                    ItemLedgerEntry.SETFILTER("Variant Code", Item."Variant Filter");
                    ItemLedgerEntry.SETFILTER("Location Code", Item."Location Filter");
                    ItemLedgerEntry.SETFILTER("Global Dimension 1 Code", Item."Global Dimension 1 Filter");
                    ItemLedgerEntry.SETFILTER("Global Dimension 2 Code", Item."Global Dimension 2 Filter");
                    ItemLedgerEntry.SETRANGE("Posting Date", 0D, ValuationDate);
                    ItemLedgerEntry.SETRANGE("Drop Shipment", FALSE);
                    IF NOT ItemLedgerEntry.FINDSET THEN
                        CurrReport.BREAK;

                    REPEAT
                        ClearBufferVariables;

                        IsPositive := GetSign(ItemLedgerEntry);
                        CalcRemainingQty(ItemLedgerEntry);
                        CalcUnitCost(ItemLedgerEntry);
                        FOR i := 1 TO ARRAYLEN(TotalCostTotal) DO BEGIN
                            TotalCostTotal[i] := TotalCostTotal[i] * ABS(RemainingQty);
                            TotalCost := TotalCost + TotalCostTotal[i];
                            TotalCostAvg[i] += TotalCostTotal[i];
                        END;
                        TotalRemAvg += RemainingQty;

                        IncrTotals;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                    CalcAvgCost;

                    //NUB1.01 Start
                    IF (ResultForTotalCostTotal[1] = 0) AND
                       (ResultForTotalCostTotal[2] = 0) AND
                       (ResultForTotalCostTotal[3] = 0) AND
                       (ResultForTotalCostTotal[4] = 0) AND
                       (ResultForTotalCostTotal[5] = 0) THEN
                        CurrReport.SKIP;
                    //NUB1.01 End
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ValuationDate; ValuationDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Valuation Date';

                        trigger OnValidate()
                        begin
                            IF ValuationDate = 0D THEN
                                ERROR(Text001);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF ValuationDate = 0D THEN
                ValuationDate := WORKDATE;
        end;
    }

    labels
    {
        InventoryValuationCostSpecificationCaption = 'Inventory Valuation - Cost Specification';
        PageCaption = 'Page';
        OfCaption = 'of';
        RemainingQtyCaption = 'Quantity';
        CostPerUnitCaption = 'Cost per Unit';
        AmountCaption = 'Amount';
        EntryTypeCaption = 'Entry Type';
        TotalCaption = 'Total';
        ItemCaption = 'Item';
        DescriptionCaption = 'Description';
    }

    /*
    value(0; "Direct Cost") { Caption = 'Direct Cost'; }
        value(1; "Revaluation") { Caption = 'Revaluation'; }
        value(2; "Rounding") { Caption = 'Rounding'; }
        value(3; "Indirect Cost") { Caption = 'Indirect Cost'; }
        value(4; "Variance") { Caption = 'Variance'; }
        value(5; "Total") { Caption = 'Total'; }
    */
    trigger OnPreReport()
    begin
        FOR i := 1 TO ARRAYLEN(EntryTypeDescription) DO BEGIN
            case (i - 1) of
                0:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::"Direct Cost";
                1:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::Revaluation;
                2:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::Rounding;
                3:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::"Indirect Cost";
                4:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::Variance;
                5:
                    ValueEntry."Entry Type" := ValueEntry."Entry Type"::Total;
            end;
            EntryTypeDescription[i] := FORMAT(ValueEntry."Entry Type");
        END;

        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.SETRANGE("Posting Date", 0D, ValuationDate);
        ValueEntry.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
        ValueEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
        ValueEntry.SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
        ValueEntry.SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
    end;

    var
        Text000: Label 'As of %1';
        Text001: Label 'Enter the valuation date';
        ValueEntry: Record "Value Entry";
        EntryTypeDescription: array[5] of Text[30];
        i: Integer;
        NoOfEntries: array[5] of Decimal;
        PosQty: Decimal;
        RemainingQty: Decimal;
        TotalCostTotal: array[5] of Decimal;
        TotalRemAvg: Decimal;
        TotalCostAvg: array[5] of Decimal;
        TotalCost: Decimal;
        ValuationDate: Date;
        IsPositive: Boolean;
        ResultForTotalCostTotal: array[5] of Decimal;
        ResultForUnitCost: array[5] of Decimal;
        ResultForTotalCostAvg: array[5] of Decimal;
        ResultForTotalRemAvg: Decimal;
        ResultForTotalCost: Decimal;
        ResultForRemainingQty: Decimal;
        ResultForAvgCost: Decimal;

    local procedure CalcRemainingQty(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        RemainingQty := ItemLedgerEntry.Quantity;
        IF IsPositive THEN
            PosQty := ItemLedgerEntry.Quantity;

        IF ItemLedgerEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETRANGE("Posting Date", 0D, ValuationDate);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    SumQty(RemainingQty, PosQty, ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, ValuationDate);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    SumQty(RemainingQty, PosQty, ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                UNTIL ItemApplnEntry.NEXT = 0;
        END;

        IF IsPositive THEN
            PosQty := RemainingQty;
    end;

    local procedure SumQty(var RemainingQty: Decimal; var PosQty: Decimal; EntryNo: Integer; AppliedQty: Decimal): Decimal
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.GET(EntryNo);
        IF (ItemLedgEntry.Quantity * AppliedQty < 0) OR
           (ItemLedgEntry."Posting Date" > ValuationDate)
        THEN
            EXIT;

        RemainingQty := RemainingQty + AppliedQty;
        IF IsPositive THEN
            PosQty := PosQty + AppliedQty;
    end;

    local procedure CalcUnitCost(ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ValueEntry."Partial Revaluation" THEN
                    SumUnitCost(TotalCostTotal[ValueEntry."Entry Type".AsInteger() + 1],
                      ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", ValueEntry."Valued Quantity")
                ELSE
                    SumUnitCost(TotalCostTotal[ValueEntry."Entry Type".AsInteger() + 1],
                      ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", ItemLedgerEntry.Quantity);
                NoOfEntries[ValueEntry."Entry Type".AsInteger() + 1] := 1;
            UNTIL ValueEntry.NEXT = 0;
    end;

    local procedure CalcAvgCost()
    begin
        FOR i := 1 TO ARRAYLEN(NoOfEntries) DO BEGIN
            IF ResultForTotalRemAvg <> 0 THEN
                ResultForUnitCost[i] := ResultForTotalCostAvg[i] / ABS(ResultForTotalRemAvg)
            ELSE
                ResultForUnitCost[i] := 0;
            ResultForAvgCost += ResultForUnitCost[i];
        END;
    end;

    local procedure GetSign(ItemLedgerEntry: Record "Item Ledger Entry"): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        CASE ItemLedgerEntry."Entry Type" OF
            ItemLedgerEntry."Entry Type"::Purchase,
  ItemLedgerEntry."Entry Type"::"Positive Adjmt.",
  ItemLedgerEntry."Entry Type"::Output,
  ItemLedgerEntry."Entry Type"::"Assembly Output":
                EXIT(TRUE);
            ItemLedgerEntry."Entry Type"::Transfer:
                BEGIN
                    IF NOT ItemLedgerEntry.Positive THEN
                        EXIT(FALSE);
                    ItemLedgEntry.COPYFILTERS(ItemLedgerEntry);
                    ItemLedgEntry."Entry No." := ItemLedgerEntry."Entry No." - 1;
                    EXIT(NOT ItemLedgEntry.FIND);
                END;
            ELSE
                EXIT(FALSE)
        END;
    end;

    local procedure SumUnitCost(var UnitCost: Decimal; CostAmount: Decimal; Quantity: Decimal)
    begin
        UnitCost := UnitCost + CostAmount / ABS(Quantity);
    end;


    procedure InitializeRequest(NewValuationDate: Date)
    begin
        ValuationDate := NewValuationDate;
    end;

    local procedure ClearTotals()
    begin
        CLEAR(NoOfEntries);
        CLEAR(ResultForTotalCostTotal);
        CLEAR(ResultForUnitCost);
        CLEAR(ResultForTotalCostAvg);
        ResultForTotalRemAvg := 0;
        ResultForTotalCost := 0;
        ResultForRemainingQty := 0;
        ResultForAvgCost := 0;
    end;

    local procedure ClearBufferVariables()
    begin
        CLEAR(TotalCostTotal);
        CLEAR(TotalCostAvg);
        TotalRemAvg := 0;
        TotalCost := 0;
        RemainingQty := 0;
    end;

    local procedure IncrTotals()
    begin
        FOR i := 1 TO ARRAYLEN(TotalCostTotal) DO BEGIN
            ResultForTotalCostTotal[i] += TotalCostTotal[i];
            ResultForTotalCostAvg[i] += TotalCostAvg[i];
        END;

        ResultForTotalRemAvg += TotalRemAvg;
        ResultForTotalCost += TotalCost;
        ResultForRemainingQty += RemainingQty;
    end;
}

