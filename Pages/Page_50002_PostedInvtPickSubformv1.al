page 50002 "Posted Invt. Pick Subform v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P7393.

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Posted Invt. Pick Line v1";

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
                    OptionCaption = ' ,,,,Sales Return Order,Purchase Order,,,,Inbound Transfer';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        BinCodeOnAfterValidate;
                    end;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
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
            }
        }
    }


    procedure ShowBinContents()
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.ShowBinContents(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Bin Code");
    end;

    local procedure BinCodeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

