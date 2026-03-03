namespace Nubani.Nubani;
using System.Security.User;

pageextension 50018 "User setup Ext" extends "User Setup"
{
    CaptionML = ENU = 'User Setup',
               ESM = 'Configuraci¢n usuarios',
               FRC = 'Configuration des utilisateurs',
               ENC = 'User Setup';
    layout
    {
        moveafter("Allow Posting To"; "Salespers./Purch. Code")
        addafter("Time Sheet Admin.")
        {
            field("Sales Post Default"; Rec."Sales Post Default")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salespers./Purch. Code")
        {
            field("Purchase Post Default"; Rec."Purchase Post Default")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchase Post Default")
        {
            field("Delete Pick Ticket"; Rec."Delete Pick Ticket")
            {
                ApplicationArea = All;
            }
        }
        addafter("Delete Pick Ticket")
        {
            field("Enable Picture Perrmission"; Rec."Enable Picture Perrmission")
            {
                ApplicationArea = All;
            }
        }
    }
}
