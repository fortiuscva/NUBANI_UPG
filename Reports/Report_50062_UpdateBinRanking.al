report 50062 "*** Update Bin Ranking"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bin Content"; "Bin Content")
        {

            trigger OnAfterGetRecord()
            begin
                IF "Bin Ranking" = 0 THEN
                    IF Bin.GET("Location Code", "Bin Code") THEN BEGIN
                        "Bin Ranking" := Bin."Bin Ranking";
                        MODIFY;
                    END;
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
        Bin: Record Bin;
}

