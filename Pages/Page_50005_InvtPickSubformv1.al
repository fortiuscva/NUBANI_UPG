page 50005 "Invt. Pick Subform v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P7378.
    // 
    // NUB1.02,11/07/13,DRH:  Added field Pick Qty.
    // NUB1.03,10/22/18,SK: Addd new field as "Requested Delivery Date" & "Shipping Agent Code".

    Caption = 'Lines';
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Warehouse Activity Line";
    SourceTableView = WHERE("Activity Type" = CONST("Invt. Pick"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Action Type"; Rec."Action Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Source Document"; Rec."Source Document")
                {

                    ApplicationArea = all;
                    //OptionCaption = ' ,Sales Order,,,,,,,Purchase Return Order,,Outbound Transfer,Prod. Consumption';
                    Visible = false;
                }
                field("Source No."; rec."Source No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Serial No."; rec."Serial No.")
                {
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        SerialNoOnAfterValidate;
                    end;
                }
                field("Serial No. Blocked"; rec."Serial No. Blocked")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Lot No."; rec."Lot No.")
                {
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        LotNoOnAfterValidate;
                    end;
                }
                field("Lot No. Blocked"; rec."Lot No. Blocked")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        BinCodeOnAfterValidate;
                    end;
                }
                field("Shelf No."; rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field(Weight; rec.Weight)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. (Base)"; rec."Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. to Handle"; rec."Qty. to Handle")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        QtytoHandleOnAfterValidate;
                    end;
                }
                field("Pick Qty."; rec."Pick Qty.")
                {
                    ApplicationArea = all;
                }
                field("Qty. Handled"; rec."Qty. Handled")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Qty. to Handle (Base)"; rec."Qty. to Handle (Base)")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. Handled (Base)"; rec."Qty. Handled (Base)")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Qty. Outstanding"; rec."Qty. Outstanding")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Qty. Outstanding (Base)"; rec."Qty. Outstanding (Base)")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Due Date"; rec."Due Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Destination Type"; rec."Destination Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Destination No."; rec."Destination No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Special Equipment Code"; rec."Special Equipment Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Assemble to Order"; rec."Assemble to Order")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Split Line")
                {
                    Caption = '&Split Line';
                    Image = Split;
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        CallSplitLine();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action("Source &Document Line")
                {
                    Caption = 'Source &Document Line';
                    Image = SourceDocLine;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        ShowSourceLine;
                    end;
                }
                action("Bin Contents List")
                {
                    Caption = 'Bin Contents List';
                    Image = BinContent;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        ShowBinContents;
                    end;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailabilityByEvent;
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailabilityByPeriod;
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailabilityByVariant;
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        ApplicationArea = all;


                        trigger OnAction()
                        begin
                            Rec.ShowItemAvailabilityByLocation;
                        end;
                    }
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Activity Type" := xRec."Activity Type";
    end;

    var
        WMSMgt: Codeunit "WMS Management";
        ItemTrackingSetup: Record "Item Tracking Setup" temporary;


    procedure ShowSourceLine()
    begin
        WMSMgt.ShowSourceDocLine(rec."Source Type", rec."Source Subtype", rec."Source No.", rec."Source Line No.", rec."Source Subline No.");
    end;


    procedure ShowBinContents()
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.ShowBinContents(rec."Location Code", rec."Item No.", rec."Variant Code", '')
    end;


    procedure AutofillQtyToHandle()
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        rec.AutofillQtyToHandle(WhseActivLine);
    end;


    procedure DeleteQtyToHandle()
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        rec.DeleteQtyToHandle(WhseActivLine);
    end;


    procedure CallSplitLine()
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        rec.SplitLine(WhseActivLine);
        CurrPage.UPDATE(false);
    end;


    procedure PostPickYesNo()
    var
        WhseActivLine: Record "Warehouse Activity Line";
        WhseActivPostYesNo: Codeunit "Whse.-Act.-Post (Yes/No)";
    begin
        WhseActivLine.COPY(Rec);
        WhseActivPostYesNo.RUN(WhseActivLine);
        CurrPage.UPDATE(false);
    end;


    procedure PostAndPrint()
    var
        WhseActivLine: Record "Warehouse Activity Line";
        WhseActivPostYesNo: Codeunit "Whse.-Act.-Post (Yes/No)";
    begin
        WhseActivLine.COPY(Rec);
        WhseActivPostYesNo.PrintDocument(true);
        WhseActivPostYesNo.RUN(WhseActivLine);
        CurrPage.UPDATE(false);
    end;


    procedure UpdateForm()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SerialNoOnAfterValidate()
    var
        ExpDate: Date;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        EntriesExist: Boolean;

    begin
        if rec."Serial No." <> '' then
            //ExpDate := ItemTrackingMgt.ExistingExpirationDate(rec."Item No.", rec."Variant Code",ItemTrackingSetup
            // rec."Lot No.", rec."Serial No.", false, EntriesExist);//B2BUPG ExstingExpirationDate has changed procedure
            ExpDate := ItemTrackingMgt.ExistingExpirationDate(rec."Item No.", rec."Variant Code", ItemTrackingSetup,
                  false, EntriesExist);

        if ExpDate <> 0D then
            rec."Expiration Date" := ExpDate;
    end;

    local procedure LotNoOnAfterValidate()
    var
        ExpDate: Date;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        EntriesExist: Boolean;
    begin
        if rec."Lot No." <> '' then
            // ExpDate := ItemTrackingMgt.ExistingExpirationDate(rec."Item No.", rec."Variant Code",
            //     rec."Lot No.", rec."Serial No.", false, EntriesExist);
            ExpDate := ItemTrackingMgt.ExistingExpirationDate(rec."Item No.", rec."Variant Code", ItemTrackingSetup,
                  false, EntriesExist);

        if ExpDate <> 0D then
            rec."Expiration Date" := ExpDate;
    end;

    local procedure BinCodeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure QtytoHandleOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
    end;
}

