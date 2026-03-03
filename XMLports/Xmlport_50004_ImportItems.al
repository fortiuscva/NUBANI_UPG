xmlport 50004 "Import Items"
{
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Items';
                fieldelement(f1; Item."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(f2; Item."Search Description")
                {
                    FieldValidate = no;
                }
                fieldelement(f3; Item.Description)
                {
                    FieldValidate = no;
                }
                fieldelement(f4; Item."Base Unit of Measure")
                {
                    FieldValidate = no;
                }
                fieldelement(f5; Item."Net Weight")
                {
                }
                fieldelement(f6; Item."Unit Cost")
                {
                }
                fieldelement(f7; Item."Vendor No.")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    BinConRec.INIT;
                    BinConRec.VALIDATE("Location Code", 'BELLWOOD');
                    BinConRec.VALIDATE("Bin Code", 'RECEIVING');
                    BinConRec.VALIDATE("Item No.", Item."No.");
                    BinConRec.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                    BinConRec.Fixed := true;
                    BinConRec.Default := true;
                    BinConRec.INSERT;
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

    var
        BinConRec: Record "Bin Content";
}

