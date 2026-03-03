xmlport 50103 "Import Open AP"
{
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(text_element)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'intrec';
                UseTemporary = true;
                textelement(vendorno)
                {
                }
                textelement(docno)
                {
                }
                textelement(amountfield)
                {
                }
                textelement(postingdate)
                {
                }
                textelement(DueDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if not vendor.GET(vendorno) then currXMLport.SKIP;

                        "Gen. Journal Line".INIT;
                        "Gen. Journal Line"."Journal Template Name" := 'PURCH';
                        "Gen. Journal Line"."Journal Batch Name" := 'DEFAULT';

                        lineno += 10000;
                        "Gen. Journal Line"."Line No." := lineno;

                        //IF STRLEN(PostingDate) = 5 THEN PostingDate := STRSUBSTNO('0%1', PostingDate);
                        //EVALUATE("Posting Date", STRSUBSTNO('%1/%2/%3', COPYSTR(PostingDate, 3, 2), COPYSTR(PostingDate, 5), COPYSTR(PostingDate, 1, 2)));
                        "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Vendor;
                        "Gen. Journal Line".VALIDATE("Account No.", vendorno);
                        EVALUATE("Gen. Journal Line"."Posting Date", postingdate);
                        "Gen. Journal Line".VALIDATE("Posting Date");

                        "Gen. Journal Line".VALIDATE("Document No.", docno);
                        "Gen. Journal Line".VALIDATE("Account Type", "Gen. Journal Line"."Account Type"::Vendor);
                        "Gen. Journal Line".VALIDATE("Account No.", vendorno);
                        EVALUATE("Gen. Journal Line".Amount, amountfield);
                        "Gen. Journal Line".VALIDATE("Gen. Journal Line".Amount);

                        vendorpostinggroup.GET(vendor."Vendor Posting Group");
                        "Gen. Journal Line".VALIDATE("Bal. Account No.", vendorpostinggroup."Payables Account");

                        EVALUATE("Gen. Journal Line"."Due Date", DueDate);
                        "Gen. Journal Line".INSERT;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        GenJrnLine.SETRANGE("Journal Template Name", 'PURCH');
        GenJrnLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        if GenJrnLine.FINDLAST then lineno := GenJrnLine."Line No.";
    end;

    var
        GenJrnLine: Record "Gen. Journal Line";
        lineno: Integer;
        vendor: Record Vendor;
        "Gen. Journal Line": Record "Gen. Journal Line";
        vendorpostinggroup: Record "Vendor Posting Group";
}

