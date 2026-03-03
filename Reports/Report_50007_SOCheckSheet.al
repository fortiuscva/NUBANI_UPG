report 50007 "SO Check Sheet"
{
    // NUB1.01,09/27/18,SK: Created new report.
    //         10/23/18,SK: Added "Quantity (Base)" filter to "Reservation Entry" dataitem.
    // NUB1.02,01/06/20,SK: Formating "Lot No." details into Date format.
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/SOCheckSheet.rdl';
    UsageCategory =ReportsAndAnalysis;
    ApplicationArea =all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.";
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = FILTER(Item));
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(ItemRecGbl_Search_Desc; ItemRecGbl."Search Description")
                {
                }
                column(Line_Caption; Line_CaptionLbl)
                {
                }
                column(Number_Caption; Number_CaptionLbl)
                {
                }
                column(SKU_Caption; SKU_CaptionLbl)
                {
                }
                column(Desc_Caption; Desc_CaptionLbl)
                {
                }
                column(SO_Qty_Caption; SO_Qty_CaptionLbl)
                {
                }
                column(Check_Numb_Caption; Check_Numb_CaptionLbl)
                {
                }
                column(Total_Caption; Total_CaptionLbl)
                {
                }
                column(Grand_Total_Caption; Grand_Total_CaptionLbl)
                {
                }
                column(LOT_Caption; LOT_CaptionLbl)
                {
                }
                column(Lot_Qty_Caption; Lot_Qty_CaptionLbl)
                {
                }
                column(GrandTotVarGbl; GrandTotVarGbl)
                {
                }
                column(Sno; Sno)
                {
                }
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No."), "Item No." = FIELD("No.");
                    DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date") WHERE("Quantity (Base)" = FILTER(<> 0));
                    column(ExpirationDate_ReservationEntry; ExpdateVar)
                    {
                    }
                    column(QuantityBase_ReservationEntry; -1 * "Reservation Entry"."Quantity (Base)")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ExpdateVar := COPYSTR("Lot No.", 5, 2) + '/' + COPYSTR("Lot No.", 7, 2) + '/' + COPYSTR("Lot No.", 1, 4);
                        //EVALUATE(ResExpDate,ExpdateVar);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(ItemRecGbl);
                    IF ItemRecGbl.GET("Sales Line"."No.") THEN;
                    GrandTotVarGbl += "Sales Line".Quantity;

                    IF ("No." <> '') THEN
                        Sno += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(GrandTotVarGbl);
                CLEAR(Sno);
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
        Line_CaptionLbl: Label 'Line';
        Number_CaptionLbl: Label 'Number';
        SKU_CaptionLbl: Label 'SKU';
        Desc_CaptionLbl: Label 'Description';
        SO_Qty_CaptionLbl: Label 'SO Qty';
        Check_Numb_CaptionLbl: Label 'Check Numbers';
        Total_CaptionLbl: Label 'Total';
        Grand_Total_CaptionLbl: Label 'Grand Total';
        LOT_CaptionLbl: Label 'Lot';
        Lot_Qty_CaptionLbl: Label 'Lot Qty';
        SKURecGbl: Record "Stockkeeping Unit";
        ItemRecGbl: Record Item;
        ExpdateVar: Text;
        ResExpDate: Date;
        GrandTotVarGbl: Decimal;
        Sno: Integer;
}

