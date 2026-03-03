report 50081 "Delete Bins"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Delete Bins"; "Delete Bins")
        {

            trigger OnAfterGetRecord()
            begin
                CLEARLASTERROR;
                IF CODEUNIT.RUN(CODEUNIT::"Delete Bins", "Delete Bins") THEN BEGIN
                    "Delete Bins".Processed := TRUE;
                    "Delete Bins".MODIFY;
                END ELSE BEGIN
                    ErrorText := GETLASTERRORTEXT;
                    "Delete Bins"."Error Text" := COPYSTR(ErrorText, 1, 250);
                    "Delete Bins"."Error Text 2" := COPYSTR(ErrorText, 251, 500);
                    "Delete Bins"."Error Text 3" := COPYSTR(ErrorText, 501, 750);
                    "Delete Bins".MODIFY;
                END;
                COMMIT;
            end;
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

    labels
    {
    }

    var
        BinRecGbl: Record Bin;
        ErrorText: Text;
}

