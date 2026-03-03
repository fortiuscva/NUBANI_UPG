namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Foundation.ExtendedText;
using Microsoft.Inventory.Item;

report 50033 "Extended Text Report"
{
    ApplicationArea = All;
    Caption = 'Extended Text Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Reports/Layout/ExtendedTextReport.rdl';
    dataset
    {
        dataitem(ExtendedTextHeader; "Extended Text Header")
        {
            DataItemTableView = where("Table Name" = const(Item));
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(ItemRec_Desc; ItemRec.Description)
            { }
            column(CompanyName; CompanyName)
            { }
            dataitem("Extended Text Line"; "Extended Text Line")
            {
                DataItemLink = "Table Name" = field("Table Name"), "No." = field("No.");
                column(Text; Text)
                { }
                column(Line_No_; "Line No.")
                { }
            }
            trigger OnAfterGetRecord()
            begin
                Clear(ItemRec);
                if ItemRec.Get("No.") then;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        ItemRec: Record Item;
}
