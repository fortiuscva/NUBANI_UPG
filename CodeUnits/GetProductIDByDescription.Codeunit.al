codeunit 50100 GetProductIDByDescription
{

    trigger OnRun()
    var
        ItemRec: Record Item;
    begin
    end;


    procedure GetProductIDByDescription(InputString: Text[100]) ReturnString: Text[1000]
    var
        CharCount: Integer;
        ItemRec: Record Item;
    begin

        IF ItemRec.FIND('-') THEN BEGIN

            REPEAT

                IF STRPOS(ItemRec.Description, InputString) <> 0 THEN BEGIN

                    ReturnString += ItemRec."No." + ';';

                    ReturnString += ItemRec.Description + ';';

                    ReturnString += FORMAT(ItemRec."Unit Price") + ';';

                    // Set and check the count

                    CharCount := STRLEN(ReturnString);

                END;

            UNTIL (ItemRec.NEXT = 0) OR (CharCount > 9500);

        END;
    end;
}

