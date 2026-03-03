namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50022 "Posted sales invoice Ext" extends "Posted Sales Invoice"
{
    CaptionML = ENU = 'Posted Sales Invoice',
               ESM = 'Hist¢rico facturas venta',
               FRC = 'Fact. vente report‚e',
               ENC = 'Posted Sales Invoice';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify("Sell-to County")
        {
            CaptionML = ENU = 'Sell-to State / ZIP Code',
                           ESM = 'Venta a-Estado / C.P.',
                           FRC = 'tat-Province/code postal (d‚biteur)',
                           ENC = 'Sell-to Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        modify("Sell-to Post Code")
        {
            Editable = FALSE;
        }
        moveafter("Responsibility Center"; "Your Reference")
        addafter("Your Reference")
        {
            field("Assigned User ID"; Rec."Assigned User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field("Pallets Spaces"; Rec."Pallets Spaces")
            {
                ApplicationArea = All;
            }
        }
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code',
                           ESM = 'Estado / C.P.',
                           FRC = 'tat-Province/code postal',
                           ENC = 'Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }
        modify("Bill-to Post Code")
        {
            Editable = FALSE;
        }
        // addbefore("Tax Liable")
        // {
        //     field(GetCreditcardNumber; Rec.GetCreditcardNumber)
        //     {
        //         CaptionML = ENU = 'Cr. Card Number (Last 4 Digits)',
        //                    ESM = 'N£mero tarjeta cr‚dito (cuatro £ltimos d¡gitos)',
        //                    FRC = 'Num‚ro de carte de cr‚dit (4ÿderniers chiffres)',
        //                    ENC = 'Cr. Card Number (Last 4 Digits)';
        //         Editable = false;
        //     }
        // }
        modify("Tax Liable")
        {
            Editable = FALSE;

        }
        modify("Tax Area Code")
        {
            Editable = FALSE;
        }
        modify("Ship-to City")
        {
            Editable = FALSE;
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to State / ZIP Code',
                           ESM = 'Env¡o a-Estado / C.P.',
                           FRC = 'tat-Province/code postal de livraison',
                           ENC = 'Ship-to Province/State / Postal/ZIP Code';

            Editable = FALSE;
        }

        moveafter("Ship-to Contact"; "Ship-to UPS Zone")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        // addafter("Foreign Trade")
        // {
        //     group("Electronic Invoice")
        //     {
        //         CaptionML = ENU = 'Electronic Invoice',
        //                    ESM = 'Factura electr¢nica',
        //                    FRC = 'Facture ‚lectronique',
        //                    ENC = 'Electronic Invoice';
        //     }
        // }
        moveafter("Electronic Invoice"; "Electronic Document Status", "Date/Time Stamped", "Date/Time Sent", "Date/Time Canceled", "Error Code")
        moveafter("Error Code"; "Error Description", "PAC Web Service Name", "Fiscal Invoice Number PAC", "No. of E-Documents Sent")

    }
    actions
    {
        modify("&Invoice")
        {
            CaptionML = ENU = '&Invoice',
                                 ESM = '&Factura',
                                 FRC = '&Facture',
                                 ENC = '&Invoice';
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
                    PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, Rec."No.")
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, Rec."No.");

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

        // addafter("&Electronic Document")
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
        //             RequestStampEDocument;
        //         END;
        //     }
        // }
        // addafter("S&end")
        // {
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
        // }
        // addafter("Export E-Document as &XML")
        // {
        //     action("&Cancel")
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
        // }
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
    var
        "--FP--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        // EmailCommT: Record 14005144;   //B2BUPG
        // ReportHelperCU: Codeunit 14005067;  //B2BUPG
        // EmailCommT2: Record 14005144;  //B2BUPG
        //  DefSetup: Record 14005001;  //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        ShippingAgent: Record 291;
        ShippingAgentServices: Record 5790;
        PaymentTerms: Record 3;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'Order No.';
        Aux2: Text;



    // PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;  //Addon
    // BEGIN
    //     //IF "Salesperson Code" <> '' THEN BEGIN
    //     //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

    //     //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
    //     OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, "No.", DocTypeTXT, FORMAT("Order Date"), "Bill-to Name", "Bill-to Contact",
    //                                FORMAT("Shipment Date"), "Salesperson Code", Aux1, Aux2, '', '', '', SubjLine); //Substitute Strings into Email Body
    //                                                                                                                //  END;
    //                                                                                                                //END;
    // END;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnSalesPerson; //NUB1.01
    end;
}
