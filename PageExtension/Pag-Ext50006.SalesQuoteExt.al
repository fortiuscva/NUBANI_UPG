namespace Nubani.Nubani;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item.Picture;

pageextension 50006 "Sales Quote Ext" extends "Sales Quote"
{
    CaptionML = ENU = 'Sales Quote',
               ESM = 'Cotizaci¢n venta',
               FRC = 'Devis',
               ENC = 'Sales Quote';
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
        }
        moveafter("Sell-to County"; "Sell-to Post Code")
        addafter("Requested Delivery Date")
        {
            field("Quote Expiration Date"; Rec."Quote Expiration Date")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Salesperson Code"; "Your Reference")
        moveafter("Your Reference"; "External Document No.")
        moveafter(Status; "No. of Archived Versions")
        addafter("No. of Archived Versions")
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
        moveafter("Bill-to County"; "Bill-to Post Code")
        moveafter("Payment Method Code"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        moveafter("Ship-to Address 2"; "Ship-to City")
        moveafter("Ship-to City"; "Ship-to County")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
        addbefore(Control1903720907)
        {
            part(LotNumbersByBin; 9126)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Lot Numbers By Bin';
                Provider = SalesLines;
                SubPageLink = "Item No." = FIELD("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
                //"Variant Code" = FIELD("Variant Code");


            }

        }
        addfirst(factboxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
                Provider = SalesLines;
            }
            part(Control1100796006; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100796005; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
        }

    }
    actions
    {
        modify("&Quote")
        {
            CaptionML = ENU = '&Quote',
                                 ESM = 'Co&tizaci¢n',
                                 FRC = '&Devis',
                                 ENC = '&Quote';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics',
                                 ESM = 'Estad¡sticas',
                                 FRC = 'Statistiques',
                                 ENC = 'Statistics';
            // PromotedIsBig = true;  //B2BUPG
            trigger OnAfterAction()
            begin
                IF Rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Stats.", Rec);
            end;
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer Card',
                                 ESM = 'Ficha cliente',
                                 FRC = 'Fiche client',
                                 ENC = 'Customer Card';
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
        addafter(Dimensions)
        {
            action("Quick Item Entry")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Quick Item Entry';
                Promoted = true;
                PromotedIsBig = true;
                Image = ItemLines;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    QuickItem: Page "Quick Item Entry";
                BEGIN
                    Rec.TESTFIELD(Rec.Status, Rec.Status::Open);
                    QuickItem.SetValues(Rec."No.", Rec."Sell-to Customer No.", Rec."Document Type");
                    QuickItem.RUN;
                END;
            }
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
            Promoted = true;
        }
        addlast(processing)
        {
            action("Customer Catalog")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Catalog';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    SalesHeader.SETRANGE("No.", Rec."No.");
                    IF SalesHeader.FINDFIRST THEN;
                    REPORT.RUNMODAL(REPORT::"Customer catalog (Sales Quote)", TRUE, FALSE, SalesHeader);
                END;
            }
            action(Action1100768005)  //14005135 B2BUPG
            {
                ApplicationArea = All;
                CaptionML = ENU = '&View Sales History';
                RunObject = Page "Recent Sales History";
                RunPageLink = "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = View;
                PromotedCategory = Process;
            }
        }
        // addafter("Customer Catalog")
        // {
        /*  action("Sales Promotion")  //10159 B2BUPG
         {
             CaptionML = ENU = 'Sales Promotion',
                              ESM = 'Promoci¢n de ventas',
                              FRC = 'Promotion de ventes',
                              ENC = 'Sales Promotion';
             RunObject = Report 10159;
             Promoted = false;
             Image = Report;
             PromotedCategory = Report;
         } */

        /*   action("Customer/Item Statistics")  //10048 B2BUPG
          {
              CaptionML = ENU = 'Customer/Item Statistics',
                               ESM = 'Estad. cliente/producto',
                               FRC = 'Statistiques client/article',
                               ENC = 'Customer/Item Statistics';
              RunObject = Report 10048;
              Promoted = false;
              Image = Report;
              PromotedCategory = Report;
          } */
        //}
        modify(Action3)
        {
            CaptionML = ENU = 'Release',
                                 ESM = 'Lanzar',
                                 FRC = 'Lancer',
                                 ENC = 'Release';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease',
                                 ESM = 'Lan&zar',
                                 FRC = '&Lancer',
                                 ENC = 'Re&lease';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open',
                                 ESM = '&Volver a abrir',
                                 FRC = 'R‚&ouvrir',
                                 ENC = 'Re&open';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount',
                                 ESM = 'Calcular dto. en la &factura',
                                 FRC = 'Calculer escompte &facture',
                                 ENC = 'Calculate &Invoice Discount';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document',
                                 ESM = 'Copiar l¡neas',
                                 FRC = 'Copier document',
                                 ENC = 'Copy Document';
            //PromotedIsBig = true; B2BUPG
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document',
                                 ESM = '&Archivar documento',
                                 FRC = 'Archi&ver document',
                                 ENC = 'Archi&ve Document';
        }
        modify(Create)
        {
            CaptionML = ENU = 'Create',
                                 ESM = 'Crear',
                                 FRC = 'Cr‚er',
                                 ENC = 'Create';
        }
        modify(MakeOrder)
        {
            CaptionML = ENU = 'Make &Order',
                                 ESM = '&Convertir en pedido',
                                 FRC = 'Faire &commande',
                                 ENC = 'Make &Order';
            //PromotedIsBig = true; //B2BUPG
        }
        modify("C&reate Customer")
        {
            CaptionML = ENU = 'C&reate Customer',
                                 ESM = 'C&rear cliente',
                                 FRC = 'C&r‚er client',
                                 ENC = 'C&reate Customer';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval',
                                 ESM = 'Aprobaci¢n',
                                 FRC = 'Approbation',
                                 ENC = 'Approval';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request',
                                 ESM = 'Enviar solicitud a&probaci¢n',
                                 FRC = 'Envoyer demande d a&pprobation',
                                 ENC = 'Send A&pproval Request';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest',
                                 ESM = '&Cancelar solicitud aprobaci¢n',
                                 FRC = 'Annuler demande d appro&bation',
                                 ENC = 'Cancel Approval Re&quest';
        }
        addlast(Approval)
        {
            action(SendAsPDF)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'SendAsPDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = SendEmailPDF;
                PromotedCategory = Process;
            }
            action(SaveAsPDF)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'SaveAsPDF';
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintForm;
                PromotedCategory = Process;
            }
        }
        addafter(CopyDocument)
        {
            action(NUBCopyDocument)
            {
                ApplicationArea = All;
                Caption = 'NUB Copy Document';
                Ellipsis = true;
                Enabled = Rec."No." <> '';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                trigger OnAction()
                var
                    NUBCopySalesDocument: Report "NUB Sales Copy Document";
                begin
                    NUBCopySalesDocument.SetSalesHeader(Rec);
                    NUBCopySalesDocument.RunModal();

                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                    CurrPage.SalesLines.Page.ForceTotalsCalculation();
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //NUB1.01 Start
        IF EventsandSubscribers.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventsandSubscribers.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    end;




    /*  PROCEDURE SendAsPDFSubstitutions(IncomingText: Text; SubjLine: Boolean) OutgoingText: Text;  //ADDon
     BEGIN
         //IF "Salesperson Code" <> '' THEN BEGIN
         //  IF Salesperson.GET("Salesperson Code") THEN BEGIN

         //DoEmailSubstitutions(IncomingText,ExtNo,"No.",<Document Type Text>,Document Date,Customer/Vendor Name,Contact Name,Other Date,Salesperson/Purchaser Code,Aux1,Aux2,Aux3,Cust1,Cust2,SubjLine); //All passed as Text except 'SubjLine' (Bool)
         OutgoingText := ReportHelperCU.DoEmailSubstitutions(IncomingText, ExtNo, Rec."No.", DocTypeTXT, FORMAT(Rec."Order Date"), Rec."Sell-to Customer Name",
                                                          Rec."Sell-to Contact", FORMAT(Rec."Shipment Date"), Rec."Salesperson Code", Aux1, Aux2, '', '', '', SubjLine); //Substitute Strings into Email Body
                                                                                                                                                             //  END;
                                                                                                                                                             //END;
     END; */

    var
        "--SendToPDF--": Integer;
        Tofile: Text;
        PdfDownloaded: Boolean;
        ExcelDownloaded: Boolean;
        ReportSelections: Record 77;
        ReportID: Integer;
        BodyText: Text;
        // EmailCommT: Record 14005144;  //B2BUPG
        // ReportHelperCU: Codeunit 14005067;  //B2BUPG
        SalesHeader: Record "Sales Header";
        // EmailCommT2: Record 14005144;  //B2BUPG
        // DefSetup: Record 14005001;   //B2BUPG
        "--FP7.0.08": Integer;
        ImgTag: Text;
        "--FP7.0.09": Integer;
        Salesperson: Record 13;
        EmailSubj: Text;
        ExtNo: Text;
        Aux1: Text;
        "--FP7.0.09_": TextConst ENU = '';
        DocTypeTXT: TextConst ENU = 'Your Request';
        Aux2: Text;
        "--BSP--": Integer;
        EventsandSubscribers: codeunit EventsandSubscribers;
    // BusSnapCU: Codeunit 14005085;  //B2BUPG
    // BusT: Record 14005085;   //B2BUPG


}
