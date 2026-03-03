page 50007 "Warehouse Activity List v1"
{
    // NUB1.01,5/1/13,OAS: Copy of P5774.

    Caption = 'Warehouse Activity List';
    Editable = false;
    PageType = List;
    SourceTable = "Warehouse Activity Header";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = all;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = all;
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = all;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        case Rec.Type of
                            rec.Type::"Put-away":
                                PAGE.RUN(PAGE::"Warehouse Put-away", Rec);
                            Rec.Type::Pick:
                                PAGE.RUN(PAGE::"Warehouse Pick", Rec);
                            Rec.Type::Movement:
                                PAGE.RUN(PAGE::"Warehouse Movement", Rec);
                            Rec.Type::"Invt. Put-away":
                                PAGE.RUN(PAGE::"Inventory Put-away", Rec);
                            Rec.Type::"Invt. Pick":
                                PAGE.RUN(PAGE::"Inventory Pick v1", Rec);
                            Rec.Type::"Invt. Movement":
                                PAGE.RUN(PAGE::"Inventory Movement", Rec);
                        end;
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Put-away List")
            {
                Caption = 'Put-away List';
                Image = Report;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Put-away List";
            }
            action("Picking List")
            {
                Caption = 'Picking List';
                Image = Report;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Picking List";
            }
            action("Warehouse Movement List")
            {
                Caption = 'Warehouse Movement List';
                Image = Report;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Movement List";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.CAPTION := FormCaption;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        rec.ErrorIfUserIsNotWhseEmployee;
    end;

    var
        Text000: Label 'Warehouse Put-away List';
        Text001: Label 'Warehouse Pick List';
        Text002: Label 'Warehouse Movement List';
        Text003: Label 'Warehouse Activity List';
        Text004: Label 'Inventory Put-away List';
        Text005: Label 'Inventory Pick List';
        Text006: Label 'Inventory Movement List';

    local procedure FormCaption(): Text[250]
    begin
        case Rec.Type of
            Rec.Type::"Put-away":
                exit(Text000);
            Rec.Type::Pick:
                exit(Text001);
            Rec.Type::Movement:
                exit(Text002);
            Rec.Type::"Invt. Put-away":
                exit(Text004);
            Rec.Type::"Invt. Pick":
                exit(Text005);
            Rec.Type::"Invt. Movement":
                exit(Text006);
            else
                exit(Text003);
        end;
    end;
}

