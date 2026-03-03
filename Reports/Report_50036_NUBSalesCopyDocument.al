report 50036 "NUB Sales Copy Document"
{
    Caption = 'NUB Sales Copy Document';
    ProcessingOnly = true;

    dataset
    {

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
                    field(DocumentType; FromDocType)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Document Type';
                        ToolTip = 'Specifies the type of document that is processed by the report or batch job.';

                        trigger OnValidate()
                        begin
                            FromDocNo := '';
                            ValidateDocNo();
                        end;
                    }
                    field(DocumentNo; FromDocNo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Document No.';
                        ShowMandatory = true;
                        ToolTip = 'Specifies the number of the document that is processed by the report or batch job.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo();
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo();
                        end;
                    }
                    field(FromDocNoOccurrence; FromDocNoOccurrence)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        Caption = 'Doc. No. Occurrence';
                        Editable = false;
                        ToolTip = 'Specifies the number of times the No. value has been used in the number series.';
                    }
                    field(FromDocVersionNo; FromDocVersionNo)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        Caption = 'Version No.';
                        Editable = false;
                        ToolTip = 'Specifies the version of the document to be copied.';
                    }

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
        trigger OnOpenPage()
        begin
            if FromDocNo <> '' then begin
                case FromDocType of
                    FromDocType::Quote:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Quote, FromDocNo) then
                            ;
                    FromDocType::"Blanket Order":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Blanket Order", FromDocNo) then
                            ;
                    FromDocType::Order:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Order, FromDocNo) then
                            ;
                    FromDocType::Invoice:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Invoice, FromDocNo) then
                            ;
                    FromDocType::"Return Order":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Return Order", FromDocNo) then
                            ;
                    FromDocType::"Credit Memo":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Credit Memo", FromDocNo) then
                            ;
                    FromDocType::"Posted Shipment":
                        if FromSalesShptHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesShptHeader);
                    FromDocType::"Posted Invoice":
                        if FromSalesInvHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                    FromDocType::"Posted Return Receipt":
                        if FromReturnRcptHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromReturnRcptHeader);
                    FromDocType::"Posted Credit Memo":
                        if FromSalesCrMemoHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                    FromDocType::"Arch. Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Order, FromDocNo, FromDocNoOccurrence, FromDocVersionNo) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Quote":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Quote, FromDocNo, FromDocNoOccurrence, FromDocVersionNo) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Blanket Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Blanket Order", FromDocNo, FromDocNoOccurrence, FromDocVersionNo) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Return Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Return Order", FromDocNo, FromDocNoOccurrence, FromDocVersionNo) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                end;
                if FromSalesHeader."No." = '' then
                    FromDocNo := '';
            end;
            ValidateDocNo();
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::OK then
                if FromDocNo = '' then
                    Error(DocNoNotSerErr)
        end;
    }
    trigger OnPreReport()
    var
        ExactCostReversingMandatory: Boolean;
    begin
        SalesSetup.Get();
        ExactCostReversingMandatory := SalesSetup."Exact Cost Reversing Mandatory";
        TransferSalesLines(FromDocType, FromDocNo, SalesHeader, FromDocNoOccurrence, FromDocVersionNo);
    end;

    procedure TransferSalesLines(FromDocType: Enum "Sales Document Type From"; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header"; FromDocNoOccurrencePar: Integer; FromDocVersionNoPar: Integer)
    var
        FromSalesHeaderLcl: Record "Sales Header";
        FromSalesShipmentHeader: Record "Sales Shipment Header";
        FromSalesInvoiceHeader: Record "Sales Invoice Header";
        FromReturnReceiptHeader: Record "Return Receipt Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FromSalesHeaderArchive: Record "Sales Header Archive";
        ToSalesLine, FromSalesLine : Record "Sales Line";
        FromSalesShptLine: Record "Sales Shipment Line";
        FromSalesInvLine: Record "Sales Invoice Line";
        FromSalesCrMemoLine: Record "Sales Cr.Memo Line";
        FromReturnRcptLine: Record "Return Receipt Line";
        FromSalesLineArchive: Record "Sales Line Archive";
    begin
        ToSalesHeader.TestField(Status, ToSalesHeader.Status::Open);
        if FromDocNo = '' then
            Error(Text000);
        ToSalesHeader.Find();
        ToSalesHeader.TestField("Sell-to Customer No.");

        ToSalesLine.Reset();
        ToSalesLine.SetRange("Document Type", ToSalesHeader."Document Type");
        ToSalesLine.SetRange("Document No.", ToSalesHeader."No.");
        if not ToSalesLine.IsEmpty() then
            ToSalesLine.DeleteAll(true);

        case FromDocType of
            "Sales Document Type From"::Quote,
            "Sales Document Type From"::"Blanket Order",
            "Sales Document Type From"::Order,
            "Sales Document Type From"::Invoice,
            "Sales Document Type From"::"Return Order",
            "Sales Document Type From"::"Credit Memo":
                begin
                    FromSalesHeaderLcl.Get(CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo);

                    FromSalesLine.Reset();
                    FromSalesLine.SetRange("Document Type", FromSalesHeaderLcl."Document Type");
                    FromSalesLine.SetRange("Document No.", FromSalesHeaderLcl."No.");
                    if FromSalesLine.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromSalesLine);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Validate("Sell-to Customer No.", ToSalesHeader."Sell-to Customer No.");
                            ToSalesLine.Validate(Quantity, FromSalesLine.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromSalesLine.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromSalesLine."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromSalesLine."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromSalesLine."Unit Cost");
                            ToSalesLine.Validate("Qty. to Ship", 0);
                            ToSalesLine.Validate("Qty. to Invoice", 0);
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine.Insert(true);
                        until FromSalesLine.Next() = 0;
                    end;

                end;
            "Sales Document Type From"::"Posted Shipment":
                begin
                    FromSalesShipmentHeader.Get(FromDocNo);

                    FromSalesShptLine.Reset();
                    FromSalesShptLine.SetRange("Document No.", FromSalesShptHeader."No.");
                    if FromSalesShptLine.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromSalesShptLine);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Insert(true);
                            ToSalesLine.Validate("Sell-to Customer No.", ToSalesHeader."Sell-to Customer No.");
                            ToSalesLine.Validate(Quantity, FromSalesShptLine.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromSalesShptLine.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromSalesShptLine."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromSalesShptLine."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromSalesShptLine."Unit Cost");
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine."Qty. Shipped (Base)" := 0;
                            ToSalesLine."Qty. Invoiced (Base)" := 0;
                            ToSalesLine."Qty. Shipped Not Invoiced" := 0;
                            ToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                            ToSalesLine.Modify(true);
                        until FromSalesShptLine.Next() = 0;
                    end;
                end;
            "Sales Document Type From"::"Posted Invoice":
                begin
                    FromSalesInvoiceHeader.Get(FromDocNo);

                    FromSalesInvLine.Reset();
                    FromSalesInvLine.SetRange("Document No.", FromSalesInvoiceHeader."No.");
                    if FromSalesInvLine.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromSalesInvLine);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Validate(Quantity, FromSalesInvLine.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromSalesInvLine.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromSalesInvLine."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromSalesInvLine."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromSalesInvLine."Unit Cost");
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine."Qty. Shipped (Base)" := 0;
                            ToSalesLine."Qty. Invoiced (Base)" := 0;
                            ToSalesLine."Qty. Shipped Not Invoiced" := 0;
                            ToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                            ToSalesLine.Insert(true);
                        until FromSalesInvLine.Next() = 0;
                    end;
                end;
            "Sales Document Type From"::"Posted Return Receipt":
                begin
                    FromReturnReceiptHeader.Get(FromDocNo);

                    FromReturnRcptLine.Reset();
                    FromReturnRcptLine.SetRange("Document No.", FromReturnReceiptHeader."No.");
                    if FromReturnRcptLine.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromReturnRcptLine);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Validate("Sell-to Customer No.", ToSalesHeader."Sell-to Customer No.");
                            ToSalesLine.Validate(Quantity, FromReturnRcptLine.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromReturnRcptLine.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromReturnRcptLine."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromReturnRcptLine."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromReturnRcptLine."Unit Cost");
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine."Qty. Shipped (Base)" := 0;
                            ToSalesLine."Qty. Invoiced (Base)" := 0;
                            ToSalesLine."Qty. Shipped Not Invoiced" := 0;
                            ToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                            ToSalesLine.Insert(true);
                        until FromReturnRcptLine.Next() = 0;
                    end;
                end;
            "Sales Document Type From"::"Posted Credit Memo":
                begin
                    FromSalesCrMemoHeader.Get(FromDocNo);

                    FromSalesCrMemoLine.Reset();
                    FromSalesCrMemoLine.SetRange("Document No.", FromSalesCrMemoHeader."No.");
                    if FromSalesCrMemoLine.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromSalesCrMemoLine);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Validate("Sell-to Customer No.", ToSalesHeader."Sell-to Customer No.");
                            ToSalesLine.Validate(Quantity, FromSalesCrMemoLine.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromSalesCrMemoLine.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromSalesCrMemoLine."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromSalesCrMemoLine."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromSalesCrMemoLine."Unit Cost");
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine."Qty. Shipped (Base)" := 0;
                            ToSalesLine."Qty. Invoiced (Base)" := 0;
                            ToSalesLine."Qty. Shipped Not Invoiced" := 0;
                            ToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                            ToSalesLine.Insert(true);
                        until FromSalesCrMemoLine.Next() = 0;
                    end;
                end;
            "Sales Document Type From"::"Arch. Quote",
            "Sales Document Type From"::"Arch. Order",
            "Sales Document Type From"::"Arch. Blanket Order",
            "Sales Document Type From"::"Arch. Return Order":
                begin
                    FromSalesHeaderArchive.Get(CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo, FromDocNoOccurrencePar, FromDocVersionNoPar);

                    FromSalesLineArchive.Reset();
                    FromSalesLineArchive.SetRange("Document No.", FromSalesHeaderArchive."No.");
                    FromSalesLineArchive.SetRange("Document Type", FromSalesHeaderArchive."Document Type");
                    FromSalesLineArchive.SetRange("Doc. No. Occurrence", FromSalesHeaderArchive."Doc. No. Occurrence");
                    FromSalesLineArchive.SetRange("Version No.", FromSalesHeaderArchive."Version No.");
                    if FromSalesLineArchive.FindSet() then begin
                        repeat
                            ToSalesLine.Init();
                            ToSalesLine.TransferFields(FromSalesLineArchive);
                            ToSalesLine."Document Type" := ToSalesHeader."Document Type";
                            ToSalesLine."Document No." := ToSalesHeader."No.";
                            ToSalesLine.Validate("Sell-to Customer No.", ToSalesHeader."Sell-to Customer No.");
                            ToSalesLine.Validate(Quantity, FromSalesLineArchive.Quantity);
                            ToSalesLine.Validate("Outstanding Quantity", FromSalesLineArchive.Quantity);
                            ToSalesLine.Validate("Outstanding Qty. (Base)", FromSalesLineArchive."Quantity (Base)");
                            ToSalesLine.Validate("Unit Price", FromSalesLineArchive."Unit Price");
                            ToSalesLine.Validate("Unit Cost", FromSalesLineArchive."Unit Cost");
                            ToSalesLine."Quantity Shipped" := 0;
                            ToSalesLine."Quantity Invoiced" := 0;
                            ToSalesLine."Qty. Shipped (Base)" := 0;
                            ToSalesLine."Qty. Invoiced (Base)" := 0;
                            ToSalesLine."Qty. Shipped Not Invoiced" := 0;
                            ToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                            ToSalesLine.Insert(true);
                        until FromSalesLineArchive.Next() = 0;
                    end;
                end;
        end;
    end;

    local procedure ValidateDocNo()
    var
        FromDocType2:
            Enum "Sales Document Type From";
    begin
        if FromDocNo = '' then begin
            FromSalesHeader.Init();
            FromDocNoOccurrence := 0;
            FromDocVersionNo := 0;
        end else
            if FromSalesHeader."No." = '' then begin
                FromSalesHeader.Init();
                case FromDocType of
                    FromDocType::Quote,
                    FromDocType::Order,
                    FromDocType::Invoice,
                    FromDocType::"Credit Memo",
                    FromDocType::"Blanket Order",
                    FromDocType::"Return Order":
                        FromSalesHeader.Get(CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo);
                    FromDocType::"Posted Shipment":
                        begin
                            FromSalesShptHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesShptHeader);
                            if SalesHeader."Document Type" in
                               [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]
                            then begin
                                FromDocType2 := FromDocType2::"Posted Invoice";
                                //Message(Text000, FromDocType, FromDocType2, Text001);
                            end;
                        end;
                    FromDocType::"Posted Invoice":
                        begin
                            FromSalesInvHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                        end;
                    FromDocType::"Posted Return Receipt":
                        begin
                            FromReturnRcptHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromReturnRcptHeader);
                            if SalesHeader."Document Type" in
                                [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]
                            then begin
                                FromDocType2 := FromDocType2::"Posted Credit Memo";
                                //Message(Text000, FromDocType, FromDocType2, Text002);
                            end;
                        end;
                    FromDocType::"Posted Credit Memo":
                        begin
                            FromSalesCrMemoHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                        end;
                    FromDocType::"Arch. Quote",
                    FromDocType::"Arch. Order",
                    FromDocType::"Arch. Blanket Order",
                    FromDocType::"Arch. Return Order":
                        begin
                            FindFromSalesHeaderArchive();
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                        end;
                end;
            end;
        FromSalesHeader."No." := '';

        //ValidateIncludeHeader();
    end;

    local procedure ValidateIncludeHeader()
    begin
        //RecalculateLines :=
        //(FromDocType in [FromDocType::"Posted Shipment", FromDocType::"Posted Return Receipt"]) or not IncludeHeader;
    end;

    local procedure FindFromSalesHeaderArchive()
    var
        IsHandled: Boolean;
    begin
        if not FromSalesHeaderArchive.Get(
             CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo, FromDocNoOccurrence, FromDocVersionNo)
        then begin
            FromSalesHeaderArchive.SetRange("No.", FromDocNo);
            if FromSalesHeaderArchive.FindLast() then begin
                FromDocNoOccurrence := FromSalesHeaderArchive."Doc. No. Occurrence";
                FromDocVersionNo := FromSalesHeaderArchive."Version No.";
            end;
        end;
    end;

    procedure LookupDocNo()
    begin
        case FromDocType of
            FromDocType::Quote,
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Credit Memo",
            FromDocType::"Blanket Order",
            FromDocType::"Return Order":
                LookupSalesDoc();
            FromDocType::"Posted Shipment":
                LookupPostedShipment();
            FromDocType::"Posted Invoice":
                LookupPostedInvoice();
            FromDocType::"Posted Return Receipt":
                LookupPostedReturn();
            FromDocType::"Posted Credit Memo":
                LookupPostedCrMemo();
            FromDocType::"Arch. Quote",
            FromDocType::"Arch. Order",
            FromDocType::"Arch. Blanket Order",
            FromDocType::"Arch. Return Order":
                LookupSalesArchive();
        end;

        ValidateDocNo();
    end;

    local procedure LookupSalesDoc()
    begin
        FromSalesHeader.FilterGroup := 0;
        FromSalesHeader.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(FromDocType));
        if SalesHeader."Document Type" = CopyDocMgt.GetSalesDocumentType(FromDocType) then
            FromSalesHeader.SetFilter("No.", '<>%1', SalesHeader."No.");
        FromSalesHeader.FilterGroup := 2;
        FromSalesHeader."Document Type" := CopyDocMgt.GetSalesDocumentType(FromDocType);
        FromSalesHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.") then begin
                FromSalesHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesHeader.Find('=><') then;
            end;
        if Page.RunModal(0, FromSalesHeader) = Action::LookupOK then
            FromDocNo := FromSalesHeader."No.";
    end;

    local procedure LookupSalesArchive()
    begin
        FromSalesHeaderArchive.Reset();
        FromSalesHeaderArchive.FilterGroup := 0;
        FromSalesHeaderArchive.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(FromDocType));
        FromSalesHeaderArchive.FilterGroup := 2;
        FromSalesHeaderArchive."Document Type" := CopyDocMgt.GetSalesDocumentType(FromDocType);
        FromSalesHeaderArchive."No." := FromDocNo;
        FromSalesHeaderArchive."Doc. No. Occurrence" := FromDocNoOccurrence;
        FromSalesHeaderArchive."Version No." := FromDocVersionNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesHeaderArchive.SetCurrentKey("Document Type", "Sell-to Customer No.") then begin
                FromSalesHeaderArchive."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesHeaderArchive.Find('=><') then;
            end;
        if Page.RunModal(0, FromSalesHeaderArchive) = Action::LookupOK then begin
            FromDocNo := FromSalesHeaderArchive."No.";
            FromDocNoOccurrence := FromSalesHeaderArchive."Doc. No. Occurrence";
            FromDocVersionNo := FromSalesHeaderArchive."Version No.";
            RequestOptionsPage.Update(false);
        end;
    end;

    local procedure LookupPostedShipment()
    begin
        FromSalesShptHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesShptHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesShptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesShptHeader.Find('=><') then;
            end;
        if Page.RunModal(0, FromSalesShptHeader) = Action::LookupOK then
            FromDocNo := FromSalesShptHeader."No.";
    end;

    local procedure LookupPostedInvoice()
    begin
        FromSalesInvHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesInvHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesInvHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesInvHeader.Find('=><') then;
            end;
        FromSalesInvHeader.FilterGroup(2);
        FromSalesInvHeader.SetRange("Prepayment Invoice", false);
        FromSalesInvHeader.FilterGroup(0);
        if Page.RunModal(0, FromSalesInvHeader) = Action::LookupOK then
            FromDocNo := FromSalesInvHeader."No.";
    end;

    local procedure LookupPostedCrMemo()
    begin
        FromSalesCrMemoHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesCrMemoHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesCrMemoHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesCrMemoHeader.Find('=><') then;
            end;
        FromSalesCrMemoHeader.FilterGroup(2);
        FromSalesCrMemoHeader.SetRange("Prepayment Credit Memo", false);
        FromSalesCrMemoHeader.FilterGroup(0);
        if Page.RunModal(0, FromSalesCrMemoHeader) = Action::LookupOK then
            FromDocNo := FromSalesCrMemoHeader."No.";
    end;

    local procedure LookupPostedReturn()
    begin
        FromReturnRcptHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromReturnRcptHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromReturnRcptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromReturnRcptHeader.Find('=><') then;
            end;
        if Page.RunModal(0, FromReturnRcptHeader) = Action::LookupOK then
            FromDocNo := FromReturnRcptHeader."No.";
    end;

    procedure SetSalesHeader(var NewSalesHeader: Record "Sales Header")
    begin
        NewSalesHeader.TestField("No.");
        SalesHeader := NewSalesHeader;
    end;

    var
        DocNoNotSerErr: Label 'Select a document number to continue, or choose Cancel to close the page.';
        Text000: Label 'Please enter a Document No.';
        SalesHeader: Record "Sales Header";
        FromSalesHeader: Record "Sales Header";
        FromSalesShptHeader: Record "Sales Shipment Header";
        FromSalesInvHeader: Record "Sales Invoice Header";
        FromReturnRcptHeader: Record "Return Receipt Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FromSalesHeaderArchive: Record "Sales Header Archive";
        SalesSetup: Record "Sales & Receivables Setup";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        FromDocType: Enum "Sales Document Type From";
        FromDocNo: Code[20];
        FromDocNoOccurrence: Integer;
        FromDocVersionNo: Integer;

}
