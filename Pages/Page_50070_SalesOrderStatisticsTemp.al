page 50070 "Sales Order Statistics-Temp"
{
    Caption = 'Sales Order Statistics';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("TotalSalesLine[1].""Line Amount"""; TotalSalesLine[1]."Line Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text002, false);
                    Editable = false;
                }
                field(InvDiscountAmount_General; TotalSalesLine[1]."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Inv. Discount Amount';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ActiveTab := ActiveTab::General;
                        UpdateInvDiscAmount(1);
                    end;
                }
                field("TotalAmount1[1]"; TotalAmount1[1])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, false);

                    trigger OnValidate()
                    begin
                        ActiveTab := ActiveTab::General;
                        UpdateTotalAmount(1);
                    end;
                }
                field("VATAmount[1]"; VATAmount[1])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText[1]);
                    Caption = 'VAT Amount';
                    Editable = false;
                }
                field("TotalAmount2[1]"; TotalAmount2[1])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, true);
                    Editable = false;

                    trigger OnValidate()
                    begin
                        TotalAmount21OnAfterValidate;
                    end;
                }
                field("TotalSalesLineLCY[1].Amount"; TotalSalesLineLCY[1].Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Sales (LCY)';
                    Editable = false;
                }
                field("TotalSalesLine[1].Quantity"; TotalSalesLine[1].Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[1].""Units per Parcel"""; TotalSalesLine[1]."Units per Parcel")
                {
                    ApplicationArea = All;
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[1].""Net Weight"""; TotalSalesLine[1]."Net Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[1].""Gross Weight"""; TotalSalesLine[1]."Gross Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[1].""Unit Volume"""; TotalSalesLine[1]."Unit Volume")
                {
                    ApplicationArea = All;
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(NoOfVATLines_General; TempVATAmountLine1.COUNT)
                {
                    ApplicationArea = All;
                    Caption = 'No. of VAT Lines';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        VATLinesDrillDown(TempVATAmountLine1, false);
                        UpdateHeaderInfo(1, TempVATAmountLine1);
                    end;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field(AmountInclVAT_Invoicing; TotalSalesLine[2]."Line Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text002, false);
                    Editable = false;
                }
                field(InvDiscountAmount_Invoicing; TotalSalesLine[2]."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Inv. Discount Amount';

                    trigger OnValidate()
                    begin
                        ActiveTab := ActiveTab::Invoicing;
                        UpdateInvDiscAmount(2);
                    end;
                }
                field(TotalInclVAT_Invoicing; TotalAmount1[2])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, false);

                    trigger OnValidate()
                    begin
                        ActiveTab := ActiveTab::Invoicing;
                        UpdateTotalAmount(2);
                    end;
                }
                field(VATAmount_Invoicing; VATAmount[2])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText[2]);
                    Editable = false;
                }
                field(TotalExclVAT_Invoicing; TotalAmount2[2])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, true);
                    Editable = false;
                }
                field("TotalSalesLineLCY[2].Amount"; TotalSalesLineLCY[2].Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Sales (LCY)';
                    Editable = false;
                }
                field("TotalSalesLine[2].Quantity"; TotalSalesLine[2].Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[2].""Units per Parcel"""; TotalSalesLine[2]."Units per Parcel")
                {
                    ApplicationArea = All;
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[2].""Net Weight"""; TotalSalesLine[2]."Net Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[2].""Gross Weight"""; TotalSalesLine[2]."Gross Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[2].""Unit Volume"""; TotalSalesLine[2]."Unit Volume")
                {
                    ApplicationArea = All;
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(NoOfVATLines_Invoicing; TempVATAmountLine2.COUNT)
                {
                    ApplicationArea = All;
                    Caption = 'No. of VAT Lines';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        ActiveTab := ActiveTab::Invoicing;
                        VATLinesDrillDown(TempVATAmountLine2, true);
                        UpdateHeaderInfo(2, TempVATAmountLine2);
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("TotalSalesLine[3].""Line Amount"""; TotalSalesLine[3]."Line Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text002, false);
                    Editable = false;
                }
                field("TotalSalesLine[3].""Inv. Discount Amount"""; TotalSalesLine[3]."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Inv. Discount Amount';
                    Editable = false;
                }
                field("TotalAmount1[3]"; TotalAmount1[3])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, false);
                    Editable = false;
                }
                field("VATAmount[3]"; VATAmount[3])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText[3]);
                    Editable = false;
                }
                field("TotalAmount2[3]"; TotalAmount2[3])
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, true);
                    Editable = false;
                }
                field("TotalSalesLineLCY[3].Amount"; TotalSalesLineLCY[3].Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Sales (LCY)';
                    Editable = false;
                }
                field("TotalSalesLine[3].Quantity"; TotalSalesLine[3].Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[3].""Units per Parcel"""; TotalSalesLine[3]."Units per Parcel")
                {
                    ApplicationArea = All;
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[3].""Net Weight"""; TotalSalesLine[3]."Net Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[3].""Gross Weight"""; TotalSalesLine[3]."Gross Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TotalSalesLine[3].""Unit Volume"""; TotalSalesLine[3]."Unit Volume")
                {
                    ApplicationArea = All;
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field("TempVATAmountLine3.COUNT"; TempVATAmountLine3.COUNT)
                {
                    ApplicationArea = All;
                    Caption = 'No. of VAT Lines';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        VATLinesDrillDown(TempVATAmountLine3, false);
                    end;
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field(PrepmtTotalAmount; PrepmtTotalAmount)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text006, false);

                    trigger OnValidate()
                    begin
                        ActiveTab := ActiveTab::Prepayment;
                        UpdatePrepmtAmount;
                    end;
                }
                field(PrepmtVATAmount; PrepmtVATAmount)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(PrepmtVATAmountText);
                    Caption = 'Prepayment Amount Invoiced';
                    Editable = false;
                }
                field(PrepmtTotalAmount2; PrepmtTotalAmount2)
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text006, true);
                    Editable = false;
                }
                field("TotalSalesLine[1].""Prepmt. Amt. Inv."""; TotalSalesLine[1]."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text007, false);
                    Editable = false;
                }
                field(PrepmtInvPct; PrepmtInvPct)
                {
                    ApplicationArea = All;
                    Caption = 'Invoiced % of Prepayment Amt.';
                    ExtendedDatatype = Ratio;
                    ToolTip = 'Invoiced % of Prepayment Amt.';
                }
                field("TotalSalesLine[1].""Prepmt Amt Deducted"""; TotalSalesLine[1]."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text008, false);
                    Editable = false;
                }
                field(PrepmtDeductedPct; PrepmtDeductedPct)
                {
                    ApplicationArea = All;
                    Caption = 'Deducted % of Prepayment Amt. to Deduct';
                    ExtendedDatatype = Ratio;
                    ToolTip = 'Deducted % of Prepayment Amt. to Deduct';
                }
                field("TotalSalesLine[1].""Prepmt Amt to Deduct"""; TotalSalesLine[1]."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text009, false);
                    Editable = false;
                }
                field("TempVATAmountLine4.COUNT"; TempVATAmountLine4.COUNT)
                {
                    ApplicationArea = All;
                    Caption = 'No. of VAT Lines';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        VATLinesDrillDown(TempVATAmountLine4, true);
                    end;
                }
            }
            group(Customer)
            {
                Caption = 'Customer';
                field("Cust.""Balance (LCY)"""; Cust."Balance (LCY)")
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Balance (LCY)';
                    Editable = false;
                }
                field("Cust.""Credit Limit (LCY)"""; Cust."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Credit Limit (LCY)';
                    Editable = false;
                }
                field(CreditLimitLCYExpendedPct; CreditLimitLCYExpendedPct)
                {
                    ApplicationArea = All;
                    Caption = 'Expended % of Credit Limit (LCY)';
                    ExtendedDatatype = Ratio;
                    ToolTip = 'Expended % of Credit Limit (LCY)';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
    begin
        CurrPage.CAPTION(STRSUBSTNO(Text000, Rec."Document Type"));

        if PrevNo = Rec."No." then
            exit;
        PrevNo := Rec."No.";
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("No.", PrevNo);
        Rec.FILTERGROUP(0);

        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);

        for i := 1 to 3 do begin
            TempSalesLine.DELETEALL;
            CLEAR(TempSalesLine);
            CLEAR(SalesPost);
            SalesPost.GetSalesLines(Rec, TempSalesLine, i - 1);
            CLEAR(SalesPost);
            case i of
                1:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine1);
                2:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine2);
                3:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine3);
            end;

            SalesPost.SumSalesLinesTemp(
              Rec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i],
              VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], TotalAdjCostLCY[i]);

            if i = 3 then
                TotalAdjCostLCY[i] := TotalSalesLineLCY[i]."Unit Cost (LCY)";

            AdjProfitLCY[i] := TotalSalesLineLCY[i].Amount - TotalAdjCostLCY[i];
            if TotalSalesLineLCY[i].Amount <> 0 then
                AdjProfitPct[i] := ROUND(AdjProfitLCY[i] / TotalSalesLineLCY[i].Amount * 100, 0.1);

            if Rec."Prices Including VAT" then begin
                TotalAmount2[i] := TotalSalesLine[i].Amount;
                TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                TotalSalesLine[i]."Line Amount" := TotalAmount1[i] + TotalSalesLine[i]."Inv. Discount Amount";
            end else begin
                TotalAmount1[i] := TotalSalesLine[i].Amount;
                TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
            end;
        end;
        TempSalesLine.DELETEALL;
        CLEAR(TempSalesLine);
        SalesPostPrepmt.GetSalesLines(Rec, 0, TempSalesLine);
        SalesPostPrepmt.SumPrepmt(
          Rec, TempSalesLine, TempVATAmountLine4, PrepmtTotalAmount, PrepmtVATAmount, PrepmtVATAmountText);
        PrepmtInvPct :=
          Pct(TotalSalesLine[1]."Prepmt. Amt. Inv.", PrepmtTotalAmount);
        PrepmtDeductedPct :=
          Pct(TotalSalesLine[1]."Prepmt Amt Deducted", TotalSalesLine[1]."Prepmt. Amt. Inv.");
        if Rec."Prices Including VAT" then begin
            PrepmtTotalAmount2 := PrepmtTotalAmount;
            PrepmtTotalAmount := PrepmtTotalAmount + PrepmtVATAmount;
        end else
            PrepmtTotalAmount2 := PrepmtTotalAmount + PrepmtVATAmount;

        if Cust.GET(Rec."Bill-to Customer No.") then
            Cust.CALCFIELDS("Balance (LCY)")
        else
            CLEAR(Cust);

        case true of
            Cust."Credit Limit (LCY)" = 0:
                CreditLimitLCYExpendedPct := 0;
            Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0:
                CreditLimitLCYExpendedPct := 0;
            Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1:
                CreditLimitLCYExpendedPct := 10000;
            else
                CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);
        end;

        TempVATAmountLine1.MODIFYALL(Modified, false);
        TempVATAmountLine2.MODIFYALL(Modified, false);
        TempVATAmountLine3.MODIFYALL(Modified, false);
        TempVATAmountLine4.MODIFYALL(Modified, false);

        PrevTab := 0;
    end;

    trigger OnOpenPage()
    begin
        SalesSetup.GET;
        AllowInvDisc := not (SalesSetup."Calc. Inv. Discount" and CustInvDiscRecExists(Rec."Invoice Disc. Code"));
        AllowVATDifference :=
          SalesSetup."Allow VAT Difference" and
          not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::"Blanket Order"]);
        VATLinesFormIsEditable := AllowVATDifference or AllowInvDisc;
        CurrPage.EDITABLE := VATLinesFormIsEditable;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        GetVATSpecification(PrevTab);
        if TempVATAmountLine1.GetAnyLineModified or TempVATAmountLine2.GetAnyLineModified then
            UpdateVATOnSalesLines;
        exit(true);
    end;

    var
        Text000: Label 'Sales %1 Statistics';
        Text001: Label 'Total';
        Text002: Label 'Amount';
        Text003: Label '%1 must not be 0.';
        Text004: Label '%1 must not be greater than %2.';
        Text005: Label 'You cannot change the invoice discount because a customer invoice discount with the code %1 exists.';
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        Cust: Record Customer;
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        TempVATAmountLine4: Record "VAT Amount Line" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPost: Codeunit "Sales-Post";
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        PrepmtTotalAmount: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtTotalAmount2: Decimal;
        VATAmountText: array[3] of Text[30];
        PrepmtVATAmountText: Text[30];
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        AdjProfitLCY: array[3] of Decimal;
        AdjProfitPct: array[3] of Decimal;
        TotalAdjCostLCY: array[3] of Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        PrepmtInvPct: Decimal;
        PrepmtDeductedPct: Decimal;
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping,Prepayment;
        PrevTab: Option " ",General,Invoicing,Shipping,Prepayment;
        VATLinesFormIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        Text006: Label 'Prepmt. Amount';
        Text007: Label 'Prepmt. Amt. Invoiced';
        Text008: Label 'Prepmt. Amt. Deducted';
        Text009: Label 'Prepmt. Amt. to Deduct';
        VATLinesForm: Page "VAT Amount Lines";

    local procedure UpdateHeaderInfo(IndexNo: Integer; var VATAmountLine: Record "VAT Amount Line")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    begin
        TotalSalesLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1[IndexNo] :=
          TotalSalesLine[IndexNo]."Line Amount" - TotalSalesLine[IndexNo]."Inv. Discount Amount";
        VATAmount[IndexNo] := VATAmountLine.GetTotalVATAmount;
        if Rec."Prices Including VAT" then begin
            TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
            TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
            TotalSalesLine[IndexNo]."Line Amount" :=
              TotalAmount1[IndexNo] + TotalSalesLine[IndexNo]."Inv. Discount Amount";
        end else
            TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];

        if Rec."Prices Including VAT" then
            TotalSalesLineLCY[IndexNo].Amount := TotalAmount2[IndexNo]
        else
            TotalSalesLineLCY[IndexNo].Amount := TotalAmount1[IndexNo];
        if Rec."Currency Code" <> '' then
            if Rec."Posting Date" = 0D then
                UseDate := WORKDATE
            else
                UseDate := Rec."Posting Date";

        TotalSalesLineLCY[IndexNo].Amount :=
          CurrExchRate.ExchangeAmtFCYToLCY(
            UseDate, Rec."Currency Code", TotalSalesLineLCY[IndexNo].Amount, Rec."Currency Factor");

        ProfitLCY[IndexNo] := TotalSalesLineLCY[IndexNo].Amount - TotalSalesLineLCY[IndexNo]."Unit Cost (LCY)";
        if TotalSalesLineLCY[IndexNo].Amount = 0 then
            ProfitPct[IndexNo] := 0
        else
            ProfitPct[IndexNo] := ROUND(100 * ProfitLCY[IndexNo] / TotalSalesLineLCY[IndexNo].Amount, 0.01);

        AdjProfitLCY[IndexNo] := TotalSalesLineLCY[IndexNo].Amount - TotalAdjCostLCY[IndexNo];
        if TotalSalesLineLCY[IndexNo].Amount = 0 then
            AdjProfitPct[IndexNo] := 0
        else
            AdjProfitPct[IndexNo] := ROUND(100 * AdjProfitLCY[IndexNo] / TotalSalesLineLCY[IndexNo].Amount, 0.01);
    end;

    local procedure GetVATSpecification(QtyType: Option General,Invoicing,Shipping)
    begin
        case QtyType of
            QtyType::General:
                begin
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine1);
                    UpdateHeaderInfo(1, TempVATAmountLine1);
                end;
            QtyType::Invoicing:
                begin
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine2);
                    UpdateHeaderInfo(2, TempVATAmountLine2);
                end;
            QtyType::Shipping:
                VATLinesForm.GetTempVATAmountLine(TempVATAmountLine3);
        end;
    end;

    local procedure UpdateTotalAmount(IndexNo: Integer)
    var
        SaveTotalAmount: Decimal;
    begin
        CheckAllowInvDisc;
        if Rec."Prices Including VAT" then begin
            SaveTotalAmount := TotalAmount1[IndexNo];
            UpdateInvDiscAmount(IndexNo);
            TotalAmount1[IndexNo] := SaveTotalAmount;
        end;

        TotalSalesLine[IndexNo]."Inv. Discount Amount" := TotalSalesLine[IndexNo]."Line Amount" - TotalAmount1[IndexNo];
        UpdateInvDiscAmount(IndexNo);
    end;

    local procedure UpdateInvDiscAmount(ModifiedIndexNo: Integer)
    var
        PartialInvoicing: Boolean;
        MaxIndexNo: Integer;
        IndexNo: array[2] of Integer;
        i: Integer;
        InvDiscBaseAmount: Decimal;
    begin
        CheckAllowInvDisc;
        if not (ModifiedIndexNo in [1, 2]) then
            exit;

        if ModifiedIndexNo = 1 then
            InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(false, Rec."Currency Code")
        else
            InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(false, Rec."Currency Code");

        if InvDiscBaseAmount = 0 then
            ERROR(Text003, TempVATAmountLine2.FIELDCAPTION("Inv. Disc. Base Amount"));

        if TotalSalesLine[ModifiedIndexNo]."Inv. Discount Amount" / InvDiscBaseAmount > 1 then
            ERROR(
              Text004,
              TotalSalesLine[ModifiedIndexNo].FIELDCAPTION("Inv. Discount Amount"),
              TempVATAmountLine2.FIELDCAPTION("Inv. Disc. Base Amount"));

        PartialInvoicing := (TotalSalesLine[1]."Line Amount" <> TotalSalesLine[2]."Line Amount");

        IndexNo[1] := ModifiedIndexNo;
        IndexNo[2] := 3 - ModifiedIndexNo;
        if (ModifiedIndexNo = 2) and PartialInvoicing then
            MaxIndexNo := 1
        else
            MaxIndexNo := 2;

        if not PartialInvoicing then
            if ModifiedIndexNo = 1 then
                TotalSalesLine[2]."Inv. Discount Amount" := TotalSalesLine[1]."Inv. Discount Amount"
            else
                TotalSalesLine[1]."Inv. Discount Amount" := TotalSalesLine[2]."Inv. Discount Amount";

        for i := 1 to MaxIndexNo do begin
            if (i = 1) or not PartialInvoicing then
                if IndexNo[i] = 1 then begin
                    TempVATAmountLine1.SetInvoiceDiscountAmount(
                      TotalSalesLine[IndexNo[i]]."Inv. Discount Amount", TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", Rec."VAT Base Discount %");
                end else
                    TempVATAmountLine2.SetInvoiceDiscountAmount(
                      TotalSalesLine[IndexNo[i]]."Inv. Discount Amount", TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", Rec."VAT Base Discount %");

            if (i = 2) and PartialInvoicing then
                if IndexNo[i] = 1 then begin
                    InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(false, TotalSalesLine[IndexNo[i]]."Currency Code");
                    if InvDiscBaseAmount = 0 then
                        TempVATAmountLine1.SetInvoiceDiscountPercent(
                          0, TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", false, Rec."VAT Base Discount %")
                    else
                        TempVATAmountLine1.SetInvoiceDiscountPercent(
                          100 * TempVATAmountLine2.GetTotalInvDiscAmount / InvDiscBaseAmount,
                          TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", false, Rec."VAT Base Discount %");
                end else begin
                    InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(false, TotalSalesLine[IndexNo[i]]."Currency Code");
                    if InvDiscBaseAmount = 0 then
                        TempVATAmountLine2.SetInvoiceDiscountPercent(
                          0, TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", false, Rec."VAT Base Discount %")
                    else
                        TempVATAmountLine2.SetInvoiceDiscountPercent(
                          100 * TempVATAmountLine1.GetTotalInvDiscAmount / InvDiscBaseAmount,
                          TotalSalesLine[IndexNo[i]]."Currency Code", Rec."Prices Including VAT", false, Rec."VAT Base Discount %");
                end;
        end;

        UpdateHeaderInfo(1, TempVATAmountLine1);
        UpdateHeaderInfo(2, TempVATAmountLine2);

        if ModifiedIndexNo = 1 then
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine1)
        else
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine2);

        Rec."Invoice Discount Calculation" := Rec."Invoice Discount Calculation"::Amount;
        Rec."Invoice Discount Value" := TotalSalesLine[1]."Inv. Discount Amount";
        Rec.MODIFY;

        UpdateVATOnSalesLines;
    end;

    local procedure UpdatePrepmtAmount()
    var
        TempSalesLine: Record "Sales Line" temporary;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
    begin
        SalesPostPrepmt.UpdatePrepmtAmountOnSaleslines(Rec, PrepmtTotalAmount);
        SalesPostPrepmt.GetSalesLines(Rec, 0, TempSalesLine);
        SalesPostPrepmt.SumPrepmt(
          Rec, TempSalesLine, TempVATAmountLine4, PrepmtTotalAmount, PrepmtVATAmount, PrepmtVATAmountText);
        PrepmtInvPct :=
          Pct(TotalSalesLine[1]."Prepmt. Amt. Inv.", PrepmtTotalAmount);
        PrepmtDeductedPct :=
          Pct(TotalSalesLine[1]."Prepmt Amt Deducted", TotalSalesLine[1]."Prepmt. Amt. Inv.");
        if Rec."Prices Including VAT" then begin
            PrepmtTotalAmount2 := PrepmtTotalAmount;
            PrepmtTotalAmount := PrepmtTotalAmount + PrepmtVATAmount;
        end else
            PrepmtTotalAmount2 := PrepmtTotalAmount + PrepmtVATAmount;
        Rec.MODIFY;
    end;

    local procedure GetCaptionClass(FieldCaption: Text[100]; ReverseCaption: Boolean): Text[80]
    begin
        if Rec."Prices Including VAT" xor ReverseCaption then
            exit('2,1,' + FieldCaption);
        exit('2,0,' + FieldCaption);
    end;

    local procedure UpdateVATOnSalesLines()
    var
        SalesLine: Record "Sales Line";
    begin
        GetVATSpecification(ActiveTab);
        if TempVATAmountLine1.GetAnyLineModified then
            SalesLine.UpdateVATOnLines(0, Rec, SalesLine, TempVATAmountLine1);
        if TempVATAmountLine2.GetAnyLineModified then
            SalesLine.UpdateVATOnLines(1, Rec, SalesLine, TempVATAmountLine2);
        PrevNo := '';
    end;

    local procedure CustInvDiscRecExists(InvDiscCode: Code[20]): Boolean
    var
        CustInvDisc: Record "Cust. Invoice Disc.";
    begin
        CustInvDisc.SETRANGE(Code, InvDiscCode);
        exit(CustInvDisc.FINDFIRST);
    end;

    local procedure CheckAllowInvDisc()
    begin
        if not AllowInvDisc then
            ERROR(Text005, Rec."Invoice Disc. Code");
    end;

    local procedure Pct(Numerator: Decimal; Denominator: Decimal): Decimal
    begin
        if Denominator = 0 then
            exit(0);
        exit(ROUND(Numerator / Denominator * 10000, 1));
    end;


    procedure VATLinesDrillDown(var VATLinesToDrillDown: Record "VAT Amount Line"; ThisTabAllowsVATEditing: Boolean)
    begin
        CLEAR(VATLinesForm);
        VATLinesForm.SetTempVATAmountLine(VATLinesToDrillDown);
        VATLinesForm.InitGlobals(
          Rec."Currency Code", AllowVATDifference, AllowVATDifference and ThisTabAllowsVATEditing,
          Rec."Prices Including VAT", AllowInvDisc, Rec."VAT Base Discount %");
        VATLinesForm.RUNMODAL;
        VATLinesForm.GetTempVATAmountLine(VATLinesToDrillDown);
    end;

    local procedure TotalAmount21OnAfterValidate()
    begin
        if Rec."Prices Including VAT" then
            TotalSalesLine[1]."Inv. Discount Amount" := TotalSalesLine[1]."Line Amount" - TotalSalesLine[1]."Amount Including VAT"
        else
            TotalSalesLine[1]."Inv. Discount Amount" := TotalSalesLine[1]."Line Amount" - TotalSalesLine[1].Amount;
        UpdateInvDiscAmount(1);
    end;
}

