report 51007 "Picking List_UPG"  //5752 id changed to 51007
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PickingList.rdl';
    Caption = 'Picking List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.")
                                WHERE(Type = FILTER(Pick | "Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed";
            column(No_WhseActivHeader; "No.")
            {
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(Time; TIME)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION + ': ' + PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines AND
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        THEN BEGIN
                            IF TmpWhseActLine."No." = '' THEN BEGIN
                                TmpWhseActLine := "Warehouse Activity Line";
                                TmpWhseActLine.INSERT;
                                MARK(TRUE);
                            END ELSE BEGIN
                                TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                IF "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                THEN BEGIN
                                    TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                END;
                                IF TmpWhseActLine.FINDFIRST THEN BEGIN
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    IF "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    THEN BEGIN
                                        TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                        TmpWhseActLine."Destination No." := '';
                                    END;
                                    TmpWhseActLine.MODIFY;
                                END ELSE BEGIN
                                    TmpWhseActLine := "Warehouse Activity Line";
                                    TmpWhseActLine.INSERT;
                                    MARK(TRUE);
                                END;
                            END;
                        END ELSE
                            MARK(TRUE);
                    end;

                    trigger OnPostDataItem()
                    begin
                        MARKEDONLY(TRUE);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TmpWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        IF BreakbulkFilter THEN
                            TmpWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TmpWhseActLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.");
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; FORMAT("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; FORMAT("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FIELDCAPTION("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FIELDCAPTION("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    dataitem(WhseActLine2; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type" = FIELD("Activity Type"),
                                       "No." = FIELD("No."),
                                       "Bin Code" = FIELD("Bin Code"),
                                       "Item No." = FIELD("Item No."),
                                       "Action Type" = FIELD("Action Type"),
                                       "Variant Code" = FIELD("Variant Code"),
                                       "Unit of Measure Code" = FIELD("Unit of Measure Code"),
                                       "Due Date" = FIELD("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = SORTING("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                        column(LotNo_WhseActLine2; "Lot No.")
                        {
                        }
                        column(SerialNo_WhseActLine2; "Serial No.")
                        {
                        }
                        column(QtyBase_WhseActLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandle_WhseActLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF SumUpLines THEN BEGIN
                            TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        COPY("Warehouse Activity Line");
                        Counter := COUNT;
                        IF Counter = 0 THEN
                            CurrReport.BREAK;

                        IF BreakbulkFilter THEN
                            SETRANGE("Original Breakbulk", FALSE);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";

                IF NOT CurrReport.PREVIEW THEN
                    WhseCountPrinted.RUN("Warehouse Activity Header");
            end;
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
                    field(Breakbulk; BreakbulkFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Set Breakbulk Filter';
                        Editable = BreakbulkEditable;
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Sum up Lines';
                        Editable = SumUpLinesEditable;
                    }
                    field(LotSerialNo; ShowLotSN)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Serial/Lot Number';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SumUpLinesEditable := TRUE;
            BreakbulkEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF HideOptions THEN BEGIN
                BreakbulkEditable := FALSE;
                SumUpLinesEditable := FALSE;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PickFilter := "Warehouse Activity Header".GETFILTERS;
    end;

    var
        Location: Record "Location";
        TmpWhseActLine: Record "Warehouse Activity Line" temporary;
        WhseCountPrinted: Codeunit "Whse.-Printed";
        PickFilter: Text[250];
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        ShowLotSN: Boolean;
        Counter: Integer;

        BreakbulkEditable: Boolean;

        SumUpLinesEditable: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        PickingListCaptionLbl: Label 'Picking List';
        WhseActLineDueDateCaptionLbl: Label 'Due Date';
        QtyHandledCaptionLbl: Label 'Qty. Handled';
        EmptyStringCaptionLbl: Label '____________';

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;


    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;


    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;
}

