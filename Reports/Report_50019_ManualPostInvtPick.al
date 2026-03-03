report 50019 "Manual Post Invt. Pick"
{
    // NUB1.01,01/26/17,ST: Created new report. This report will be triggerd from page 500004.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.") ORDER(Ascending) WHERE(Type = CONST("Invt. Pick"));

            trigger OnAfterGetRecord()
            var
                WhseActivLine: Record "Warehouse Activity Line";
                WhseActivPostYesNo: Codeunit "Whse.-Act.-Post (Yes/No)";
            begin
                CLEAR(WhseActivPostYesNo);
                WhseActivLine.RESET;
                WhseActivLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                WhseActivLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                WhseActivLine.FINDFIRST;
                //WhseActivLine.COPY("Warehouse Activity Header");
                //WhseActivPostYesNo.ManualInvtPickPost(DATABASE::"Sales Shipment Header", ShptNoVarGbl);//B2BUPG
                EventsandSubscriber.ManualInvtPickPost(DATABASE::"Sales Shipment Header", ShptNoVarGbl);//B2BUPG
                WhseActivPostYesNo.RUN(WhseActivLine);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShptNoVarGbl; ShptNoVarGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment No.';
                        TableRelation = "Sales Shipment Header"."No.";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF NOT RunFromPageVarGbl THEN
            ERROR('This report cannot be executed directly');

        IF ShptNoVarGbl = '' THEN
            ERROR('Shipment No. must not be empty.');
    end;

    var
        ShptNoVarGbl: Code[20];
        RunFromPageVarGbl: Boolean;
        EventsandSubscriber: Codeunit EventsandSubscribers;


    procedure RunFromPage()
    begin
        RunFromPageVarGbl := TRUE;
    end;
}

