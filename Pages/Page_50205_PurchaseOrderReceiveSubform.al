page 50205 "Purchase Order Receive Subform"//14005151
{
    // //DS    LockLeft and added the Original Quantity field
    // //PLL   Add one global
    //         Add one local function
    //         Add Item Purchase History
    // NUB1.01,17-Mar-16,ST: Added new Action Item  "Update Item Description" to Line group.

    AutoSplitKey = true;
    Caption = 'Purchase Order Receive Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //CrossReferenceNoLookUp;

                        InsertExtendedText(false);
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {

                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = all;

                }
                field("Quantity Received"; Rec."Quantity Received")
                {

                    Editable = false;
                    ApplicationArea = all;
                }
                field("Original Qty"; Rec."Original Qty")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {

                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Line Amount"; Rec."Line Amount")
                {

                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = all;

                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = all;

                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;

                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Finished; Rec.Finished)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                // field("IRS 1099 Liable"; Rec."IRS 1099 Liable")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        //CurrPage.PurchLines.FORM.
                        ApproveCalcInvDisc;

                    end;
                }
                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        // CurrPage.PurchLines.FORM.
                        ExplodeBOM;

                    end;
                }
                action("Insert &Ext. Text")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Text';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        //CurrPage.PurchLines.FORM.
                        _InsertExtendedText(true);

                    end;
                }
                action("&Reserve")
                {
                    ApplicationArea = All;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        // CurrPage.PurchLines.FORM.
                        Rec.ShowReservation;

                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        //CurrPage.PurchLines.FORM.
                        ShowTracking;

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                            //CurrPage.PurchLines.FORM.
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                            //CurrPage.PurchLines.FORM.
                            _ItemAvailability(1);

                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                            // CurrPage.PurchLines.FORM.
                            _ItemAvailability(2);

                        end;
                    }
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        // CurrPage.PurchLines.FORM.
                        Rec.OpenItemTrackingLines;

                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        // CurrPage.PurchLines.FORM.
                        Rec.ShowDimensions;

                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #14005150. Unsupported part was commented. Please check it.
                        //CurrPage.PurchLines.FORM.
                        Rec.ShowLineComments;

                    end;
                }
                separator(Separator1100796001)
                {
                }
                action("Update Item Description")
                {
                    ApplicationArea = All;
                    Caption = 'Update Item Description';
                    Ellipsis = true;
                    // Promoted = true;
                    // PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //NUB1.02 Start
                        Rec.UpdateItemDescription;
                        //NUB1.02 End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            COMMIT;
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        "--FP--": Integer;
    //LineLookupC: Codeunit "Posting Doc.Line Reporting";//14005058B2BUPG


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;


    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := false;
        SalesOrder.RUN;
    end;


    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;


    // procedure _ShowReservation()
    // begin
    //     Rec.FIND;
    //     Rec.ShowReservation;
    // end;


    // procedure ShowReservation()
    // begin
    //     Rec.FIND;
    //     Rec.ShowReservation;
    // end;


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        Rec.InitType;
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        Rec.InitType;
    end;


    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;


    procedure ShowTracking()
    begin
        Rec.ShowOrderTracking();
    end;


    // procedure _ShowDimensions()
    // begin
    //     Rec.ShowDimensions;
    // end;


    // procedure ShowDimensions()
    // begin
    //     Rec.ShowDimensions;
    // end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    // procedure _OpenItemTrackingLines()
    // begin
    //     Rec.OpenItemTrackingLines;
    // end;


    // procedure OpenItemTrackingLines()
    // begin
    //     Rec.OpenItemTrackingLines;
    // end;


    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := false;
        SalesOrder.RUN;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;


    // procedure _ShowLineComments()
    // begin
    //     Rec.ShowLineComments;
    // end;


    // procedure ShowLineComments()
    // begin
    //     Rec.ShowLineComments;
    // end;


    procedure GetItemHistory()
    begin
        //PLL
        //LineLookupC.GetPurchLineHistory(Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;
}

