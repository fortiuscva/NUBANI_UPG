report 50001 "Update reclass journal"
{
    // NUB1.01,SP3166.12/19/13,AK: New Processing report.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/Updatereclassjournal.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;


    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.") ORDER(Ascending) WHERE("Journal Template Name" = FILTER('RECLASS'));

            trigger OnAfterGetRecord()
            begin
                VALIDATE("New Bin Code", "Bin Code");
                MODIFY;
            end;
        }
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date") ORDER(Ascending) WHERE("Source ID" = FILTER('RECLASS'));

            trigger OnAfterGetRecord()
            begin
                IF "New Expiration Date" <> 0D THEN BEGIN


                    yrval := FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date", 3));
                    moval := FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date", 2));
                    IF STRLEN(moval) < 2 THEN
                        moval := '0' + moval;

                    dayval := FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date", 1));
                    ;
                    IF STRLEN(dayval) < 2 THEN
                        dayval := '0' + dayval;



                    "New Lot No." := yrval + moval + dayval;
                    // FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date", 3)) + FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date",2))  +
                    //FORMAT(DATE2DMY("Reservation Entry"."New Expiration Date", 1));
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
        yrval: Text[4];
        moval: Text[2];
        dayval: Text[2];
}

