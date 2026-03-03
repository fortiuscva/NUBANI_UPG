namespace Nubani.Nubani;

using Microsoft.Foundation.Comment;

pageextension 50019 "Comment sheet Ext" extends "Comment Sheet"
{
    CaptionML = ENU = 'Comment Sheet',
               ESM = 'Hoja comentarios',
               FRC = 'Feuille de commentaires',
               ENC = 'Comment Sheet';
    layout
    {
        addafter(Code)
        {
            field("AR Comment"; Rec."AR Comment")
            {
                ApplicationArea = All;
                Visible = ARCommentVisibleGVar;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //NU1.01 Start
        ControlsVisibility;
        //NU1.01 End
    end;

    trigger OnAfterGetRecord()
    begin
        //NU1.01 Start
        ControlsVisibility;
        //NU1.01 End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //NU1.01 Start
        ControlsVisibility;
        //NU1.01 End
    end;

    VAR
        "-NU1.01-": Integer;
        ARCommentVisibleGVar: Boolean;

    PROCEDURE ControlsVisibility();
    BEGIN
        //NU1.01 Start
        IF Rec."Table Name" = Rec."Table Name"::Customer THEN
            ARCommentVisibleGVar := TRUE;
        //NU1.01 End
    END;
}
