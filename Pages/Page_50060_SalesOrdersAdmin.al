page 50060 "Sales Orders-Admin"
{
    // //FP  Added Posting Description field
    //       Added Sales History to Line button
    //       Added the field Ready for Shipping
    // //FP6.2.01   Added 7 globals for SendToPDF
    //              Added Email Tab and 2 page actions
    // //FP6.2.06  Added ability to chose where Temp Directory is for SaveAsPDF
    // //FP7.0.08  Various Changes to SendAsPDF Functionality
    //     - CR Global Removed
    //     - ImgTag Global Created
    //     - Removed Length attribute on "BodyText" Global
    // 
    // //FP7.0.09
    //   - More Changes to SendAsPDF Functionality to support "Substitutions" (See, Func. "SendAsPDFSubstitions(...)"
    //     - Replaced ImgTag Creation with more flexible Top & Bottom Banners
    //     - Added Function "SendAsPDFSubstitutions(...)"
    //     - Added Globals "Salesperson", "ShippingAgent", "ShippingAgentServices", "EmailSubj", "ExtNo" and "Aux1"
    // 
    // ---------------------------------------------------------------------------------------------
    // 
    // NUB1.01,SP2357,09/17/12,DRH:  New action to open Quick Item Entry.
    // NUB1.02,04/27/18,SK: Added code at OnOpenPage() to filter on Sales Person code.
    // NUB1.03,07/26/18,SK: Added code "<Action148> - OnAction()" to Check Item Inventory before creating Pick & delcared local variables.
    // NUB1.04,07/27/18,SK: Pullout "No. of Pallets".
    //                      Added new action button as "PalletsCalculator"
    //                      Added code "PalletsCalculator - OnAction()" to update "No. of Pallets" in Sales Header & Declared Global & Local Variables.
    //                      Added code "<Action148> - OnAction()" to Check Item Tracking Lines before creating Pick & delcared local variables.
    // NUB1.05,10/01/18,SK: Added new factbox as "Item Details by PO".
    // NUB1.06,01/16/19,SK: Added code at "Post - OnAction()" & "<Action76> - OnAction()".
    // NUB1.07,07/01/19,ST: Modifications handled to show if there is an open invt. pick exists and if there is quantity already shipped on the order.
    //                       - Added new flow fields "Invt. Pick Exists", "Order Shipped".
    // NUB1.08,12/04/19,SK: Pullout new fields as 50011/Pallets Spaces, 50012/Shipping Status.
    // NUB1.09,05/06/20,ST: Enhancements to print pallet label.
    //                       - Added field "Pallet Count".
    //                       - Added button "Print Label".

    Caption = 'Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec.GETFILTER(Rec."Sell-to Contact No.") = xRec."Sell-to Contact No." then
                            if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then
                                Rec.SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    QuickEntry = false;
                    ApplicationArea = All;

                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    QuickEntry = false;
                    ApplicationArea = All;

                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    Caption = 'Sell-to State / ZIP Code';
                    ApplicationArea = All;

                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;

                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    QuickEntry = false;
                    ApplicationArea = All;

                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ApplicationArea = All;

                }
                field("Document Date"; Rec."Document Date")
                {
                    QuickEntry = false;
                    ApplicationArea = All;

                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;

                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;

                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Quote No."; Rec."Quote No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Your Reference"; Rec."Your Reference")
                {
                    Caption = 'Su/Ntra. ref.';
                    ApplicationArea = All;

                }
                field("External Document No."; Rec."External Document No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    QuickEntry = false;
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Allow Backorder"; Rec."Allow Backorder")
                {
                    ApplicationArea = All;
                }
                field("No. of Pallets"; Rec."No. of Pallets")
                {
                    ApplicationArea = All;
                }
                field("Invt. Pick Exists"; Rec."Invt. Pick Exists")
                {
                    ApplicationArea = All;
                }
                field("Order Shipped"; Rec."Order Shipped")
                {
                    ApplicationArea = All;

                }


                field("Pallets Spaces"; Rec."Pallets Spaces")
                {
                    ApplicationArea = All;
                }
                field("Shipping Status"; Rec."Shipping Status")
                {
                    ApplicationArea = All;
                }
                field("Pallet Count"; Rec."Pallet Count")
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                    Caption = 'State / ZIP Code';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                // field("Credit Card No."; Rec."Credit Card No.")
                // {
                // }
                // field(GetCreditcardNumber; Rec.GetCreditcardNumber)
                // {
                //     Caption = 'Cr. Card Number (Last 4 Digits)';
                // }B2BUPG
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to State / ZIP Code';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                {
                    ApplicationArea = All;
                }
                field("Ready for Shipping"; Rec."Ready for Shipping")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
#pragma warning disable AL0432
                field("Package Tracking No."; Rec."Package Tracking No.")
#pragma warning restore AL0432
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Rec."Shipping Advice" <> xRec."Shipping Advice" then
                            if not CONFIRM(Text001, false, Rec.FIELDCAPTION("Shipping Advice")) then
                                ERROR(Text002);
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        if ChangeExchangeRate.RUNMODAL = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            group(Prepayment1)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Include Tax"; Rec."Prepmt. Include Tax")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            // part(Control1100796002; "Sales Header Factbox")//14005186 B2BUPG
            // {
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "No." = FIELD("No.");
            //     SubPageView = SORTING("Document Type", "No.")
            //                   ORDER(Ascending);
            // }//B2BUPG
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Lot Numbers by Bin FactBox"; "Lot Numbers by Bin FactBox")
            {
                ApplicationArea = All;
                Caption = 'Lot Numbers by Bin FactBox';
                Provider = SalesLines;
                SubPageLink = "Item No." = FIELD("No."),
                              "Variant Code" = FIELD("Variant Code");
            }
            part("Item Details by PO"; "Item Det. by PO FactBox")
            {
                ApplicationArea = All;
                Caption = 'Item Details by PO';
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control1906127307; "Sales Line FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control1906354007; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part(Control1907012907; "Resource Details FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1901796907; "Item Warehouse FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
            part(Control1100796006; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100796005; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100796004; "Item Picture Factbox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Order Statistics-Admin";
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        if Rec."Tax Area Code" = '' then
                            PAGE.RUNMODAL(PAGE::"Sales Order Statistics-Admin", Rec)
                        else
                            PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("A&pprovals")
                {
                    ApplicationArea = All;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                // action("Credit Cards Transaction Lo&g Entries")
                // {
                //     Caption = 'Credit Cards Transaction Lo&g Entries';
                //     Image = CreditCardLog;
                //     RunObject = Page "DO Payment Trans. Log Entries";
                //     RunPageLink = "Document No." = FIELD("No."),
                //                   "Customer No." = FIELD("Bill-to Customer No.");//829 B2BUPG PAGE not found
                // }//B2BUPG
                action("Assembly Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List v1";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    // RunObject = Page "Whse. Shipment Lines";
                    // RunPageLink = "Source Type" = CONST(37),
                    //               "Source Subtype" = FIELD("Document Type"),
                    //               "Source No." = FIELD("No.");
                    // RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");

                    trigger OnAction()
                    var
                        WhsShipmentLines: Page "Whse. Shipment Lines";
                        WhsShipLineRec: Record "Warehouse Shipment Line";
                    begin
                        WhsShipLineRec.SetCurrentKey("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                        WhsShipLineRec.SetRange("Source Type", 37);
                        WhsShipLineRec.SetRange("Source Subtype", Rec."Document Type".AsInteger());
                        WhsShipLineRec.SetRange("Source No.", Rec."No.");
                        WhsShipmentLines.SetTableView(WhsShipLineRec);
                        WhsShipmentLines.Run();
                    end;
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
        }
        area(processing)
        {
            group(ActionGroup21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        //ApprovalMgt: Codeunit "Approvals Management";B2BUPG
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        //if ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) then//B2BUPG
                        if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
                action("Quick Item Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Quick Item Entry';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        QuickItem: Page "Quick Item Entry";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        QuickItem.SetValues(Rec."No.", Rec."Sell-to Customer No.", Rec."Document Type");
                        QuickItem.RUN;
                    end;
                }
                action(PalletsCalculator)
                {
                    ApplicationArea = All;
                    Caption = 'Pallets Calculator';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesLineLRec: Record "Sales Line";
                        UOMlRec: Record "Unit of Measure";
                    begin
                        //NUB1.05 Start
                        CLEAR(TotalPallets);

                        SalesLineLRec.RESET;
                        SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                        SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                        SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                        SalesLineLRec.SETFILTER("No.", '<>%1', '');
                        if SalesLineLRec.FINDSET then begin
                            repeat
                                if UOMlRec.GET(SalesLineLRec."Unit of Measure Code") then
                                    if UOMlRec."Pallet Per" = 0 then
                                        ERROR('Please fill Pallets Per for %1 UOM', UOMlRec.Code);

                                TotalPallets += (SalesLineLRec."Outstanding Quantity" / UOMlRec."Pallet Per");
                            until SalesLineLRec.NEXT = 0;
                        end;

                        Rec."No. of Pallets" := TotalPallets;
                        //NUB1.05 ENd
                    end;
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Demand Overview';
                    Image = Forecast;

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                    begin
                        DemandOverview.SetCalculationParameter(true);
                        DemandOverview.SetParameters(0D, 1, Rec."No.", '', '');
                        DemandOverview.RUNMODAL;
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
            }
            group(Request)
            {
                Caption = 'Request';
                Image = SendApprovalRequest;
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Management";
                    begin
                        //ApprovalMgt.SendSalesApprovalRequest(Rec) ;//B2BUPG
                        if ApprovalMgt.CheckSalesApprovalPossible(Rec) then
                            ApprovalMgt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Management";//B2BUPG
                    begin
                        //if ApprovalMgt.OnCancelSalesApprovalRequest(Rec) then;
                        ApprovalMgt.OnCancelSalesApprovalRequest(Rec);

                    end;
                }
                group(Authorize)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;
                    action(Action256)
                    {
                        ApplicationArea = All;
                        Caption = 'Authorize';
                        Image = AuthorizeCreditCard;

                        trigger OnAction()
                        begin
                            //Authorize;/// In these action we are using "DO Payment Trans. Log Entry" table which is removed in higer version B2BUPG 
                        end;
                    }
                    action("Void A&uthorize")
                    {
                        ApplicationArea = All;
                        Caption = 'Void A&uthorize';
                        Image = VoidCreditCard;

                        trigger OnAction()
                        begin
                            //Void; In these action we are using "DO Payment Trans. Log Entry" table which is removed in higer version B2BUPG 
                        end;
                    }
                }
            }
            group(ActionGroup3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        "-NUB1.03-": Integer;
                        SalesLineLRec: Record "Sales Line";
                        TempSalesLineLRec: Record "Sales Line" temporary;
                        ItemLRec: Record Item;
                    begin
                        //NUB1.03 Start
                        //Checking the Item Inventory before creating Pick.
                        Rec.TESTFIELD(Status, Rec.Status::Released);

                        SalesLineLRec.RESET;
                        SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                        SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                        SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                        SalesLineLRec.SETFILTER("No.", '<>%1', '');
                        if SalesLineLRec.FINDSET then begin
                            repeat
                                if ItemLRec.GET(SalesLineLRec."No.") then
                                    ItemLRec.CALCFIELDS(Inventory);

                                if ItemLRec.Inventory = 0 then begin
                                    TempSalesLineLRec.INIT;
                                    TempSalesLineLRec.TRANSFERFIELDS(SalesLineLRec);
                                    TempSalesLineLRec.INSERT;
                                end;
                            until SalesLineLRec.NEXT = 0;
                        end;

                        if TempSalesLineLRec.COUNT > 0 then
                            PAGE.RUNMODAL(PAGE::"Sales Lines", TempSalesLineLRec);
                        //NUB1.03 End

                        //NUB1.04 Start
                        SalesLineLRec.RESET;
                        SalesLineLRec.SETRANGE("Document Type", Rec."Document Type");
                        SalesLineLRec.SETRANGE("Document No.", Rec."No.");
                        SalesLineLRec.SETRANGE(Type, SalesLineLRec.Type::Item);
                        SalesLineLRec.SETFILTER("No.", '<>%1', '');
                        if SalesLineLRec.FINDSET then begin
                            repeat
                                ResEntryRecGbl.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
                                ResEntryRecGbl.SETRANGE("Source ID", SalesLineLRec."Document No.");
                                ResEntryRecGbl.SETRANGE("Source Ref. No.", SalesLineLRec."Line No.");
                                ResEntryRecGbl.CALCSUMS("Qty. to Handle (Base)");
                                QtyToHandleVar := ABS(ResEntryRecGbl."Qty. to Handle (Base)");

                                if ItemLRec.GET(SalesLineLRec."No.") then;

                                if (QtyToHandleVar = 0) and (ItemLRec."Item Tracking Code" <> '') then begin
                                    TempSalesLineLRec.INIT;
                                    TempSalesLineLRec.TRANSFERFIELDS(SalesLineLRec);
                                    TempSalesLineLRec.INSERT;
                                end;
                            until SalesLineLRec.NEXT = 0;
                        end;

                        if TempSalesLineLRec.COUNT > 0 then
                            PAGE.RUNMODAL(PAGE::"Sales Lines", TempSalesLineLRec);
                        //NUB1.04 End


                        Rec.CreateInvtPutAwayPick;

                        if not Rec.FIND('=><') then
                            Rec.INIT;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT;
                    end;
                }
                separator(Separator1240070003)
                {
                }
                action(SendAsPDF)
                {
                    ApplicationArea = All;
                    Caption = 'SendAsPDF';
                    Image = SendEmailPDF;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Mail: Codeunit Mail;
                        Name: Text;
                        FileName: Text;
                        ToFile: Text;
                        //ReportHelper: Codeunit ReportHelper;//B2BUPG
                        //EmailTracking: Record "Email Tracking";//B2BUPG
                        "--FP7.0.09---": Integer;
                        DialogOption: Option Always,Never,Ask;
                        ShowDialog: Boolean;
                    begin
                        //FP6.2.01 begin
                        // CurrPage.SETSELECTIONFILTER(SalesHeader);
                        // Name := STRSUBSTNO('Order No. %1.pdf', Rec."No."); //Default Subject is PDF FIlename
                        // ToFile := Name;
                        // FileName := TEMPORARYPATH + ToFile;

                        //FP7.0.09 Start
                        //Document-Type-Specific Stuff here...

                        if Rec."Shipping Agent Code" <> '' then begin
                            if ShippingAgent.GET(Rec."Shipping Agent Code") then
                                Aux1 := ', via ' + ShippingAgent.Name;
                            if Rec."Shipping Agent Service Code" <> '' then begin
                                if ShippingAgentServices.GET(Rec."Shipping Agent Code", Rec."Shipping Agent Service Code") then
                                    Aux1 := Aux1 + ', ' + ShippingAgentServices.Description;
                            end;
                        end;

                        if Rec."External Document No." <> '' then begin
                            ExtNo := Rec."External Document No.";
                        end;
                        //FP7.0.09 Finish

                        // ReportHelperCU.GetEmailAddressesSO(Rec);
                        // EmailTracking.GET(EmailTracking."Transaction Type"::Sales, EmailTracking."Document Type"::Order, "No.");

                        //FP7.0.09 Start

                        BodyText := '';

                        //FP7.0.09 Start
                        //ImgTag := ReportHelperCU.CreateImgTag; //Form an HTML '<img>' Tag, if appropriate
                        //ReportHelperCU.HandleTopImg(BodyText,ImgTag); //If desired, Start email Body with Logo on Top, with two Carriage Returns after
                        //FP7.0.09 Finish

                        // EmailCommT.SETRANGE(REC.Type, EmailCommT.Type::Customer);
                        // EmailCommT.SETRANGE(Rec."No.", Rec."Sell-to Customer No.");
                        // if EmailCommT.FINDFIRST then begin
                        //     if (EmailCommT."Order Email Body Salutation" <> '') and (EmailCommT."Order Email Body Text" <> '') then begin
                        //         //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                        //         BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                        //         EmailSubj := EmailCommT."Order Email Subject";
                        //     end;

                        // if (EmailCommT."Order Email Body Salutation" <> '') and (EmailCommT."Order Email Body Text" = '') then begin
                        //     EmailCommT2.RESET;
                        //     EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                        //     EmailCommT2.SETRANGE(Rec."No.", 'DEFAULT');
                        //     if EmailCommT2.FINDFIRST then begin
                        //         //      BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
                        //         BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
                        //         EmailSubj := EmailCommT2."Order Email Subject";
                        //     end;
                        // end;

                        // if (EmailCommT."Order Email Body Salutation" = '') and (EmailCommT."Order Email Body Text" <> '') then begin
                        //     EmailCommT2.RESET;
                        //     EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                        //     EmailCommT2.SETRANGE(Rec."No.", 'DEFAULT');
                        //     if EmailCommT2.FINDFIRST then begin
                        //         //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                        //         BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                        //         EmailSubj := EmailCommT."Order Email Subject"
                        //     end;
                        // end;

                        // if (EmailCommT."Order Email Body Salutation" = '') and (EmailCommT."Order Email Body Text" = '') then begin
                        //     EmailCommT2.RESET;
                        //     EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                        //     EmailCommT2.SETRANGE(Rec."No.", 'DEFAULT');
                        //     if EmailCommT2.FINDFIRST then begin
                        //         //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
                        //         BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
                        //         EmailSubj := EmailCommT2."Order Email Subject"
                        //     end;
                        // end;

                        // end else begin  //EmailCommT Record for this CUSTOMER NOT Found
                        //     EmailCommT.RESET;
                        //     EmailCommT.SETRANGE(Type, EmailCommT.Type::Default);
                        //     EmailCommT.SETRANGE("No.", 'DEFAULT');
                        //     if EmailCommT.FINDFIRST then begin
                        //         //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                        //         BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                        //         EmailSubj := EmailCommT."Order Email Subject";
                        //     end;
                        // end;

                        //FP7.0.09 Next Line REM-ed out
                        //ReportHelperCU.HandleBotImg(BodyText,ImgTag); //Finish with Image on Bottom, if desired, followed by a Carriage Return

                        //DialogOption := EmailCommT."Open Order Email";

                        //FP7.0.09 Finish

                        //FP7.0.09 Start
                        BodyText := SendAsPDFSubstitutions(BodyText, false); //"merge" arguments into Email Body
                        if (EmailSubj <> '') then
                            Name := SendAsPDFSubstitutions(EmailSubj, true); //"merge" arguments into Subject, too...

                        // ReportHelperCU.AddSlogan(BodyText); //Add Random Marketing Slogan to Body from Master File Setup Defaults
                        // ReportHelperCU.AddBanners(BodyText); //Add Top and Bottom Banners to Body from Master File Setup Defaults

                        ShowDialog := true; //Default to Opening Outlook on Send
                        if DialogOption = DialogOption::Never then
                            ShowDialog := false
                        else
                            if DialogOption = DialogOption::Ask then
                                ShowDialog := CONFIRM('Do you want to open the email before sending?', true);
                        //FP7.0.09 Finish

                        //     ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
                        //     ReportSelections.SETFILTER("Report ID", '<>0');
                        //     if ReportSelections.FINDFIRST then
                        //         ReportID := ReportSelections."Report ID";

                        //     REPORT.SAVEASPDF(ReportID, FileName, SalesHeader);
                        //     ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);
                        //     Mail.NewMessage(EmailTracking."Order Ackn. Send Email To", EmailTracking."Order Ackn. CC Email To", Name, BodyText, ToFile, ShowDialog);
                        //     FILE.ERASE(FileName);
                        //     //FP6.2.01 end
                    end;
                }
                // action(SaveAsPDF)
                // {
                //     Caption = 'SaveAsPDF';
                //     Image = PrintForm;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         CurrPage.SETSELECTIONFILTER(SalesHeader);

                //         ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
                //         ReportSelections.SETFILTER("Report ID", '<>0');
                //         if ReportSelections.FINDFIRST then
                //             ReportID := ReportSelections."Report ID";

                //         //FP6.2.06
                //         DefSetup.GET;
                //         //REPORT.SAVEASPDF(ReportID, 'C:\temp\default.pdf', SalesHeader);
                //         REPORT.SAVEASPDF(ReportID, DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', SalesHeader);

                //         Tofile := STRSUBSTNO('Order No. %1.pdf', Rec."No.");

                //         //FP6.2.06
                //         //PdfDownloaded := DOWNLOAD('C:\temp\default.pdf', 'Save PDF As..', 'C:\','PDF file(*.pdf)|*.pdf', Tofile );
                //         PdfDownloaded := DOWNLOAD(DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', 'Save PDF As..', 'C:\',
                //             'PDF file(*.pdf)|*.pdf', Tofile);
                //     end;
                // }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.CheckSalesLineUnitPrice; //NUB1.11

                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Rec.CheckSalesLineUnitPrice; //NUB1.11

                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //if ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) then B2BUPG
                            if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //if ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) then//B2BUPG
                            if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            //if ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) then//B2BUPG
                            if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Order Confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Instruction';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
                action(PalletLabel)
                {
                    ApplicationArea = All;
                    Caption = 'Pallet Label';

                    trigger OnAction()
                    var
                        PalletLabelRepVarLcl: Report "Pallet Label";
                    begin
                        //NUB1.09 Start
                        REC.TESTFIELD("Pallet Count");
                        CLEAR(PalletLabelRepVarLcl);
                        PalletLabelRepVarLcl.SetDetails(Rec);
                        PalletLabelRepVarLcl.RUNMODAL;
                        //NUB1.09 End
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Drop Shipment Status")
            {
                ApplicationArea = All;
                Caption = 'Drop Shipment Status';
                Image = Report;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //RunObject = Report "Drop Shipment Status";//B2BUPG
            }
            action("Picking List by Order")
            {
                ApplicationArea = All;
                Caption = 'Picking List by Order';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Picking List by Order";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := REC."Job Queue Status" = REC."Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        exit(REC.ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REC."Responsibility Center" := UserMgt.GetSalesFilter;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            REC.FILTERGROUP(2);
            REC.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            REC.FILTERGROUP(0);
        end;

        //NUB1.02 Start
        if EventsAndSubcriber.GetSalesPersonFilter <> '' then begin
            REC.FILTERGROUP(2);
            REC.SETRANGE("Salesperson Code", EventsAndSubcriber.GetSalesPersonFilter);
        end;
        //NUB1.02 End

        REC.SETRANGE("Date Filter", 0D, WORKDATE - 1);
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        //ApprovalMgt :Codeunit "Approvals Management";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";

        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        "--SendToPDF--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record "Report Selections";
        ReportID: Integer;
        BodyText: Text;
        // EmailCommT: Record "Email Communication";//14005169 B2BUPG
        // ReportHelperCU: Codeunit ReportHelper;//14005067 B2BUPG
        // SalesHeader: Record "Sales Header";
        // EmailCommT2: Record "Email Communication";//14005169 B2BUPG
        // DefSetup: Record "Master File Setup Defaults";//B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record "Salesperson/Purchaser";
        "--FP7.0.09_": Label '''''';
        DocTypeTXT: Label 'P.O. No.';
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "-NUB1.04-": Integer;
        TotalPallets: Decimal;
        ResEntryRecGbl: Record "Reservation Entry";
        QtyToHandleVar: Decimal;
        EventsAndSubcriber: codeunit EventsandSubscribers;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        REC.SendToPosting(PostingCodeunitID);
        if REC."Job Queue Status" = REC."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE;
        CurrPage.UPDATE(false);
    end;


    procedure UpdateAllowed(): Boolean
    begin
        if CurrPage.EDITABLE = false then
            ERROR(Text000);
        exit(true);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if REC.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
            if REC."Sell-to Customer No." <> xRec."Sell-to Customer No." then
                REC.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;


    procedure "-FP7.0.09-"()
    begin
    end;


    procedure SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text
    begin
        //IF "Salesperson Code" <> '' THEN BEGIN
        //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

        //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
        // OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText,
        // ExtNo,
        // "No.",
        // DocTypeTXT,
        // FORMAT("Order Date"),
        // "Sell-to Customer Name",
        // "Sell-to Contact",
        // FORMAT("Shipment Date"),
        // "Salesperson Code",
        // Aux1,
        // '', '', '', '', SubjLine); //Substitute Strings into Email Body//B2BUPG
        //  END;
        //END;
    end;
}

