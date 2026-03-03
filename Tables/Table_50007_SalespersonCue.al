table 50007 "Salesperson Cue"//14005147 Addon table changed the id 50007 //B2BUPG
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Sales Quotes - Open"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Quote), Status = CONST(Open), "Salesperson Code" = FIELD("Salesperson Filter")));
            Caption = 'Sales Quotes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Sales Orders - Open"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order), Status = CONST(Open), "Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Sales Quotes - Released"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Quote), Status = CONST(Released), "Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Caption = 'Sales Quotes - Released';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Sales Orders - Released"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order), Status = CONST(Released), "Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Caption = 'Sales Orders - Released';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Opportunities - Open"; Integer)
        {
            CalcFormula = Count(Opportunity WHERE(Closed = CONST(false), "Creation Date" = FIELD(FILTER("Date Filter")), "Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Opportunities - Closed"; Integer)
        {
            CalcFormula = Count(Opportunity WHERE(Closed = CONST(true), "Creation Date" = FIELD(FILTER("Date Filter")), "Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "To-Do"; Integer)
        {
            CalcFormula = Count("To-do" WHERE(Closed = CONST(false), Date = FIELD(FILTER("Date Filter")), "Salesperson Code" = FIELD(FILTER("Salesperson Filter")), "System To-do Type" = FILTER(Organizer | "Salesperson Attendee")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Contacts; Integer)
        {
            CalcFormula = Count(Contact WHERE("Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Customers; Integer)
        {
            CalcFormula = Count(Customer WHERE("Salesperson Code" = FIELD(FILTER("Salesperson Filter"))));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Campaigns; Integer)
        {
            CalcFormula = Count(Campaign WHERE("Salesperson Code" = FIELD("Salesperson Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(13; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(14; "Salesperson Filter"; Text[30])
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

