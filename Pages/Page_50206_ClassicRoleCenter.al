page 50206 "Classic Role Center"//14004992 
{
    // //FP7.0.15   Julia Baxter added the split screen views of posted documents

    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                // part(Control1906262008; "Classic Activities")//14004994
                // {
                // }
                systempart(Control1901420308; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = all;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                }
                part(Control1240070003; "Sales Performance")
                {
                    ApplicationArea = All;
                }
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
            action("Bin Contents")
            {
                ApplicationArea = All;
                Image = BinContent;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Page "Bin Contents";
            }
            action("Vendor Inventory Valuation")
            {
                ApplicationArea = All;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Invt.Valu.Cost Spec.With Vend.";
            }
            action("Aged Accounts Receivable")
            {
                ApplicationArea = All;
                Caption = 'Aged Accounts Receivable';
                RunObject = Report "Aged Accounts Receivable";
            }
            action("Customer Order Detail")
            {
                ApplicationArea = All;
                Caption = 'Customer Order Detail';
                RunObject = Report "Customer - Order Detail";
            }
            // action("Customer Sales History")
            // {
            //     Caption = 'Customer Sales History';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Report "Customer Sales History";//14005136B2BUPG
            // }
            action("Receiving Bins Report")
            {
                ApplicationArea = All;
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Display Receving Bin Sales";
            }
            action("Bin Movement by User")
            {
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Bin Movement by User";
            }
            action("Items Replenishment Report")
            {
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Replenishment";
            }
            // action("Customer Shipment Performance")
            // {
            //     Caption = 'Customer Shipment Performance';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Report "Shipment Performance";//14005138
            // }B2BUPG
            separator(Separator1100768067)
            {
            }
            action("Aged Accounts Payable")
            {
                ApplicationArea = All;
                Caption = 'Aged Accounts Payable';
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Report "Aged Accounts Payable";
            }
            action("Outstanding Order Status")
            {
                ApplicationArea = All;
                Caption = 'Outstanding Order Status';
                RunObject = Report "Outstanding Order Stat. by PO";
            }
            // action("Vendor Purchase History")
            // {
            //     Caption = 'Vendor Purchase History';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Report "Vendor Purchase History";//14005137
            // }
            // action("Vendor Performance")
            // {
            //     Caption = 'Vendor Performance';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Report "Vendor Performance";//14005139
            // }
            action("Sales Invoice Profitability")
            {
                ApplicationArea = All;
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Invoicing Rep. with Statistics";
            }
            action("Sales Shipments by Lots")
            {
                ApplicationArea = All;
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Sales By Lot/Exp. Date -Excel";
            }
            separator(Separator49)
            {
            }
            action("Top Customers")
            {
                ApplicationArea = All;
                Caption = 'Top Customers';
                RunObject = Report "Customer - Top 10 List";
            }
            action("Top Vendors")
            {
                ApplicationArea = All;
                Caption = 'Top Vendors';
                RunObject = Report "Top __ Vendor List";
            }
            action("Top Items")
            {
                ApplicationArea = All;
                Caption = 'Top Items';
                RunObject = Report "Top __ Inventory Items";
            }
        }
        area(embedding)
        {
            action("Product Expiration List")
            {
                ApplicationArea = All;
                RunObject = Page "Product Expiration";
            }
            action("Blocked Items")
            {
                ApplicationArea = All;
                RunObject = Page "Blocked Items";
            }
            action("Reseller Cert Expiration")
            {
                ApplicationArea = All;
                Caption = 'Reseller Certificate Expirations';
                RunObject = Page "Reseller Cert Expiration";
            }
            action("Sales Orders - Admin")
            {
                ApplicationArea = All;
                RunObject = Page "Sales Order List-Admin";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Customer List";
            }
            action("With Balance Due")
            {
                ApplicationArea = All;
                Caption = 'With Balance Due';
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Customer Ship-To Address")
            {
                ApplicationArea = All;
                RunObject = Page "Customer Ship-to Address List";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                //Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Vendor List";
            }
            action(Action5)
            {
                ApplicationArea = All;
                Caption = 'With Balance Due';
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                RunObject = Page "Item List- Admin";
            }
            action("Inventory Valuation Analysis")
            {
                ApplicationArea = All;
                RunObject = Page "Inventory Valuation";
            }
            action("Items Shipped by Qty and Date")
            {
                ApplicationArea = All;
                RunObject = Page "Items Posting by Qty and Date";
            }
            action("Items Received by Qty and Date")
            {
                ApplicationArea = All;
                RunObject = Page "Item Received by Qty and Date";
            }
            action("Warehouse Manager Order Report")
            {
                ApplicationArea = All;
                RunObject = Page "Warehouse Manager Order Report";
            }
            action("Items on Picks")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Picks";
            }
            action("Items on Sales Orders")
            {
                ApplicationArea = All;
                RunObject = Page "Items on Sales Orders";
            }
            action(Resources)
            {
                ApplicationArea = All;
                Caption = 'Resources';
                RunObject = Page "Resource List";
            }
        }
        area(sections)
        {
            group(Financials)
            {
                Caption = 'Financials';
                Image = Calculator;
                action("Chart of Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Chart of Accounts';
                    RunObject = Page "Chart of Accounts";
                }
                action(Budgets)
                {
                    ApplicationArea = All;
                    Caption = 'Budgets';
                    RunObject = Page "G/L Budget Names";
                }
                action("Gen. Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                }
                action("Recurring Gen. Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring Gen. Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                }
                action("Account Schedules")
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
                action("Column Layouts")
                {
                    ApplicationArea = All;
                    Caption = 'Column Layouts';
                    RunObject = Page "Column Layout Names";
                }
                action("Analysis Views")
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Bank Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    RunObject = Page "Bank Account List";
                }
                action("Cash Receipt Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                }
                action("Payment Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                }
                // action(Deposits)
                // {
                //     Caption = 'Deposits';
                //     Image = Document;
                //     RunObject = Page Deposits;//36646
                // }
                action("Posted Deposit List")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Deposit List';
                    RunObject = Page "Posted Deposit List";
                }
                // action("Bank Acct Reconciliations")
                // {
                //     Caption = 'Bank Acct Reconciliations';
                //     RunObject = Page "Bank Rec. List";//10124
                // }//B2BUPG
                action("Approval Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
                action("Approval Request Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Request Entries';
                    RunObject = Page "Approval Request Entries";
                }
                action(Action1100768009)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action("Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    RunObject = Page "Sales Invoice List";
                }
                action("Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                }
                action(Action1100768002)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                }
                action(Action1100768008)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    RunObject = Page "Item List";
                }
                // separator(Separator1100768170)
                // {
                //     IsHeader = true;
                // }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                Visible = false;
                action(Action17)
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
                action(Insurance)
                {
                    ApplicationArea = All;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                }
                action("Insurance Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                }
            }
            group("Sales & Marketing")
            {
                Caption = 'Sales & Marketing';
                Image = Sales;
                action(Action1100768039)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action(Contacts)
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    RunObject = Page "Contact List";
                }

                action(Teams)
                {
                    ApplicationArea = All;
                    Caption = 'Teams';
                    RunObject = Page Teams;
                }
                action(Salespeople)
                {
                    ApplicationArea = All;
                    Caption = 'Salespeople';
                    Image = ExportSalesPerson;
                    //RunObject = Page 14;
                    RunObject = page "Salespersons/Purchasers";
                }
                action("To-dos")
                {
                    ApplicationArea = All;
                    Caption = 'To-dos';
                    RunObject = Page 5096;
                }
                action(Opportunities)
                {
                    ApplicationArea = All;
                    Caption = 'Opportunities';
                    RunObject = Page "Opportunity List";
                }
                action(Campaigns)
                {
                    ApplicationArea = All;
                    Caption = 'Campaigns';
                    RunObject = Page "Campaign List";
                }
                action(Segments)
                {
                    ApplicationArea = All;
                    Caption = 'Segments';
                    Image = Segment;
                    RunObject = Page "Segment List";
                }
                action("Sales Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                }
                action("Sales Blanket Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Blanket Orders';
                    RunObject = Page "Blanket Sales Orders";
                }
                action("Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    RunObject = Page "Sales Order List-Admin";
                }
                action("Open Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Open Sales Orders';
                    RunObject = Page "Sales Order List-Admin";
                    RunPageView = WHERE(Status = FILTER(Open));
                }
                action("Released Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Released Sales Orders';
                    RunObject = Page "Sales Order List-Admin";
                    RunPageView = WHERE(Status = CONST(Released));
                }
                action(Action1100768035)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    RunObject = Page "Sales Invoice List";
                }
                action("Open Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Open Sales Invoices';
                    RunObject = Page "Sales Invoice List";
                    RunPageView = WHERE(Status = FILTER(Open));
                }
                action("Sales Return Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Return Orders';
                    RunObject = Page "Sales Return Order List";
                }
                action(Action1100768176)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                }
                action(Action1100768037)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
                action(Action1100768179)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Request Entries';
                    RunObject = Page "Approval Request Entries";
                }
                action("Sales Order Shipping")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Shipping';
                    RunObject = Page "Sales Order Shipment List";
                }
                action("Sales Order Invoicing")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Invoicing';
                    RunObject = Page "Sales Order Invoice List";
                }
                action("Sales Analysis Reports")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page "Analysis Report Sale";
                }
                action("Sales Analysis by Dimensions")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis by Dimensions';
                    RunObject = Page "Analysis View List Sales";
                }
                action(Registers)
                {
                    ApplicationArea = All;
                    Caption = 'Registers';
                    RunObject = Page "G/L Registers";
                }
            }
            group(Purchases)
            {
                Caption = 'Purchases';
                Image = Purchasing;
                action(Action1240070001)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                }
                action(Action1240070000)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    RunObject = Page "Item List";
                }
                action("Requisition Worksheets")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Worksheets';
                    RunObject = Page "Req. Wksh. Names";
                    RunPageView = WHERE("Template Type" = CONST("Req."),
                                        Recurring = CONST(false));
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Quotes';
                    RunObject = Page "Purchase Quotes";
                }
                action("Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                }
                action(Open)
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status = FILTER(Open));
                    ShortCutKey = 'Return';
                }
                action(Released)
                {
                    ApplicationArea = All;
                    Caption = 'Released';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status = CONST(Released));
                }
                action("Partially Received")
                {
                    ApplicationArea = All;
                    Caption = 'Partially Received';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status = FILTER(Released),
                                        Receive = FILTER(true),
                                        "Completely Received" = FILTER(false));
                }
                action("Purchase Blanket Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Blanket Orders';
                    RunObject = Page "Blanket Purchase Orders";
                }
                action(Action1100768049)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action(Action1100768051)
                {
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Return Orders';
                    RunObject = Page "Purchase Return Order List";
                }
                action("Purchase Order Receiving")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order Receiving';
                    RunObject = Page "Purchase Order Receiving List";
                }
                action("Transfer Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Orders';
                    Image = Document;
                    RunObject = Page "Transfer Orders";
                }
                action("Purchase Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Analysis';
                    RunObject = Page "Analysis Report Purchase";
                    RunPageView = WHERE("Analysis Area" = FILTER(Purchase));
                }
                action("Inventory Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Analysis';
                    RunObject = Page "Analysis Report Inventory";
                    RunPageView = WHERE("Analysis Area" = FILTER(Inventory));
                }
                action(Action1100768060)
                {
                    ApplicationArea = All;
                    Caption = 'Registers';
                    RunObject = Page "G/L Registers";
                }
            }
            group(Inventory)
            {
                Caption = 'Inventory';
                action(Action1100768076)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    RunObject = Page "Item List";
                }
                action(Action1100768075)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                }
                action("Nonstock Items")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstock Items';
                    RunObject = Page "Catalog Item List";//Nonstock Item List
                }
                action("Stockkeeping Units")
                {
                    ApplicationArea = All;
                    Caption = 'Stockkeeping Units';
                    RunObject = Page "Stockkeeping Unit List";
                }
                action("Inventory Analysis Reports")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Analysis Reports';
                    RunObject = Page "Analysis Report Inventory";
                    RunPageView = WHERE("Analysis Area" = FILTER(Inventory));
                }
                action("Purchase Analysis Reports")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Analysis Reports';
                    RunObject = Page "Analysis Report Purchase";
                    RunPageView = WHERE("Analysis Area" = FILTER(Purchase));
                }
                action("Item Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Item Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Item),
                                        Recurring = CONST(false));
                }
                action("Item Reclass. Journal")
                {
                    ApplicationArea = All;
                    Caption = 'Item Reclass. Journal';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('RECLASS'),
                                        Recurring = CONST(false),
                                        "Template Type" = CONST(Transfer));
                }
                action("Phys. Inventory Journal")
                {
                    ApplicationArea = All;
                    Caption = 'Phys. Inventory Journal';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Template Type" = CONST("Phys. Inventory"),
                                        Recurring = CONST(false));
                }
                action("Revaluation Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Revaluation Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('REVAL'),
                                        Recurring = CONST(false),
                                        "Template Type" = CONST(Revaluation));
                }
                action("Lot No. Information")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No. Information';
                    RunObject = Page "Lot No. Information List";
                }
                action("Serial No. Information")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No. Information';
                    RunObject = Page "Serial No. Information List";
                }
                action("Standard Cost Worksheets")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Cost Worksheets';
                    RunObject = Page "Standard Cost Worksheet Names";
                }
                action("Item Registers")
                {
                    ApplicationArea = All;
                    Caption = 'Item Registers';
                    RunObject = Page "Item Registers";
                }
                action(Locations)
                {
                    ApplicationArea = All;
                    Caption = 'Locations';
                    RunObject = Page "Location List";
                }
                action("Item Charges")
                {
                    ApplicationArea = All;
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                }
                action("Item Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Item Categories';
                    RunObject = Page "Item Categories";
                }
                action("Phys. Invt. Counting Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Phys. Invt. Counting Periods';
                    RunObject = Page "Phys. Invt. Counting Periods";
                }
                action("Units of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'Units of Measure';
                    RunObject = Page "Units of Measure";
                }
                action(Manufacturers)
                {
                    ApplicationArea = All;
                    Caption = 'Manufacturers';
                    RunObject = Page Manufacturers;
                }
                // action("Product Groups")
                // {
                //     Caption = 'Product Groups';
                //     RunObject = Page "Product Groups";//5731
                // }
                action("Item Tracking Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Item Tracking Codes';
                    RunObject = Page "Item Tracking Codes";
                }
                action("Item Journal Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Item Journal Templates';
                    RunObject = Page "Item Journal Templates";
                }
            }
            group(ActionGroup1100768109)
            {
                Caption = 'Resources';
                Image = ResourcePlanning;
                action(Action1100768110)
                {
                    ApplicationArea = All;
                    Caption = 'Resources';
                    RunObject = Page "Resource List";
                }
                action(People)
                {
                    ApplicationArea = All;
                    Caption = 'People';
                    RunObject = Page "Resource List";
                    RunPageView = WHERE(Type = CONST(Person));
                }
                action(Machines)
                {
                    ApplicationArea = All;
                    Caption = 'Machines';
                    RunObject = Page "Resource List";
                    RunPageView = WHERE(Type = FILTER(Machine));
                }
                action("Resource Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Groups';
                    RunObject = Page "Resource Groups";
                }
                action("Resource Price Changes")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Price Changes';
                    RunObject = Page "Resource Price Changes";
                }
                action("Resource Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Journals';
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Recurring Resource Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring Resource Journals';
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                }
                action("Resource Registers")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Registers';
                    RunObject = Page "Resource Registers";
                }
            }
            group(Jobs)
            {
                Caption = 'Jobs';
                Image = Statistics;
                Visible = false;
                action(Action1100768105)
                {
                    ApplicationArea = All;
                    Caption = 'Jobs';
                    RunObject = Page "Job List";
                }
                action("Order Jobs")
                {
                    ApplicationArea = All;
                    Caption = 'Order Jobs';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER('Order'));
                }
                action("Planned and Quoted Jobs")
                {
                    ApplicationArea = All;
                    Caption = 'Planned and Quoted Jobs';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER(Quote | Planning));
                }
                action("Completed Jobs")
                {
                    ApplicationArea = All;
                    Caption = 'Completed Jobs';
                    RunObject = Page "Job List";
                    RunPageView = WHERE(Status = FILTER(Completed));
                }
                action(Action1100768126)
                {
                    ApplicationArea = All;
                    Caption = 'Resources';
                    RunObject = Page "Resource List";
                }
                action("Person Resources")
                {
                    ApplicationArea = All;
                    Caption = 'Person Resources';
                    RunObject = Page "Resource List";
                    RunPageView = SORTING(Type)
                                  WHERE(Type = CONST(Person));
                }
                action("Machine Resources")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Resources';
                    RunObject = Page "Resource List";
                    RunPageView = SORTING(Type)
                                  WHERE(Type = CONST(Machine));
                }
                action("Job Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Job Journals';
                    RunObject = Page "Job Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('JOB'),
                                        Recurring = CONST(false));
                }
                action("Job G/L Journal")
                {
                    ApplicationArea = All;
                    Caption = 'Job G/L Journal';
                    RunObject = Page "General Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('JOB'),
                                        Recurring = CONST(false));
                }
                action("Job Registers")
                {
                    ApplicationArea = All;
                    Caption = 'Job Registers';
                    RunObject = Page "Job Registers";
                }
                action("Job Posting Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Job Posting Groups';
                    RunObject = Page "Job Posting Groups";
                }
            }
            group(Manufacturing)
            {
                Caption = 'Manufacturing';
                Image = ProductDesign;
                Visible = false;
                action("Finished Goods")
                {
                    ApplicationArea = All;
                    Caption = 'Finished Goods';
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Replenishment System" = CONST("Prod. Order"));
                }
                action("Raw Materials")
                {
                    ApplicationArea = All;
                    Caption = 'Raw Materials';
                    RunObject = Page "Item List";
                    RunPageView = WHERE("Low-Level Code" = FILTER(> 0),
                                        "Replenishment System" = CONST(Purchase),
                                        "Production BOM No." = FILTER(= ''));
                }
                action(Action1100768157)
                {
                    ApplicationArea = All;
                    Caption = 'Stockkeeping Units';
                    RunObject = Page "Stockkeeping Unit List";
                }
                action("Production BOMs")
                {
                    ApplicationArea = All;
                    Caption = 'Production BOMs';
                    RunObject = Page "Production BOM List";
                }
                action(Routings)
                {
                    ApplicationArea = All;
                    Caption = 'Routings';
                    RunObject = Page "Routing List";
                }
                action(Families)
                {
                    ApplicationArea = All;
                    Caption = 'Families';
                    RunObject = Page "Family List";
                }
                action("Machine Centers")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Centers';
                    RunObject = Page "Machine Center List";
                }
                action("Work Centers")
                {
                    ApplicationArea = All;
                    Caption = 'Work Centers';
                    RunObject = Page "Work Center List";
                }
                action("   Sales Quote")
                {
                    ApplicationArea = All;
                    Caption = '   Sales Quote';
                    RunObject = Page "Sales Quotes";
                }
                action("   Blanket Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Blanket Sales Orders';
                    RunObject = Page "Blanket Sales Orders";
                }
                action("   Sales Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Sales Orders';
                    RunObject = Page "Sales Order List";
                }
                action("   Purchase Quotes")
                {
                    ApplicationArea = All;
                    Caption = '   Purchase Quotes';
                    RunObject = Page "Purchase Quotes";
                }
                action("   Blanket Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Blanket Purchase Orders';
                    RunObject = Page "Blanket Purchase Orders";
                }
                action("   Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Purchase Orders';
                    RunObject = Page "Purchase Order List";
                }
                action("   Transfer Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Transfer Orders';
                    RunObject = Page "Transfer Orders";//5742 Transfer List
                }
                action("Production Forecast")
                {
                    ApplicationArea = All;
                    Caption = 'Production Forecast';
                    RunObject = Page "Demand Forecast Names";//99000921 Production Forecast Names
                }
                action("   Simulated Production Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Simulated Production Orders';
                    RunObject = Page "Simulated Production Orders";
                }
                action("   Planned Production Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Planned Production Orders';
                    RunObject = Page "Planned Production Orders";
                }
                action("   Firm Planned Production Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Firm Planned Production Orders';
                    RunObject = Page "Firm Planned Prod. Orders";
                }
                action("   Released Production Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Released Production Orders';
                    RunObject = Page "Released Production Orders";
                }
                action("   Finished Production Orders")
                {
                    ApplicationArea = All;
                    Caption = '   Finished Production Orders';
                    RunObject = Page "Finished Production Orders";
                }
                action("Consumption Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('CONSUMP'),
                                        Recurring = CONST(false));
                }
                action("Output Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Output Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('OUTPUT'),
                                        Recurring = CONST(false));
                }
                action(Action1100768172)
                {
                    ApplicationArea = All;
                    Caption = 'Revaluation Journals';
                    RunObject = Page "Item Journal Batches";
                    RunPageView = SORTING("Journal Template Name", Name)
                                  WHERE("Journal Template Name" = CONST('REVAL'),
                                        Recurring = CONST(false),
                                        "Template Type" = CONST(Revaluation));
                }
                action(Certified)
                {
                    ApplicationArea = All;
                    Caption = 'Certified';
                    RunObject = Page "Production BOM List";
                    RunPageView = WHERE(Status = CONST(Certified));
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = Transactions;
                Visible = false;
                action("Service Items")
                {
                    ApplicationArea = All;
                    Caption = 'Service Items';
                    RunObject = Page "Service Items";
                }
                action(Action1100768214)
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    RunObject = Page "Contact List";
                }
                action("Service Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Service Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Service Contracts";
                }
                action("Service Contract Quotes")
                {
                    Caption = 'Service Contract Quotes';
                    RunObject = Page "Service Contract Quotes";
                }
                action("Service Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Service Quotes';
                    Image = Quote;
                    RunObject = Page "Service Quotes";
                }
                action("Service Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                }
                action("Service Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Service Invoices';
                    RunObject = Page "Service Invoices";
                }
                action("Service Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Service Credit Memos';
                    RunObject = Page "Service Credit Memos";
                }
                action(Loaners)
                {
                    ApplicationArea = All;
                    Caption = 'Loaners';
                    RunObject = Page "Loaner List";
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = FiledPosted;
                action("Posted Sales Invoice Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoice Lines';
                    RunObject = Page "Posted Sales Invoice Lines";
                }
                action("Posted Sales Credit Memo Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memo Lines';
                    RunObject = Page "Posted Sales Credit Memo Lines";
                }
                action("Posted Purchase Invoice Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoice Lines';
                    RunObject = Page "Posted Purchase Invoice Lines";
                }
                action("Posted Purchase Credit Memo Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memo Lines';
                    RunObject = Page "Posted Purchase Cr. Memo Lines";
                }
                action("Sales Quote Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Quote Archives';
                    RunObject = Page "Sales List Archive";
                    RunPageView = WHERE("Document Type" = CONST(Quote));
                }
                action("Sales Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Archives';
                    RunObject = Page "Sales List Archive";
                    RunPageView = WHERE("Document Type" = CONST(Order));
                }
                action("Sales Return Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Return Order Archives';
                    RunObject = Page "Sales List Archive";
                    RunPageView = WHERE("Document Type" = CONST("Return Order"));
                }
                action("Posted Sales Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipments';
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                }
                // action("Posted Sales Inv. Split Scr")
                // {
                //     Caption = 'Posted Sales Inv. Split Scr';
                //     RunObject = Page "Posted Sales Invoices Split Sc";//14005155
                // }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                // action("Posted Sales CrM Split Scr")
                // {
                //     Caption = 'Posted Sales CrM Split Scr';
                //     RunObject = Page "Posted Sales CrMemo Split Sc";//14005156
                // }
                action("Posted Purchase Quote Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Quote Archives';
                    RunObject = Page "Purchase List Archive";
                    RunPageView = WHERE("Document Type" = CONST(Quote));
                }
                action("Posted Purchase Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Order Archives';
                    RunObject = Page "Purchase List Archive";
                    RunPageView = WHERE("Document Type" = CONST(Order));
                }
                action("Posted Purchase Return Order Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Return Order Archives';
                    RunObject = Page "Purchase List Archive";
                    RunPageView = WHERE("Document Type" = CONST("Return Order"));
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                // action("Posted Purch. Inv. Split Scr")
                // {
                //     Caption = 'Posted Purch. Inv. Split Scr';
                //     RunObject = Page "Posted Purch Invoices Split Sc";//14005157
                // }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                // action("Posted Purch. CM Split Scr")
                // {
                //     Caption = 'Posted Purch. CM Split Scr';
                //     RunObject = Page "Posted Purch CrMemo Split Sc";//14005158
                // }
                action("Issued Reminders")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Reminders';
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Fin. Charge Memos';
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
                action("Posted Deposits")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Deposits';
                    RunObject = Page "Posted Deposit List";
                }
                action("Posted Bank Recs.")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Bank Recs.';
                    RunObject = Page "Posted Bank Rec. List";
                }
                action("Posted Transfer Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page "Posted Transfer Shipments";
                }
                action("Posted Transfer Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipts";
                }
                action("Posted Service Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Shipments';
                    RunObject = Page "Posted Service Shipments";
                }
                action("Posted Service Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Invoices';
                    RunObject = Page "Posted Service Invoices";
                }
                action("Posted Service Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Credit Memos';
                    RunObject = Page "Posted Service Credit Memos";
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Cash Receipt Journal")
            {
                ApplicationArea = All;
                Caption = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page "Cash Receipt Journal";
            }
            action("Payment Journal")
            {
                ApplicationArea = All;
                Caption = 'Payment Journal';
                Image = PaymentJournal;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page "Payment Journal";
            }
            action("General Journal")
            {
                ApplicationArea = All;
                Caption = 'General Journal';
                Image = Edit;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page "General Journal";
            }
            separator(Separator97)
            {
            }
            action("Calculate Depreciation")
            {
                ApplicationArea = All;
                Caption = 'Calculate Depreciation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
            }
            action("Import Consolidation from Database")
            {
                ApplicationArea = All;
                Caption = 'Import Consolidation from Database';
                Ellipsis = true;
                RunObject = Report "Import Consolidation from DB";
            }
            action("Bank Account Reconciliation")
            {
                ApplicationArea = All;
                Caption = 'Bank Account Reconciliation';
                RunObject = Page "Bank Acc. Reconciliation";
            }
            action("Recurring Journals")
            {
                ApplicationArea = All;
                Caption = 'Recurring Journals';
                Image = Edit;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page "Recurring General Journal";
            }
            action("Adjust Exchange Rates")
            {
                ApplicationArea = All;
                Caption = 'Adjust Exchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report "Exch. Rate Adjustment";
            }
            action("Adjust Inventory Cost Entries")
            {
                ApplicationArea = All;
                Caption = 'Adjust Inventory Cost Entries';
                RunObject = Report "Adjust Cost - Item Entries";
            }
            action("Post Inventory Cost to G/L")
            {
                ApplicationArea = All;
                Caption = 'Post Inventory Cost to G/L';
                RunObject = Report "Post Inventory Cost to G/L";
            }
            separator(Separator73)
            {
            }
            action("Create Reminders")
            {
                ApplicationArea = All;
                Caption = 'Create Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
            }
            action("Create Finance Charge Memos")
            {
                ApplicationArea = All;
                Caption = 'Create Finance Charge Memos';
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report "Create Finance Charge Memos";
            }
            separator(Separator80)
            {
            }
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Navigate';
                Image = Navigate;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page Navigate;
            }
        }
    }
}

