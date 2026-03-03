pageextension 50074 "Invt. Pick Subform Ext" extends "Invt. Pick Subform"//7378
{
    layout
    {
        // Add changes to page layout here
        modify("Assemble to Order")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}