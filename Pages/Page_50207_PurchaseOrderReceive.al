page 50207 "Purchase Order Receive"//14005150 
{
    // //DS Stretched Subform for Lock left
    //      Bolded the Status field
    //      Added Posting Description field
    //      Added Requested Receipt Date
    //      Added Your Reference field
    // //JM5    Added Jobs menu choices on Post button for PO Post Job receipt
    // //JM5.12 Removed menu choices from JM5.
    // //JM5.14 Created this form
    //          Created Report 14004453 to print with this form
    // NUB1.01,17-Mar-16,ST: Added new Action Item  "Update Item Description" to function group.
    ApplicationArea = All;
    Caption = 'Purchase Order Receive';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Time"; Rec."Expected Receipt Time")
                {
                    ApplicationArea = All;
                }
                field("Pallets-Cases"; Rec."Pallets-Cases")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(PurchLines; "Purchase Order Receive Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to State / ZIP Code';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Exemption No."; Rec."Tax Exemption No.")
                {
                    ApplicationArea = All;
                }
                field("Provincial Tax Area Code"; Rec."Provincial Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        PurchSetup.GET;
                        if PurchSetup."Calc. Inv. Discount" then begin
                            CurrPage.PurchLines.PAGE.CalcInvDisc;
                            COMMIT;
                        end;
                        if Rec."Tax Area Code" = '' then
                            PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec)
                        else
                            PAGE.RUNMODAL(PAGE::"Purchase Order Stats.", Rec)
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                separator(Separator181)
                {
                }
                action("Whse. Receipt Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Receipt Lines';
                    // RunObject = Page "Whse. Receipt Lines";
                    // RunPageLink = "Source Type" = CONST(39),
                    //               "Source Subtype" = FIELD("Document Type"),
                    //               "Source No." = FIELD("No.");
                    // RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    trigger OnAction()
                    var
                        WhseReceiptLinesPage: Page "Whse. Receipt Lines";
                        WhseReceiptLineRec: Record "Warehouse Receipt Line";
                    begin
                        WhseReceiptLineRec.SetCurrentKey("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                        WhseReceiptLineRec.SetRange("Source Type", 39);
                        WhseReceiptLineRec.SetRange("Source Subtype", Rec."Document Type".AsInteger());
                        WhseReceiptLineRec.SetRange("Source No.", Rec."No.");
                        WhseReceiptLinesPage.SetTableView(WhseReceiptLineRec);
                        WhseReceiptLinesPage.Run();
                    end;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Separator190)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Separator75)
                {
                }
                action("Copy Document")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(Separator189)
                {
                }
                action("Create &Whse. Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Receipt';
                    Visible = false;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        if not Rec.FIND('=><') then
                            Rec.INIT;
                    end;
                }
                separator(Separator74)
                {
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //if ApprovalMgt.SendPurchaseApprovalRequest(Rec) then;
                        if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalMgt.OnSendPurchaseDocForApproval(rec);

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        WorkFlowbhookMgt: codeunit "Workflow Webhook Management";
                    begin
                        //if ApprovalMgt.CancelPurchaseApprovalRequest(Rec, true, true) then;
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkFlowbhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
                separator(Separator73)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //         if ApprovalMgt.TestPurchasePrepayment(Rec) then
                        //             ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                        //         else begin
                        //             if ApprovalMgt.TestPurchasePayment(Rec) then begin
                        //                 if not CONFIRM(STRSUBSTNO(Text002, "Document Type", "No.")) then
                        //                     exit;
                        //                 Status := Status::"Pending Prepayment";
                        //                 MODIFY;
                        //                 CurrPage.UPDATE;
                        //             end else
                        //                 ReleasePurchDoc.PerformManualRelease(Rec);
                        //         end;
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator611)
                {
                }
                // action("Send IC Purchase Order")
                // {
                //     Caption = 'Send IC Purchase Order';
                //     Visible = false;

                //     trigger OnAction()
                //     var
                //         ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                //         SalesHeader: Record "Sales Header";
                //         ApprovalMgt: Codeunit "Approvals Mgmt.";
                //     begin
                //         if ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) then
                //             ICInOutboxMgt.SendPurchDoc(Rec, false);
                //     end;
                // }
                separator(Separator1100796005)
                {
                }
                action("Update Item Description")
                {
                    ApplicationArea = All;
                    Caption = 'Update Item Description';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //NUB1.02 Start
                        Rec.UpdateItemDescription;
                        //NUB1.02 End
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        //     if ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) then begin
                        //         if ApprovalMgt.TestPurchasePrepayment(Rec) then
                        //             ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                        //         else begin
                        //             if ApprovalMgt.TestPurchasePayment(Rec) then begin
                        //                 if not CONFIRM(STRSUBSTNO(Text002, "Document Type", "No."), true) then
                        //                     exit
                        //                 else
                        //                     CODEUNIT.RUN(CODEUNIT::"Receive-Post (Yes/No)", Rec);
                        //             end else
                        //                 CODEUNIT.RUN(CODEUNIT::"Receive-Post (Yes/No)", Rec);//14005063
                        //         end;
                        //     end;
                    end;
                }
                //     action("Post and &Print")
                //     {
                //         Caption = 'Post and &Print';
                //         Ellipsis = true;
                //         Image = PostPrint;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         ShortCutKey = 'Shift+F9';
                //         Visible = false;
                //         trigger OnAction()
                //         var
                //             SalesHeader: Record "Sales Header";
                //         begin
                //             if ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) then begin
                //                 if ApprovalMgt.TestPurchasePrepayment(Rec) then
                //                     ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                //                 else begin
                //                     if ApprovalMgt.TestPurchasePayment(Rec) then begin
                //                         if not CONFIRM(STRSUBSTNO(Text002, "Document Type", "No."), true) then
                //                             exit
                //                         else
                //                             CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                //                     end else
                //                         CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                //                 end;
                //             end;
                //         end;
                //     }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                // trigger OnAction()
                // begin
                //     SETRANGE("No.", "No.");
                //     REPORT.RUN(REPORT::Report14005140, true, true, Rec);
                //     SETRANGE("No.");
                // end;//B2BUPG
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        end;

        //DS5
        Rec.SETRANGE(Status, Rec.Status::Released);
        //DS
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2. Do you wish to continue?';
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;
}

