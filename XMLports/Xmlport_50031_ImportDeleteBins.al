xmlport 50031 "Import Delete Bins"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'DeleteBins';
                SourceTableView = SORTING(Number) ORDER(Ascending);
                textelement(BinCode)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    if not DeleteBinsRecGbl.GET(BinCode) then begin
                        DeleteBinsRecGbl.INIT;
                        DeleteBinsRecGbl."Bin Code" := BinCode;
                        DeleteBinsRecGbl.INSERT;
                    end;
                end;
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

    var
        DeleteBinsRecGbl: Record "Delete Bins";
}

