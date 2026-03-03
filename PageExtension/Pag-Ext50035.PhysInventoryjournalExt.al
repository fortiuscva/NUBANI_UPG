namespace Nubani.Nubani;

using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Journal;

pageextension 50035 "Phys. Inventory journal Ext" extends "Phys. Inventory Journal"
{
    CaptionML = ENU = 'Phys. Inventory Journal',
               ESM = 'Diario inventario f¡sico',
               FRC = 'Journal d‚compte inventaire',
               ENC = 'Phys. Inventory Journal';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name',
                           ESM = 'Nombre secci¢n',
                           FRC = 'Nom de lot',
                           ENC = 'Batch Name';
        }
        addafter(CurrentJnlBatchName)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        // modify("Entry Type")
        // {
        //     OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.',
        //                          ESM = 'Compra,Venta,Ajuste positivo,Ajuste negativo',
        //                          FRC = 'Achat,Vente,Ajust. positif,Ajust. n‚gatif',
        //                          ENC = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
        // }
        addafter("Document No.")
        {
            field(Skip; Rec.Skip)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Bin Code")
        {
            field("Serial No. for Phys. Inv."; Rec."Serial No. for Phys. Inv.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Serial No. for Phys. Inv.")
        {
            field("Lot No. for Phys. Inv."; Rec."Lot No. for Phys. Inv.")
            {
                ApplicationArea = All;
            }
        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description',
                           ESM = 'Descripci¢n producto',
                           FRC = 'Description article',
                           ENC = 'Item Description';
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'Dimensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. &seguim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents',
                                 ESM = 'Contenidos ubicaci¢n',
                                 FRC = 'Contenu de la zone',
                                 ENC = 'Bin Contents';
        }
        modify("&Item")
        {
            CaptionML = ENU = '&Item',
                                 ESM = '&Producto',
                                 FRC = '&Article',
                                 ENC = '&Item';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card',
                                 ESM = 'Ficha',
                                 FRC = 'Fiche',
                                 ENC = 'Card';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries',
                                 ESM = '&Movimientos',
                                 FRC = '&critures',
                                 ENC = 'Ledger E&ntries';
        }
        modify("Phys. In&ventory Ledger Entries")
        {
            CaptionML = ENU = 'Phys. In&ventory Ledger Entries',
                                 ESM = 'Movs. in&ventario f¡sico',
                                 FRC = 'critures du grand livre de l inventaire physique',
                                 ENC = 'Phys. In&ventory Ledger Entries';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by',
                                 ESM = 'Disponibilidad prod. por',
                                 FRC = 'Disponibilit‚ d article par',
                                 ENC = 'Item Availability by';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event',
                                 ESM = 'Evento',
                                 FRC = 'v‚nement',
                                 ENC = 'Event';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period',
                                 ESM = 'Periodo',
                                 FRC = 'P‚riode',
                                 ENC = 'Period';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant',
                                 ESM = 'Variante',
                                 FRC = 'Variante',
                                 ENC = 'Variant';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location',
                                 ESM = 'Almac‚n',
                                 FRC = 'Emplacement',
                                 ENC = 'Location';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level',
                                 ESM = 'Nivel L.M.',
                                 FRC = 'Niveau nomenclature',
                                 ENC = 'BOM Level';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify(CalculateInventory)
        {
            ApplicationArea = All;
            CaptionML = ENU = 'Calculate &Inventory',
                                 ESM = 'Calcular &inventario f¡sico',
                                 FRC = 'Calculer l &inventaire',
                                 ENC = 'Calculate &Inventory';
            // PromotedIsBig = true;  //B2BUPG
        }
        addafter(CalculateInventory)
        {
            action(CalculateInventoryLW)
            {
                ApplicationArea = All;
                Ellipsis = true;
                CaptionML = ENU = 'LW Calculate &Inventory',
                                 ESM = 'Calcular &inventario f¡sico',
                                 FRC = 'Calculer l &inventaire',
                                 ENC = 'Calculate &Inventory';
                Promoted = false;
                // PromotedIsBig = false;  //B2BUPG
                // PromotedCategory = Process;
                trigger OnAction()
                VAR
                    CalcQtyOnHand: Report "Calculate Inventory - LW";
                BEGIN
                    CalcQtyOnHand.SetItemJnlLine(Rec);
                    CalcQtyOnHand.RUNMODAL;
                    CLEAR(CalcQtyOnHand);
                END;
            }
        }
        modify(CalculateCountingPeriod)
        {
            CaptionML = ENU = '&Calculate Counting Period',
                                 ESM = 'Ca&lcular periodo recuento',
                                 FRC = '&Calculer p‚riode d inventaire',
                                 ENC = '&Calculate Counting Period';
        }
        addafter(CalculateCountingPeriod)
        {
            action(UpdateBatchForNegativePosting)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Update Batch For NegativePosting';
                Promoted = false;
                // PromotedIsBig = false;  //B2BUPG
                // PromotedCategory = Process;
                trigger OnAction()
                BEGIN

                    UpdateBatchForNegativeInventory;
                    CurrPage.UPDATE(FALSE);
                END;
            }
        }
        addafter(UpdateBatchForNegativePosting)
        {
            action(UpdateLots)
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Update Lot On All Lines';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    //NUB1.01 Start
                    UpdateLotsOnAllLines;
                    CurrPage.UPDATE(FALSE);
                    //NUB1.01 End
                END;
            }
        }
        addafter(UpdateLots)
        {
            action(UpdateLotsOnCurrLine)
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Update Lot On Curr. Line';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    //NUB1.01 Start
                    UpdateLotsOnCurrLines;
                    CurrPage.UPDATE(FALSE);
                    //NUB1.01 End
                END;
            }
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print',
                                 ESM = '&Imprimir',
                                 FRC = '&Imprimer',
                                 ENC = '&Print';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting',
                                 ESM = '&Registro',
                                 FRC = 'Rep&ort',
                                 ENC = 'P&osting';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report',
                                 ESM = 'Informe prueba',
                                 FRC = 'Tester le report',
                                 ENC = 'Test Report';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost',
                                 ESM = '&Registrar',
                                 FRC = 'Rep&orter',
                                 ENC = 'P&ost';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print',
                                 ESM = 'Registrar e &imprimir',
                                 FRC = 'Reporter et im&primer',
                                 ENC = 'Post and &Print';
        }
        addlast("P&osting")
        {
            // action(Action1100768001)  //10151 B2BUPG
            // {

            //     CaptionML = ENU = 'Physical Inventory Count';
            //     RunObject = Report 10151;
            // }
            action(Action1100768002)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Physical Inventory list';
                RunObject = Report 722;
            }
        }
    }
    PROCEDURE UpdateBatchForNegativeInventory()
    VAR
        CreateReservEntryLcl: Codeunit "Create Reserv. Entry";
        ItemJnlLineRecLcl: Record "Item Journal Line";
        TempName: Code[10];
        BatchName: Code[10];
        ILERecLcl: Record 32;
        ExpDate: Date;
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ReservMgt: Codeunit "Reservation Management";
        ItemJnlLine: record "Item Journal Line";
        ForSubtype: Integer;
        ForID: Code[20];
        OrderLineNo: Integer;
        ForRefNo: Integer;
        ForReservEntry: Record "Reservation Entry";



    BEGIN
        TempName := Rec."Journal Template Name";
        BatchName := Rec."Journal Batch Name";
        ItemJnlLineRecLcl.RESET;
        ItemJnlLineRecLcl.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLineRecLcl.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IF ItemJnlLineRecLcl.FINDSET THEN
            REPEAT

                CLEAR(ReservMgt);
                SetItemJnlLine(ItemJnlLineRecLcl);
                ReservMgt.SetItemTrackingHandling(1); // Allow Deletion
                ReservMgt.DeleteReservEntries(TRUE, 0);

                ItemJnlLineRecLcl.VALIDATE("Qty. (Phys. Inventory)", 0);
                ItemJnlLineRecLcl.MODIFY;
                IF (ItemJnlLineRecLcl."Quantity (Base)" <> 0) AND ((ItemJnlLineRecLcl."Lot No. for Phys. Inv." <> '') OR (ItemJnlLineRecLcl."Serial No. for Phys. Inv." <> '')) THEN BEGIN

                    ExpDate := 0D;

                    ILERecLcl.RESET;
                    ILERecLcl.SETRANGE("Item No.", ItemJnlLineRecLcl."Item No.");
                    ILERecLcl.SETRANGE("Variant Code", ItemJnlLineRecLcl."Variant Code");
                    ILERecLcl.SETRANGE("Location Code", ItemJnlLineRecLcl."Location Code");
                    ILERecLcl.SETRANGE("Lot No.", ItemJnlLineRecLcl."Lot No. for Phys. Inv.");
                    ILERecLcl.SETRANGE("Serial No.", ItemJnlLineRecLcl."Serial No. for Phys. Inv.");
                    ILERecLcl.SETFILTER("Expiration Date", '<>%1', 0D);
                    IF ILERecLcl.FINDLAST THEN
                        ExpDate := ILERecLcl."Expiration Date";



                    CLEAR(CreateReservEntryLcl);
                    // CreateReservEntryLcl.CreateReservEntryFor(DATABASE::"Item Journal Line", // source type
                    //                                ItemJnlLineRecLcl."Entry Type", // source subtype
                    //                                TempName, // source id
                    //                                BatchName, // source batch name
                    //                                0, // source prod. order line -> should not be filled in
                    //                                ItemJnlLineRecLcl."Line No.", // source ref. no.
                    //                                ItemJnlLineRecLcl."Qty. per Unit of Measure", // qty per uom
                    //                                ItemJnlLineRecLcl.Quantity, //quantity
                    //                                ItemJnlLineRecLcl."Quantity (Base)", // quantity (base) abs???
                    //                                ItemJnlLineRecLcl."Serial No. for Phys. Inv.", // serial no.
                    //                                ItemJnlLineRecLcl."Lot No. for Phys. Inv."); // lot no.//B2BUPG
                    CreateReservEntryLcl.CreateReservEntryFor(ItemJnlLineRecLcl."Entry Type".AsInteger(), ForSubtype, TempName, BatchName, ItemJnlLineRecLcl."Line No.", ForRefNo, ItemJnlLineRecLcl."Qty. per Unit of Measure", ItemJnlLineRecLcl.Quantity, ItemJnlLineRecLcl."Quantity (Base)", ForReservEntry); //By B2BUPG

                    CreateReservEntryLcl.SetDates(0D, ExpDate);
                    //CreateReservEntryLcl.SetNewSerialLotNo('',"Item Reclass Details"."Lot No.");
                    //CreateReservEntryLcl.SetNewExpirationDate("Item Reclass Details"."Expiration Date");
                    CreateReservEntryLcl.CreateEntry(ItemJnlLineRecLcl."Item No.", // itemno
                                        ItemJnlLineRecLcl."Variant Code", // variant code
                                        ItemJnlLineRecLcl."Location Code", // location code
                                        '', // description
                                        0D, // expected receipt date
                                        WORKDATE, // shipment date
                                        0, // transferred from entry no
                                        Enum::"Reservation Status"::"Prospect"); // status
                END;
            UNTIL ItemJnlLineRecLcl.NEXT = 0;
    END;

    PROCEDURE UpdateLotsOnAllLines();
    VAR
        ItemJnlLineRecLcl: Record "Item Journal Line";
        Text50000: TextConst ENU = 'Do you want to update the item tracking lines automatically?';
        LinesProcessedVarcl: Boolean;
        Text50001: TextConst ENU = 'Item Tracking Lines created successfully.';
    BEGIN
        IF NOT CONFIRM(Text50000, FALSE) THEN
            EXIT;
        ItemJnlLineRecLcl.RESET;
        ItemJnlLineRecLcl.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLineRecLcl.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineRecLcl.SETFILTER("Lot No. for Phys. Inv.", '<>%1', '');
        ItemJnlLineRecLcl.SETFILTER("Serial No. for Phys. Inv.", '=%1', '');
        ItemJnlLineRecLcl.SETFILTER(Quantity, '<>%1', 0);
        IF ItemJnlLineRecLcl.FINDSET THEN BEGIN
            REPEAT
                ItemJnlLineRecLcl.CreateReservEntryForLots;
                LinesProcessedVarcl := TRUE;
            UNTIL ItemJnlLineRecLcl.NEXT = 0;
        END;
        IF LinesProcessedVarcl THEN
            MESSAGE(Text50001);
    END;

    PROCEDURE UpdateLotsOnCurrLines();
    VAR
        ItemJnlLineRecLcl: Record "Item Journal Line";
        Text50000: TextConst ENU = 'Do you want to update the item tracking lines automatically?';
        LinesProcessedVarcl: Boolean;
        Text50001: TextConst ENU = 'Item Tracking Lines created successfully.';
    BEGIN
        IF NOT CONFIRM(Text50000, FALSE) THEN
            EXIT;
        ItemJnlLineRecLcl.RESET;
        ItemJnlLineRecLcl.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLineRecLcl.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineRecLcl.SETRANGE("Line No.", Rec."Line No.");
        ItemJnlLineRecLcl.SETFILTER("Lot No. for Phys. Inv.", '<>%1', '');
        ItemJnlLineRecLcl.SETFILTER("Serial No. for Phys. Inv.", '=%1', '');
        ItemJnlLineRecLcl.SETFILTER(Quantity, '<>%1', 0);
        IF ItemJnlLineRecLcl.FINDSET THEN BEGIN
            REPEAT
                ItemJnlLineRecLcl.CreateReservEntryForLots;
                LinesProcessedVarcl := TRUE;
            UNTIL ItemJnlLineRecLcl.NEXT = 0;
        END;
        IF LinesProcessedVarcl THEN
            MESSAGE(Text50001);
    END;

    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
    var
        ItemJnlLine: record "Item Journal Line";
    begin
        ItemJnlLine := NewItemJnlLine;
    end;
}
