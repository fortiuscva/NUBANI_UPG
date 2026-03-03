codeunit 50009 CallGetItemNoByDescService
{
    // // DJW 07/25/2012
    // // This codeunit is built so that the WMS can pass a word, and all associated Item.No records
    // // and their full Item.Description values are returned.


    trigger OnRun()
    begin
    end;


    procedure GetItemNoByDesc(InputString: Text[100]) ReturnString: Text[1000]
    var
        ItemRec: Record Item;
        CharCount: Integer;
    begin

        IF ItemRec.FINDSET THEN BEGIN

            REPEAT

                IF STRPOS(ItemRec."Search Description", UPPERCASE(InputString)) <> 0 THEN BEGIN

                    ReturnString += ItemRec."No." + ';';

                    ReturnString += ItemRec.Description + ';';

                    CharCount := STRLEN(ReturnString);

                END;

            UNTIL ((ItemRec.NEXT = 0) OR (CharCount > 950));

        END;
    end;
}

