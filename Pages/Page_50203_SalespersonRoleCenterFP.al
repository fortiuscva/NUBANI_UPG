page 50203 "Salesperson Role Center - FP"//14005153
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-09-15" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA6.00">Add local reports to homepage</add>
    //   <change id="NA0001" dev="ALL-E" date="2011-03-03" area="REPORTS SR" feature="VSTF253725"
    //     baseversion="NA6.00" releaseversion="NA7.00">
    //     Caption of Customer Top 10 List Report is Translated To Top  Customer List in the NA Local Version</change>
    // </changelog>
    ApplicationArea = All;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(Control1000000000; "Salesperson Activities")
                {
                    ApplicationArea = All;
                }
                // part(Control21; "Connect Online")
                // {
                //     Visible = false;
                // }B2BUPG
                systempart(Control31; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                // part(Control1000000001; "My Opportunities")//14005181
                // {
                // }B2BUPG
                part(Control11; "Sales Performance")
                {
                    ApplicationArea = All;
                }
                part(Control6; "Sales Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control4; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = All;
                }
                part(Control1; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Order Summary';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Customer - Order Summary";
            }
            // action("Customer Top 10 List")
            // {
            //     Caption = 'Customer Top 10 List';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Report "Customer Top 10 List";//B2BUPG
            // }
            separator(Separator17)
            {
            }
            action("Customer Sales Statistics")
            {
                ApplicationArea = All;
                Caption = 'Customer Sales Statistics';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Customer Sales Statistics";
            }
            action("Customer/Item Statistics")
            {
                ApplicationArea = All;
                Caption = 'Customer/Item Statistics';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Customer/Item Statistics";
            }
            action("Cust./Item Stat. by Salespers.")
            {
                ApplicationArea = All;
                Caption = 'Cust./Item Stat. by Salespers.';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Cust./Item Stat. by Salespers.";
            }
            action("Salesperson Commissions")
            {
                ApplicationArea = All;
                Caption = 'Salesperson Commissions';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Salesperson Commissions";
            }
            separator(Separator22)
            {
            }
            action("Contact Summary")
            {
                ApplicationArea = All;
                Caption = 'Contact Summary';
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Contact - Company Summary";
            }
            action("Salesperson To Do")
            {
                ApplicationArea = All;
                Caption = 'Salesperson To Do';
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                //RunObject = Report "Salesperson - To-dos";//5057
            }
            action("Opportunity List")
            {
                ApplicationArea = All;
                Caption = 'Opportunity List';
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Opportunity - List";
            }
            action("Campaign - &Details")
            {
                ApplicationArea = All;
                Caption = 'Campaign - &Details';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Campaign - Details";
            }
        }
        area(embedding)
        {
            action("Product Expiration List")
            {
                ApplicationArea = All;
                RunObject = Page "Product Expiration";
            }
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ShortCutKey = 'Return';
            }
            action("Sales Invoices")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }
            action(Action16)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Invoice List";
                RunPageView = WHERE(Status = FILTER(Open));
                ShortCutKey = 'Return';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List-Salesperson";
            }
            action("Item Recevied by Qty and Date")
            {
                ApplicationArea = All;
                //Promoted = false;
                RunObject = Page "Item Recd  by Qty and Date";
            }
            action(Opportunities)
            {
                ApplicationArea = All;
                Caption = 'Opportunities';
                RunObject = Page "Opportunity List";
            }
        }
        area(sections)
        {
            group("Administration Sales/Purchase")
            {
                Caption = 'Administration Sales/Purchase';
                Image = AdministrationSalesPurchases;
                action("Cust. Invoice Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Cust. Invoice Discounts';
                    RunObject = Page "Cust. Invoice Discounts";
                }
                action("Vend. Invoice Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Vend. Invoice Discounts';
                    RunObject = Page "Vend. Invoice Discounts";
                }
                action("Item Disc. Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Item Disc. Groups';
                    RunObject = Page "Item Disc. Groups";
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
            action("Sales Price &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
            }
            separator(Separator2)
            {
            }
            action("Sales &Prices")
            {
                ApplicationArea = All;
                Caption = 'Sales &Prices';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
            }
            action("Sales Line &Discounts")
            {
                ApplicationArea = All;
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
            }
        }
    }
}

