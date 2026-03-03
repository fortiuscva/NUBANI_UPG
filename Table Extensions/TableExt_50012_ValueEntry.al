namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Payables;

tableextension 50012 "Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Your Reference"; Text[100])
        {
            Caption = 'Your Reference';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Your Reference" where("No." = field("Document No.")));
            Editable = false;
        }
    }
}
