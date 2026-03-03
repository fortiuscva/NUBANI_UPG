namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50049 "Sales Return Order Ext" extends "Sales Return Order"
{
    CaptionML = ENU = 'Sales Return Order',
               ESM = 'Devoluci¢n venta',
               FRC = 'Retour vente',
               ENC = 'Sales Return Order';
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
        moveafter("Sell-to County"; "Sell-to Post Code")
        addafter(Status)
        {
            field("No. of Pallets"; Rec."No. of Pallets")
            {
                ApplicationArea = All;
            }
        }
        addafter("No. of Pallets")
        {
            field("Shipping Status"; Rec."Shipping Status")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Bill-to City"; "Bill-to County")
        moveafter("Bill-to County"; "Bill-to Post Code")
        moveafter("Applies-to ID"; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        addafter("Tax Area Code")
        {
            field("Orig. Invoice No."; Rec."Orig. Invoice No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Ship-to Address 2"; "Ship-to City")
        moveafter("Ship-to City"; "Ship-to County")
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade',
                           ESM = 'Comercio exterior',
                           FRC = 'Commerce ‚tranger',
                           ENC = 'Foreign Trade';
        }
    }
    actions
    {
        modify("&Return Order")
        {
            CaptionML = ENU = '&Return Order',
                                 ESM = '&Devoluci¢n',
                                 FRC = '&Retour',
                                 ENC = '&Return Order';
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
                    PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
            end;
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
            CaptionML = ENU = 'A&pprovals',
                                 ESM = 'A&probaciones',
                                 FRC = 'A&pprobations',
                                 ENC = 'A&pprovals';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents',
                                 ESM = 'Documentos',
                                 FRC = 'Documents',
                                 ENC = 'Documents';
        }
        modify("Return Receipts")
        {
            CaptionML = ENU = 'Return Receipts',
                                 ESM = 'Recep. devoluci¢n',
                                 FRC = 'R‚ceptions retour',
                                 ENC = 'Return Receipts';
        }
        modify("Cred&it Memos")
        {
            CaptionML = ENU = 'Cred&it Memos',
                                 ESM = 'Nota Cr‚d&ito',
                                 FRC = 'A&voirs',
                                 ENC = 'Cred&it Memos';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                 ESM = 'L¡neas ubicac./ pic&k exist.',
                                 FRC = 'Lignes d articles en stoc&k … classer/pr‚lever',
                                 ENC = 'In&vt. Put-away/Pick Lines';

        }
        modify("Whse. Receipt Lines")
        {
            CaptionML = ENU = 'Whse. Receipt Lines',
                                 ESM = 'L¡neas recep. alm.',
                                 FRC = 'Lignes r‚ception entrep“t',
                                 ENC = 'Whse. Receipt Lines';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease',
                                 ESM = 'Lan&zar',
                                 FRC = '&Lancer',
                                 ENC = 'Re&lease';
        }
        modify(Action7)
        {
            CaptionML = ENU = 'Release',
                                 ESM = 'Lanzar',
                                 FRC = 'Lancer',
                                 ENC = 'Release';
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
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries',
                                 ESM = 'Liquidar movs.',
                                 FRC = 'Affecter les ‚critures',
                                 ENC = 'Apply Entries';
        }
        modify("Create Return-Related &Documents")
        {
            CaptionML = ENU = 'Create Return-Related &Documents',
                                 ESM = 'Crear docs. &relacionados-dev.',
                                 FRC = 'Cr‚er documents ass&oci‚s retour',
                                 ENC = 'Create Return-Related &Documents';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document',
                                 ESM = 'Copiar l¡neas',
                                 FRC = 'Copier document',
                                 ENC = 'Copy Document';
        }
        modify(MoveNegativeLines)
        {
            CaptionML = ENU = 'Move Negative Lines',
                                 ESM = 'Mover l¡neas negativas',
                                 FRC = 'D‚placer lignes n‚gatives',
                                 ENC = 'Move Negative Lines';
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse',
                                 ESM = 'Revertir l¡neas doc&umentos registrados',
                                 FRC = 'Extraire les lignes de doc&ument report‚es … inverser',
                                 ENC = 'Get Posted Doc&ument Lines to Reverse';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archi&ve Document',
                                 ESM = '&Archivar documento',
                                 FRC = 'Archi&ver document',
                                 ENC = 'Archi&ve Document';
        }
        modify("Send IC Return Order Cnfmn.")
        {
            CaptionML = ENU = 'Send IC Return Order Cnfmn.',
                                 ESM = 'Confirmar env¡o devoluci¢n IC',
                                 FRC = 'Envoyer une confirmation de commande de retour IC',
                                 ENC = 'Send IC Return Order Cnfmn.';
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
        modify(Action13)
        {
            CaptionML = ENU = 'Warehouse',
                                 ESM = 'Almac‚n',
                                 FRC = 'Entrep“t',
                                 ENC = 'Warehouse';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt',
                                 ESM = 'Crear &recep. almac‚n',
                                 FRC = 'Cr‚er un re‡u d &entrep“t',
                                 ENC = 'Create &Whse. Receipt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away / Pick',
                                 ESM = 'Crear &ubicac./ pick. inventario',
                                 FRC = 'Cr‚er une r‚servation/sortie de stoc&k',
                                 ENC = 'Create Inventor&y Put-away / Pick';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting',
                                 ESM = '&Registro',
                                 FRC = 'Rep&ort',
                                 ENC = 'P&osting';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost',
                                 ESM = '&Registrar',
                                 FRC = 'Rep&orter',
                                 ENC = 'P&ost';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print',
                                 ESM = 'Registrar e &imprimir',
                                 FRC = 'Reporter et im&primer',
                                 ENC = 'Post and &Print';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch',
                                 ESM = 'Registrar por &lotes',
                                 FRC = 'Reporter &lot',
                                 ENC = 'Post &Batch';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue',
                                 ESM = 'Quitar de cola de proyecto',
                                 FRC = 'Supprimer de la file d attente des travaux',
                                 ENC = 'Remove From Job Queue';
        }

    }
    trigger OnOpenPage()
    begin
        //NUB1.01 Start
        IF EventsandSubcribers.GetSalesPersonFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Salesperson Code", EventsandSubcribers.GetSalesPersonFilter);
        END;
        //NUB1.01 End
    end;

    var
        EventsandSubcribers: codeunit EventsandSubscribers;
}
