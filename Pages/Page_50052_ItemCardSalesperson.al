page 50052 "Item Card-Salesperson"
{
    // //FP  Filter on Drill down on QOH(Inventory) field
    //       Added three global variables
    //       Modify on the Unit Price OnValidate
    //       Add 'View Sales History' to Sales Button
    //       Add 'View Purchase History' to Purchase Button
    //       Added new fact boxes
    // //POPN  Add Pop-Up Notes field to form
    //         Add Menu item on Item Button
    //         New Entry point for Popup Notes
    //         Add 3 global variables
    // //POPN4.01  Corrected Lookup filters on the "Popup Notes" control
    // //POPN6  Changed form on Pop-Up Note menu choice
    // NUB1.01,10/31/19,SK: Added new action as "SKU Label" report.

    Caption = 'Item Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit then
                            CurrPage.UPDATE;
                    end;
                }
                field("Search Description"; rec."Search Description")
                {
                    Caption = 'SKU';
                    ApplicationArea = all;
                }
                field("Inner UPC"; rec."Inner UPC")
                {
                    ApplicationArea = All;
                }
                field(GMO; rec.GMO)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    Caption = 'Description Other';
                    ApplicationArea = all;
                }
                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Country/Region Purchased Code"; rec."Country/Region Purchased Code")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Qty.  Per Pallet"; rec."Qty.  Per Pallet")
                {
                    ApplicationArea = all;
                }
                field("<Shelf No.>"; rec."Shelf No.")
                {
                    Caption = 'Shelf No.';
                    ApplicationArea = all;
                }
                field("Automatic Ext. Texts"; rec."Automatic Ext. Texts")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        EnableCostingControls;
                    end;
                }
                field("Product Group Code"; rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Pop-UP Notes"; rec."Pop-UP Notes")
                // {
                // }
                field(Inventory; rec.Inventory)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Qty. on Purch. Order"; rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. on Sales Order"; rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Blocked; rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Date Modified"; rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Unit Count"; rec."Unit Count")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Vendor Item No."; rec."Vendor Item No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Purch. Unit of Measure"; rec."Purch. Unit of Measure")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                }
                group(Assembly)
                {
                    Caption = 'Assembly';
                }
            }
            group(Planning)
            {
                Caption = 'Planning';
                group("Lot-for-Lot Parameters")
                {
                    Caption = 'Lot-for-Lot Parameters';
                }
                group("Reorder-Point Parameters")
                {
                    Caption = 'Reorder-Point Parameters';
                    grid(Control65)
                    {
                        GridLayout = Rows;
                        group(Control64)
                        {
                            field("Reorder Point"; rec."Reorder Point")
                            {
                                Enabled = ReorderPointEnable;
                                ApplicationArea = all;
                            }
                            field("Reorder Quantity"; rec."Reorder Quantity")
                            {
                                Enabled = ReorderQtyEnable;
                                ApplicationArea = all;
                            }
                            field("Maximum Inventory"; rec."Maximum Inventory")
                            {
                                Enabled = MaximumInventoryEnable;
                                ApplicationArea = all;
                            }
                        }
                    }
                    field("Overflow Level"; rec."Overflow Level")
                    {
                        Enabled = OverflowLevelEnable;
                        Importance = Additional;
                        ApplicationArea = all;
                    }
                    field("Time Bucket"; rec."Time Bucket")
                    {
                        Enabled = TimeBucketEnable;
                        Importance = Additional;
                        ApplicationArea = all;
                    }
                }
                group("Order Modifiers")
                {
                    Caption = 'Order Modifiers';
                    grid(Control60)
                    {
                        GridLayout = Rows;
                        group(Control61)
                        {
                            field("Minimum Order Quantity"; rec."Minimum Order Quantity")
                            {
                                Enabled = MinimumOrderQtyEnable;
                                ApplicationArea = all;
                            }
                            field("Maximum Order Quantity"; rec."Maximum Order Quantity")
                            {
                                Enabled = MaximumOrderQtyEnable;
                                ApplicationArea = all;
                            }
                            field("Order Multiple"; rec."Order Multiple")
                            {
                                Enabled = OrderMultipleEnable;
                                ApplicationArea = all;
                            }
                        }
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Tariff No."; rec."Tariff No.")
                {
                    ApplicationArea = all;
                }
                field("Country/Region of Origin Code"; rec."Country/Region of Origin Code")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Item Tracking';
                field("Item Tracking Code"; rec."Item Tracking Code")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Serial Nos."; rec."Serial Nos.")
                {
                    ApplicationArea = all;
                }
                field("Lot Nos."; rec."Lot Nos.")
                {
                    ApplicationArea = all;
                }
                field("Expiration Calculation"; rec."Expiration Calculation")
                {
                    ApplicationArea = all;
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                field("Special Equipment Code"; rec."Special Equipment Code")
                {
                    ApplicationArea = all;
                }
                // field("Put-away Template Code"; "Put-away Template Code")
                // {
                // }//B2BUPG
                field("Put-away Unit of Measure Code"; rec."Put-away Unit of Measure Code")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Phys Invt Counting Period Code"; rec."Phys Invt Counting Period Code")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Last Phys. Invt. Date"; rec."Last Phys. Invt. Date")
                {
                    ApplicationArea = all;
                }
                field("Last Counting Period Update"; rec."Last Counting Period Update")
                {
                    ApplicationArea = all;
                }
                // field("Next Counting Period"; rec."Next Counting Period")
                // {
                // }//B2BUPG
                field("Identifier Code"; rec."Identifier Code")
                {
                    ApplicationArea = all;
                }
                field("Use Cross-Docking"; rec."Use Cross-Docking")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1902521707; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1907737707; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100768006; "Item Picture Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = all;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
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
                // action("&Quick Edit Items")
                // {
                //     Caption = '&Quick Edit Items';
                //     Image = EditList;
                //     Promoted = false;
                //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //     //PromotedCategory = Process;
                //     RunObject = Page "Defaults Quick Edit Items";//14004984 B2BUPG
                // }//B2BUPG
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                }
                action(Action184)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = all;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
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
                //     RunPageLink = "Item No." = FIELD("No.");
                // }//B2BUPG
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
                    RunPageLink = "Item No." = FIELD("No.");
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
                // action("Pop-Up Note Entry")
                // {
                //     Caption = 'Pop-Up Note Entry';//14005021 B2BUPG
                //     Image = Note;

                //     trigger OnAction()
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
                // action("Pop-&Up Notes")
                // {
                //     Caption = 'Pop-&Up Notes';
                //     Image = Note;
                //     RunObject = Page "Note Display";//14005018 B2BUPG
                //     RunPageLink = "No." = FIELD("No.");
                //     RunPageView = SORTING(Type, "Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                //                   WHERE(Type = FILTER(Customer | Vendor | Item),
                //                         Effective = CONST(true),
                //                         Expired = CONST(false));
                // }B2BUPG
            }
            group(Availability)
            {
                Caption = 'Availability';
                Image = ItemAvailability;
                action(ItemsByLocation)
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
                    action("<Action110>")
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
                    //     ApplicationArea = all;

                    //     trigger OnAction()
                    //     begin
                    //         rec.ShowTimelineFromItem(Rec);
                    //     end;
                    // }
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
                            //ItemTrackingMgt.CallItemTrackingEntryForm(3, '', rec."No.", '', '', '', '');//B2BUPG
                            EventsandSubscriber.CallItemTrackingEntryForm(3, '', rec."No.", '', '', '', '');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        ApplicationArea = all;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                    }
                    action("Application Worksheet")
                    {
                        Caption = 'Application Worksheet';
                        Image = ApplicationWorksheet;
                        ApplicationArea = all;
                        RunObject = Page "Application Worksheet";
                        RunPageLink = "Item No." = FIELD("No.");
                    }
                }
                group(ActionGroup102)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        ApplicationArea = all;
                        Promoted = true;
                        PromotedCategory = Process;
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
            }
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
                action(Prices)
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
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    ApplicationArea = all;
                    // RunObject = Page "Purchase Line Discounts";
                    // RunPageLink = "Item No." = FIELD("No.");
                    trigger OnAction()
                    begin
                        Rec.ShowPriceListLines(Enum::"Price Type"::Purchase, Enum::"Price Amount Type"::Discount);
                    end;
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    ApplicationArea = all;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                separator(Separator47)
                {
                }
                action(Orders)
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
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    ApplicationArea = all;
                    //RunObject = Page "Nonstock Item List";//5726B2BUPG page is name is replaced
                    RunObject = Page "Catalog Item List";
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action(Action82)
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
                action(Action80)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    ApplicationArea = all;
                    // RunObject = Page "Sales Line Discounts";
                    // RunPageLink = Type = CONST(Item),
                    //               Code = FIELD("No.");
                    // RunPageView = SORTING(Type, Code);
                    trigger OnAction()
                    begin
                        Rec.ShowPriceListLines(Enum::"Price Type"::Sale, Enum::"Price Amount Type"::Discount);
                    end;
                }
                action(Action300)
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    ApplicationArea = all;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                separator(Separator46)
                {
                }
                action(Action83)
                {
                    Caption = 'Orders';
                    Image = Document;
                    ApplicationArea = all;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
                action(Action163)
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    ApplicationArea = all;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
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

                    action(AssemblyBOM)
                    {
                        Caption = 'Assembly BOM';
                        ApplicationArea = all;
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
                            CLEAR(CalculateStdCost);
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
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcAssemblyItemPrice(rec."No.")
                        end;
                    }
                }
                group(Production1)
                {
                    Caption = 'Production';
                    Image = Production;

                    action("Production BOM")
                    {
                        ApplicationArea = All;
                        Caption = 'Production BOM';
                        Image = BOM;
                        RunObject = Page "Production BOM";
                        RunPageLink = "No." = FIELD("No.");
                    }
                    action(Action78)
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
                    action(Action5)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcItem(rec."No.", false);
                        end;
                    }
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
                    ApplicationArea = all;
                    Image = ServiceItem;
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
                    ApplicationArea = all;
                    Image = Troubleshoot;
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

                    action("Resource Skills")
                    {
                        Caption = 'Resource Skills';
                        Image = ResourceSkills;
                        ApplicationArea = all;
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                    }
                    action("Skilled Resources")
                    {
                        Caption = 'Skilled Resources';
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
                separator(Separator1100768003)
                {
                }
                // action("History-Credit Memos")
                // {
                //     Caption = 'History-Credit Memos';
                //     RunObject = Page "Recent Purch. Credit History";//14005140 B2BUPG
                //     RunPageLink = Type = CONST(Item),
                //                   "No." = FIELD("No.");
                //     RunPageView = SORTING(Type, "No.");
                // }
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
                separator(Separator241)
                {
                }
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    ApplicationArea = all;
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "Config. Template Management";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
            action("Requisition Worksheet")
            {
                Caption = 'Requisition Worksheet';
                Image = Worksheet;
                Promoted = false;
                ApplicationArea = all;
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
            action("History Sales")
            {
                Caption = 'History Sales';
                ApplicationArea = all;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Recent Sales History";//14005135 B2BUPG//50201
                RunPageLink = "No." = FIELD("No.");
                RunPageMode = View;
                RunPageView = SORTING(Type, "No.");
            }//B2BUPG
            action("History Purchases")
            {
                Caption = 'History Purchases';
                Image = History;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Recent Purch. History-No Cost";//50056 B2BUPG
                RunPageLink = "No." = FIELD("No.");
                RunPageMode = View;
                RunPageView = SORTING(Type, "No.");
            }
        }
        area(reporting)
        {
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
            action("Item Transaction Detail")
            {
                Caption = 'Item Transaction Detail';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Item Transaction Detail";
            }
            action("Serial Number Status/Aging")
            {
                Caption = 'Serial Number Status/Aging';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Top __ Inventory Items";
            }
            action("Issue History")
            {
                Caption = 'Issue History';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Issue History";
            }
            // action("Costed Bill of Materials")
            // {
            //     Caption = 'Costed Bill of Materials';
            //     Image = Report;
            //     Promoted = false;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";
            //     //RunObject = Report Report10171;//B2BUPG
            // }
            action("Item Sales by Customer")
            {
                Caption = 'Item Sales by Customer';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Sales by Customer";
            }
            action("Picking List by Item")
            {
                Caption = 'Picking List by Item';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Picking List by Item";
            }
            action("Sales Order Status")
            {
                Caption = 'Sales Order Status';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Order Status";
            }
            action("Serial Number Sold History")
            {
                Caption = 'Serial Number Sold History';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Serial Number Sold History";
            }
            action("Vendor Purchases by Item")
            {
                Caption = 'Vendor Purchases by Item';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Vendor Purchases by Item";
            }
            action("Item/Vendor Catalog")
            {
                Caption = 'Item/Vendor Catalog';
                Image = Report;
                ApplicationArea = all;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item/Vendor Catalog";
            }
            action("Purchase Order Status")
            {
                Caption = 'Purchase Order Status';
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Purchase Order Status";
            }
            action("SKU Label ")
            {
                Image = Report;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    CurrPage.SETSELECTIONFILTER(Item);
                    REPORT.RUNMODAL(REPORT::"Item SKU Label", true, false, Item);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnablePlanningControls;
        EnableCostingControls;
    end;

    trigger OnInit()
    begin
        UnitCostEnable := true;
        StandardCostEnable := true;
        OverflowLevelEnable := true;
        DampenerQtyEnable := true;
        DampenerPeriodEnable := true;
        LotAccumulationPeriodEnable := true;
        ReschedulingPeriodEnable := true;
        IncludeInventoryEnable := true;
        OrderMultipleEnable := true;
        MaximumOrderQtyEnable := true;
        MinimumOrderQtyEnable := true;
        MaximumInventoryEnable := true;
        ReorderQtyEnable := true;
        ReorderPointEnable := true;
        SafetyStockQtyEnable := true;
        SafetyLeadTimeEnable := true;
        TimeBucketEnable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EnablePlanningControls;
        EnableCostingControls;
    end;

    var
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

        TimeBucketEnable: Boolean;

        SafetyLeadTimeEnable: Boolean;

        SafetyStockQtyEnable: Boolean;

        ReorderPointEnable: Boolean;

        ReorderQtyEnable: Boolean;

        MaximumInventoryEnable: Boolean;

        MinimumOrderQtyEnable: Boolean;

        MaximumOrderQtyEnable: Boolean;

        OrderMultipleEnable: Boolean;

        IncludeInventoryEnable: Boolean;

        ReschedulingPeriodEnable: Boolean;

        LotAccumulationPeriodEnable: Boolean;

        DampenerPeriodEnable: Boolean;

        DampenerQtyEnable: Boolean;

        OverflowLevelEnable: Boolean;

        StandardCostEnable: Boolean;

        UnitCostEnable: Boolean;
        "--FP--": Integer;
        //PostDocCU: Codeunit "Posting Doc.Line Reporting";//14005058 B2BUPG
        //greNote: Record Note;//14005020 B2BUPG
        EntryNo: Integer;
        //NotesT: Record Note;//14005020 B2BUPG
        EventsandSubscriber: codeunit EventsandSubscribers;



    procedure EnablePlanningControls()
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        TimeBucketEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQtyEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
        ReschedulingPeriodEnabled: Boolean;
        LotAccumulationPeriodEnabled: Boolean;
        DampenerPeriodEnabled: Boolean;
        DampenerQtyEnabled: Boolean;
        OverflowLevelEnabled: Boolean;
    begin
        EventsandSubscriber.SetUpPlanningControls(rec."Reordering Policy", rec."Include Inventory",
          TimeBucketEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
          ReorderPointEnabled, ReorderQtyEnabled, MaximumInventoryEnabled,
          MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled,
          ReschedulingPeriodEnabled, LotAccumulationPeriodEnabled,
          DampenerPeriodEnabled, DampenerQtyEnabled, OverflowLevelEnabled);
        TimeBucketEnable := TimeBucketEnabled;
        SafetyLeadTimeEnable := SafetyLeadTimeEnabled;
        SafetyStockQtyEnable := SafetyStockQtyEnabled;
        ReorderPointEnable := ReorderPointEnabled;
        ReorderQtyEnable := ReorderQtyEnabled;
        MaximumInventoryEnable := MaximumInventoryEnabled;
        MinimumOrderQtyEnable := MinimumOrderQtyEnabled;
        MaximumOrderQtyEnable := MaximumOrderQtyEnabled;
        OrderMultipleEnable := OrderMultipleEnabled;
        IncludeInventoryEnable := IncludeInventoryEnabled;
        ReschedulingPeriodEnable := ReschedulingPeriodEnabled;
        LotAccumulationPeriodEnable := LotAccumulationPeriodEnabled;
        DampenerPeriodEnable := DampenerPeriodEnabled;
        DampenerQtyEnable := DampenerQtyEnabled;
        OverflowLevelEnable := OverflowLevelEnabled;
    end;




    procedure EnableCostingControls()
    begin
        StandardCostEnable := rec."Costing Method" = Rec."Costing Method"::Standard;
        UnitCostEnable := rec."Costing Method" <> Rec."Costing Method"::Standard;
    end;


}

