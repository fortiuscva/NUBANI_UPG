page 50057 "Nubani Sales Manager"
{
    // <changelog>
    //   <add id="NA0000" dev="ELYNCH" date="2006-09-15" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA6.00">Add local reports to homepage</add>
    //   <change id="NA0001" dev="ALL-E" date="2011-03-03" area="REPORTS SR" feature="VSTF253725"
    //     baseversion="NA6.00" releaseversion="NA7.00">
    //     Caption of Customer Top 10 List Report is Translated To Top  Customer List in the NA Local Version</change>
    // </changelog>

    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
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
                // }//B2BUPG IT IS VISIBLE FALSE
                systempart(Control31; MyNotes)
                {
                    ApplicationArea = all;
                }
            }
            group(Control1900724708)
            {
                // part(Control1000000001; "My Opportunities")//14005181 B2BUPG
                // {
                // }
                part(Control11; "Sales Performance")
                {
                    ApplicationArea = all;
                }
                part(Control6; "Sales Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control4; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = all;
                }
                part(Control1; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = all;
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
                Caption = 'Customer - &Order Summary';
                Image = Report;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                ApplicationArea = all;
                RunObject = Report "Customer - Order Summary";
            }
            action("Customer Top 10 List")
            {
                Caption = 'Customer Top 10 List';
                Image = Report;
                ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Customer - Top 10 List";
            }
            separator(Separator17)
            {
            }
            action("Customer Sales Statistics")
            {
                Caption = 'Customer Sales Statistics';
                Image = Report;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Customer Sales Statistics";
            }
            action("Customer/Item Statistics")
            {
                Caption = 'Customer/Item Statistics';
                Image = Report;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Customer/Item Statistics";
            }
            action("Cust./Item Stat. by Salespers.")
            {
                Caption = 'Cust./Item Stat. by Salespers.';
                Image = Report;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Cust./Item Stat. by Salespers.";
            }
            action("Salesperson Commissions")
            {
                Caption = 'Salesperson Commissions';
                Image = Report;
                ApplicationArea = all;
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
                Caption = 'Contact Summary';
                Image = Report;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                ApplicationArea = all;
                RunObject = Report "Contact - Company Summary";
            }
            action("Salesperson To Do")
            {
                Caption = 'Salesperson To Do';
                Image = Report;
                ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                //RunObject = Report "Salesperson - To-dos";//5057 5057 "Salesperson - Tasks" //B2BUPG
                RunObject = Report "Salesperson - Tasks";
            }
            action("Opportunity List")
            {
                Caption = 'Opportunity List';
                Image = Report;
                //Promoted = true;
                ApplicationArea = all;
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
                RunObject = Page "Product Expiration";
                ApplicationArea = all;
            }
            action("Reseller Cert Expirations")
            {
                Caption = 'Reseller Certificate Expirations';
                RunObject = Page "Reseller Cert Expiration";
                ApplicationArea = all;
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ApplicationArea = all;
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = all;
            }
            action(Open)
            {
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ShortCutKey = 'Return';
                ApplicationArea = all;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ApplicationArea = all;
            }
            action(Action16)
            {
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Invoice List";
                RunPageView = WHERE(Status = FILTER(Open));
                ShortCutKey = 'Return';
                ApplicationArea = all;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List- Admin";
                ApplicationArea = all;
            }
            action(Opportunities)
            {
                Caption = 'Opportunities';
                RunObject = Page "Opportunity List";
                ApplicationArea = all;
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
                    Caption = 'Cust. Invoice Discounts';
                    RunObject = Page "Cust. Invoice Discounts";
                    ApplicationArea = all;
                }
                action("Vend. Invoice Discounts")
                {
                    Caption = 'Vend. Invoice Discounts';
                    RunObject = Page "Vend. Invoice Discounts";
                    ApplicationArea = all;
                }
                action("Item Disc. Groups")
                {
                    Caption = 'Item Disc. Groups';
                    RunObject = Page "Item Disc. Groups";
                    ApplicationArea = all;
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
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
                ApplicationArea = all;
            }
            separator(Separator2)
            {
            }
            action("Sales &Prices")
            {
                Caption = 'Sales &Prices';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
                ApplicationArea = all;
            }
            action("Sales Line &Discounts")
            {
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
                ApplicationArea = all;
            }
        }
    }
}

