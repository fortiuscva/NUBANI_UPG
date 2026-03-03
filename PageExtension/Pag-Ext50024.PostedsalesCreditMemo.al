namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50024 "Posted sales Credit Memo Ext" extends "Posted Sales Credit Memo"
{
    CaptionML = ENU = 'Posted Sales Credit Memo',
               ESM = 'Hist¢rico nota cr‚dito venta',
               FRC = 'Note de cr‚dit vente report‚e',
               ENC = 'Posted Sales Credit Memo';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        moveafter("Sell-to City"; "Sell-to County")
        modify("Sell-to County")
        {
            CaptionML = ENU = 'Sell-to State / ZIP Code',
                           ESM = 'Venta a-Estado / C.P.',
                           FRC = 'tat-Province/code postal (d‚biteur)',
                           ENC = 'Sell-to Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Sell-to County"; "Sell-to Post Code")
        modify("Sell-to Post Code")
        {

            Editable = FALSE;
        }
        addafter("No. Printed")
        {
            field("Pallets Spaces"; Rec."Pallets Spaces")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pallets Spaces")
        {
            field("Shipping Status"; Rec."Shipping Status")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Bill-to City"; "Bill-to County")
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code;',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Bill-to County"; "Bill-to Post Code")
        modify("Bill-to Post Code")
        {
            Editable = FALSE;
        }
        // addafter("Payment Method Code")
        // {
        //     field(GetCreditcardNumber; Rec.GetCreditcardNumber)
        //     {
        //         CaptionML = ENU = 'Cr. Card Number (Last 4 Digits)',
        //                    ESM = 'N£mero tarjeta cr‚dito (cuatro £ltimos d¡gitos)',
        //                    FRC = 'Num‚ro de carte de cr‚dit (4ÿderniers chiffres)',
        //                    ENC = 'Cr. Card Number (Last 4 Digits)';

        //         Editable = FALSE;
        //     }
        // }
        addafter("Bill-to Post Code")
        {
            field("Orig. Invoice No."; Rec."Orig. Invoice No.")
            {
                ApplicationArea = All;
                Visible = TRUE;
                Editable = AllowEdit;
            }
        }
        moveafter("Ship-to City"; "Ship-to County")
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        moveafter("Ship-to County"; "Ship-to Post Code")
        moveafter("Ship-to Contact"; "Ship-to UPS Zone")
        movefirst("Electronic Invoice"; "Electronic Document Status")
        moveafter("Electronic Document Status"; "Date/Time Stamped", "Date/Time Sent", "Date/Time Canceled", "Error Code")
        moveafter("Error Code"; "Error Description", "PAC Web Service Name", "Fiscal Invoice Number PAC", "No. of E-Documents Sent")

    }
    actions
    {
        modify("&Cr. Memo")
        {
            CaptionML = ENU = '&Cr. Memo',
                                 ESM = 'Nota &Cr‚dito',
                                 FRC = 'Note de &cr‚dit',
                                 ENC = '&Cr. Memo';
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
                //     PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.", Rec,Rec."No.");B2BUPG
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
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals',
                                 ESM = 'Aprobaciones',
                                 FRC = 'Approbations',
                                 ENC = 'Approvals';
        }
        // addafter("&Cr. Memo")
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
        //         CaptionML = ENU = 'S&end',,
        //                          ESM = '&Enviar',
        //                          FRC = 'Envoy&er',
        //                          ENC = 'S&end';
        //         Image = SendTo;
        //         trigger OnAction()
        //         BEGIN
        //             RequestStampEDocument;
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
        //             ExportEDocument;
        //         END;
        //     }
        //     action()
        //     {
        //         CaptionML = ENU = '&Cancel',
        //                          ESM = '&Cancelar',
        //                          FRC = '&Annuler',
        //                          ENC = '&Cancel';
        //         Image = Cancel;
        //         trigger OnAction()
        //         BEGIN
        //             CancelEDocument;
        //         END;
        //     }
        //}
        modify(Print)
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate',
                                 ESM = '&Navegar',
                                 FRC = '&Naviguer',
                                 ENC = '&Navigate';
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01

    end;

    var
        "--FP--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        //EmailCommT: Record 14005144;  //B2BUPG
        // ReportHelperCU: Codeunit 14005067;  //B2BUPG
        // EmailCommT2: Record 14005144;  //B2BUPG
        // DefSetup: Record 14005001;  //B2BUPG
        "--FP6.2.08--": Integer;
        CustEntryEdit: Codeunit 103;
        AllowEdit: Boolean;
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        ShippingAgent: Record 291;
        ShippingAgentServices: Record 5790;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'Invoice No.';
        Aux2: Text;

    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;   //Addon
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, "No.", DocTypeTXT, FORMAT("Posting Date"),
    //                                "Sell-to Customer Name", "Sell-to Contact", '', "Salesperson Code", Aux1, Aux2, '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                                                                                                                       //  END;
    //                                                                                                                                       //END;
    // END;
}
