page 50037 "Customer Ledger Entries - 2022"
{
    // //FP  Added the Show Documents button for faster viewing of documents.
    //       Added your reference field to form

    Caption = 'Customer Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Your Reference"; rec."Your Reference")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Original Amount"; rec."Original Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Original Amt. (LCY)"; rec."Original Amt. (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remaining Amt. (LCY)"; rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Pmt. Discount Date"; rec."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Disc. Tolerance Date"; rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = all;
                }
                field("Original Pmt. Disc. Possible"; rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = all;
                }
                field("Remaining Pmt. Disc. Possible"; rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = all;
                }
                field("Max. Payment Tolerance"; rec."Max. Payment Tolerance")
                {
                    ApplicationArea = all;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1903096107; "Customer Ledger Entry FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "Entry No." = FIELD("Entry No.");
                Visible = true;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Reminder/Fin. Charge Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Reminder/Fin. Charge Entries';
                    Image = Reminder;
                    RunObject = Page "Reminder/Fin. Charge Entries";
                    RunPageLink = "Customer Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Customer Entry No.");
                }
                action("Applied E&ntries")
                {
                    ApplicationArea = all;
                    Caption = 'Applied E&ntries';
                    Image = Approve;
                    RunObject = Page "Applied Customer Entries";
                    RunPageOnRec = true;
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    RunObject = Page "Detailed Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = FIELD("Entry No."),
                                  "Customer No." = FIELD("Customer No.");
                    RunPageView = SORTING("Cust. Ledger Entry No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            action("&Show Doc.")
            {
                ApplicationArea = All;
                Caption = '&Show Doc.';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IssuedFinChrgMemoHdr: Record "Issued Fin. Charge Memo Header";
                    IssuedReminderHdr: Record "Issued Reminder Header";
                    SalesCMHeader: Record "Sales Cr.Memo Header";
                    SalesInvHeader: Record "Sales Invoice Header";
                    IssuedFCM: Page "Issued Finance Charge Memo";
                    IssuedReminder: Page "Issued Reminder";
                    PostSalesCM: Page "Posted Sales Credit Memo";
                    PostSalesInv: Page "Posted Sales Invoice";
                    SDText000: Label 'No document was Found.';
                begin
                    //FP
                    case rec."Document Type" of

                        rec."Document Type"::Invoice:
                            begin
                                SalesInvHeader.RESET;
                                SalesInvHeader.SETRANGE("No.", rec."Document No.");
                                SalesInvHeader.SETRANGE("Posting Date", rec."Posting Date");
                                if SalesInvHeader.FIND('-') then begin
                                    CLEAR(PostSalesInv);
                                    PostSalesInv.SETTABLEVIEW(SalesInvHeader);
                                    PostSalesInv.RUNMODAL;
                                end else
                                    ERROR(STRSUBSTNO(SDText000));
                            end;

                        rec."Document Type"::Payment:
                            begin
                                SalesInvHeader.RESET;
                                SalesInvHeader.SETRANGE("No.", rec."Document No.");
                                SalesInvHeader.SETRANGE("Posting Date", rec."Posting Date");
                                if SalesInvHeader.FIND('-') then begin
                                    CLEAR(PostSalesInv);
                                    PostSalesInv.SETTABLEVIEW(SalesInvHeader);
                                    PostSalesInv.RUNMODAL;
                                end else
                                    ERROR(STRSUBSTNO(SDText000));
                            end;

                        rec."Document Type"::"Credit Memo":
                            begin
                                SalesCMHeader.RESET;
                                SalesCMHeader.SETRANGE("No.", rec."Document No.");
                                SalesCMHeader.SETRANGE("Posting Date", rec."Posting Date");
                                if SalesCMHeader.FIND('-') then begin
                                    CLEAR(PostSalesCM);
                                    PostSalesCM.SETTABLEVIEW(SalesCMHeader);
                                    PostSalesCM.RUNMODAL;
                                end else
                                    ERROR(STRSUBSTNO(SDText000));
                            end;

                        rec."Document Type"::"Finance Charge Memo":
                            begin
                                IssuedFinChrgMemoHdr.RESET;
                                IssuedFinChrgMemoHdr.SETRANGE("No.", rec."Document No.");
                                IssuedFinChrgMemoHdr.SETRANGE("Posting Date", rec."Posting Date");
                                if IssuedFinChrgMemoHdr.FIND('-') then begin
                                    CLEAR(IssuedFCM);
                                    IssuedFCM.SETTABLEVIEW(IssuedFinChrgMemoHdr);
                                    IssuedFCM.RUNMODAL;
                                end else
                                    ERROR(STRSUBSTNO(SDText000));
                            end;

                        rec."Document Type"::Reminder:
                            begin
                                IssuedReminderHdr.RESET;
                                IssuedReminderHdr.SETRANGE("No.", rec."Document No.");
                                IssuedReminderHdr.SETRANGE("Posting Date", rec."Posting Date");
                                if IssuedReminderHdr.FIND('-') then begin
                                    CLEAR(IssuedReminder);
                                    IssuedReminder.SETTABLEVIEW(IssuedReminderHdr);
                                    IssuedReminder.RUNMODAL;
                                end else
                                    ERROR(STRSUBSTNO(SDText000));
                            end;

                        else
                            ERROR(STRSUBSTNO(SDText000));
                    end;
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    var
                        CustEntryApplyPostEntries: Codeunit "CustEntry-Apply Posted Entries";
                    begin
                        CustEntryApplyPostEntries.ApplyCustEntryformEntry(Rec);
                    end;
                }
                separator(Separator63)
                {
                }
                action(UnapplyEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Unapply Entries';
                    Ellipsis = true;
                    Image = UnApply;

                    trigger OnAction()
                    var
                        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
                    begin
                        CustEntryApplyPostedEntries.UnApplyCustLedgEntry(rec."Entry No.");
                    end;
                }
                separator(Separator65)
                {
                }
                action("Reverse Transaction")
                {
                    ApplicationArea = All;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        CLEAR(ReversalEntry);
                        if rec.Reversed then
                            ReversalEntry.AlreadyReversedEntry(rec.TABLECAPTION, rec."Entry No.");
                        if rec."Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError;
                        rec.TESTFIELD("Transaction No.");
                        ReversalEntry.ReverseTransaction(Rec."Transaction No.");
                    end;
                }
            }
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Navigate.SetDoc(rec."Posting Date", rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := rec.SetStyle;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    trigger OnOpenPage()
    begin
        rec.SETFILTER("Posting Date", '%1..%2', 20220101D, 20221231D);
    end;

    var
        Navigate: Page Navigate;
        StyleTxt: Text;
}

