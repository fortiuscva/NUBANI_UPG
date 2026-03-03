xmlport 50009 "Import Open Inventory"
{
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Import)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                AutoSave = false;
                XmlName = 'ItemJournalDI';
                UseTemporary = true;
                fieldelement(BinCode; "Item Journal Line"."Bin Code")
                {
                }
                fieldelement(ItemNo; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(ExpDate; "Item Journal Line"."Expiration Date")
                {
                }
                fieldelement(Qty; "Item Journal Line".Quantity)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    ItemJournalRec."Journal Template Name" := 'ITEM';
                    ItemJournalRec."Journal Batch Name" := 'DEFAULT';
                    lineno += 10000;
                    ItemJournalRec."Line No." := lineno;
                    ItemJournalRec."Posting Date" := TODAY;
                    ItemJournalRec.VALIDATE("Item No.", "Item Journal Line"."Item No.");
                    ItemJournalRec."Entry Type" := ItemJournalRec."Entry Type"::"Positive Adjmt.";
                    ItemJournalRec."Document No." := 'CONV';
                    ItemJournalRec.VALIDATE("Location Code", 'BELLWOOD');
                    ItemJournalRec."Bin Code" := "Item Journal Line"."Bin Code";
                    ItemJournalRec.VALIDATE(Quantity, "Item Journal Line".Quantity);
                    ItemJournalRec.VALIDATE("Expiration Date", "Item Journal Line"."Expiration Date");
                    ItemJournalRec.INSERT(true);

                    ItemRec.GET("Item Journal Line"."Item No.");
                    ItemRec.TESTFIELD("Lot Nos.");
                    LotN := NoSeriesMgt.GetNextNo(ItemRec."Lot Nos.", WORKDATE, true);

                    LastResEnt.RESET;
                    if LastResEnt.FINDLAST then
                        EntNo := LastResEnt."Entry No." + 1
                    else
                        EntNo := 1;

                    ResEnt.INIT;
                    ResEnt."Entry No." := EntNo;
                    ResEnt.Positive := true;
                    ResEnt."Item No." := "Item Journal Line"."Item No.";
                    ResEnt.VALIDATE("Location Code", 'BELLWOOD');
                    ResEnt."Reservation Status" := ResEnt."Reservation Status"::Prospect;
                    ResEnt."Creation Date" := TODAY;
                    ResEnt."Source Type" := 83;
                    ResEnt."Source Subtype" := ResEnt."Source Subtype"::"2";
                    ResEnt."Source ID" := 'ITEM';
                    ResEnt."Source Batch Name" := 'DEFAULT';
                    ResEnt."Source Ref. No." := lineno;
                    ResEnt."Lot No." := LotN;
                    ResEnt."Expiration Date" := "Item Journal Line"."Expiration Date";
                    ResEnt."Item Tracking" := ResEnt."Item Tracking"::"Lot No.";
                    ResEnt.VALIDATE("Quantity (Base)", "Item Journal Line".Quantity);
                    ResEnt.INSERT(true);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        ItemJournalRec.RESET;
        ItemJournalRec.SETRANGE("Journal Template Name", 'ITEM');
        ItemJournalRec.SETRANGE("Journal Batch Name", 'DEFAULT');
        if ItemJournalRec.FINDLAST then
            lineno := ItemJournalRec."Line No.";
    end;

    var
        ItemJournalRec: Record "Item Journal Line";
        lineno: Integer;
        ItemRec: Record Item;
        LotN: Code[50];
        NoSeriesMgt: Codeunit "No. Series";
        LastResEnt: Record "Reservation Entry";
        EntNo: Integer;
        ResEnt: Record "Reservation Entry";
}

