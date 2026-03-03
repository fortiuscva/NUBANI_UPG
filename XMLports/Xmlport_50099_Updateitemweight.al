xmlport 50099 "*** Update item weight"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;
                XmlName = 'ItemIn';
                fieldelement(SearchName; Item."Search Description")
                {
                }
                textelement(ItemNum)
                {
                }
                fieldelement(NetWeight; Item."Net Weight")
                {

                    trigger OnAfterAssignField()
                    begin
                        Item2.SETRANGE("Search Description", Item."Search Description");

                        if Item2.FINDFIRST then begin
                            Item2."Net Weight" := Item."Net Weight";
                            Item2.MODIFY;
                        end;
                    end;
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

    trigger OnPreXmlPort()
    begin
        Item2.SETCURRENTKEY("Search Description");
    end;

    var
        Item2: Record Item;
}

