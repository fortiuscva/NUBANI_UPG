xmlport 50000 "Import PO Lines"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("<purchase line>"; "Purchase Line")
            {
                XmlName = 'PurchaseLine';
                fieldelement(DocNo; "<Purchase Line>"."Document No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        if PurchHeader."No." <> "<Purchase Line>"."Document No." then begin
                            PurchHeader.GET(PurchHeader."Document Type"::Order, "<Purchase Line>"."Document No.");
                            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                            PurchLine.SETRANGE("Document No.", PurchHeader."No.");

                            if PurchLine.FINDLAST then
                                LineNo := PurchLine."Line No."
                            else
                                LineNo := 0;
                        end;

                        LineNo += 10000;
                        "<Purchase Line>"."Line No." := LineNo;
                    end;
                }
                fieldelement(ItemNo; "<Purchase Line>"."No.")
                {
                }
                fieldelement(Qty; "<Purchase Line>".Quantity)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    "<Purchase Line>"."Document Type" := "<Purchase Line>"."Document Type"::Order;
                    "<Purchase Line>".Type := "<Purchase Line>".Type::Item;
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
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
}

