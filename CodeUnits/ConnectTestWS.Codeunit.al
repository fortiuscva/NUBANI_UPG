codeunit 50007 ConnectTest_WS
{

    trigger OnRun()
    begin
    end;


    procedure Capitalize(InputString: Text[30]) ReturnString: Text[30]
    begin

        ReturnString := UPPERCASE(InputString);
    end;
}

