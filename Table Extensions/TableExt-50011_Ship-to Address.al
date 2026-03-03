tableextension 50011 ShiptoAddressExt extends "Ship-to Address"
{

    Caption = 'Ship-to Address';
    fields
    {
        modify("Customer No.")
        {
            Caption = 'Customer No.';



        }
        modify("Code")
        {
            Caption = 'Code';



        }
        modify(Name)
        {
            Caption = 'Name';
        }
        modify("Name 2")
        {
            Caption = 'Name 2';
        }
        modify(Address)
        {
            Caption = 'Address';
        }
        modify("Address 2")
        {
            Caption = 'Address 2';
        }
        modify(City)
        {
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));



            Caption = 'City';
        }
        modify(Contact)
        {
            Caption = 'Contact';
        }
        modify("Phone No.")
        {
            Caption = 'Phone No.';
        }
        modify("Telex No.")
        {
            Caption = 'Telex No.';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Method Code';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Place of Export")
        {
            Caption = 'Place of Export';
        }
        modify("Country/Region Code")
        {
            Caption = 'Country/Region Code';
        }
        modify("Last Date Modified")
        {
            Caption = 'Last Date Modified';



        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Fax No.")
        {
            Caption = 'Fax No.';
        }
        modify("Telex Answer Back")
        {
            Caption = 'Telex Answer Back';
        }
        modify("Post Code")
        {
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code" ELSE IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            Caption = 'ZIP Code';
        }
        modify(County)
        {
            Caption = 'State';
        }
        modify("E-Mail")
        {
            Caption = 'E-Mail';
        }
#pragma warning disable AL0432
        modify("Home Page")
#pragma warning restore AL0432
        {
            Caption = 'Home Page';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Service Zone Code")
        {
            Caption = 'Service Zone Code';
        }

        field(50000; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Description = 'NUB1.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {


    }










}

