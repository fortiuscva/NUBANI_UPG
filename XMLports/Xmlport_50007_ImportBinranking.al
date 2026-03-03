xmlport 50007 "Import Bin ranking"
{
    // NUB1.01,SP3166,12/19/13,AK; New XML port.

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Bin; Bin)
            {
                XmlName = 'Bin';
                UseTemporary = true;
                fieldelement(Location; Bin.Code)
                {
                    FieldValidate = no;
                }
                fieldelement(BinCode; Bin."Bin Ranking")
                {
                    FieldValidate = no;
                }

                trigger OnBeforeInsertRecord()
                begin
                    binrec.SETRANGE(binrec.Code, Bin.Code);
                    if binrec.FINDSET then begin
                        binrec."Bin Ranking" := Bin."Bin Ranking";
                        binrec.MODIFY;
                    end;
                    bincont.RESET;
                    bincont.SETRANGE(bincont."Bin Code", Bin.Code);
                    if bincont.FINDSET then begin
                        bincont."Bin Ranking" := Bin."Bin Ranking";
                        bincont.MODIFY;
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
        binrec: Record Bin;
        bincont: Record "Bin Content";
}

