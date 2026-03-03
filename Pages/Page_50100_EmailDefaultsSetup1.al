/*page 50100 "Email Defaults Setup1"
{
    // FP7.0.09  JB added lookup to Email Tracking Entries
    // 
    //   -Several Changes to accomodate String "Substitutions"

    PageType = Card;
    SourceTable = "Email Communication";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea=all;
                }
            }
            group("Default Quote")
            {
                field("Open Quote Email"; "Open Quote Email")
                {
                }
                field("Quote Email Body Salutation"; "Quote Email Body Salutation")
                {
                    Importance = Promoted;
                }
                field("Quote Email Subject"; "Quote Email Subject")
                {
                }
                field(BigQuoteBody; BigQuoteBody)
                {
                    Caption = 'Quote Email Body Text';
                    MultiLine = true;
                }
                field("Quote Email Body Text"; "Quote Email Body Text")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    MultiLine = true;
                    Visible = false;
                }
            }
            group("Default Order")
            {
                field("Open Order Email"; "Open Order Email")
                {
                }
                field("Order Email Body Salutation"; "Order Email Body Salutation")
                {
                    Importance = Promoted;
                }
                field("Order Email Subject"; "Order Email Subject")
                {
                }
                field("Order Email Body Text"; "Order Email Body Text")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    MultiLine = true;
                    Visible = false;
                }
                field(BigBody; BigBody)
                {
                    Caption = 'Order Email Body Text';
                    MultiLine = true;
                }
            }
            group("Default Invoice")
            {
                field("Open Invoice Email"; "Open Invoice Email")
                {
                }
                field("Invoice Email Body Salutation"; "Invoice Email Body Salutation")
                {
                    Importance = Promoted;
                }
                field("Invoice Email Subject"; "Invoice Email Subject")
                {
                }
                field(BigInvoiceBody; BigInvoiceBody)
                {
                    Caption = 'Invoice Email Body Text';
                    MultiLine = true;
                }
                field("Invoice Email Body Text"; "Invoice Email Body Text")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    MultiLine = true;
                    Visible = false;
                }
            }
            group("Default CrMemo")
            {
                field("Open Cr. Memo Email"; "Open Cr. Memo Email")
                {
                }
                field("Cr. Memo Email Salutation"; "Cr. Memo Email Salutation")
                {
                    Importance = Promoted;
                }
                field("Cr. Memo Email Subject"; "Cr. Memo Email Subject")
                {
                }
                field(BigCrMemoBody; BigCrMemoBody)
                {
                    Caption = 'Cr. Memo Email Body Text';
                    MultiLine = true;
                }
                field("Cr. Memo Email Body Text"; "Cr. Memo Email Body Text")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    MultiLine = true;
                    Visible = false;
                }
            }
            group("Default PO")
            {
                field("Open P.O. Email"; "Open P.O. Email")
                {
                }
                field("P. O. Email Body Salutation"; "P. O. Email Body Salutation")
                {
                    Importance = Promoted;
                }
                field("P.O Email Subject"; "P.O Email Subject")
                {
                }
                field(BigPOBody; BigPOBody)
                {
                    Caption = 'P.O. Email Body Text';
                    MultiLine = true;
                }
                field("P. O. Email Body Text"; "P. O. Email Body Text")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    MultiLine = true;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action74>")
            {
                Caption = '&Email';
                action("&Help with HTML Tags")
                {
                    Caption = '&Help with HTML Tags';
                    Image = Help;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        MESSAGE(TXT001 + TXT002 + TXT003 + TXT004 + TXT005 + TXT006 + TXT007 + TXT008);
                    end;
                }
                action("Customer List")
                {
                    Caption = 'Customer List';
                    Image = ListPage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Email Comm Quit Edit List";
                    RunPageView = SORTING (Type, "No.")
                                  WHERE (Type = CONST (Customer));
                }
                action("Vendor List")
                {
                    Caption = 'Vendor List';
                    Image = ListPage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Email Comm Quit Edit List";
                    RunPageView = SORTING (Type, "No.")
                                  WHERE (Type = CONST (Vendor));
                }
                action("Contact List")
                {
                    Caption = 'Contact List';
                    Image = ListPage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Email Comm Quit Edit List";
                    RunPageView = SORTING (Type, "No.")
                                  WHERE (Type = CONST (Contact));
                }
                action("Email Tracking Entries")
                {
                    Caption = 'Email Tracking Entries';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Email Tracking Entries";
                }
            }
            group(Substitutions)
            {
                group("Document Type")
                {
                    action("Sales Quote")
                    {
                        RunObject = Page "Email Comm Substitions Subform";
                        RunPageLink = Type = CONST (Default),
                                      "No." = CONST ('DEFAULT'),
                                      "Document Type" = CONST ("Sales Quote");
                        RunPageView = SORTING (Type, "No.", "Document Type", "Substitute No.")
                                      ORDER(Ascending)
                                      WHERE ("Document Type" = CONST ("Sales Quote"));
                    }
                    action("Sales Order")
                    {
                        RunObject = Page "Email Comm Substitions Subform";
                        RunPageLink = Type = CONST (Default),
                                      "No." = CONST ('DEFAULT'),
                                      "Document Type" = CONST ("Sales Order");
                        RunPageView = SORTING (Type, "No.", "Document Type", "Substitute No.")
                                      ORDER(Ascending)
                                      WHERE ("Document Type" = CONST ("Sales Order"));
                    }
                    action("Posted Sales Invoice")
                    {
                        RunObject = Page "Email Comm Substitions Subform";
                        RunPageLink = Type = CONST (Default),
                                      "No." = CONST ('DEFAULT'),
                                      "Document Type" = CONST ("Posted Sales Invoice");
                        RunPageView = SORTING (Type, "No.", "Document Type", "Substitute No.")
                                      ORDER(Ascending)
                                      WHERE ("Document Type" = CONST ("Posted Sales Invoice"));
                    }
                    action("Posted Sales Cr. Memo")
                    {
                        RunObject = Page "Email Comm Substitions Subform";
                        RunPageLink = Type = CONST (Default),
                                      "No." = CONST ('DEFAULT'),
                                      "Document Type" = CONST ("Posted Sales Cr. Memo");
                        RunPageView = SORTING (Type, "No.", "Document Type", "Substitute No.")
                                      ORDER(Ascending)
                                      WHERE ("Document Type" = CONST ("Posted Sales Cr. Memo"));
                    }
                    action("Purchase Order")
                    {
                        RunObject = Page "Email Comm Substitions Subform";
                        RunPageLink = Type = CONST (Default),
                                      "No." = CONST ('DEFAULT'),
                                      "Document Type" = CONST ("Purch. Order");
                        RunPageView = SORTING (Type, "No.", "Document Type", "Substitute No.")
                                      ORDER(Ascending)
                                      WHERE ("Document Type" = CONST ("Purch. Order"));
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //EVALUATE(BigBody,"Order Email Body Text");
        BigBody := ReadSalesBody;
        BigInvoiceBody := ReadInvoiceBody;
        BigQuoteBody := ReadQuoteBody;
        BigCrMemoBody := ReadCrMemoBody;
        BigPOBody := ReadPOBody;
    end;

    trigger OnClosePage()
    begin
        WriteSalesBody(BigBody);
        WriteInvoiceBody(BigInvoiceBody);
        WriteQuoteBody(BigQuoteBody);
        WriteCrMemoBody(BigCrMemoBody);
        WritePOBody(BigPOBody);
    end;

    trigger OnOpenPage()
    begin
        RESET;
        if not GET(Type::Default, 'Default') then begin
            Type := Type::Default;
            "No." := 'Default';
            Name := 'Used when specific email setup is blank';
            INSERT;
        end;
    end;

    var
        TXT001: Label 'TIPS FOR USING HTML TAGS IN THE EMAIL BODY:                                                             \\';
        TXT002: Label 'You can use HTML Tags in the SendAsPDF Email body. Almost all HTML Tags can be used, but typically, only a few will actually be useful in an email, and are included in the list below.\\';
        TXT003: Label '<br>  -  Line Break (like a Carriage Return). You can use multiple times for additional blank lines, e.g. <br><br>\\';
        TXT004: Label '<b></b> -  Bold Text.  <b>This will be  Bold</b>This is not Bold\\';
        TXT005: Label '<i></i>    -  Italic Text. <i>This will be Italics</i>This will not be Italics.\\';
        TXT006: Label '<ul></ul> - Underline Text. <ul>This will be Underlined</ul>This will not be.\\';
        TXT007: Label '<HR>       - Horizontal Rule. Creates a horizontal line.\\';
        TXT008: Label 'PLEASE NOTE THAT HTML TAGS ARE CASE-SENSITIVE!';
        BigBody: Text;
        BigInvoiceBody: Text;
        BigQuoteBody: Text;
        BigCrMemoBody: Text;
        BigPOBody: Text;
        ThisBigBody: Text;
        ThisSubject: Text;
        ThisSalutation: Text;
        ThisOpenEmail: Option Always,Never,Ask;
}*/

