report 51012 "Inventory Valuation_UPG"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/InventoryValuation.rdl';
    Caption = 'Inventory Valuation';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(item; item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Costing Method", "Location Filter", "Variant Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PAGENO)
            // {
            // }
            column(USERID; USERID)
            {
            }
            column(STRSUBSTNO_Text003_AsOfDate_; STRSUBSTNO(Text003, AsOfDate))
            {
            }
            column(ShowVariants; ShowVariants)
            {
            }
            column(ShowLocations; ShowLocations)
            {
            }
            column(ShowACY; ShowACY)
            {
            }
            column(STRSUBSTNO_Text006_Currency_Description_; STRSUBSTNO(Text006, Currency.Description))
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(STRSUBSTNO_Text004_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; STRSUBSTNO(Text004, InvPostingGroup.TABLECAPTION, InvPostingGroup.Code, InvPostingGroup.Description))
            {
            }
            column(Item__Inventory_Posting_Group_; "Inventory Posting Group")
            {
            }
            column(Grouping; Grouping)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item__Costing_Method_; "Costing Method")
            {
            }
            column(STRSUBSTNO_Text005_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; STRSUBSTNO(Text005, InvPostingGroup.TABLECAPTION, InvPostingGroup.Code, InvPostingGroup.Description))
            {
            }
            column(InventoryValue; InventoryValue)
            {
            }
            column(InventoryValue_Control1020009; InventoryValue)
            {
            }
            column(Item_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Item_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Item_Location_Filter; "Location Filter")
            {
            }
            column(Item_Variant_Filter; "Variant Filter")
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__Costing_Method_Caption; FIELDCAPTION("Costing Method"))
            {
            }
            column(InventoryValue_Control34Caption; InventoryValue_Control34CaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FIELDCAPTION("Base Unit of Measure"))
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity_Caption; "Item Ledger Entry".FIELDCAPTION("Remaining Quantity"))
            {
            }
            column(UnitCost_Control33Caption; UnitCost_Control33CaptionLbl)
            {
            }
            column(Total_Inventory_ValueCaption; Total_Inventory_ValueCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter");
                DataItemTableView = SORTING("Item No.", "Variant Code", "Location Code", "Posting Date");
                column(STRSUBSTNO_Text004_ItemVariant_TABLECAPTION_ItemVariant_Code_ItemVariant_Description_; STRSUBSTNO(Text004, ItemVariant.TABLECAPTION, ItemVariant.Code, ItemVariant.Description))
                {
                }
                column(ItemVariant_GET__Item_No____Variant_Code__; ItemVariant.GET("Item No.", "Variant Code"))
                {
                }
                column(STRSUBSTNO_Text004_Location_TABLECAPTION_Location_Code_Location_Name_; STRSUBSTNO(Text004, Location.TABLECAPTION, Location.Code, Location.Name))
                {
                }
                column(Location_GET__Location_Code__; Location.GET("Location Code"))
                {
                }
                column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item_Ledger_Entry__Remaining_Quantity_; "Remaining Quantity")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(InventoryValue_Control34; InventoryValue)
                {
                }
                column(Item_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(STRSUBSTNO_Text005_Location_TABLECAPTION__Location_Code__Location_Name_; STRSUBSTNO(Text005, Location.TABLECAPTION, "Location Code", Location.Name))
                {
                }
                column(InventoryValue_Control21; InventoryValue)
                {
                }
                column(RemainingQty; RemainingQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UnitCost; UnitCost)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(STRSUBSTNO_Text005_Location_TABLECAPTION__Location_Code__Text008_; STRSUBSTNO(Text005, Location.TABLECAPTION, "Location Code", Text008))
                {
                }
                column(STRSUBSTNO_Text005_ItemVariant_TABLECAPTION__Variant_Code__ItemVariant_Description_; STRSUBSTNO(Text005, ItemVariant.TABLECAPTION, "Variant Code", ItemVariant.Description))
                {
                }
                column(InventoryValue_Control39; InventoryValue)
                {
                }
                column(RemainingQty_Control40; RemainingQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UnitCost_Control41; UnitCost)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(STRSUBSTNO_Text005_ItemVariant_TABLECAPTION__Variant_Code__Text007_; STRSUBSTNO(Text005, ItemVariant.TABLECAPTION, "Variant Code", Text007))
                {
                }
                column(RemainingQty_Control35; RemainingQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(InventoryValue_Control36; InventoryValue)
                {
                }
                column(Item_Ledger_Entry__Item_No__; "Item No.")
                {
                }
                column(Item__Costing_Method__Control1020008; Item."Costing Method")
                {
                }
                column(Item__Base_Unit_of_Measure__Control1020009; Item."Base Unit of Measure")
                {
                }
                column(Item_Description_Control1020011; Item.Description)
                {
                }
                column(UnitCost_Control33; UnitCost)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(Item_Ledger_Entry_Variant_Code; "Variant Code")
                {
                }
                column(Item_Ledger_Entry_Location_Code; "Location Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AdjustItemLedgEntryToAsOfDate("Item Ledger Entry");

                    RemainingQty := "Remaining Quantity";
                    IF ShowACY THEN
                        InventoryValue := "Cost Amount (Actual) (ACY)"
                    ELSE
                        InventoryValue := "Cost Amount (Actual)";

                    IF PrintToExcel THEN
                        MakeExcelDataBody;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(RemainingQty, InventoryValue);
                    SETRANGE("Posting Date", 0D, AsOfDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT InvPostingGroup.GET("Inventory Posting Group") THEN
                    CLEAR(InvPostingGroup);
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS(RemainingQty, InventoryValue);
                SETRANGE("Date Filter", 0D, AsOfDate);

                IF PrintToExcel THEN
                    MakeExcelInfo;
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
                    field(AsOfDate; AsOfDate)
                    {
                        ApplicationArea = all;
                        Caption = 'As Of Date';
                    }
                    field(ShowVariants; ShowVariants)
                    {
                        ApplicationArea = all;
                        Caption = 'Breakdown by Variants';
                    }
                    field(ShowLocations; ShowLocations)
                    {
                        ApplicationArea = all;
                        Caption = 'Breakdown by Location';
                    }
                    field(ShowACY; ShowACY)
                    {
                        ApplicationArea = all;
                        Caption = 'Use Additional Reporting Currency';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = all;
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        Grouping := (Item.FIELDCAPTION("Inventory Posting Group") = Item.CURRENTKEY);

        IF AsOfDate = 0D THEN
            ERROR(Text000);
        IF ShowLocations AND NOT ShowVariants THEN
            IF NOT "Item Ledger Entry".SETCURRENTKEY("Item No.", "Location Code") THEN
                ERROR(Text001,
                  "Item Ledger Entry".TABLECAPTION,
                  "Item Ledger Entry".FIELDCAPTION("Item No."),
                  "Item Ledger Entry".FIELDCAPTION("Location Code"));
        IF Item.GETFILTER("Date Filter") <> '' THEN
            ERROR(Text002, Item.FIELDCAPTION("Date Filter"), Item.TABLECAPTION);

        CompanyInformation.GET;
        ItemFilter := Item.GETFILTERS;
        ShowFootnote := FALSE;
        GLSetup.GET;
        IF GLSetup."Additional Reporting Currency" = '' THEN
            ShowACY := FALSE
        ELSE BEGIN
            Currency.GET(GLSetup."Additional Reporting Currency");
            Currency.TESTFIELD("Amount Rounding Precision");
            Currency.TESTFIELD("Unit-Amount Rounding Precision");
        END;

        FilterString := Item.GETFILTERS;
    end;

    var
        GLSetup: Record 98;
        CompanyInformation: Record 79;
        InvPostingGroup: Record 94;
        Currency: Record 4;
        Location: Record 14;
        ItemVariant: Record 5401;
        ItemFilter: Text[250];
        InventoryValue: Decimal;
        UnitCost: Decimal;
        ShowFootnote: Boolean;
        ShowVariants: Boolean;
        ShowLocations: Boolean;
        ShowACY: Boolean;
        AsOfDate: Date;
        RemainingQty: Decimal;
        Text000: Label 'You must enter an As Of Date.';
        Text001: Label 'If you want to show Locations without also showing Variants, you must add a new key to the %1 table which starts with the %2 and %3 fields.';
        Text002: Label 'Do not set a %1 on the %2.  Use the As Of Date on the Option tab instead.';
        Text003: Label 'Quantities and Values As Of %1';
        Text004: Label '%1 %2 (%3)';
        Text005: Label '%1 %2 (%3) Total';
        Text006: Label 'All Inventory Values are shown in %1.';
        Text007: Label 'No Variant';
        Text008: Label 'No Location';
        Grouping: Boolean;
        Inventory_ValuationCaptionLbl: Label 'Inventory Valuation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        InventoryValue_Control34CaptionLbl: Label 'Inventory Value';
        DescriptionCaptionLbl: Label 'Description';
        UnitCost_Control33CaptionLbl: Label 'Unit Cost';
        Total_Inventory_ValueCaptionLbl: Label 'Total Inventory Value';
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        Text101: Label 'Data';
        Text102: Label 'Inventory Valuation';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Vendor Filters';
        FilterString: Text[250];

    local procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgEntry: Record 32)
    var
        ItemApplnEntry: Record 339;
        ValueEntry: Record 5802;
        ItemLedgEntry2: Record 32;
        InvoicedValue: Decimal;
        InvoicedValueACY: Decimal;
        ExpectedValue: Decimal;
        ExpectedValueACY: Decimal;
    begin
        // adjust remaining quantity
        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry.Quantity;
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgEntry."Entry No.");
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" + ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.SETCURRENTKEY(
              "Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Posting Date", 0D, AsOfDate);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF ItemLedgEntry2.GET(ItemApplnEntry."Inbound Item Entry No.") AND
                       (ItemLedgEntry2."Posting Date" <= AsOfDate)
                    THEN
                        ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - ItemApplnEntry.Quantity;
                UNTIL ItemApplnEntry.NEXT = 0;
        END;
        // calculate adjusted cost of entry
        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        ValueEntry.SETRANGE("Posting Date", 0D, AsOfDate);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                ExpectedValue := ExpectedValue + ValueEntry."Cost Amount (Expected)";
                ExpectedValueACY := ExpectedValueACY + ValueEntry."Cost Amount (Expected) (ACY)";
                InvoicedValue := InvoicedValue + ValueEntry."Cost Amount (Actual)";
                InvoicedValueACY := InvoicedValueACY + ValueEntry."Cost Amount (Actual) (ACY)";
            UNTIL ValueEntry.NEXT = 0;
        ItemLedgEntry."Cost Amount (Actual)" := ROUND(InvoicedValue + ExpectedValue);
        ItemLedgEntry."Cost Amount (Actual) (ACY)" := ROUND(InvoicedValueACY + ExpectedValueACY, Currency."Amount Rounding Precision");
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Inventory Valuation", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text108), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Base Unit Of Measure', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Costing Method', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Renaming Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Inventory Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Base Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item."Costing Method", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(RemainingQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        IF RemainingQty = 0 THEN
            ExcelBuf.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number)
        ELSE
            ExcelBuf.AddColumn(InventoryValue / RemainingQty, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(InventoryValue, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
    end;

    local procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel(Text101, Text102, COMPANYNAME, USERID);//B2BUPG
        ExcelBuf.CreateNewBook(Text101);
        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
        ExcelBuf.CloseBook;
        ExcelBuf.OpenExcel;
        ERROR('');
    end;
}

