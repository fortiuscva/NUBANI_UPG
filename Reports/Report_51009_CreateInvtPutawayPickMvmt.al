report 51009 "CreateInvtPut-away/Pick/Mvmt_U" ///7323 id changed to 51009
{
    Caption = 'Create Invt. Put-away/Pick/Movement';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Request"; "Warehouse Request")
        {
            DataItemTableView = SORTING("Source Document", "Source No.");
            RequestFilterFields = "Source Document", "Source No.";

            trigger OnAfterGetRecord()
            var
                ATOMvmntCreated: Integer;
                TotalATOMvmtToBeCreated: Integer;
            begin
                Window.UPDATE(1, "Source Document");
                Window.UPDATE(2, "Source No.");

                CASE Type OF
                    Type::Inbound:
                        TotalPutAwayCounter += 1;
                    Type::Outbound:
                        IF CreatePick THEN
                            TotalPickCounter += 1
                        ELSE
                            TotalMovementCounter += 1;
                END;

                IF CheckWhseRequest("Warehouse Request") THEN
                    CurrReport.SKIP;

                IF ((Type = Type::Inbound) AND (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Put-away")) OR
                   ((Type = Type::Outbound) AND ((WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Pick") AND
                                                 (WhseActivHeader.Type <> WhseActivHeader.Type::"Invt. Movement"))) OR
                   ("Source Type" <> WhseActivHeader."Source Type") OR
                   ("Source Subtype" <> WhseActivHeader."Source Subtype") OR
                   ("Source No." <> WhseActivHeader."Source No.") OR
                   ("Location Code" <> WhseActivHeader."Location Code")
                THEN BEGIN
                    CASE Type OF
                        Type::Inbound:
                            IF NOT CreateInvtPutAway.CheckSourceDoc("Warehouse Request") THEN
                                CurrReport.SKIP;
                        Type::Outbound:
                            IF NOT CreateInvtPickMovement.CheckSourceDoc("Warehouse Request") THEN
                                CurrReport.SKIP;
                    END;
                    InitWhseActivHeader;
                END;

                CASE Type OF
                    Type::Inbound:
                        BEGIN
                            CreateInvtPutAway.SetWhseRequest("Warehouse Request", TRUE);
                            CreateInvtPutAway.AutoCreatePutAway(WhseActivHeader);
                        END;
                    Type::Outbound:
                        BEGIN
                            CreateInvtPickMovement.SetWhseRequest("Warehouse Request", TRUE);
                            CreateInvtPickMovement.AutoCreatePickOrMove(WhseActivHeader);
                        END;
                END;

                IF WhseActivHeader."No." <> '' THEN BEGIN
                    DocumentCreated := TRUE;
                    CASE Type OF
                        Type::Inbound:
                            PutAwayCounter := PutAwayCounter + 1;
                        Type::Outbound:
                            IF CreatePick THEN BEGIN
                                PickCounter := PickCounter + 1;

                                CreateInvtPickMovement.GetATOMovementsCounters(ATOMvmntCreated, TotalATOMvmtToBeCreated);
                                MovementCounter += ATOMvmntCreated;
                                TotalMovementCounter += TotalATOMvmtToBeCreated;
                            END ELSE
                                MovementCounter += 1;
                    END;
                    IF PrintDocument THEN
                        InsertTempWhseActivHdr;
                    COMMIT;
                END;
            end;

            trigger OnPostDataItem()
            var
                ExpiredItemMessageText: Text[100];
                Msg: Text;
            begin
                ExpiredItemMessageText := CreateInvtPickMovement.GetExpiredItemMessage;
                IF TempWhseActivHdr.FIND('-') THEN
                    PrintNewDocuments;

                Window.CLOSE;
                IF NOT SuppressMessagesState THEN
                    IF DocumentCreated THEN BEGIN
                        IF PutAwayCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Put-away", PutAwayCounter, TotalPutAwayCounter));
                        IF PickCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Pick", PickCounter, TotalPickCounter));
                        IF MovementCounter > 0 THEN
                            AddToText(Msg, STRSUBSTNO(Text005, WhseActivHeader.Type::"Invt. Movement", MovementCounter, TotalMovementCounter));

                        IF CreatePutAway OR CreatePick THEN
                            Msg += ExpiredItemMessageText;

                        MESSAGE(Msg);
                    END ELSE BEGIN
                        Msg := Text004 + ' ' + ExpiredItemMessageText;
                        MESSAGE(Msg);
                    END;
            end;

            trigger OnPreDataItem()
            begin
                IF CreatePutAway AND NOT (CreatePick OR CreateMovement) THEN
                    SETRANGE(Type, Type::Inbound);
                IF NOT CreatePutAway AND (CreatePick OR CreateMovement) THEN
                    SETRANGE(Type, Type::Outbound);

                Window.OPEN(
                  Text001 +
                  Text002 +
                  Text003);

                DocumentCreated := FALSE;

                IF CreatePick OR CreateMovement THEN
                    CreateInvtPickMovement.SetReportGlobals(PrintDocument, ShowError);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CreateInventorytPutAway; CreatePutAway)
                    {
                        ApplicationArea = All;
                        Caption = 'Create Invt. Put-Away';
                    }
                    field(CInvtPick; CreatePick)
                    {
                        ApplicationArea = All;
                        Caption = 'Create Invt. Pick';
                        Editable = CreatePickEditable;
                        Enabled = CreatePickEditable;

                        trigger OnValidate()
                        begin
                            IF CreatePick AND CreateMovement THEN
                                ERROR(Text009);
                            EnableFieldsInPage;
                        end;
                    }
                    field(CInvtMvmt; CreateMovement)
                    {
                        ApplicationArea = All;
                        Caption = 'Create Invt. Movement';
                        Editable = CreateMovementEditable;
                        Enabled = CreateMovementEditable;

                        trigger OnValidate()
                        begin
                            IF CreatePick AND CreateMovement THEN
                                ERROR(Text009);
                            EnableFieldsInPage;
                        end;
                    }
                    field(PrintDocument; PrintDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Document';
                    }
                    field(ShowError; ShowError)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Error';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CreatePickEditable := TRUE;
            CreateMovementEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            EnableFieldsInPage;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        TempWhseActivHdr.DELETEALL;
    end;

    trigger OnPreReport()
    begin
        IF NOT CreatePutAway AND NOT (CreatePick OR CreateMovement) THEN
            ERROR(Text008);

        CreateInvtPickMovement.SetInvtMovement(CreateMovement);
    end;

    var
        WhseActivHeader: Record "Warehouse Activity Header";
        TempWhseActivHdr: Record "Warehouse Activity Header" temporary;
        CreateInvtPutAway: Codeunit "Create Inventory Put-away";
        CreateInvtPickMovement: Codeunit "Create Inventory Pick/Movement";
        WhseDocPrint: Codeunit "Warehouse Document-Print";
        Window: Dialog;
        CreatePutAway: Boolean;
        CreatePick: Boolean;
        Text001: Label 'Creating Inventory Activities...\\';
        Text002: Label 'Source Type     #1##########\';
        Text003: Label 'Source No.      #2##########';
        CreateMovement: Boolean;
        DocumentCreated: Boolean;
        PrintDocument: Boolean;
        PutAwayCounter: Integer;
        PickCounter: Integer;
        MovementCounter: Integer;
        Text004: Label 'There is nothing to create.';
        Text005: Label 'Number of %1 activities created: %2 out of a total of %3.';
        Text006: Label '%1\\%2', Comment = 'No translation needed. Only a new line separator.';
        Text008: Label 'You must select Create Invt. Put-away, Create Invt. Pick, or Create Invt. Movement.';
        TotalPutAwayCounter: Integer;
        TotalPickCounter: Integer;
        TotalMovementCounter: Integer;
        ShowError: Boolean;
        Text009: Label 'You can select either Create Invt. Pick or Create Invt. Movement.';

        CreatePickEditable: Boolean;

        CreateMovementEditable: Boolean;
        SuppressMessagesState: Boolean;

    local procedure InitWhseActivHeader()
    begin
        WhseActivHeader.INIT;
        CASE "Warehouse Request".Type OF
            "Warehouse Request".Type::Inbound:
                WhseActivHeader.Type := WhseActivHeader.Type::"Invt. Put-away";
            "Warehouse Request".Type::Outbound:
                IF CreatePick THEN
                    WhseActivHeader.Type := WhseActivHeader.Type::"Invt. Pick"
                ELSE
                    WhseActivHeader.Type := WhseActivHeader.Type::"Invt. Movement";
        END;
        WhseActivHeader."No." := '';
        WhseActivHeader."Location Code" := "Warehouse Request"."Location Code";
    end;

    local procedure InsertTempWhseActivHdr()
    begin
        TempWhseActivHdr.INIT;
        TempWhseActivHdr := WhseActivHeader;
        TempWhseActivHdr.INSERT;
    end;

    local procedure PrintNewDocuments()
    begin
        REPEAT
            CASE TempWhseActivHdr.Type OF
                TempWhseActivHdr.Type::"Invt. Put-away":
                    WhseDocPrint.PrintInvtPutAwayHeader(TempWhseActivHdr, TRUE);
                TempWhseActivHdr.Type::"Invt. Pick":
                    IF CreatePick THEN
                        WhseDocPrint.PrintInvtPickHeader(TempWhseActivHdr, TRUE)
                    ELSE
                        WhseDocPrint.PrintInvtMovementHeader(TempWhseActivHdr, TRUE);
            END;
        UNTIL TempWhseActivHdr.NEXT = 0;
    end;

    local procedure CheckWhseRequest(WhseRequest: Record "Warehouse Request"): Boolean
    var
        SalesHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        GetSrcDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        IF WhseRequest."Document Status" <> WhseRequest."Document Status"::Released THEN
            EXIT(TRUE);
        IF (WhseRequest.Type = WhseRequest.Type::Outbound) AND
           (WhseRequest."Shipping Advice" = WhseRequest."Shipping Advice"::Complete)
        THEN
            CASE WhseRequest."Source Type" OF
                DATABASE::"Sales Line":
                    IF WhseRequest."Source Subtype" = WhseRequest."Source Subtype"::"1" THEN BEGIN
                        SalesHeader.GET(SalesHeader."Document Type"::Order, WhseRequest."Source No.");
                        EXIT(GetSrcDocOutbound.CheckSalesHeader(SalesHeader, ShowError));
                    END;
                DATABASE::"Transfer Line":
                    BEGIN
                        TransferHeader.GET(WhseRequest."Source No.");
                        EXIT(GetSrcDocOutbound.CheckTransferHeader(TransferHeader, ShowError));
                    END;
            END;
    end;


    procedure InitializeRequest(NewCreateInvtPutAway: Boolean; NewCreateInvtPick: Boolean; NewCreateInvtMovement: Boolean; NewPrintDocument: Boolean; NewShowError: Boolean)
    begin
        CreatePutAway := NewCreateInvtPutAway;
        CreatePick := NewCreateInvtPick;
        CreateMovement := NewCreateInvtMovement;
        PrintDocument := NewPrintDocument;
        ShowError := NewShowError;
    end;


    procedure EnableFieldsInPage()
    begin
        CreatePickEditable := NOT CreateMovement;
        CreateMovementEditable := NOT CreatePick;
    end;


    procedure SuppressMessages(NewState: Boolean)
    begin
        SuppressMessagesState := NewState;
    end;

    local procedure AddToText(var OrigText: Text; Addendum: Text)
    begin
        IF OrigText = '' THEN
            OrigText := Addendum
        ELSE
            OrigText := STRSUBSTNO(Text006, OrigText, Addendum);
    end;


    procedure GetMovementCounters(var MovementsCreated: Integer; var TotalMovementsToBeCreated: Integer)
    begin
        MovementsCreated := MovementCounter;
        TotalMovementsToBeCreated := TotalMovementCounter;
    end;
}

