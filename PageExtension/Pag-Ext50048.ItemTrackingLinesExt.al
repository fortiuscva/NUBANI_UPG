namespace Nubani.Nubani;

using Microsoft.Inventory.Tracking;

pageextension 50048 "Item Tracking Lines Ext" extends "Item Tracking Lines"
{
    CaptionML = ENU = 'Item Tracking Lines',
               ESM = 'L¡ns. seguim. prod.',
               FRC = 'Lignes de tra‡abilit‚ d article',
               ENC = 'Item Tracking Lines';
    layout
    {
        modify(Source)
        {
            CaptionML = ENU = 'Source',
                           ESM = 'Origen',
                           FRC = 'Origine',
                           ENC = 'Source';
        }
        modify("SourceQuantityArray[1]")
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify(Handle1)
        {
            CaptionML = ENU = 'Qty. to Handle',
                           ESM = 'Cdad.a manipular',
                           FRC = 'Quantit‚ … traiter',
                           ENC = 'Qty. to Handle';
        }
        modify(Invoice1)
        {
            CaptionML = ENU = 'Qty. to Invoice',
                           ESM = 'Cdad. a facturar',
                           FRC = 'Quantit‚ … facturer',
                           ENC = 'Qty. to Invoice';
        }
        modify("Item Tracking")
        {
            CaptionML = ENU = 'Item Tracking',
                           ESM = 'Seguim. prod.',
                           FRC = 'Tra‡abilit‚',
                           ENC = 'Item Tracking';
        }
        modify(Quantity_ItemTracking)
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify(Handle2)
        {
            CaptionML = ENU = 'Qty. to Handle',
                           ESM = 'Cdad.a manipular',
                           FRC = 'Quantit‚ … traiter',
                           ENC = 'Qty. to Handle';
        }
        modify(Invoice2)
        {
            CaptionML = ENU = 'Qty. to Invoice',
                           ESM = 'Cdad. a facturar',
                           FRC = 'Quantit‚ … facturer',
                           ENC = 'Qty. to Invoice';
        }
        modify(Undefined)
        {
            CaptionML = ENU = 'Undefined',
                           ESM = 'Indefinido',
                           FRC = 'Non d‚fini',
                           ENC = 'Undefined';
        }
        modify(Quantity3)
        {
            CaptionML = ENU = 'Undefined Quantity',
                           ESM = 'Cdad. no definida',
                           FRC = 'Quantit‚ non d‚finie',
                           ENC = 'Undefined Quantity';
        }
        modify(Handle3)
        {
            CaptionML = ENU = 'Undefined Quantity to Handle',
                           ESM = 'Cdad. no definida a manipular',
                           FRC = 'Quantit‚ non d‚finie … traiter',
                           ENC = 'Undefined Quantity to Handle';
        }
        modify(Invoice3)
        {
            CaptionML = ENU = 'Undefined Quantity to Invoice',
                           ESM = 'Cdad. no definida a facturar',
                           FRC = 'Quantit‚ non d‚finie … facturer',
                           ENC = 'Undefined Quantity to Invoice';
        }
        modify("ItemTrackingCode.Code")
        {
            CaptionML = ENU = 'Item Tracking Code',
                           ESM = 'C¢d. seguim. prod.',
                           FRC = 'Code de suivi d article',
                           ENC = 'Item Tracking Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description',
                           ESM = 'Descripci¢n',
                           FRC = 'Description',
                           ENC = 'Description';
        }
        modify(AvailabilitySerialNo)
        {
            CaptionML = ENU = 'Availability, Serial No.',
                           ESM = 'Disponibilidad, N§ Serie',
                           FRC = 'Disponibilit‚, Nø de s‚rie',
                           ENC = 'Availability, Serial No.';
            ToolTipML = ENU = 'Serial No. Availability',
                           ESM = 'Disponibilidad n§ serie',
                           FRC = 'Disponibilit‚ de nø de s‚rie',
                           ENC = 'Serial No. Availability';

        }
        modify(AvailabilityLotNo)
        {
            CaptionML = ENU = 'Availability, Lot No.',
                           ESM = 'Disponibilidad, N§ Lote',
                           FRC = 'Disponibilit‚, Nø de lot',
                           ENC = 'Availability, Lot No';
            ToolTipML = ENU = 'Lot No. Availability',
                           ESM = 'Disponibilidad n§ lote',
                           FRC = 'Disponibilit‚ de nø de lot',
                           ENC = 'Lot No. Availability';

        }
        modify("Lot No.")
        {
            trigger OnAfterValidate()
            begin
                LotNoOnAfterValidate();
            end;
        }
    }
    actions
    {
        modify(ButtonLineReclass)
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify(Reclass_SerialNoInfoCard)
        {
            CaptionML = ENU = 'Serial No. Information Card',
                                 ESM = 'Ficha informaci¢n n§ serie',
                                 FRC = 'Fiche d information sur le nø de s‚rie',
                                 ENC = 'Serial No. Information Card';
        }
        modify(Reclass_LotNoInfoCard)
        {
            CaptionML = ENU = 'Lot No. Information Card',
                                 ESM = 'Ficha informaci¢n n§ lote',
                                 FRC = 'Fiche d information sur le nø de lot',
                                 ENC = 'Lot No. Information Card';
        }
        modify(NewSerialNoInformation)
        {
            CaptionML = ENU = 'New S&erial No. Information',
                                 ESM = 'Nu&eva informaci¢n n§ serie',
                                 FRC = 'Information sur le &nouveau nø de s‚rie',
                                 ENC = 'New S&erial No. Information';
        }
        modify(NewLotNoInformation)
        {
            CaptionML = ENU = 'New L&ot No. Information',
                                 ESM = 'Nueva inf&ormaci¢n n§ lote',
                                 FRC = 'Information sur le nouveau nø de l&ot',
                                 ENC = 'New L&ot No. Information';
        }
        modify(ButtonLine)
        {
            CaptionML = ENU = '&Line',
                                 ESM = '&L¡nea',
                                 FRC = '&Ligne',
                                 ENC = '&Line';
        }
        modify(Line_SerialNoInfoCard)
        {
            CaptionML = ENU = 'Serial No. Information Card',
                                 ESM = 'Ficha informaci¢n n§ serie',
                                 FRC = 'Fiche d information sur le nø de s‚rie',
                                 ENC = 'Serial No. Information Card';
        }
        modify(Line_LotNoInfoCard)
        {
            CaptionML = ENU = 'Lot No. Information Card',
                                 ESM = 'Ficha informaci¢n n§ lote',
                                 FRC = 'Fiche d information sur le nø de lot',
                                 ENC = 'Lot No. Information Card';
        }
        modify(FunctionsSupply)
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("Assign &Serial No.")
        {
            CaptionML = ENU = 'Assign &Serial No.',
                                 ESM = 'Asignar n§ &serie',
                                 FRC = 'Affecter nø de &s‚rie',
                                 ENC = 'Assign &Serial No.';
        }
        modify("Assign &Lot No.")
        {
            CaptionML = ENU = 'Assign &Lot No.',
                                 ESM = 'Asignar n§ &lote',
                                 FRC = 'Affecter nø l&ot',
                                 ENC = 'Assign &Lot No.';
        }
        modify("Create Customized SN")
        {
            CaptionML = ENU = 'Create Customized SN',
                                 ESM = 'Crear NS personalizado',
                                 FRC = 'Cr‚er nø de s‚rie personnalis‚',
                                 ENC = 'Create Customized SN';
        }
        modify("Refresh Availability")
        {
            CaptionML = ENU = 'Refresh Availability',
                                 ESM = 'Actualizar disponibilidad',
                                 FRC = 'Actualiser la disponibilit‚',
                                 ENC = 'Refresh Availability';
        }
        modify(FunctionsDemand)
        {
            CaptionML = ENU = 'F&unctions',
                                 ESM = 'Acci&ones',
                                 FRC = 'F&onctions',
                                 ENC = 'F&unctions';
        }
        modify("Assign Serial No.")
        {
            CaptionML = ENU = 'Assign &Serial No.',
                                 ESM = 'Asignar n§ &serie',
                                 FRC = 'Affecter nø de &s‚rie',
                                 ENC = 'Assign &Serial No.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Assign Lot No.")
        {
            CaptionML = ENU = 'Assign &Lot No.',
                                 ESM = 'Asignar n§ &lote',
                                 FRC = 'Affecter nø l&ot',
                                 ENC = 'Assign &Lot No.';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(CreateCustomizedSN)
        {
            CaptionML = ENU = 'Create Customized SN',
                                 ESM = 'Crear NS personalizado',
                                 FRC = 'Cr‚er nø de s‚rie personnalis‚',
                                 ENC = 'Create Customized SN';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Select Entries")
        {
            CaptionML = ENU = 'Select &Entries',
                                 ESM = 'Seleccionar &movs.',
                                 FRC = 'S‚lectionner les ‚critur&es',
                                 ENC = 'Select &Entries';
        }
        modify(Action64)
        {
            CaptionML = ENU = 'Refresh Availability',
                                 ESM = 'Actualizar disponibilidad',
                                 FRC = 'Actualiser la disponibilit‚',
                                 ENC = 'Refresh Availability';
        }
    }
    trigger OnClosePage()
    VAR
        resentry: Record "Reservation Entry";
    begin

        IF Rec."Source Type" = 37 THEN BEGIN
            resentry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");
            resentry.SETRANGE("Source ID", Rec."Source ID");
            resentry.SETRANGE("Source Ref. No.", Rec."Source Ref. No.");
            resentry.CALCSUMS(resentry."Quantity (Base)");

            IF soline.GET(soline."Document Type"::Order, Rec."Source ID", Rec."Source Ref. No.") THEN BEGIN
                soline."Lot Qty" := ABS(resentry."Quantity (Base)");
                soline.MODIFY;
            END;
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        whseline: Record 5767;
    begin
        IF Rec."Source Type" = 37 THEN BEGIN
            IF soline.GET(soline."Document Type"::Order, Rec."Source ID", Rec."Source Ref. No.") THEN BEGIN
                whseline.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                whseline.SETRANGE("Source Type", 37);
                whseline.SETRANGE("Source No.", soline."Document No.");
                whseline.SETRANGE("Source Line No.", soline."Line No.");
                IF NOT (whseline.ISEMPTY) THEN
                    ERROR('There is a pick for this lot. Lot assignment can not be deleted');
            END;
        END;
    end;

    VAR
        soline: Record 37;
        Text002: TextConst ENU = 'Quantity must be %1.', ESM = 'Cantidad debe ser %1.', FRC = 'La quantit‚ doit ˆtre %1.', ENC = 'Quantity must be %1.';
        Text003: TextConst ENU = 'negative', ESM = 'negativo', FRC = 'n‚gative', ENC = 'negative';
        Text004: TextConst ENU = 'positive', ESM = 'positivo', FRC = 'positif', ENC = 'positive';
        Text005: TextConst ENU = 'Error when writing to database.', ESM = 'Error al escribir en la base de datos.', FRC = 'Erreur lors de l ‚criture sur la base de donn‚es.', ENC = 'Error when writing to database.';
        Text006: TextConst ENU = 'The corrections cannot be saved as excess quantity has been defined.\Close the form anyway?', ESM = 'No se pueden guardar las correcciones porque existe un exceso de cdad.\¨Desea cerrar el formulario?', FRC = 'Les corrections ne peuvent ˆtre enregistr‚es car vous avez indiqu‚ une quantit‚ excessive.\Souhaitez-vous tout de mˆme fermer le formulaire ?', ENC = 'The corrections cannot be saved as excess quantity has been defined.\Close the form anyway?';
        Text007: TextConst ENU = 'Another user has modified the item tracking data since it was retrieved from the database.\Start again.', ESM = 'Otro usuario ha modificado datos seguim. prod. desde que se recuper¢ de la base de datos.\Empiece otra vez.', FRC = 'Un autre utilisateur a modifi‚ les donn‚es de tra‡abilit‚ depuis qu''elles ont ‚t‚ extraites de la base de donn‚es.\Veuillez recommencer.', ENC = 'Another user has modified the item tracking data since it was retrieved from the database.\Start again.';
        Text008: TextConst ENU = 'The quantity to create must be an integer.', ESM = 'La cantidad a crear debe ser un n§ entero.', FRC = 'La quantit‚ … cr‚er doit un entier.', ENC = 'The quantity to create must be an integer.';
        Text009: TextConst ENU = 'The quantity to create must be positive.', ESM = 'La cdad. a crear debe ser positiva.', FRC = 'La quantit‚ … cr‚er doit ˆtre positive.', ENC = 'The quantity to create must be positive.';
        Text011: TextConst ENU = 'Tracking specification with Serial No. %1 and Lot No. %2 already exists.', ESM = 'La especificaci¢n de seguimiento con N§ serie %1 y N§ lote %2 ya existe.', FRC = 'La sp‚cification tra‡abilit‚ avec le nø de s‚rie %1 et le nø de lot %2 existe d‚j….', ENC = 'Tracking specification with Serial No. %1 and Lot No. %2 already exists.';
        Text012: TextConst ENU = 'Tracking specification with Serial No. %1 already exists.', ESM = 'La especificaci¢n de seguimiento con N§ serie %1 ya existe.;FRC=La sp‚cification tra‡abilit‚ avec le nø de s‚rie %1 existe d‚j….', ENC = 'Tracking specification with Serial No. %1 already exists.';
        Text013: TextConst ENU = 'The string %1 contains no number and cannot be incremented.', ESM = 'La cadena %1 no contiene un n£mero y no puede ser incrementada.', FRC = 'La chaŒne de caractŠres %1 ne contient pas de num‚ro et ne peut ˆtre incr‚ment‚e.', ENC = 'The string %1 contains no number and cannot be incremented.';
        Text014: TextConst ENU = 'The total item tracking quantity %1 exceeds the %2 quantity %3.\The changes cannot be saved to the database.', ESM = 'La cdad. seguim. prod. total %1 excede el %2 cantidad %3.\No se pueden guardar los cambios en la base de datos.', FRC = 'La quantit‚ tra‡abilit‚ totale %1 d‚passe la quantit‚ %2 %3.\Les modifications ne peuvent ˆtre enregistr‚es dans la base de donn‚es.', ENC = 'The total item tracking quantity %1 exceeds the %2 quantity %3.\The changes cannot be saved to the database.';
        Text015: TextConst ENU = 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?', ESM = '¨Quiere sincronizar el seguim. de prod. en la l¡nea con el seguim. de prod. del env¡o directo relacionado %1?', FRC = 'Voulez-vous synchroniser le suivi d''article sur la ligne avec suivi d''article de la livraison annul‚e %1 correspondante?', ENC = 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?';
        Text016: TextConst ENU = 'purchase order line', ESM = 'l¡nea pedido compra', FRC = 'ligne de bon de commande', ENC = 'purchase order line';
        Text017: TextConst ENU = 'sales order line', ESM = 'l¡n. pedido venta', FRC = 'ligne de document de vente', ENC = 'sales order line';
        Text018: TextConst ENU = 'Saving item tracking line changes', ESM = 'Guardando cambios de l¡nea de seguim. prod.', FRC = 'Enregistrement des modifications … la ligne de suivi d''article', ENC = 'Saving item tracking line changes';
        Text019: TextConst ENU = 'There are availability warnings on one or more lines.\Close the form anyway?', ESM = 'Existen advertencias de disponibilidad en una o m s l¡neas.\¨Desea cerrar el formulario de todas maneras?;', FRC = 'Une ou plusieurs lignes comportent des avertissements sur la disponibilit‚.\Fermer le formulaire quand mˆme?', ENC = 'There are availability warnings on one or more lines.\Close the form anyway?';
        Text020: TextConst ENU = 'Placeholder', ESM = 'Marcador de posici¢n', FRC = 'ParamŠtre substituable', ENC = 'Placeholder';
        "Expiration DateEditable": Boolean;

    LOCAL PROCEDURE LotNoOnAfterValidate();
    VAR
        ok1: Boolean;
        expdate: Text;
    BEGIN
        UpdateExpDateEditable;
        //NUB1.01 added code below.
        IF STRLEN(Rec."Lot No.") <> 8 THEN
            ERROR('Lot No. should be 8 numeric characters');
        expdate := COPYSTR(Rec."Lot No.", 5, 2) + COPYSTR(Rec."Lot No.", 7, 2) + COPYSTR(Rec."Lot No.", 1, 4);
        ok1 := EVALUATE(Rec."Expiration Date", expdate);
        IF NOT ok1 THEN
            ERROR('Lot No. should be 8 numeric characters');
        //NUB1.01 end of code.
        CurrPage.UPDATE;
    END;

    procedure UpdateExpDateEditable()
    begin

        "Expiration DateEditable" :=
          NOT ((Rec."Buffer Status2" = Rec."Buffer Status2"::"ExpDate blocked") OR (CurrentSignFactor < 0));
    end;

    LOCAL PROCEDURE QuantityBaseOnAfterValidate();
    BEGIN
        //CurrPage.UPDATE;
    END;

    LOCAL PROCEDURE QuantityBaseOnValidate()
    VAR
        storeqty: Decimal;
    BEGIN
        storeqty := xRec."Quantity (Base)";
        CurrPage.UPDATE;

        IF NOT (LotSnAvailable(Rec, Enum::"Item Tracking Type"::"Lot No.")) THEN BEGIN
            Rec.VALIDATE("Quantity (Base)", storeqty);
            CurrPage.UPDATE;
            ERROR('There is not enough qty on this lot');
        END;
    end;

    procedure LotSnAvailable(VAR TrackingSpecification: Record "Tracking Specification"; LookupMode: Enum "Item Tracking Type"): Boolean
    begin
        //EXIT(ItemTrackingDataCollection.LotSNAvailable(TrackingSpecification,LookupMode));
        ItemTrackingDataCollection.LookupTrackingAvailability(TrackingSpecification, LookupMode);
    end;


}
