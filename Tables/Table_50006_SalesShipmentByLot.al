table 50006 "Sales Shipment By Lot"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(5; "Posting Date"; Date)
        {
        }
        field(10; "Item No."; Code[20])
        {
        }
        field(15; Description; Text[50])
        {
        }
        field(20; "Item Category Code"; Code[20])
        {
        }
        field(25; "Entry Type"; Option)
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(30; "Cust No."; Code[20])
        {
        }
        field(35; "Document No."; Code[20])
        {
        }
        field(40; "Location Code"; Code[20])
        {
        }
        field(45; Quantity; Decimal)
        {
        }
        field(50; "Unit of Measure Code"; Code[20])
        {
        }
        field(55; "Sales Amount (Actual)"; Decimal)
        {
        }
        field(60; "Cost Per Case"; Decimal)
        {
        }
        field(65; "Lot/Expiration"; Code[20])
        {
        }
        field(70; "Lot Date"; Date)
        {
        }
        field(75; "Delta Post vs Lot"; Decimal)
        {
        }
        field(80; Expired; Decimal)
        {
        }
        field(85; "0-2 Months"; Decimal)
        {
        }
        field(90; "2-4 Months"; Decimal)
        {
        }
        field(95; "4-6 months"; Decimal)
        {
        }
        field(100; "6-8 Months"; Decimal)
        {
        }
        field(105; "Above 8 Months"; Decimal)
        {
        }
        field(500; "Error Text"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

