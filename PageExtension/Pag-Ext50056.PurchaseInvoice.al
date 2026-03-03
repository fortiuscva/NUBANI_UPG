namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Purchases.Document;

pageextension 50056 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the vendor''s reference.';
            }
        }
    }
}
