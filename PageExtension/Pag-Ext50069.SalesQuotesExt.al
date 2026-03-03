pageextension 50069 SalesQuotesExt extends "Sales Quotes"
{
    layout
    {

        addafter(Status)
        {
            field("Outstanding Amount ($)"; Rec."Outstanding Amount ($)")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {


        modify(Statistics)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                IF rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Stats.", Rec);
            end;
        }

    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;

    PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;
    BEGIN
        //IF "Salesperson Code" <> '' THEN BEGIN
        //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

        //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
        //       OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText,
        //       ExtNo,
        //       rec."No.",
        //       DocTypeTXT,
        //       FORMAT(rec."Order Date"),
        //       rec."Sell-to Customer Name",
        //       rec."Sell-to Contact",
        //       FORMAT(rec."Shipment Date"),
        //       rec."Salesperson Code",
        //       Aux1,
        //       Aux2,'','','',SubjLine); //Substitute Strings into Email Body
        //   //  END;//B2BUPG
        //END;
    END;


    var
        ExtNo: Text;
        Aux1: Text;
        Aux2: Text;
        "--FP7.0.09_": Label 'ENU=''''';
        DocTypeTXT: Label 'ENU=Your Reference';

        myInt: Integer;
        ReportSelections: Record "Report Selections";
    //ReportHelperCU: Codeunit 14005067;//B2BUpg
}