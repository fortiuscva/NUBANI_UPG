page 50065 "Whse. Basic RCr- Manager"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1906245608; "Whse Ship & Receive Activities")
                {
                    ApplicationArea = All;
                }
                systempart(Control1901420308; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                part(Control4; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control18; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
                // part(Control1903012608; "Connect Online")
                // {
                //     Visible = false;
                // }//B2BUPG Its in visible false
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Warehouse &Bin List")
            {
                ApplicationArea = All;
                Caption = 'Warehouse &Bin List';
                Image = Report;
                RunObject = Report "Warehouse Bin List";
            }
            action("Item Replenishment")
            {
                ApplicationArea = All;
                // Promoted = true;
                // PromotedIsBig = true;
                RunObject = Report "Item Replenishment";
            }
            separator(Separator51)
            {
            }
            action("Physical &Inventory List")
            {
                ApplicationArea = All;
                Caption = 'Physical &Inventory List';
                Image = Report;
                RunObject = Report "Phys. Inventory List";
            }
            separator(Separator54)
            {
            }
            action("Customer &Labels")
            {
                ApplicationArea = All;
                Caption = 'Customer &Labels';
                Image = Report;
                RunObject = Report "Customer - Labels";
            }
        }
        area(embedding)
        {
            // action("Purchase Order Receiving")
            // {
            //     RunObject = Page "Purchase Order Receiving List";
            // }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Released)
            {
                ApplicationArea = All;
                Caption = 'Released';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE(Status = FILTER(Released));
            }
            action("Partially Shipped")
            {
                ApplicationArea = All;
                Caption = 'Partially Shipped';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE(Status = FILTER(Released),
                                    "Completely Shipped" = FILTER(false));
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Return Orders';
                RunObject = Page "Purchase Return Order List";
                RunPageView = WHERE("Document Type" = FILTER("Return Order"));
            }
            action("Inventory Picks")
            {
                ApplicationArea = All;
                Caption = 'Inventory Picks';
                RunObject = Page "Inventory Picks";
            }
            action("Items on Sales Orders")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Sales Orders";
            }
            action("Items on Picks")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Picks";
            }
            action("Warehouse Manager Order Report")
            {
                ApplicationArea = All;
                RunObject = Page "Warehouse Manager Order Report";
            }
            action("Inventory Put-aways")
            {
                ApplicationArea = All;
                Caption = 'Inventory Put-aways';
                RunObject = Page "Inventory Put-aways";
            }
            action("Inventory Movements")
            {
                ApplicationArea = All;
                Caption = 'Inventory Movements';
                RunObject = Page "Inventory Movements";
            }
            action("Internal Movements")
            {
                ApplicationArea = All;
                Caption = 'Internal Movements';
                RunObject = Page "Internal Movement List";
            }
            action("Bin Contents")
            {
                ApplicationArea = All;
                Caption = 'Bin Contents';
                Image = BinContent;
                RunObject = Page "Bin Contents List";
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List-Salesperson";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Invt. Picks")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Invt. Picks';
                    RunObject = Page "Posted Invt. Pick List";
                }
                action("Posted Sales Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipment';
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
            }
        }
        area(creation)
        {
            action("T&ransfer Order")
            {
                ApplicationArea = All;
                Caption = 'T&ransfer Order';
                Image = Document;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Transfer Order";
                RunPageMode = Create;
            }
            action("&Purchase Order")
            {
                ApplicationArea = All;
                Caption = '&Purchase Order';
                Image = Document;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
            }
            separator(Separator9)
            {
            }
            action("Inventory Pi&ck")
            {
                ApplicationArea = All;
                Caption = 'Inventory Pi&ck';
                Image = CreateInventoryPickup;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Inventory Pick";
                RunPageMode = Create;
            }
            action("Inventory P&ut-away")
            {
                ApplicationArea = All;
                Caption = 'Inventory P&ut-away';
                Image = CreatePutAway;
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Inventory Put-away";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Edit Item Reclassification &Journal")
            {
                ApplicationArea = All;
                Caption = 'Edit Item Reclassification &Journal';
                Image = OpenWorksheet;
                RunObject = Page "Item Reclass. Journal";
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Item &Tracing")
            {
                ApplicationArea = All;
                Caption = 'Item &Tracing';
                Image = ItemTracing;
                RunObject = Page "Item Tracing";
            }
            separator(Customer)
            {
                Caption = 'Customer';
                IsHeader = true;
            }
            // action("Credit Management")
            // {
            //     Caption = 'Credit Management';
            //     RunObject = Page "Customer List - Credit Mgmt.";
            // }
            // action("Order Status")
            // {
            //     Caption = 'Order Status';
            //     RunObject = Page "Customer List - Order Status";
            // }
            // action("Sales Order Shipping")
            // {
            //     Caption = 'Sales Order Shipping';
            //     RunObject = Page "Sales Order Shipment List";
            // }///B2BUPG
        }
    }
}

