report 50029 "Display Receving Bin Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/DisplayRecevingBinSales.rdl';
   UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            DataItemTableView = SORTING("Entry No.", Positive) ORDER(Ascending) WHERE("Source Type" = CONST(37), "Source Subtype" = CONST(1), "Source ID" = FILTER(<> ''));
            RequestFilterFields = "Source ID";
            column(SourceNo; "Reservation Entry"."Source ID")
            {
            }
            column(SourceRefNo; "Reservation Entry"."Source Ref. No.")
            {
            }
            column(ItemNo; SalesLineRec."No.")
            {
            }
            column(Description; SalesLineRec.Description)
            {
            }
            column(BinCode_SalesLine; SalesLineRec."Bin Code")
            {
            }
            column(LotNo; "Reservation Entry"."Lot No.")
            {
            }
            column(Quantity; ("Reservation Entry"."Quantity (Base)" * -1))
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesLineRec.RESET;
                SalesLineRec.SETRANGE("Document Type", SalesLineRec."Document Type"::Order);
                SalesLineRec.SETRANGE("Document No.", "Reservation Entry"."Source ID");
                SalesLineRec.SETRANGE("Line No.", "Reservation Entry"."Source Ref. No.");
                SalesLineRec.SETFILTER("Bin Code", '@REC*');
                IF SalesLineRec.FINDFIRST THEN BEGIN
                    BinContentRec.RESET;
                    BinContentRec.SETFILTER("Location Code", SalesLineRec."Location Code");
                    BinContentRec.SETFILTER("Bin Code", SalesLineRec."Bin Code");
                    BinContentRec.SETFILTER("Item No.", SalesLineRec."No.");
                    BinContentRec.SETFILTER("Lot No. Filter", "Reservation Entry"."Lot No.");
                    IF "Reservation Entry"."Serial No." <> '' THEN
                        BinContentRec.SETFILTER("Serial No. Filter", "Reservation Entry"."Serial No.");
                    IF BinContentRec.FINDFIRST THEN BEGIN
                        BinContentRec.CALCFIELDS("Quantity (Base)");
                        IF BinContentRec."Quantity (Base)" = 0 THEN
                            CurrReport.SKIP;
                    END ELSE
                        CurrReport.SKIP;
                END ELSE
                    CurrReport.SKIP;
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
        SalesLineRec: Record "Sales Line";
        WhseEntryRec: Record "Warehouse Entry";
        BinContentRec: Record "Bin Content";
}

