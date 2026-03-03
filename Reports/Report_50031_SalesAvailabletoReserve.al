report 50031 "Sales Available to Reserve"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SalesAvailabletoReserve.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date") ORDER(Ascending) WHERE("Document Type" = FILTER(Order), "Outstanding Quantity" = FILTER(<> 0), Type = FILTER(Item), "No." = FILTER(<> ''));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(Sales_Line__Document_No__; "Document No.")
            {
            }
            column(Sales_Line__Line_No__; "Line No.")
            {
            }
            column(Sales_Line__Sales_Line___Outstanding_Qty___Base__; "Sales Line"."Outstanding Qty. (Base)")
            {
            }
            column(ABS_resentry__Quantity__Base___; ABS(resentry."Quantity (Base)"))
            {
            }
            column(whseline__Qty__Outstanding__Base__; whseline."Qty. Outstanding (Base)")
            {
            }
            column(itemrec_Inventory_____ABS_resentry2__Quantity__Base___; itemrec.Inventory - ABS(resentry2."Quantity (Base)"))
            {
            }
            column(Order_Pick_TicketCaption; Order_Pick_TicketCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(On_PickCaption; On_PickCaptionLbl)
            {
            }
            column(Available_to_ReserveCaption; Available_to_ReserveCaptionLbl)
            {
            }
            column(Item_TrackedCaption; Item_TrackedCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Sales_Line__Line_No__Caption; FIELDCAPTION("Line No."))
            {
            }
            column(Sales_Line__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(whseline);
                whseline.RESET;
                whseline.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                whseline.SETRANGE("Source Type", 37);
                whseline.SETRANGE("Source No.", "Document No.");
                whseline.SETRANGE("Source Line No.", "Line No.");
                whseline.CALCSUMS(whseline."Qty. Outstanding (Base)");
                IF whseline."Qty. Outstanding (Base)" = "Sales Line"."Outstanding Qty. (Base)" THEN
                    CurrReport.SKIP;

                itemrec.GET("No.");
                itemrec.SETRANGE("Location Filter", "Location Code");
                itemrec.CALCFIELDS(itemrec.Inventory);
                CLEAR(whseline2);
                whseline2.RESET;
                whseline2.SETCURRENTKEY("Item No.", "Location Code", "Activity Type");
                whseline2.SETRANGE("Item No.", "No.");
                whseline2.SETRANGE("Location Code", "Location Code");
                whseline2.SETRANGE("Activity Type", whseline2."Activity Type"::"Invt. Pick");
                whseline2.CALCSUMS(whseline2."Qty. Outstanding (Base)");

                IF itemrec.Inventory - whseline2."Qty. Outstanding (Base)" <= 0 THEN
                    CurrReport.SKIP;

                CLEAR(resentry);
                resentry.RESET;
                resentry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");
                resentry.SETRANGE("Source ID", "Document No.");
                resentry.SETRANGE("Source Ref. No.", "Line No.");
                resentry.CALCSUMS(resentry."Quantity (Base)");
                CLEAR(resentry2);
                resentry2.RESET;
                resentry2.SETCURRENTKEY("Item No.", "Location Code", "Source Type", "Lot No.");
                resentry2.SETRANGE("Item No.", "No.");
                resentry2.SETRANGE("Location Code", "Location Code");
                resentry2.SETRANGE("Source Type", 37);
                resentry2.SETFILTER("Lot No.", '<>%1', '');
                resentry2.CALCSUMS(resentry2."Quantity (Base)");
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
        whseline: Record "Warehouse Activity Line";
        itemrec: Record Item;
        whseline2: Record "Warehouse Activity Line";
        resentry: Record "Reservation Entry";
        resentry2: Record "Reservation Entry";
        Order_Pick_TicketCaptionLbl: Label 'Sales Available to Reserve';
        CurrReport_PAGENOCaptionLbl: Label 'Label1100796016';
        On_PickCaptionLbl: Label 'On Pick';
        Available_to_ReserveCaptionLbl: Label 'Available to Reserve';
        Item_TrackedCaptionLbl: Label 'Item Tracked';
        QuantityCaptionLbl: Label 'Quantity';
}

