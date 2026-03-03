table 50010 "Credit Card"
{
    Caption = 'Dynamics Online Payment Credit Card';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Type; Code[20])
        {
            Caption = 'Type';
            NotBlank = true;

        }
        field(3; "Credit Card Number"; Text[20])
        {
            Caption = 'Credit Card Number';
        }
        field(4; "Expiry Date"; Code[4])
        {
            Caption = 'Expiry Date';
            NotBlank = true;


        }
        field(5; "Card Holder Name"; Text[50])
        {
            Caption = 'Card Holder Name';
            NotBlank = true;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;



        }
        field(7; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;


        }
        field(8; "Cvc No."; Text[4])
        {
            Caption = 'Cvc No.';


        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';

        }
        field(11; "CC No."; Text[30])
        {
        }
        field(12; "CVV Code"; Text[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Type, "Expiry Date")
        {
        }
    }


}

