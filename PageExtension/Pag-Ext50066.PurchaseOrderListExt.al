pageextension 50066 purchaseOrderListEcxt extends "Purchase Order List"
{
    layout
    {

        moveafter("No."; "Your Reference")
        moveafter("Your Reference"; "Buy-from Vendor Name")

        addafter("Buy-from Vendor Name")
        {
            field("Pallets-Cases"; Rec."Pallets-Cases")
            {
                ApplicationArea = all;
            }
            field("Priority Level"; Rec."Priority Level")
            {
                ApplicationArea = all;
            }

            field("Contact Phone"; Rec."Contact Phone")
            {
                ApplicationArea = all;
            }
            field("Total Qty."; Rec."Total Qty.")
            {
                ApplicationArea = all;
            }
            field("Total Qty. Received"; Rec."Total Qty. Received")
            {
                ApplicationArea = all;
            }
            field("Total Qty. Invoiced"; Rec."Total Qty. Invoiced")
            {
                ApplicationArea = all;
            }

        }
        modify(Status)
        {
            Visible = false;
        }

    }



    actions
    {
        modify(Statistics)
        {
            trigger OnAfterAction()
            begin
                IF rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Purchase Order Stats.", Rec)
            end;
        }
        addafter(CancelApprovalRequest)
        {
            action("Import PO Lines")
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'Import PO Lines';
                RunObject = XMLport "Import PO Lines";
                PromotedCategory = Process;
                Promoted = true;
                Image = Import;

            }
        }
        addbefore("P&osting")
        {
            action("Send As PDF")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'SendAsPDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = SendEmailPDF;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Mail: Codeunit Mail;
                    Name: Text;
                    FileName: Text;
                    ToFile: Text;
                    /* ReportHelper: Codeunit 14005067;
                    EmailTracking: Record 14005150; *///B2BUpg
                    DialogOption: Option "Always","Never","Ask";
                    ShowDialog: Boolean;
                begin
                    //FP6.2.01 begin
                    /* CurrPage.SETSELECTIONFILTER(PurchHeader);
                    Name := STRSUBSTNO('PO No. %1.pdf', "No.");
                    ToFile := Name;
                    FileName := TEMPORARYPATH + ToFile;

                    //FP7.0.09 Start
                    //Document-Type-Specific Stuff here...
                    IF "Your Reference" <> '' THEN BEGIN
                        ExtNo := "Your Reference";
                    END;
                    //FP7.0.09 Finish

                    ReportHelperCU.GetEmailAddressesPO(Rec);
                    EmailTracking.GET(EmailTracking."Transaction Type"::Purchase, EmailTracking."Document Type"::Order, "No.");

                    //FP7.0.09 Start

                    BodyText := '';

                    //ImgTag := ReportHelperCU.CreateImgTag; //Form an HTML '<img>' Tag, if appropriate
                    //ReportHelperCU.HandleTopImg(BodyText,ImgTag); //If desired, Start email Body with Logo on Top, with two Carriage Returns after

                    EmailCommT.SETRANGE(Type, EmailCommT.Type::Vendor);
                    EmailCommT.SETRANGE("No.", "Buy-from Vendor No.");
                    IF EmailCommT.FINDFIRST THEN BEGIN
                        IF (EmailCommT."P. O. Email Body Salutation" <> '') AND (EmailCommT."P. O. Email Body Text" <> '') THEN BEGIN
                            BodyText := BodyText + EmailCommT."P. O. Email Body Salutation" + '<br><br>' + EmailCommT.ReadPOBody;
                            EmailSubj := EmailCommT."P.O Email Subject";
                        END;

                        IF (EmailCommT."P. O. Email Body Salutation" <> '') AND (EmailCommT."P. O. Email Body Text" = '') THEN BEGIN
                            EmailCommT2.RESET;
                            EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                            EmailCommT2.SETRANGE("No.", 'DEFAULT');
                            IF EmailCommT2.FINDFIRST THEN BEGIN
                                BodyText := BodyText + EmailCommT."P. O. Email Body Salutation" + '<br><br>' + EmailCommT2.ReadPOBody;
                                EmailSubj := EmailCommT2."P.O Email Subject";
                            END;
                        END;

                        IF (EmailCommT."P. O. Email Body Salutation" = '') AND (EmailCommT."P. O. Email Body Text" <> '') THEN BEGIN
                            EmailCommT2.RESET;
                            EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                            EmailCommT2.SETRANGE("No.", 'DEFAULT');
                            IF EmailCommT2.FINDFIRST THEN BEGIN
                                BodyText := BodyText + EmailCommT2."P. O. Email Body Salutation" + '<br><br>' + EmailCommT.ReadPOBody;
                                EmailSubj := EmailCommT."P.O Email Subject";
                            END;
                        END;

                        IF (EmailCommT."P. O. Email Body Salutation" = '') AND (EmailCommT."P. O. Email Body Text" = '') THEN BEGIN
                            EmailCommT2.RESET;
                            EmailCommT2.SETRANGE(Type, EmailCommT.Type::Default);
                            EmailCommT2.SETRANGE("No.", 'DEFAULT');
                            IF EmailCommT2.FINDFIRST THEN BEGIN
                                BodyText := BodyText + EmailCommT2."P. O. Email Body Salutation" + '<br><br>' + EmailCommT2.ReadPOBody;
                                EmailSubj := EmailCommT2."P.O Email Subject";
                            END;
                        END;

                    END ELSE BEGIN  //EmailCommT Record for this VENDOR NOT Found
                        EmailCommT.RESET;
                        EmailCommT.SETRANGE(Type, EmailCommT.Type::Default);
                        EmailCommT.SETRANGE("No.", 'DEFAULT');
                        IF EmailCommT.FINDFIRST THEN BEGIN
                            BodyText := BodyText + EmailCommT."P. O. Email Body Salutation" + '<br><br>' + EmailCommT.ReadPOBody;
                            EmailSubj := EmailCommT."P.O Email Subject";
                        END;
                    END;

                    //ReportHelperCU.HandleBotImg(BodyText,ImgTag); //Finish with Image on Bottom, if desired, followed by a Carriage Return

                    DialogOption := EmailCommT."Open P.O. Email";

                    //FP7.0.09 Finish

                    //FP7.0.09 Start
                    BodyText := SendAsPDFSubstitutions(BodyText, FALSE); //"merge" arguments into Email Body
                    IF (EmailSubj <> '') THEN
                        Name := SendAsPDFSubstitutions(EmailSubj, TRUE); //"merge" arguments into Subject, too...

                    ReportHelperCU.AddSlogan(BodyText); //Add Random Marketing Slogan to Body from Master File Setup Defaults
                    ReportHelperCU.AddBanners(BodyText); //Add Top and Bottom Banners to Body from Master File Setup Defaults

                    ShowDialog := TRUE; //Default to Opening Outlook on Send
                    IF DialogOption = DialogOption::Never THEN
                        ShowDialog := FALSE
                    ELSE IF DialogOption = DialogOption::Ask THEN
                        ShowDialog := CONFIRM('Do you want to open the email before sending?', TRUE);
                    //FP7.0.09 Finish

                    ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"P.Order");
                    ReportSelections.SETFILTER("Report ID", '<>0');
                    IF ReportSelections.FINDFIRST THEN
                        ReportID := ReportSelections."Report ID";

                    REPORT.SAVEASPDF(ReportID, FileName, PurchHeader);
                    ToFile := ReportHelper.DownloadToClientFileName(FileName, ToFile);
                    Mail.NewMessage(EmailTracking."Order Ackn. Send Email To", EmailTracking."Order Ackn. CC Email To", Name, BodyText, ToFile, TRUE);
                    FILE.ERASE(FileName);
                    //FP6.2.01 end
                END;
 *///B2BUpg Need to Check
                end;
            }
            action("Save As PDF")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'SaveAsPDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintForm;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    /*  CurrPage.SETSELECTIONFILTER(PurchHeader);

                     ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"P.Order");
                     ReportSelections.SETFILTER("Report ID", '<>0');
                     IF ReportSelections.FINDFIRST THEN
                         ReportID := ReportSelections."Report ID";

                     //FP6.2.06
                     DefSetup.GET;
                     //REPORT.SAVEASPDF(ReportID, 'C:\temp\default.pdf', PurchHeader);
                     REPORT.SAVEASPDF(ReportID, DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', PurchHeader);

                     Tofile := STRSUBSTNO('PO No. %1.pdf', "No.");

                     //FP6.2.06
                     //PdfDownloaded := DOWNLOAD('C:\temp\default.pdf', 'Save PDF As..', 'C:\','PDF file(*.pdf)|*.pdf', Tofile );
                     PdfDownloaded := DOWNLOAD(DefSetup."Temp Dir. for Save AS PDF" + '\default.pdf', 'Save PDF As..', 'C:\',
                         'PDF file(*.pdf)|*.pdf', Tofile); *///B2BUpg Need to Check
                end;
            }

        }

    }

    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText,
    //     ExtNo,
    //     rec."No.",
    //     DocTypeTXT,
    //     FORMAT(rec."Order Date"),
    //     rec."Buy-from Vendor Name",
    //     rec."Buy-from Contact",
    //     '',
    //     rec."Purchaser Code",
    //     Aux1,
    //     '', '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                //  END;
    //                                //END;
    // END;//B2BUPG

    var
        ExtNo: Text;
        Aux1: Text;
        "--FP7.0.09_": Label 'ENU=''''';
        DocTypeTXT: Label 'ENU=Your Reference';

        myInt: Integer;
        ReportSelections: Record "Report Selections";
    //ReportHelperCU: Codeunit 14005067;//B2BUpg
}