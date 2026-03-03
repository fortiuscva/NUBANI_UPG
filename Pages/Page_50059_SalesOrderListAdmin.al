page 50059 "Sales Order List-Admin"
{
    // //FP  Added Lines Shipped Not Inv. to form
    //       Added Amount to form
    //       Added Your Reference and Posting Description
    // //FP6.2.01  Added two Page actions for Send PDF
    //             Added 7 globals
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
    // NUB1.01,04/27/18,SK: Added code at OnOpenPage() to filter on Sales Person code.
    // NUB1.02,01/16/19,SK: Added code at "Post - OnAction()" & "<Action76> - OnAction()".
    // NUB1.03,07/01/19,ST: Modifications handled to show if there is an open invt. pick exists and if there is quantity already shipped on the order.
    //                       - Added new flow fields "Invt. Pick Exists", "Order Shipped".

    Caption = 'Sales Orders';
    CardPageID = "Sales Orders-Admin";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount ($)"; Rec."Outstanding Amount ($)")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Lines Shipped Not Invoiced"; Rec."Lines Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Visible = JobQueueActive;
                }
                field("Invt. Pick Exists"; Rec."Invt. Pick Exists")
                {
                    ApplicationArea = All;
                }
                field("Order Shipped"; Rec."Order Shipped")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            // part("Sales Header Factbox"; "Sales Header Factbox")//14005186 B2BUPG
            // {
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "No." = FIELD("No.");
            //     SubPageView = SORTING("Document Type", "No.");
            // }
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
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
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
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
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
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
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
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
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
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        SalesOrderPlanningForm: Page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                // action("Send A&pproval Request")
                // {
                //     Caption = 'Send A&pproval Request';
                //     Image = SendApprovalRequest;

                //     trigger OnAction()
                //     var
                //         ApprovalMgt: Codeunit "Approvals Management";//B2BUPG
                //     begin
                //         if ApprovalMgt.SendSalesApprovalRequest(Rec) then;
                //     end;
                // }//B2BUPG
                // action("Cancel Approval Re&quest")
                // {
                //     Caption = 'Cancel Approval Re&quest';
                //     Image = Cancel;

                //     trigger OnAction()
                //     var
                //         ApprovalMgt: Codeunit "Approvals Management";
                //     begin
                //         if ApprovalMgt.CancelSalesApprovalRequest(Rec, true, true) then;
                //     end;
                // }B2BUPG
                // action("Send IC Sales Order Cnfmn.")
                // {
                //     Caption = 'Send IC Sales Order Cnfmn.';
                //     Image = IntercompanyOrder;

                //     trigger OnAction()
                //     var
                //         ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                //         ApprovalMgt: Codeunit "Approvals Management";
                //         PurchaseHeader: Record "Purchase Header";
                //     begin
                //         if ApprovalMgt.PrePostApprovalCheck(Rec, PurchaseHeader) then
                //             ICInOutboxMgt.SendSalesDoc(Rec, false);
                //     end;
                // }//B2BUPG
            }
            group(ActionGroup3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
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
                // action(SendAsPDF)
                // {
                //     Caption = 'SendAsPDF';
                //     Image = SendEmailPDF;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         Mail: Codeunit Mail;
                //         Name: Text;
                //         FileName: Text;
                //         ToFile: Text;
                //         //ReportHelper: Codeunit ReportHelper;//14005067 B2BUPG
                //         //EmailTracking: Record "Email Tracking";//14005150 B2BUPG
                //         "--FP7.0.09---": Integer;
                //         DialogOption: Option Always,Never,Ask;
                //         ShowDialog: Boolean;
                //     begin
                //         //FP6.2.01 begin
                //         CurrPage.SETSELECTIONFILTER(SalesHeader);
                //         Name := STRSUBSTNO('Order No. %1.pdf', Rec."No."); //Default Subject is PDF FIlename
                //         ToFile := Name;
                //         FileName := TEMPORARYPATH + ToFile;

                //         //FP7.0.09 Start
                //         //Document-Type-Specific Stuff here...

                //         if Rec."Shipping Agent Code" <> '' then begin
                //             if ShippingAgent.GET(Rec."Shipping Agent Code") then
                //                 Aux1 := ', via ' + ShippingAgent.Name;
                //             if Rec."Shipping Agent Service Code" <> '' then begin
                //                 if ShippingAgentServices.GET(Rec."Shipping Agent Code", Rec."Shipping Agent Service Code") then
                //                     Aux1 := Aux1 + ', ' + ShippingAgentServices.Description;
                //             end;
                //         end;

                //         if Rec."External Document No." <> '' then begin
                //             ExtNo := Rec."External Document No.";
                //         end;
                //         //FP7.0.09 Finish

                //         ReportHelperCU.GetEmailAddressesSO(Rec);
                //         EmailTracking.GET(EmailTracking."Transaction Type"::Sales, EmailTracking."Document Type"::Order, "No.");

                //         //FP7.0.09 Start

                //         BodyText := '';

                //         //FP7.0.09 Start
                //         //ImgTag := ReportHelperCU.CreateImgTag; //Form an HTML '<img>' Tag, if appropriate
                //         //ReportHelperCU.HandleTopImg(BodyText,ImgTag); //If desired, Start email Body with Logo on Top, with two Carriage Returns after
                //         //FP7.0.09 Finish

                //         EmailCommT.SETRANGE( EmailCommT.Type, EmailCommT.Type::Customer);
                //         EmailCommT.SETRANGE( EmailCommT."No.", Rec."Sell-to Customer No.");
                //         if EmailCommT.FINDFIRST then begin
                //             if (EmailCommT."Order Email Body Salutation" <> '') and (EmailCommT."Order Email Body Text" <> '') then begin
                //                 //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                //                 BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                //                 EmailSubj := EmailCommT."Order Email Subject";
                //             end;

                //             if (EmailCommT."Order Email Body Salutation" <> '') and (EmailCommT."Order Email Body Text" = '') then begin
                //                 EmailCommT2.RESET;
                //                 EmailCommT2.SETRANGE(EmailCommT2.Type, EmailCommT.Type::Default);
                //                 EmailCommT2.SETRANGE(EmailCommT2."No.", 'DEFAULT');
                //                 if EmailCommT2.FINDFIRST then begin
                //                     //      BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
                //                     BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
                //                     EmailSubj := EmailCommT2."Order Email Subject";
                //                 end;
                //             end;

                //             if (EmailCommT."Order Email Body Salutation" = '') and (EmailCommT."Order Email Body Text" <> '') then begin
                //                 EmailCommT2.RESET;
                //                 EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                //                 EmailCommT2.SETRANGE("No.", 'DEFAULT');
                //                 if EmailCommT2.FINDFIRST then begin
                //                     //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                //                     BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                //                     EmailSubj := EmailCommT."Order Email Subject"
                //                 end;
                //             end;

                //             if (EmailCommT."Order Email Body Salutation" = '') and (EmailCommT."Order Email Body Text" = '') then begin
                //                 EmailCommT2.RESET;
                //                 EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                //                 EmailCommT2.SETRANGE("No.", 'DEFAULT');
                //                 if EmailCommT2.FINDFIRST then begin
                //                     //      BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2."Order Email Body Text";
                //                     BodyText := BodyText + EmailCommT2."Order Email Body Salutation" + '<br><br>' + EmailCommT2.ReadSalesBody;
                //                     EmailSubj := EmailCommT2."Order Email Subject"
                //                 end;
                //             end;

                //         end else begin  //EmailCommT Record for this CUSTOMER NOT Found
                //             EmailCommT.RESET;
                //             EmailCommT.SETRANGE(Type, EmailCommT.Type::Default);
                //             EmailCommT.SETRANGE("No.", 'DEFAULT');
                //             if EmailCommT.FINDFIRST then begin
                //                 //    BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT."Order Email Body Text";
                //                 BodyText := BodyText + EmailCommT."Order Email Body Salutation" + '<br><br>' + EmailCommT.ReadSalesBody;
                //                 EmailSubj := EmailCommT."Order Email Subject";
                //             end;
                //         end;

                //         //FP7.0.09 Next Line REM-ed out
                //         //ReportHelperCU.HandleBotImg(BodyText,ImgTag); //Finish with Image on Bottom, if desired, followed by a Carriage Return

                //         DialogOption := EmailCommT."Open Order Email";

                //         //FP7.0.09 Finish

                //         //FP7.0.09 Start
                //         BodyText := SendAsPDFSubstitutions(BodyText, false); //"merge" arguments into Email Body
                //         if (EmailSubj <> '') then
                //             Name := SendAsPDFSubstitutions(EmailSubj, true); //"merge" arguments into Subject, too...

                //         ReportHelperCU.AddSlogan(BodyText); //Add Random Marketing Slogan to Body from Master File Setup Defaults
                //         ReportHelperCU.AddBanners(BodyText); //Add Top and Bottom Banners to Body from Master File Setup Defaults

                //         ShowDialog := true; //Default to Opening Outlook on Send
                //         if DialogOption = DialogOption::Never then
                //             ShowDialog := false
                //         else
                //             if DialogOption = DialogOption::Ask then
                //                 ShowDialog := CONFIRM('Do you want to open the email before sending?', true);
                //         //FP7.0.09 Finish

                //         ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
                //         ReportSelections.SETFILTER("Report ID", '<>0');
                //         if ReportSelections.FINDFIRST then
                //             ReportID := ReportSelections."Report ID";

                //         REPORT.SAVEASPDF(ReportID, FileName, SalesHeader);
                //         ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);
                //         Mail.NewMessage(EmailTracking."Order Ackn. Send Email To", EmailTracking."Order Ackn. CC Email To", Name, BodyText, ToFile, ShowDialog);
                //         FILE.ERASE(FileName);
                //         //FP6.2.01 end
                //     end;
                // }//B2BUPG
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
                //         REPORT.SaveAs(ReportID, DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', SalesHeader);

                //         Tofile := STRSUBSTNO('Order No. %1.pdf', "No.");

                //         //FP6.2.06
                //         //PdfDownloaded := DOWNLOAD('C:\temp\default.pdf', 'Save PDF As..', 'C:\','PDF file(*.pdf)|*.pdf', Tofile );
                //         PdfDownloaded := DOWNLOAD(DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', 'Save PDF As..', 'C:\',
                //             'PDF file(*.pdf)|*.pdf', Tofile);
                //     end;
                // }//B2BUPG
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
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
                        Rec.CheckSalesLineUnitPrice; //NUB1.02
                        Rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
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
                        Rec.CheckSalesLineUnitPrice; //NUB1.02
                        Rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
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
                    Promoted = true;
                    PromotedCategory = Process;

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
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
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
                    Promoted = true;
                    PromotedCategory = Process;

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
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ApplicationArea = All;
                Caption = 'Sales Reservation Avail.';
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FILTERGROUP(0);
        end;

        //NUB1.01 Start
        if EventandSubscriber.GetSalesPersonFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventandSubscriber.GetSalesPersonFilter);
        end;
        //NUB1.01 End

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive;
    end;

    var
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        EventandSubscriber: Codeunit EventsandSubscribers;
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";

        JobQueueActive: Boolean;
        "--FP--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record "Report Selections";
        ReportID: Integer;
        BodyText: Text;
        //EmailCommT: Record "Email Communication";//14005169 B2BUPG
        //ReportHelperCU: Codeunit ReportHelper;//14005067 B2BUPG
        SalesHeader: Record "Sales Header";
        //EmailCommT2: Record "Email Communication";//14005169 B2BUPG
        //DefSetup: Record "Master File Setup Defaults";//14005001 B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record "Salesperson/Purchaser";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        DocTypeTXT: Label 'P.O. No.';



    procedure "-FP7.0.09-"()
    begin
    end;


    procedure SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text
    begin
        if Rec."Salesperson Code" <> '' then begin
            if Salesperson.GET(Rec."Salesperson Code") then begin
                //    Salesperson.CALCFIELDS("Signature Picture");
                //    IF Salesperson."Signature Picture".HASVALUE THEN BEGIN

                //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
                // OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText,
                // ExtNo,
                // Rec."No.",
                // DocTypeTXT,
                // FORMAT(Rec."Order Date"),
                // Rec."Sell-to Customer Name",
                // Rec."Sell-to Contact",
                // FORMAT(Rec."Shipment Date"),
                // Rec."Salesperson Code",
                // Aux1,
                // '', '', '', '', SubjLine); //Substitute Strings into Email Body //B2BUPG
                //    END;
            end;
        end;
    end;
}

