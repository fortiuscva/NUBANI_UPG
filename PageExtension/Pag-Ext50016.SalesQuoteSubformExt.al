namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50016 "Sales Quote Subform Ext" extends "Sales Quote Subform"
{
    layout
    {
        addbefore("Variant Code")
        {
            field("Inner UPC"; Rec."Inner UPC")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Description; "Description 2")
        modify(PriceExists)
        {
            CaptionML = ENU = 'Sales Price Exists',
                           ESM = 'Existe precio venta',
                           FRC = 'Prix de vente existant',
                           ENC = 'Sales Price Exists';
        }
        addafter(PriceExists)
        {
            field(Each; Rec.Each)
            {
                ApplicationArea = All;
            }
        }
        modify("Tax Liable")
        {

            Visible = FALSE;
            Editable = FALSE;
        }
        modify("Tax Area Code")
        {
            Visible = FALSE;
        }
        moveafter("Tax Area Code"; "Tax Group Code")
        moveafter("Line Amount"; "Amount Including VAT")
        modify(LineDiscExists)
        {
            CaptionML = ENU = 'Sales Line Disc. Exists',
                           ESM = 'Existe dto. l¡nea venta',
                           FRC = 'Rem. ligne vente existante',
                           ENC = 'Sales Line Disc. Exists';
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
        modify("Select Item Substitution")
        {
            CaptionML = ENU = 'Select Item Substitution',
                                 ESM = 'Seleccionar prod. alternativo',
                                 FRC = 'S‚lectionner la substitution d article',
                                 ENC = 'Select Item Substitution';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                                 ESM = 'D&imensiones',
                                 FRC = 'Dimensions',
                                 ENC = 'Dimensions';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments',
                                 ESM = 'C&omentarios',
                                 FRC = 'Co&mmentaires',
                                 ENC = 'Co&mments';
        }
        modify("Item Charge &Assignment")
        {
            CaptionML = ENU = 'Item Charge &Assignment',
                                 ESM = '&Asignaci¢n cargos prod.',
                                 FRC = '&Affectation frais annexes',
                                 ENC = 'Item Charge &Assignment';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines',
                                 ESM = 'L¡ns. se&guim. prod.',
                                 FRC = '&Lignes de tra‡abilit‚ d article',
                                 ENC = 'Item &Tracking Lines';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order',
                                 ESM = 'Ensamblar para pedido',
                                 FRC = 'Assembler pour commande',
                                 ENC = 'Assemble to Order';
        }
        modify("Assemble-to-Order Lines")
        {
            CaptionML = ENU = 'Assemble-to-Order Lines',
                                 ESM = 'Ensamblar para l¡neas de pedido',
                                 FRC = 'Lignes Assembler pour commande',
                                 ENC = 'Assemble-to-Order Lines';
        }
        modify("Roll Up &Price")
        {
            CaptionML = ENU = 'Roll Up &Price',
                                 ESM = 'Revertir &precio',
                                 FRC = '&Prix relation',
                                 ENC = 'Roll Up &Price';
        }
        modify("Roll Up &Cost")
        {
            CaptionML = ENU = 'Roll Up &Cost',
                                 ESM = 'Distribuir &costo',
                                 FRC = '&Co–ts relation',
                                 ENC = 'Roll Up &Cost';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'F&unciones',
                                 FRC = 'Fonction&s',
                                 ENC = 'F&unctions';
        }
        modify(GetPrice)
        {
            CaptionML = ENU = 'Get &Price',
                                 ESM = 'Tomar &precio',
                                 FRC = 'Obtenir le &prix',
                                 ENC = 'Get &Price';
        }
        modify(GetLineDiscount)
        {
            CaptionML = ENU = 'Get Li&ne Discount',
                                 ESM = 'Tomar descuento l¡&nea',
                                 FRC = 'Obtenir l escompte de li&gne',
                                 ENC = 'Get Li&ne Discount';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM',
                                 ESM = 'D&esplegar L.M.',
                                 FRC = '&clater nomenclature',
                                 ENC = 'E&xplode BOM';
        }
        modify(InsertExtTexts)
        {
            CaptionML = ENU = 'Insert &Ext. Texts',
                                 ESM = 'Insertar &textos adicionales',
                                 FRC = 'Ins‚rer te&xte ‚tendu',
                                 ENC = 'Insert &Ext. Text';
        }
        addlast("F&unctions")
        {
            // action("Pop-&Up Notes")
            // {
            //     CaptionML = ENU = 'Pop-&Up Notes';
            //     trigger OnAction()
            //     BEGIN
            //         //POPN
            //         gnnrGetNotesForm();
            //     END;
            // }//B2BUPG
            action("Regular Items")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Regular Items';
                Image = ItemGroup;
                trigger OnAction()
                VAR
                    RegularItemsPage: Page "Regular Items";
                    SalesHeaderRecGbl: Record "Sales Header";
                BEGIN
                    //NUB1.01 Start
                    IF SalesHeaderRecGbl.GET(Rec."Document Type", Rec."Document No.") THEN
                        SalesHeaderRecGbl.TESTFIELD(Status, SalesHeader.Status::Open);

                    CLEAR(RegularItemsPage);
                    RegularItemsPage.SetValues(Rec."Document Type", Rec."Document No.");
                    RegularItemsPage.RUN;
                    //NUB1.01 End
                END;
            }
            action("Item Selection")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Item Selection';
                //Promoted = true;
                //PromotedIsBig = true;
                Image = ItemLines;
                //PromotedCategory = Process;
                trigger OnAction()
                VAR
                    ItemSelectionPage: Page "Item Selection";
                    SalesHeaderRecGbl: Record "Sales Header";
                BEGIN
                    //NUB1.01 Start
                    IF SalesHeaderRecGbl.GET(Rec."Document Type", Rec."Document No.") THEN
                        SalesHeaderRecGbl.TESTFIELD(Status, SalesHeader.Status::Open);

                    CLEAR(ItemSelectionPage);
                    ItemSelectionPage.SetValues(Rec."Document Type", Rec."Document No.");
                    ItemSelectionPage.RUN;
                    //NUB1.01 End
                END;
            }
        }
        addbefore(GetPrice)
        {
            action("Sales History")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales History';
                trigger OnAction()
                begin
                    GetItemHistory;
                end;
            }
        }
    }

    procedure GetItemHistory()
    begin
        LineLookupC.GetSalesLineHistory(Rec);
    end;

    var
        "--FP--": Integer;
        LineLookupC: Codeunit "Posting Doc.Line Reporting";
        // NotesCU: Codeunit 14005020;  //B2BUPG
        SalesHeader: Record "Sales Header";
}
