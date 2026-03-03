xmlport 50010 "Import Open Inventory-temp"
{
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(text_element)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'intrec';
                UseTemporary = true;
                textelement(Loc)
                {
                }
                textelement(Bin)
                {
                }
                textelement(ItemNo)
                {
                }
                textelement(Qty)
                {
                }
                textelement(SN)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    ItemJournal."Journal Template Name" := 'ITEM';
                    ItemJournal."Journal Batch Name" := 'DEFAULT';
                    lineno += 10000;
                    ItemJournal."Line No." := lineno;
                    ItemJournal."Posting Date" := TODAY;
                    ItemJournal.VALIDATE("Item No.", ItemNo);
                    ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
                    ItemJournal."Document No." := 'CONV';
                    ItemJournal.VALIDATE("Location Code", Loc);
                    ItemJournal."Bin Code" := Bin;
                    EVALUATE(QtyDec, Qty);
                    ItemJournal.VALIDATE(Quantity, QtyDec);
                    ItemJournal.INSERT(true);

                    Item.GET(ItemNo);

                    if CreateSerial then
                        CreateSerialNo(ItemJournal, Item, SN);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CreateSerial; CreateSerial)
                {
                    ApplicationArea = All;
                    Caption = 'Create Serial No.';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        CreateSerial := false;
    end;

    trigger OnPreXmlPort()
    begin


        ItemJournal.SETRANGE("Journal Template Name", 'ITEM');
        ItemJournal.SETRANGE("Journal Batch Name", 'DEFAULT');
        if ItemJournal.FINDLAST then lineno := ItemJournal."Line No.";
    end;

    var
        GenJrnLine: Record "Gen. Journal Line";
        lineno: Integer;
        vendor: Record Vendor;
        "Gen. Journal Line": Record "Gen. Journal Line";
        vendorpostinggroup: Record "Vendor Posting Group";
        ItemJournal: Record "Item Journal Line";
        Item: Record Item;
        BinRec: Record Bin;
        NoSeriesMgt: Codeunit "No. Series";
        SerNo: Code[20];
        NoSeri: Code[10];

        CreateSerial: Boolean;
        QtyDec: Decimal;


    procedure CreateSerialNo(var IJL: Record "Item Journal Line"; var Item2: Record Item; var SN: Text)
    var
        ResEnt: Record "Reservation Entry";
        LastResEnt: Record "Reservation Entry";
        i: Integer;
        EntNo: Integer;
    begin
        LastResEnt.RESET;
        if LastResEnt.FINDLAST then
            EntNo := LastResEnt."Entry No." + 1
        else
            EntNo := 1;



        i := 1;
        repeat
            if SN = '' then
                SerNo := NoSeriesMgt.GetNextNo('SN1', WORKDATE, true)
            else
                SerNo := SN;
            ResEnt.INIT;
            ResEnt."Entry No." := EntNo;
            ResEnt.Positive := true;
            ResEnt."Item No." := IJL."Item No.";
            ResEnt."Location Code" := IJL."Location Code";
            ResEnt."Reservation Status" := ResEnt."Reservation Status"::Prospect;
            ResEnt."Creation Date" := IJL."Posting Date";
            ResEnt."Source Type" := 83;
            ResEnt."Source Subtype" := ResEnt."Source Subtype"::"2";
            ResEnt."Source ID" := 'ITEM';
            ResEnt."Source Batch Name" := 'DEFAULT';
            ResEnt."Source Ref. No." := IJL."Line No.";
            ResEnt."Serial No." := SerNo;
            ResEnt."Item Tracking" := ResEnt."Item Tracking"::"Serial No.";
            ResEnt.VALIDATE("Quantity (Base)", 1);
            ResEnt.INSERT(true);

            EntNo += 1;
            i += 1;
        until i > IJL.Quantity;
    end;
}

