xmlport 50104 "Import Open AR"
{
    FieldDelimiter = '|';
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
                textelement(CUSTNO)
                {
                }
                textelement(docno)
                {
                }
                textelement(postingdate)
                {
                }
                textelement(amountfield)
                {
                }
                textelement(duedate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if not Customer.GET(CUSTNO) then currXMLport.SKIP;

                        "Gen. Journal Line".INIT;
                        "Gen. Journal Line"."Journal Template Name" := 'SALES';
                        "Gen. Journal Line"."Journal Batch Name" := 'DEFAULT';

                        lineno += 10000;
                        "Gen. Journal Line"."Line No." := lineno;

                        //IF STRLEN(PostingDate) = 5 THEN PostingDate := STRSUBSTNO('0%1', PostingDate);
                        //EVALUATE("Posting Date", STRSUBSTNO('%1/%2/%3', COPYSTR(PostingDate, 3, 2), COPYSTR(PostingDate, 5), COPYSTR(PostingDate, 1, 2)));
                        "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Customer;
                        "Gen. Journal Line".VALIDATE("Account No.", CUSTNO);
                        EVALUATE("Gen. Journal Line"."Posting Date", postingdate);
                        "Gen. Journal Line".VALIDATE("Posting Date");

                        "Gen. Journal Line"."Document Type" := "Gen. Journal Line"."Document Type"::Invoice;
                        "Gen. Journal Line".VALIDATE("Document No.", docno);
                        "Gen. Journal Line".VALIDATE("Account Type", "Gen. Journal Line"."Account Type"::Customer);
                        "Gen. Journal Line".VALIDATE("Account No.", CUSTNO);
                        EVALUATE("Gen. Journal Line".Amount, amountfield);
                        "Gen. Journal Line".VALIDATE("Gen. Journal Line".Amount);

                        custpostinggroup.GET(Customer."Customer Posting Group");
                        "Gen. Journal Line".VALIDATE("Bal. Account No.", custpostinggroup."Receivables Account");
                        EVALUATE("Gen. Journal Line"."Due Date", duedate);
                        "Gen. Journal Line".VALIDATE("Due Date");
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
        GenJrnLine.SETRANGE("Journal Template Name", 'SALES');
        GenJrnLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        if GenJrnLine.FINDLAST then lineno := GenJrnLine."Line No.";
    end;

    var
        GenJrnLine: Record "Gen. Journal Line";
        lineno: Integer;
        vendor: Record Vendor;
        "Gen. Journal Line": Record "Gen. Journal Line";
        custpostinggroup: Record "Customer Posting Group";
        Customer: Record Customer;
}

