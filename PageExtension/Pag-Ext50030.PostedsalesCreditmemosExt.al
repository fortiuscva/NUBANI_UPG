namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50030 "Posted sales Credit memos Ext" extends "Posted Sales Credit Memos"
{
    CaptionML = ENU = 'Posted Sales Credit Memos',
               ESM = 'Lista hist. nota cr‚dito venta',
               FRC = 'Notes cr‚dit ventes report‚es',
               ENC = 'Posted Sales Credit Memos';
    layout
    {

        moveafter("Location Code"; "Electronic Document Status", "Date/Time Stamped", "Date/Time Sent", "Date/Time Canceled", "Error Code", "Error Description")
    }
    actions
    {
        modify("&Credit Memo")
        {
            CaptionML = ENU = '&Cr. Memo',
                                 ESM = 'Nota &Cr‚dito',
                                 FRC = 'Note de &cr‚dit',
                                 ENC = '&Cr. Memo';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Credit Memo Statistics", Rec, Rec."No.");
                // ELSE
                //     PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.", Rec, Rec."No.");
            end;
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        // addafter("&Credit Memo")
        // {
        //     group("&Electronic Document")
        //     {
        //         CaptionML = ENU = '&Electronic Document',
        //                          ESM = 'Documento &electr¢nico',
        //                          FRC = '&Document ‚lectronique',
        //                          ENC = '&Electronic Document';
        //     }
        // }
        // addlast("&Electronic Document")
        // {
        //     action("S&end")
        //     {
        //         Ellipsis = true;
        //         CaptionML = ENU = 'S&end',
        //                          ESM = '&Enviar',
        //                          FRC = 'Envoy&er',
        //                          ENC = 'S&end';
        //         Image = SendTo;
        //         trigger OnAction()
        //         BEGIN
        //            Rec. RequestStampEDocument;
        //         END;
        //     }
        //     action("Export E-Document as &XML")
        //     {
        //         CaptionML = ENU = 'Export E-Document as &XML',
        //                          ESM = 'Exportar documento electr¢nico como &XML',
        //                          FRC = 'Exporter le document ‚lectronique au format &XML',
        //                          ENC = 'Export E-Document as &XML';
        //         Image = ExportElectronicDocument;
        //         trigger OnAction()
        //         BEGIN
        //             Rec.ExportEDocument;
        //         END;
        //     }
        //     action("&Cancel")
        //     {
        //         CaptionML = ENU = '&Cancel',
        //                          ESM = '&Cancelar',
        //                          FRC = '&Annuler',
        //                          ENC = '&Cancel';
        //         Image = Cancel;
        //         trigger OnAction()
        //         BEGIN
        //             Rec.CancelEDocument;
        //         END;
        //     }B2BUPG

        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = 'Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
        // addlast("&Credit Memo")
        // {

        //     action("Sales - Credit Memo")  //10073 B2BUPG
        //     {
        //         CaptionML = ENU = 'Sales - Credit Memo',
        //                          ESM = 'Ventas - Nota cr‚dito',
        //                          FRC = 'Ventes - Note de cr‚dit',
        //                          ENC = 'Sales - Credit Memo';
        //         RunObject = Report 10073;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Process;
        //     }
        //     action("Outstanding Sales Order Aging")  //10055 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Sales Order Aging',
        //                          ESM = 'Antig. pedido venta pendiente',
        //                          FRC = 'Document de vente en souffrance ouvert',
        //                          ENC = 'Outstanding Sales Order Aging';
        //         RunObject = Report 10055;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        //     action("Outstanding Sales Order Status") //10056 B2BUPG
        //     {
        //         CaptionML = ENU = 'Outstanding Sales Order Status',
        //                          ESM = 'Estado pedidos vta. pendientes',
        //                          FRC = 'tat document de vente en souffrance',
        //                          ENC = 'Outstanding Sales Order Status';
        //         RunObject = Report 10056;
        //         Promoted = true;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }
        //     action("Daily Invoicing Report")  //10050 B2BUPG
        //     {
        //         CaptionML = ENU = 'Daily Invoicing Report',
        //                          ESM = 'Informe fact. diario',
        //                          FRC = 'Rapport facturation quotidienne',
        //                             ENC = 'Daily Invoicing Report';
        //         RunObject = Report 10050;
        //         Promoted = false;
        //         Image = Report;
        //         PromotedCategory = Report;
        //     }

        // }


    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;

    VAR
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ChangeExchangeRate: Page 511;
        "--FP--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        //EmailCommT: Record 14005144;  //B2BUPG
        //ReportHelperCU: Codeunit 14005067;  //B2BUPG
        // EmailCommT2: Record 14005144;  //B2BUPG
        // DefSetup: Record 14005001;  //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        ShippingAgent: Record 291;
        ShippingAgentServices: Record 5790;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        Aux2: Text;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'Invoice No.';


    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;  //Addon
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, "No.", DocTypeTXT, FORMAT("Posting Date"), "Sell-to Customer Name", "Sell-to Contact",
    //                          '', "Salesperson Code", Aux1, Aux2, '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                                                                     //  END;
    //                                                                                     //END;
    // END;
}
