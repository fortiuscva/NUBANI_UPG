namespace NUBANI_UPG.NUBANI_UPG;

using Microsoft.Bank.Deposit;

tableextension 50024 "Bank Deposit Header" extends "Bank Deposit Header"
{
    fields
    {
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Bank Account No." <> '' then
                    Rec.Validate("Post as Lump Sum", true);
            end;
        }
    }
}
