namespace Nubani.Nubani;

using Microsoft.Inventory.Item.Picture;

pageextension 50034 "Item Picture Ext" extends "Item Picture"
{
    CaptionML = ENU = 'Item Picture',
               ESM = 'Imagen prod.',
               FRC = 'Image de l article',
               ENC = 'Item Picture';
    layout
    {
        modify(Picture)
        {
            trigger OnAfterValidate()
            begin
                //NUB1.02 STart
                IF UserSetupRecGbl.GET(USERID) THEN BEGIN
                    IF NOT (UserSetupRecGbl."Enable Picture Perrmission") THEN
                        ERROR('You are unable to Change or delete the picture');
                END;
                //NUB1.02 End
            end;
        }
        addafter(Picture)
        {
            field("Picture 2"; Rec."Picture 2")
            {
                ApplicationArea = All;
                trigger OnValidate()
                BEGIN
                    //NUB1.02 STart
                    IF UserSetupRecGbl.GET(USERID) THEN BEGIN
                        IF NOT (UserSetupRecGbl."Enable Picture Perrmission") THEN
                            ERROR('You are unable to Change or delete the picture');
                    END;
                    //NUB1.02 End
                END;
            }
        }
    }
    var
        UserSetupRecGbl: Record 91;
}
