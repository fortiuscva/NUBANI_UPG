xmlport 50020 "Import Nubani Inventory"
{
    Direction = Import;
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Import Nubani Inventory"; "Import Nubani Inventory")
            {
                XmlName = 'ImportNubaniInvt';
                fieldelement(EntryNo; "Import Nubani Inventory"."Entry No.")
                {
                }
                fieldelement(PostingDate; "Import Nubani Inventory"."Posting Date")
                {
                }
                fieldelement(EntryType; "Import Nubani Inventory"."Entry Type")
                {
                }
                fieldelement(DocNo; "Import Nubani Inventory"."Document No.")
                {
                }
                fieldelement(ItemNo; "Import Nubani Inventory"."Item No.")
                {
                }
                fieldelement(LocationCode; "Import Nubani Inventory"."Location Code")
                {
                }
                fieldelement(BinCode; "Import Nubani Inventory"."Bin Code")
                {
                }
                fieldelement(Qty; "Import Nubani Inventory".Quantity)
                {
                }
                fieldelement(UOMCode; "Import Nubani Inventory"."UOM Code")
                {
                }
                fieldelement(LotNo; "Import Nubani Inventory"."Lot No.")
                {
                }
                fieldelement(SerialNo; "Import Nubani Inventory"."Serial No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ExpirationDate; "Import Nubani Inventory"."Expiration Date")
                {
                }
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
}

