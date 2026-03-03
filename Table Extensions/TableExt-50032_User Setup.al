tableextension 50032 UserSetupExt extends "User Setup"
{

    Caption = 'User Setup';
    fields
    {
        field(50001; "Delete Pick Ticket"; Boolean)
        {
            Description = 'NU1.01';
        }
        field(50006; "Enable Picture Perrmission"; Boolean)
        {
        }
        field(60210; "Sales Post Default"; Option)
        {
            Description = ',Ship,Invoice,Ship and Invoice';
            OptionMembers = " ",Ship,Invoice,"Ship and Invoice";
        }
        field(60211; "Purchase Post Default"; Option)
        {
            Description = ',Receive,Invoice,Receive and Invoice';
            OptionMembers = " ",Receive,Invoice,"Receive and Invoice";
        }
    }
}

