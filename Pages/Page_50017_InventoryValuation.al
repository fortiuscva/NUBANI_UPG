#pragma implicitwith disable
page 50017 "Inventory Valuation"
{
    // //FP  Add 'View Sales History' to Sales Button
    //       Add 'View Purchase History' to Purchase Button
    //       Add Quick Edit to Item Button
    //       Promoted Quick Edit, History-Sales, History-Purchase into the Promoted Category of Process
    //       Promoted Ledger Entries Option
    //       Added Picture factbox to top of part section
    // //POPN6.2  Add menu items to Item Button
    //         Add global variables

    Caption = 'Item List';
    CardPageID = "Item Card - Admin";
    Editable = true;
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Inventory; rec.Inventory)
                {
                    Caption = 'Qty on Hand';
                    ApplicationArea = all;
                }
                field("Inventory on Date"; rec."Inventory on Date")
                {
                    ApplicationArea = all;
                }
                field("Last Direct Cost"; rec."Last Direct Cost")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1900510507; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1905726507; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }//B2BUPG
            part(Control1100768008; "Item Picture Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = all;
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = true;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            part(Control1906840407; "Item Planning FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            part(Control1901796907; "Item Warehouse FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Bin Filter" = FIELD("Bin Filter"),
                              "Variant Filter" = FIELD("Variant Filter"),
                              "Lot No. Filter" = FIELD("Lot No. Filter"),
                              "Serial No. Filter" = FIELD("Serial No. Filter");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
                ApplicationArea = all;
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
            group(Availability)
            {
                Caption = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ItemsByLocation: Page "Items by Location";
                    begin
                        ItemsByLocation.SETRECORD(Rec);
                        ItemsByLocation.RUN;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;

                    action("<Action5>")
                    {
                        Caption = 'Event';
                        Image = "Event";
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = all;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = all;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        ApplicationArea = all;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                    // action(Timeline)
                    // {
                    //     Caption = 'Timeline';
                    //     Image = Timeline;
                    //     Promoted = true;
                    //     PromotedCategory = Process;
                    //     PromotedIsBig = true;
                    //      ApplicationArea = all;

                    //     trigger OnAction()
                    //     begin
                    //         ShowTimelineFromItem(Rec);
                    //     end;
                    // }
                }
            }
            group("Master Data")
            {
                Caption = 'Master Data';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    ApplicationArea = all;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    ApplicationArea = all;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        ApplicationArea = all;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ApplicationArea = all;

                        trigger OnAction()
                        var
                            Item: Record Item;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                            NoField: Integer;
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            // DefaultDimMultiple.SetMultiItem(Item);//B2BUPG
                            DefaultDimMultiple.SetMultiRecord(Item, NoField);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    ApplicationArea = all;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                }
                // action("Cross Re&ferences")
                // {
                //     Caption = 'Cross Re&ferences';
                //     Image = Change;
                //     RunObject = Page "Item Cross Reference Entries";//5721 B2BUPG
                //     RunPageLink = "Item No." = FIELD ("No.");
                // }//B2BUPG PAGE not Found
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    ApplicationArea = all;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    ApplicationArea = all;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No."),
                                  "Variant Code" = CONST('');
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    ApplicationArea = all;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = BarCode;
                    ApplicationArea = all;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                }
                separator(Separator1100768050)
                {
                }
                // action("<Action1100768002>")
                // {
                //     Caption = 'Pop-Up Note Entry';14005021 B2BUPG
                //     Image = Note;

                //     trigger OnAction()//14005020
                //     begin
                //         if greNote.FINDLAST then
                //             EntryNo := greNote."Entry No." + 1
                //         else
                //             EntryNo := 1;

                //         NotesT.INIT;
                //         NotesT."Entry No." := EntryNo;
                //         NotesT."User ID Insert" := USERID;
                //         NotesT.INSERT;
                //         NotesT.Type := NotesT.Type::Item;
                //         NotesT."Vend/Cust No." := '';
                //         NotesT."No." := rec."No.";
                //         NotesT."Creation Date" := TODAY;
                //         NotesT.VALIDATE("Effective Date", TODAY);
                //         NotesT."Sales Documents" := true;
                //         NotesT."Purchase Documents" := true;
                //         NotesT."Service Documents" := true;
                //         NotesT.MODIFY;
                //         COMMIT;
                //         if PAGE.RUNMODAL(PAGE::"Note Card", NotesT) = ACTION::LookupCancel then
                //             NotesT.DELETE;
                //     end;
                // }//B2BUPG
                // action("<Action1100768003>")
                // {
                //     Caption = 'Pop-&Up Notes';
                //     Image = Note;
                //     RunObject = Page "Note Display"; //14005018 B2BUPG
                //     RunPageLink = "No." = FIELD ("No.");
                //     RunPageView = SORTING (Type, "Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                //                   WHERE (Type = FILTER (Customer | Vendor | Item),
                //                         Effective = CONST (true),
                //                         Expired = CONST (false));
                // }//B2BUPG
            }
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                Image = Production;
                action(Structure)
                {
                    Caption = 'Structure';
                    Image = Hierarchy;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN;
                    end;
                }
                action("Cost Shares")
                {
                    Caption = 'Cost Shares';
                    Image = CostBudget;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BOMCostShares: Page "BOM Cost Shares";
                    begin
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.RUN;
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Assemb&ly';
                    Image = AssemblyBOM;

                    action("<Action32>")
                    {
                        ApplicationArea = all;
                        Caption = 'Assembly BOM';
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                    }
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        Image = Track;
                        ApplicationArea = all;
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(rec."No.", true);
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        Caption = 'Calc. Unit Price';
                        Image = SuggestItemPrice;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcAssemblyItemPrice(rec."No.");
                        end;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                    Image = Production;
                    action("Production BOM")
                    {
                        Caption = 'Production BOM';
                        Image = BOM;
                        ApplicationArea = all;
                        RunObject = Page "Production BOM";
                        RunPageLink = "No." = FIELD("No.");
                    }
                    action(Action29)
                    {
                        Caption = 'Where-Used';
                        Image = "Where-Used";
                        ApplicationArea = all;

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action(Action24)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            CalculateStdCost.CalcItem(rec."No.", false);
                        end;
                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        ApplicationArea = all;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation),
                                      "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        ApplicationArea = all;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        ApplicationArea = all;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;
                        ApplicationArea = all;

                        trigger OnAction()
                        var
                            ItemTrackingMgt: Codeunit "Item Tracking Management";
                        begin
                            //ItemTrackingMgt.CallItemTrackingEntryForm(3, '', "No.", '', '', '', '');B2BUPG
                            EventsandSubscriber.CallItemTrackingEntryForm(3, '', Rec."No.", '', '', '', '');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        ApplicationArea = all;
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Action16)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        ApplicationArea = all;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        ApplicationArea = all;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        ApplicationArea = all;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = all;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                }
                separator(Separator1100768000)
                {
                }
                // action("&Quick Edit Items")
                // {
                //     Caption = '&Quick Edit Items';
                //     Image = EditList;
                //     Promoted = false;
                //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //     //PromotedCategory = Process;
                //     RunObject = Page "Defaults Quick Edit Items";//14004984 B2BUPG
                // }//B2BUPG
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    ApplicationArea = all;
                    // RunObject = Page "Sales Prices";
                    // RunPageLink = "Item No." = FIELD("No.");
                    // RunPageView = SORTING("Item No.");
                    trigger OnAction()
                    begin
                        Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Price);
                    end;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    ApplicationArea = all;
                    // RunObject = Page "Sales Line Discounts";
                    // RunPageLink = Type = CONST(Item),
                    //               Code = FIELD("No.");
                    // RunPageView = SORTING(Type, Code);
                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Discount);
                        // Rec.ToPriceSource(PriceSource);
                        // PriceUXManagement.ShowPriceListLines(PriceSource, Enum::"Price Amount Type"::Discount);
                    end;
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    ApplicationArea = all;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    ApplicationArea = all;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action("Returns Orders")
                {
                    Caption = 'Returns Orders';
                    Image = ReturnOrder;
                    ApplicationArea = all;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                separator(Separator1100768002)
                {
                }
                action("Sales History")
                {
                    Caption = 'Sales History';
                    Image = History;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Recent Sales History";//14005135 B2BUPG//50201
                    RunPageLink = "No." = FIELD("No."),
                                  Type = CONST(Item);
                    RunPageView = SORTING(Type, "No.");
                }//B2BUPG
                //     action("History-Credit Memos")
                //     {
                //         Caption = 'History-Credit Memos';
                //         Image = History;
                //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //         //PromotedCategory = Process;
                //         RunObject = Page "Recent Sales Credit History";//14005136 B2BUPG
                //         RunPageLink = "No." = FIELD ("No."),
                //                       Type = CONST (Item);
                //         RunPageView = SORTING (Type, "No.");
                //     }
                // }//B2BUPG
                group("&Purchases")
                {
                    Caption = '&Purchases';
                    Image = Purchasing;
                    action("Ven&dors")
                    {
                        Caption = 'Ven&dors';
                        Image = Vendor;
                        ApplicationArea = all;
                        RunObject = Page "Item Vendor Catalog";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action(Action39)
                    {
                        Caption = 'Prices';
                        Image = Price;
                        ApplicationArea = all;
                        // RunObject = Page "Purchase Prices";
                        // RunPageLink = "Item No." = FIELD("No.");
                        // RunPageView = SORTING("Item No.");
                        trigger OnAction()
                        begin
                            Rec.ShowPriceListLines(Enum::"Price Type"::Purchase, Enum::"Price Amount Type"::Price);
                        end;
                    }
                    action(Action42)
                    {
                        Caption = 'Line Discounts';
                        Image = LineDiscount;
                        ApplicationArea = all;
                        // RunObject = Page "Purchase Line Discounts";
                        // RunPageLink = "Item No." = FIELD("No.");
                        // RunPageView = SORTING("Item No.");
                        trigger OnAction()
                        begin
                            Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Discount);
                        end;
                    }
                    action(Action125)
                    {
                        Caption = 'Prepa&yment Percentages';
                        Image = PrepaymentPercentages;
                        ApplicationArea = all;
                        RunObject = Page "Purchase Prepmt. Percentages";
                        RunPageLink = "Item No." = FIELD("No.");
                    }
                    action(Action40)
                    {
                        Caption = 'Orders';
                        Image = Document;
                        ApplicationArea = all;
                        RunObject = Page "Purchase Orders";
                        RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", Type, "No.");
                    }
                    action("Return Orders")
                    {
                        Caption = 'Return Orders';
                        Image = ReturnOrder;
                        ApplicationArea = all;
                        RunObject = Page "Purchase Return Orders";
                        RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", Type, "No.");
                    }
                    action("Nonstoc&k Items")
                    {
                        ApplicationArea = all;
                        Caption = 'Nonstoc&k Items';
                        Image = NonStockItem;
                        //RunObject = Page "Nonstock Item List";//5726B2BUPG page is name is replaced
                        RunObject = Page "Catalog Item List";
                    }
                }
                group(Warehouse)
                {
                    Caption = 'Warehouse';
                    Image = Warehouse;
                    action("&Bin Contents")
                    {
                        Caption = '&Bin Contents';
                        Image = BinContent;
                        ApplicationArea = all;
                        RunObject = Page "Bin Contents";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("Stockkeepin&g Units")
                    {
                        Caption = 'Stockkeepin&g Units';
                        Image = SKU;
                        ApplicationArea = all;
                        RunObject = Page "Stockkeeping Unit List";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                }
                group(Service)
                {
                    Caption = 'Service';
                    Image = ServiceItem;

                    action("Ser&vice Items")
                    {
                        Caption = 'Ser&vice Items';
                        Image = ServiceItem;
                        ApplicationArea = all;
                        RunObject = Page "Service Items";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action(Troubleshooting)
                    {
                        Caption = 'Troubleshooting';
                        Image = Troubleshoot;
                        ApplicationArea = all;

                        trigger OnAction()
                        var
                            TroubleshootingHeader: Record "Troubleshooting Header";
                        begin
                            TroubleshootingHeader.ShowForItem(Rec);
                        end;
                    }
                    action("Troubleshooting Setup")
                    {
                        Caption = 'Troubleshooting Setup';
                        Image = Troubleshoot;
                        ApplicationArea = all;
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    }
                }
                group(Resources)
                {
                    Caption = 'Resources';
                    Image = Resource;
                    group("R&esource")
                    {
                        Caption = 'R&esource';
                        Image = Resource;
                        action("Resource &Skills")
                        {
                            Caption = 'Resource &Skills';
                            Image = ResourceSkills;
                            ApplicationArea = all;
                            RunObject = Page "Resource Skills";
                            RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        }
                        action("Skilled R&esources")
                        {
                            Caption = 'Skilled R&esources';
                            Image = ResourceSkills;
                            ApplicationArea = all;

                            trigger OnAction()
                            var
                                ResourceSkill: Record "Resource Skill";
                            begin
                                CLEAR(SkilledResourceList);
                                SkilledResourceList.Initialize(ResourceSkill.Type::Item, rec."No.", rec.Description);
                                SkilledResourceList.RUNMODAL;
                            end;
                        }
                    }
                    separator(Separator1100768005)
                    {
                    }
                    // action("<Action1100768006>")
                    // {
                    //     Caption = 'Purchase History';
                    //     Image = History;
                    //     Promoted = true;
                    //     PromotedCategory = Process;
                    //     PromotedIsBig = true;
                    //     RunObject = Page "Recent Purch. History";//14005138 //B2BUPG
                    //     RunPageLink = Type = CONST (Item),
                    //                   "No." = FIELD ("No.");
                    //     RunPageView = SORTING (Type, "No.");
                    // }//B2BUPG
                    // action(Action1100768007)
                    // {
                    //     Caption = 'History-Credit Memos';
                    //     Image = History;
                    //     RunObject = Page "Recent Purch. Credit History";//14005140//B2BUPG
                    //     RunPageLink = Type = CONST (Item),
                    //                   "No." = FIELD ("No.");
                    //     RunPageView = SORTING (Type, "No.");
                    // }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("&Create Stockkeeping Unit")
                {
                    Caption = '&Create Stockkeeping Unit';
                    Image = CreateSKU;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", true, false, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
            }
            action("Sales Prices")
            {
                Caption = 'Sales Prices';
                Image = SalesPrices;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Page "Sales Prices";
                // RunPageLink = "Item No." = FIELD("No.");
                // RunPageView = SORTING("Item No.");
                trigger OnAction()
                begin
                    Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Price);
                end;
            }
            action("Sales Line Discounts")
            {
                Caption = 'Sales Line Discounts';
                Image = SalesLineDisc;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                // RunObject = Page "Sales Line Discounts";
                // RunPageLink = Type = CONST(Item),
                //               Code = FIELD("No.");
                // RunPageView = SORTING(Type, Code);
                trigger OnAction()
                begin
                    Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Discount);
                end;
            }
            action("Requisition Worksheet")
            {
                Caption = 'Requisition Worksheet';
                Image = Worksheet;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Req. Worksheet";
            }
            action("Item Journal")
            {
                Caption = 'Item Journal';
                Image = Journals;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Journal";
            }
            action("Item Reclassification Journal")
            {
                Caption = 'Item Reclassification Journal';
                Image = Journals;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Reclass. Journal";
            }
            action("Item Tracing")
            {
                Caption = 'Item Tracing';
                Image = ItemTracing;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Tracing";
            }
            action("Adjust Item Cost/Price")
            {
                Caption = 'Adjust Item Cost/Price';
                Image = AdjustItemCost;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Report "Adjust Item Costs/Prices";
            }
            action("Adjust Cost - Item Entries")
            {
                Caption = 'Adjust Cost - Item Entries';
                Image = AdjustEntries;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Report "Adjust Cost - Item Entries";
            }
        }
        area(reporting)
        {
            group(Item)
            {
                Caption = 'Item';
                group("Item Reports")
                {
                    Caption = 'Item Reports';
                    Image = PrintReport;
                    action("Inventory - List")
                    {
                        Caption = 'Inventory - List';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item List";
                    }
                    action("Item/Vendor Catalog")
                    {
                        Caption = 'Item/Vendor Catalog';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item/Vendor Catalog";
                    }
                    action("Phys. Inventory List")
                    {
                        Caption = 'Phys. Inventory List';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Phys. Inventory List";
                    }
                    action("Price List")
                    {
                        Caption = 'Price List';
                        Image = Report;
                        ApplicationArea = all;
                        Promoted = true;
                        PromotedCategory = "Report";
                        RunObject = Report "List Price Sheet V16";
                    }
                    action("Inventory Cost and Price List")
                    {
                        Caption = 'Inventory Cost and Price List';
                        Image = Report;
                        ApplicationArea = all;
                        Promoted = true;
                        PromotedCategory = "Report";
                        RunObject = Report "Item Cost and Price List";
                    }
                    // action("Inventory Valuation w/Detail")
                    // {
                    //     Caption = 'Inventory Valuation w/Detail';
                    //     Image = Report;
                    //     Promoted = true;
                    //     PromotedCategory = "Report";
                    //     PromotedIsBig = true;
                    //     RunObject = Report "Inventory Valuation w/Detail";//14005151 B2BUPG
                    // }//B2BUPG
                    action("Inventory - Top 10 List")
                    {
                        Caption = 'Inventory - Top 10 List';
                        Image = Report;
                        ApplicationArea = all;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Top __ Inventory Items";
                    }
                    action("Where Used (Top Level)")
                    {
                        Caption = 'Where Used (Top Level)';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Where-Used (Top Level)";
                    }
                    action("Quantity Explosion of BOM")
                    {
                        Caption = 'Quantity Explosion of BOM';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Quantity Explosion of BOM";
                    }
                    action("Compare List")
                    {
                        Caption = 'Compare List';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Compare List";
                    }
                    action("Item Register - Quantity")
                    {
                        Caption = 'Item Register - Quantity';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Register";
                    }
                    action("Inventory - Transaction Detail")
                    {
                        Caption = 'Inventory - Transaction Detail';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Transaction Detail";
                    }
                    action("Back Order Fill by Item")
                    {
                        Caption = 'Back Order Fill by Item';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Back Order Fill by Item";
                    }
                    action("Issue History")
                    {
                        Caption = 'Issue History';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Issue History";
                    }
                    action("Picking List by Item")
                    {
                        Caption = 'Picking List by Item';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Picking List by Item";
                    }
                    action("Purchase Advice")
                    {
                        Caption = 'Purchase Advice';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Purchase Advice";
                    }
                    action("Sales Order Status")
                    {
                        Caption = 'Sales Order Status';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Sales Order Status";
                    }
                    action("Inventory Purchase Orders")
                    {
                        Caption = 'Inventory Purchase Orders';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Purchase Order Status";
                    }
                    action("Inventory - Sales Statistics")
                    {
                        Caption = 'Inventory - Sales Statistics';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Sales Statistics";
                    }
                    action("Assemble to Order - Sales")
                    {
                        Caption = 'Assemble to Order - Sales';
                        Image = Report;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Assemble to Order - Sales";
                    }
                    action("Inventory - Customer Sales")
                    {
                        Caption = 'Inventory - Customer Sales';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Sales by Customer";
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        Caption = 'Inventory - Vendor Purchases';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Vendor/Item Statistics";
                    }
                    action("Inventory - Reorders")
                    {
                        Caption = 'Inventory - Reorders';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory - Reorders";
                    }
                    action("Inventory - Sales Back Orders")
                    {
                        Caption = 'Inventory - Sales Back Orders';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory - Sales Back Orders";
                    }
                    action("Nonstock Item Sales")
                    {
                        Caption = 'Nonstock Item Sales';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        //RunObject = Report "Nonstock Item Sales";//5700 B2BUPG
                        RunObject = Report "Catalog Item Sales";
                    }
                    action("Inventory - Cost Variance")
                    {
                        Caption = 'Inventory - Cost Variance';
                        Image = ItemCosts;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory - Cost Variance";
                    }
                    action("Inventory Valuation")
                    {
                        Caption = 'Inventory Valuation';
                        Image = Report;
                        Promoted = true;
                        ApplicationArea = all;
                        PromotedCategory = "Report";
                        RunObject = Report "Inventory Valuation";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        Caption = 'Invt. Valuation - Cost Spec.';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Invt. Valuation - Cost Spec.";
                    }
                    action("Inventory Valuation - WIP")
                    {
                        Caption = 'Inventory Valuation - WIP';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory Valuation - WIP";
                    }
                    action("Item Register - Value")
                    {
                        Caption = 'Item Register - Value';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Register - Value";
                    }
                    action("Item Charges - Specification")
                    {
                        Caption = 'Item Charges - Specification';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Charges - Specification";
                    }
                    action("Item Age Composition - Qty.")
                    {
                        Caption = 'Item Age Composition - Qty.';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Age Composition - Qty.";
                    }
                    action("Item Age Composition - Value")
                    {
                        Caption = 'Item Age Composition - Value';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Age Composition - Value";
                    }
                    action("Item Expiration - Quantity")
                    {
                        Caption = 'Item Expiration - Quantity';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Expiration - Quantity";
                    }
                    action("Cost Shares Breakdown")
                    {
                        Caption = 'Cost Shares Breakdown';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Cost Shares Breakdown";
                    }
                    action("Detailed Calculation")
                    {
                        Caption = 'Detailed Calculation';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Detailed Calculation";
                    }
                    action("Rolled-up Cost Shares")
                    {
                        Caption = 'Rolled-up Cost Shares';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Rolled-up Cost Shares";
                    }
                    action("Single-Level Cost Shares")
                    {
                        Caption = 'Single-Level Cost Shares';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Single-level Cost Shares";
                    }
                    action("Inventory to G/L Reconcile")
                    {
                        Caption = 'Inventory to G/L Reconcile';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory to G/L Reconcile";
                    }
                    action("Inventory Availability")
                    {
                        Caption = 'Inventory Availability';
                        Image = Report;
                        Promoted = true;
                        ApplicationArea = all;
                        PromotedCategory = "Report";
                        RunObject = Report "Availability Status";
                    }
                    action("Availability Projection")
                    {
                        Caption = 'Availability Projection';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Availability Projection";
                    }
                    action(Action1908000106)
                    {
                        Caption = 'Item Charges - Specification';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Charges - Specification";
                    }
                    action("Item Turnover")
                    {
                        Caption = 'Item Turnover';
                        Image = Report;
                        Promoted = false;
                        ApplicationArea = all;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Item Turnover";
                    }
                    // action("Inventory Valuation Report")
                    // {
                    //     Caption = 'Inventory Valuation Report';
                    //     Image = Report2;
                    //     Promoted = true;
                    //     PromotedCategory = "Report";
                    //     RunObject = Report "Inventory Valuation w/Detail";//14005151 B2BUPG
                    // }//B2BUPG
                }
            }
        }
    }

    var
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

        //greNote: Record Note;//B2BUPG
        EntryNo: Integer;
        //NotesT: Record Note;//B2BUPG
        EventsandSubscriber: Codeunit EventsandSubscribers;


    procedure GetSelectionFilter(): Text
    var
        Item: Record Item;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        exit(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;


    procedure SetSelection(var Item: Record Item)
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;
}

#pragma implicitwith restore

