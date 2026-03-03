page 50004 "Inventory Pick v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P7377.
    // NUB1.02,10/22/18,SK: Addd new field as "Requested Delivery Date" & "Shipping Agent Code".

    Caption = 'Inventory Pick';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = WHERE(Type = CONST("Invt. Pick"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Document"; Rec."Source Document")
                {
                    DrillDown = false;
                    Lookup = false;
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CreateInvtPick: Codeunit "Create Inventory Pick/Movement";
                    begin
                        CreateInvtPick.RUN(Rec);
                        CurrPage.UPDATE;
                        CurrPage.WhseActivityLines.PAGE.UpdateForm;
                    end;

                    trigger OnValidate()
                    begin
                        SourceNoOnAfterValidate;
                    end;
                }
                field("Destination No."; rec."Destination No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(rec."Destination Type".AsInteger(), rec."Source Document".AsInteger(), 0));
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type".AsInteger(), Rec."Source Document".AsInteger(), 1));
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(rec."Destination Type".AsInteger(), rec."Source Document".AsInteger(), 2));
                    ApplicationArea = all;
                }
                field("External Document No.2"; rec."External Document No.2")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(rec."Destination Type".AsInteger(), rec."Source Document".AsInteger(), 3));
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Allow Backorder"; rec."Allow Backorder")
                {
                    ApplicationArea = all;
                }
            }
            part(WhseActivityLines; "Invt. Pick Subform v1")
            {
                ApplicationArea = all;
                SubPageLink = "Activity Type" = FIELD(Type),
                              "No." = FIELD("No.");
                SubPageView = SORTING("Activity Type", "No.", "Sorting Sequence No.")
                              WHERE(Breakbulk = CONST(false));
            }
        }
        area(factboxes)
        {
            part(Control4; "Lot Numbers by Bin FactBox")
            {
                ApplicationArea = all;
                Provider = WhseActivityLines;
                SubPageLink = "Item No." = FIELD("Item No."),
                              "Variant Code" = FIELD("Variant Code"),
                              "Location Code" = FIELD("Location Code");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ick")
            {
                Caption = 'P&ick';
                Image = CreateInventoryPickup;
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.LookupActivityHeader(rec."Location Code", Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = all;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type),
                                  "No." = FIELD("No.");
                }
                action("Posted Picks")
                {
                    Caption = 'Posted Picks';
                    Image = PostedInventoryPick;
                    ApplicationArea = all;
                    RunObject = Page "Posted Invt. Pick List v1";
                    RunPageLink = "Invt Pick No." = FIELD("No.");
                    RunPageView = SORTING("Invt Pick No.");
                }
                action("Source Document1")
                {
                    Caption = 'Source Document';
                    Image = "Order";
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WMSMgt: Codeunit "WMS Management";
                    begin
                        WMSMgt.ShowSourceDocCard(rec."Source Type", rec."Source Subtype", rec."Source No.");
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("&Get Source Document")
                {
                    Caption = '&Get Source Document';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        CreateInvtPick: Codeunit "Create Inventory Pick/Movement";
                    begin
                        CreateInvtPick.RUN(Rec);
                    end;
                }
                action(AutofillQtyToHandle1)
                {
                    Caption = 'Autofill Qty. to Handle';
                    Image = AutofillQtyToHandle;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        AutofillQtyToHandle;
                    end;
                }
                action("Delete Qty. to Handle")
                {
                    Caption = 'Delete Qty. to Handle';
                    Image = DeleteQtyToHandle;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        DeleteQtyToHandle;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PostPickYesNo;
                    end;
                }
                action(PostAndPrint1)
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        PostAndPrint;
                    end;
                }
                action(PostInvtPickManuallly)
                {
                    Caption = 'Post Only Inventory Pick';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ManPostInvtPickRepVarLcl: Report "Manual Post Invt. Pick";
                    begin
                        //NUB1.02 Start
                        rec.TESTFIELD("Source Document", rec."Source Document"::"Sales Order");
                        rec.TESTFIELD("Source No.");
                        MESSAGE('This will post only inventory pick without posting shipment.');
                        WhseActHeadRecGbl.RESET;
                        WhseActHeadRecGbl.SETRANGE(Type, rec.Type);
                        WhseActHeadRecGbl.SETRANGE("No.", rec."No.");
                        WhseActHeadRecGbl.FINDFIRST;

                        CLEAR(ManPostInvtPickRepVarLcl);
                        ManPostInvtPickRepVarLcl.RunFromPage();
                        ManPostInvtPickRepVarLcl.SETTABLEVIEW(WhseActHeadRecGbl);
                        ManPostInvtPickRepVarLcl.RUNMODAL();
                        CurrPage.UPDATE(false);
                        //NUB1.02 End
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    WhseActPrint.PrintInvtPickHeader(Rec, false);
                end;
            }
        }
        area(reporting)
        {
            action("Picking List")
            {
                Caption = 'Picking List';
                Image = Report;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Picking List";
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Location Code" := rec.GetUserLocation;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        rec.ErrorIfUserIsNotWhseEmployee;
    end;

    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
        WMSMgt: Codeunit "WMS Management";
        "-NUB1.02-": Integer;
        WhseActHeadRecGbl: Record "Warehouse Activity Header";

    local procedure AutofillQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle;
    end;

    local procedure DeleteQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle;
    end;

    local procedure PostPickYesNo()
    begin
        CurrPage.WhseActivityLines.PAGE.PostPickYesNo;
    end;

    local procedure PostAndPrint()
    begin
        CurrPage.WhseActivityLines.PAGE.PostAndPrint;
    end;

    local procedure SourceNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
        CurrPage.WhseActivityLines.PAGE.UpdateForm;
    end;
}

