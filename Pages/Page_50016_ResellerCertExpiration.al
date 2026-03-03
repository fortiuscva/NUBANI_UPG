page 50016 "Reseller Cert Expiration"
{
    // //FP  Add Balance ($) Field to Customer List
    //       Added the code OnDrillDown on the Balance ($) field
    //       Added Customer Quick Edit to Customer Button
    //       Added Invoice choice to Sales Button
    //       Added History options to Sales Button
    //       Added 2 reports
    //       Promoted Quick Edit, History-Sales, into the Promoted Category of Process
    //       Added Customer Order Status to Customer menu
    //       Added Descending Ledger Entries
    // //FP6.2.01  Added Email communication Related Information under customer
    // //FP7.0.07  Added Shipment Performance to Reports Action tab
    // 
    // //FP7.0.07 07/27/12 Doug McIntosh, Cost Control Software
    //        -   Added code in OnOpenPage to filter list to SalesPerson (see comments below)
    //        -   Added Pct. of Credit Limit Used Indicator Bar and supporting var. & code
    // //POPN6.2  Add menu items to Vendor Button
    //         Add global variables

    ApplicationArea = All;
    Caption = 'Customer List';
    CardPageID = "Customer Card";
    Editable = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = SORTING("Cert Expiration Date")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    Style = AttentionAccent;
                    StyleExpr = CustomerFlag;
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Tax Exemption No."; Rec."Tax Exemption No.")
                {
                    ApplicationArea = all;
                }
                field("Cert Expiration Date"; Rec."Cert Expiration Date")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            // part("Customer Comments")
            // {
            //     SubPageLink = "Table Name" = CONST(Customer),
            //                   "No." = FIELD("No.");
            // }//B2BUPG Page Not Available
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1907829707; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1902613707; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = All;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        ApplicationArea = All;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Cust);
                            //DefaultDimMultiple.SetMultiCust(Cust);//B2BUPG  procedure is added in same page
                            SetMultiCust(Cust);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Bank Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Ship-&to Addresses")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("C&ontact")
                {
                    ApplicationArea = All;
                    Caption = 'C&ontact';
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                // action("Cross Re&ferences")
                // {
                //     Caption = 'Cross Re&ferences';
                //     Image = Change;
                //     RunObject = Page "Cross References";
                //     RunPageLink = "Cross-Reference Type" = CONST(Customer),
                //                   "Cross-Reference Type No." = FIELD("No.");
                //     RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");
                // }//B2BUPG Page not found
                separator(Separator17)
                {
                }
                action("&Quick Edit Customers")
                {
                    ApplicationArea = All;
                    Caption = '&Quick Edit Customers';
                    Image = EditList;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //RunObject = Page "Defaults Quick Edit Customers";//14004982 B2BUPG
                }
                // action("<Action1100768007>")
                // {
                //     Caption = 'Email Communication';
                //     Image = SendAsPDF;
                //     RunObject = Page "Email Communications New";//14005169 B2BUPG
                //     RunPageLink = "No." = FIELD("No.");
                //     RunPageView = SORTING(Type, "No.")
                //                   WHERE(Type = CONST(Customer));
                // }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("<Action1240070000>")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries &Descending';
                    Image = LedgerEntries;

                    trigger OnAction()
                    begin
                        //FP
                        CustLedgerEntryT.SETCURRENTKEY("Customer No.", "Posting Date");
                        CustLedgerEntryT.SETRANGE("Customer No.", Rec."No.");
                        Ok := CustLedgerEntryT.ASCENDING(false);
                        if CustLedgerEntryT.FINDFIRST then
                            PAGE.RUN(PAGE::"Customer Ledger Entries", CustLedgerEntryT);
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("S&ales")
                {
                    ApplicationArea = All;
                    Caption = 'S&ales';
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("Entry Statistics")
                {
                    ApplicationArea = All;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("<Action1100768001>")
                {
                    ApplicationArea = All;
                    Caption = 'Customer &Order Status';
                    Image = StatisticsDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Order Status";
                    RunPageLink = "No." = FIELD("No.");
                }
                // action("Statistics by C&urrencies")
                // {
                //     Caption = 'Statistics by C&urrencies';
                //     Image = Currencies;
                //     RunObject = Page "Customer Stats. by Currencies";
                //     RunPageLink = "No." = FIELD("No."),
                //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                //                   "Date Filter" = FIELD("Date Filter");
                // }//B2B UPG page not found
                action("Item &Tracking Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    var
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                    begin
                        //ItemTrackingMgt.CallItemTrackingEntryForm(1, "No.", '', '', '', '', '');B2BUPG
                        EventsandSubscriber.CallItemTrackingEntryForm(1, Rec."No.", '', '', '', '', '');
                    end;
                }
                separator(Separator1100768050)
                {
                }
                // action("<Action1100768003>")
                // {
                //     Caption = 'Pop-Up Note Entry';
                //     Image = Note;

                //     trigger OnAction()
                //     begin
                //         //POPN
                //         if grenote.FINDLAST then
                //             EntryNo := grenote."Entry No." + 1
                //         else
                //             EntryNo := 1;

                //         NotesT.INIT;
                //         NotesT."Entry No." := EntryNo;
                //         NotesT."User ID Insert" := USERID;
                //         NotesT.INSERT;
                //         NotesT.Type := NotesT.Type::Customer;
                //         NotesT."Vend/Cust No." := "No.";
                //         NotesT."Creation Date" := TODAY;
                //         NotesT.VALIDATE("Effective Date", TODAY);
                //         NotesT."Sales Documents" := true;
                //         NotesT."Service Documents" := true;
                //         NotesT.MODIFY;
                //         COMMIT;
                //         if PAGE.RUNMODAL(PAGE::"Note Card", NotesT) = ACTION::LookupCancel then
                //             NotesT.DELETE;
                //     end;
                // }//B2B
                // action("<Action1100768004>")
                // {
                //     Caption = 'Pop-&Up Notes';
                //     Image = Note;
                //     RunObject = Page "Note Display";//14005018 B2BUPG
                //     RunPageLink = "Vend/Cust No." = FIELD("No.");
                //     RunPageView = SORTING(Type, "Vend/Cust No.", "No.", Effective, Expired, "Sales Documents", "Purchase Documents")
                //                   WHERE(Type = CONST(Customer),
                //                         Effective = CONST(true),
                //                         Expired = CONST(false));
                // }
            }
            group(ActionGroup24)
            {
                Caption = 'S&ales';
                Image = Sales;
                action("Invoice &Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                }
                action(Prices)
                {
                    ApplicationArea = All;
                    Caption = 'Prices';
                    Image = Price;
                    // RunObject = Page "Sales Prices";
                    // RunPageLink = "Sales Type" = CONST(Customer),
                    //               "Sales Code" = FIELD("No.");
                    // RunPageView = SORTING("Sales Type", "Sales Code");
                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, Enum::"Price Amount Type"::Price);
                    end;
                }
                action("Line Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    // RunObject = Page "Sales Line Discounts";
                    // RunPageLink = "Sales Type" = CONST(Customer),
                    //               "Sales Code" = FIELD("No.");
                    // RunPageView = SORTING("Sales Type", "Sales Code");

                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, Enum::"Price Amount Type"::Discount);
                    end;
                }
                action("Prepa&yment Percentages")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Sales Type" = CONST(Customer),
                                  "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                }
                action("S&td. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'S&td. Cust. Sales Codes';
                    Image = CodesList;
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Quotes)
                {
                    ApplicationArea = All;
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                action(Orders)
                {
                    ApplicationArea = All;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                action(Invoice)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice';
                    RunObject = Page "Sales Invoice List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                }
                action("Return Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Image = Documents;
                    action("Issued &Reminders")
                    {
                        ApplicationArea = All;
                        Caption = 'Issued &Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        ApplicationArea = All;
                        Caption = 'Issued &Finance Charge Memos';
                        Image = FinChargeMemo;
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                    }
                }
                action("Blanket Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                }
            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = CreditCard;
                group("Credit Cards")
                {
                    Caption = 'Credit Cards';
                    Image = CreditCard;
                    // action("C&redit Cards")
                    // {
                    //     Caption = 'C&redit Cards';
                    //     Image = CreditCard;
                    //     RunObject = Page "DO Payment Credit Card List";//828 page not found
                    //     RunPageLink = "Customer No." = FIELD("No.");
                    // }//B2BUPG
                    // action("Credit Cards Transaction Lo&g Entries")
                    // {
                    //     Caption = 'Credit Cards Transaction Lo&g Entries';
                    //     Image = CreditCardLog;
                    //     RunObject = Page "DO Payment Trans. Log Entries";//829 Page not found
                    //     RunPageLink = "Customer No." = FIELD("No.");
                    // }//B2BUPG
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;
                action("Service Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Customer No.");
                }
                action("Ser&vice Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                }
                action("Service &Items")
                {
                    ApplicationArea = All;
                    Caption = 'Service &Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                }
                separator(Separator1100768003)
                {
                }
                // action("&Print Invoice and Credit Hist")
                // {
                //     Caption = '&Print Invoice and Credit Hist';
                //     Image = Print;

                //     trigger OnAction()
                //     begin
                //         //FP
                //         SETRANGE("No.", "No.");
                //         REPORT.RUN(REPORT::"Customer Sales History", true, true, Rec);//14005136 
                //         SETRANGE("No.");
                //     end;
                // }//B2B UPG
                action("<Action1100768005>")
                {
                    ApplicationArea = All;
                    Caption = '&View Sales History';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Recent Sales History";//14005135 //B2BUPG //50201
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                }//B2BUPG
                action("<Action1100768006>")
                {
                    // Caption = 'View Credit &History';
                    // Image = View;
                    // RunObject = Page "Recent Sales Credit History";//14005136 B2BUPG
                    // RunPageLink = "Sell-to Customer No." = FIELD("No.");
                }



            }
        }
        area(creation)
        {
            action("Blanket Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Blanket Sales Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Blanket Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Quote")
            {
                ApplicationArea = All;
                Caption = 'Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Sales Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 42;
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Sales Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Credit Memo";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Sales Return Order")
            {
                ApplicationArea = All;
                Caption = 'Sales Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Return Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Quote")
            {
                ApplicationArea = All;
                Caption = 'Service Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Quote";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Invoice")
            {
                ApplicationArea = All;
                Caption = 'Service Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Invoice";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Order")
            {
                ApplicationArea = All;
                Caption = 'Service Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Order";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Service Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Service Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Credit Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action(Reminder)
            {
                ApplicationArea = All;
                Caption = 'Reminder';
                Image = Reminder;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page Reminder;
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
            action("Financial Charge Memo")
            {
                ApplicationArea = All;
                Caption = 'Financial Charge Memo';
                Image = FinChargeMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Finance Charge Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            action("Cash Receipt Journal")
            {
                ApplicationArea = All;
                Caption = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Cash Receipt Journal";
            }
            action("Sales Journal")
            {
                ApplicationArea = All;
                Caption = 'Sales Journal';
                Image = Journals;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Journal";
            }
        }
        area(reporting)
        {
            group(General)
            {
                Caption = 'General';
                action("Customer Register")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Register';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Register";
                }
                action("Sales Dashboard")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Dashboard';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //RunObject = Report "Sales Dashboard RT";//14005159
                }
                action("Customer - Top 10 List")
                {
                    ApplicationArea = All;
                    Caption = 'Customer - Top 10 List';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    // RunObject = Report "Customer Top 10 List";//B2BUPG
                    RunObject = Report "Customer - Top 10 List";
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                action("Customer - Order Summary")
                {
                    ApplicationArea = All;
                    Caption = 'Customer - Order Summary';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Summary";
                }
                action("Customer - Order Detail")
                {
                    ApplicationArea = All;
                    Caption = 'Customer - Order Detail';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Detail";
                }
                action("Customer - Sales List")
                {
                    ApplicationArea = All;
                    Caption = 'Customer - Sales List';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Sales List";
                }
                action("Sales Statistics")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Statistics';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Sales Statistics";
                }
            }
            group("Financial Management")
            {
                Caption = 'Financial Management';
                Image = Report;
                action("Customer - Detail Trial Bal.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer - Detail Trial Bal.';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Detail Trial Bal.";
                }
                action(Statement)
                {
                    Caption = 'Statement';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report Statement;
                }
                action(Action1903839806)
                {
                    Caption = 'Reminder';
                    Image = Reminder;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report Reminder;
                }
                action("Aged Accounts Receivable")
                {
                    Caption = 'Aged Accounts Receivable';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                }
                action("Customer - Balance to Date")
                {
                    Caption = 'Customer - Balance to Date';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Balance to Date";
                }
                action("Customer - Trial Balance")
                {
                    Caption = 'Customer - Trial Balance';
                    Image = Report;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Trial Balance";
                }
                action("Customer - Payment Receipt")
                {
                    Caption = 'Customer - Payment Receipt';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Payment Receipt";
                }
            }
            action("Shipment Performance")
            {
                Caption = 'Shipment Performance';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "Shipment Performance";//14005138-report id B2BUPG
            }
            action("Customer Sales History")
            {
                Caption = 'Customer Sales History';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                // RunObject = Report "Customer Sales History";//14005136 report id B2BUPG
            }
            action("Commission Report")
            {
                Caption = 'Commission Report';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "Commission Report - Gross";//14005150 report id B2BUPG
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //FP7.0.07 Start
        //Drive Indicator Bar...
        if Rec."Credit Limit (LCY)" > 0 then //Avoid Div. by Zero err in next line
            "Pct of Credit Limit" := (Rec."Balance (LCY)" / Rec."Credit Limit (LCY)") * 100
        else
            "Pct of Credit Limit" := 0;

        //CustomerFlag := FALSE;
        //IF Blocked OR (("Credit Limit (LCY)" > 0) AND ("Pct of Credit Limit" > 100))) THEN
        //  CustomerFlag := TRUE;

        //FP7.0.07 Finish
    end;

    trigger OnOpenPage()
    begin
        //FP7.0.07 Start
        //If there is an associated Salesperson/Purch Code for this USERID then use it.
        //This is used primarily to filter lists for the Salesperson Role Center
        UserPersonal.SETRANGE("User ID", USERID);
        if UserPersonal.FINDFIRST then begin
            if User.GET(USERID) then begin
                if User."Salespers./Purch. Code" <> '' then
                    Rec.SETRANGE("Salesperson Code", User."Salespers./Purch. Code");
            end;
        end;
        //FP7.0.07 Finish
    end;

    var
        CustLedgerEntryT: Record "Cust. Ledger Entry";
        Ok: Boolean;
        "--FP--": Integer;
        UserPersonal: Record "User Personalization";
        //"Profile": Record "Profile";//Support for System Profiles has been removed. Profiles should now be defined in AL extensions and should be accessed through the All Profile virtual table.';//B2BUPG
        User: Record "User Setup";
        "Pct of Credit Limit": Decimal;

        CustomerFlag: Boolean;
        "--POPN--": Integer;
        //grenote: Record Note;//14005020 table Id B2BUPG
        EntryNo: Integer;
        //NotesT: Record Note;//14005020 table Id B2BUPG
        TempDefaultDim2: record "Default Dimension";//B2BUPG
        TempDefaultDim3: Record "Default Dimension";//B2BUPG
        TotalRecNo: Integer;//B2BUPG
        EventsandSubscriber: codeunit EventsandSubscribers;


    procedure GetSelectionFilter(): Text
    var
        Cust: Record Customer;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        exit(SelectionFilterManagement.GetSelectionFilterForCustomer(Cust));
    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;


    procedure SetMultiCust(VAR Cust: Record Customer)//B2BUPG
    begin

        TempDefaultDim2.DELETEALL;
        IF Cust.FIND('-') THEN
            REPEAT
                CopyDefaultDimToDefaultDim(DATABASE::Customer, Cust."No.");
            UNTIL Cust.NEXT = 0;
    end;


    procedure CopyDefaultDimToDefaultDim(TableID: Integer; No: Code[20])
    var
        DefaultDim: record "Default Dimension";
    begin
        TotalRecNo := TotalRecNo + 1;
        TempDefaultDim3."Table ID" := TableID;
        TempDefaultDim3."No." := No;
        TempDefaultDim3.INSERT;

        DefaultDim.SETRANGE("Table ID", TableID);
        DefaultDim.SETRANGE("No.", No);
        IF DefaultDim.FIND('-') THEN
            REPEAT
                TempDefaultDim2 := DefaultDim;
                TempDefaultDim2.INSERT;
            UNTIL DefaultDim.NEXT = 0;
    end;


}//B2BUPG

