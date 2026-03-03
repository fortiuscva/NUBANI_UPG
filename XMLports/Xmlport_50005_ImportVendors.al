xmlport 50005 "Import Vendors"
{
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoSave = false;
                XmlName = 'Vend';
                fieldelement(f1; Vendor."No.")
                {
                }
                fieldelement(f2; Vendor.Name)
                {
                }
                fieldelement(f3; Vendor.Address)
                {
                }
                fieldelement(f4; Vendor."Phone No.")
                {
                }
                fieldelement(f5; Vendor."Post Code")
                {
                }
                fieldelement(f6; Vendor."Fax No.")
                {
                }
                fieldelement(f7; Vendor.Contact)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    VendorRec.INIT;
                    VendorRec."No." := Vendor."No.";
                    VendorRec.VALIDATE(Name, Vendor.Name);
                    VendorRec.Address := Vendor.Address;
                    VendorRec."Phone No." := Vendor."Phone No.";
                    VendorRec.VALIDATE("Post Code", Vendor."Post Code");
                    VendorRec.INSERT;
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
        VendorRec: Record Vendor;
}

