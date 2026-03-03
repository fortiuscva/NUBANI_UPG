codeunit 50010 GetItemByItemNo_WS
{
    // // DJW 02-17-2012
    // // Created Function GetItemByItemNo
    // // Input: Item Number
    // // Output: ReturnString
    // // ReturnString consists of a semi-colon delimited Text[1000] (since Nav does not allow the return of an array)
    // // Which contains the following fields where the Item Number is found on the Item table:
    // // 1.  Return Code
    // // 2.  Item Tracking Code
    // // 3.  Item Description


    trigger OnRun()
    begin
    end;


    procedure GetItemByItemNo(ItemNumber: Text[50]) ReturnString: Text[1000]
    var
        ReturnCode: Text[10];
        ItemTrackingCode: Text[50];
        ItemDescription: Text[80];
        ItemRecord: Record Item;
    begin
        // ReturnString consists of a semi-colon delimited string (since Nav does not allow the return of an array)
        // Which contains the following fields where the Item Number is found on the Item table:
        // 1.  Return Code
        // 2.  Item Tracking Code
        // 3.  Item Description

        ReturnString := '';

        ItemRecord.SETRANGE("No.", ItemNumber);


        IF ItemRecord.FIND('-') THEN BEGIN

            REPEAT

                ReturnString += ItemRecord."Item Tracking Code" + ';';
                ReturnString += ItemRecord.Description + ';';

            UNTIL ItemRecord.NEXT = 0;

        END;

        IF ReturnString = '' THEN
            ReturnString := '1';
    end;
}

