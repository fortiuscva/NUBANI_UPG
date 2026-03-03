namespace NubaniNubaniUPG.NubaniNubaniUPG;
using Microsoft.Foundation.ExtendedText;

pageextension 50077 "Extended Text" extends "Extended Text"
{
    actions
    {
        addlast(Reporting)
        {
            action(ExtendedTextReport)
            {
                ApplicationArea = All;
                Caption = 'Extended Text Report';
                Image = Report;
                trigger OnAction()
                var
                    ExtendedTextHeader: Record "Extended Text Header";
                begin
                    CurrPage.SetSelectionFilter(ExtendedTextHeader);
                    Report.RunModal(Report::"Extended Text Report", true, false, ExtendedTextHeader);
                end;
            }
        }
    }
}
