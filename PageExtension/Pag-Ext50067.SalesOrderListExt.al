pageextension 50067 SalesOrderListExt extends "Sales Order List"
{
    layout
    {

    }

    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.CheckItemTrackingLines; //NUB1.02
            end;
        }

    }
    trigger OnOpenPage()
    begin
        //NUB1.03 Start
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Salesperson Code", UserMgt.GetSalesFilter());
        END;
        //NUB1.03 End

    end;

    var
        UserMgt: Codeunit "User Setup Management";
        "--FP--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record "Report Selections";
        ReportID: Integer;
        BodyText: Text;
        //EmailCommT: Record 14005144;  //B2BUPG
        //ReportHelperCU: Codeunit 14005067;  //B2BUPG
        SalesHeader: Record "Sales Header";
        //EmailCommT2: Record 14005144;  //B2BUPG
        //DefSetup: Record 14005001;  //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record "Salesperson/Purchaser";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentServices: Record "Shipping Agent Services";
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        DocTypeTXT: Label 'ENU=P.O. No.';
        "-NB1.01-": Integer;
        SalesHeadGRec: Record "Sales Header";

}