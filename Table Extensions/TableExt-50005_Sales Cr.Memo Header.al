tableextension 50005 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{

    Caption = 'Sales Cr.Memo Header';
    fields
    {
        modify("Sell-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';

        }
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';


        }
        modify("Bill-to Name")
        {
            Caption = 'Name';
        }
        modify("Bill-to Name 2")
        {
            Caption = 'Name 2';
        }
        modify("Bill-to Address")
        {
            Caption = 'Address';
        }
        modify("Bill-to Address 2")
        {
            Caption = 'Address 2';
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Bill-to City"(Field 9)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Bill-to City"(Field 9)".

            Caption = 'City';
        }
        modify("Bill-to Contact")
        {
            Caption = 'Contact';
        }
        modify("Your Reference")
        {
            Caption = 'Customer PO No.';
        }
        modify("Ship-to Code")
        {
            Caption = 'Ship-to Code';
        }
        modify("Ship-to Name")
        {
            Caption = 'Ship-to Name';
        }
        modify("Ship-to Name 2")
        {
            Caption = 'Ship-to Name 2';
        }
        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';
        }
        modify("Ship-to Address 2")
        {
            Caption = 'Ship-to Address 2';
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Ship-to City"(Field 17)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Ship-to City"(Field 17)".

            Caption = 'Ship-to City';
        }
        modify("Ship-to Contact")
        {
            Caption = 'Ship-to Contact';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Shipment Date")
        {
            Caption = 'Shipment Date';
        }
        modify("Posting Description")
        {
            Caption = 'Posting Description';
        }
        modify("Payment Terms Code")
        {
            Caption = 'Payment Terms Code';
        }
        modify("Due Date")
        {
            Caption = 'Due Date';
        }
        modify("Payment Discount %")
        {
            Caption = 'Payment Discount %';
        }
        modify("Pmt. Discount Date")
        {
            Caption = 'Pmt. Discount Date';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Method Code';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Customer Posting Group")
        {
            Caption = 'Customer Posting Group';

            //Unsupported feature: Property Modification (Editable) on ""Customer Posting Group"(Field 31)".

        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';

            //Unsupported feature: Property Modification (Editable) on ""Currency Code"(Field 32)".

        }
        modify("Currency Factor")
        {
            Caption = 'Currency Factor';
        }
        modify("Customer Price Group")
        {
            Caption = 'Customer Price Group';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including VAT';
        }
        modify("Invoice Disc. Code")
        {
            Caption = 'Invoice Disc. Code';
        }
        modify("Customer Disc. Group")
        {
            Caption = 'Customer Disc. Group';
        }
        modify("Language Code")
        {
            Caption = 'Language Code';
        }
        modify("Salesperson Code")
        {
            Caption = 'Salesperson Code';
        }
        modify(Comment)
        {

            //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

            Caption = 'Comment';

            //Unsupported feature: Property Modification (Editable) on "Comment(Field 46)".

        }
        modify("No. Printed")
        {
            Caption = 'No. Printed';

            //Unsupported feature: Property Modification (Editable) on ""No. Printed"(Field 47)".

        }
        modify("On Hold")
        {
            Caption = 'On Hold';
        }
        modify("Applies-to Doc. Type")
        {
            Caption = 'Applies-to Doc. Type';
            //OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';



        }
        modify("Applies-to Doc. No.")
        {
            Caption = 'Applies-to Doc. No.';
        }
        modify("Bal. Account No.")
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" ELSE IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            Caption = 'Bal. Account No.';
        }
        modify(Amount)
        {
            Caption = 'Amount';



        }
        modify("Amount Including VAT")
        {
            Caption = 'Amount Including Tax';



        }
        modify("VAT Registration No.")
        {
            Caption = 'Tax Registration No.';
        }
        modify("Reason Code")
        {
            Caption = 'Reason Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("EU 3-Party Trade")
        {
            Caption = 'EU 3-Party Trade';
        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
        }
        modify("Transport Method")
        {
            Caption = 'Transport Method';
        }
        modify("VAT Country/Region Code")
        {
            Caption = 'VAT Country/Region Code';
        }
        modify("Sell-to Customer Name")
        {
            Caption = 'Sell-to Customer Name';
        }
        modify("Sell-to Customer Name 2")
        {
            Caption = 'Sell-to Customer Name 2';
        }
        modify("Sell-to Address")
        {
            Caption = 'Sell-to Address';
        }
        modify("Sell-to Address 2")
        {
            Caption = 'Sell-to Address 2';
        }
        modify("Sell-to City")
        {

            Caption = 'Sell-to City';
        }
        modify("Sell-to Contact")
        {
            Caption = 'Sell-to Contact';
        }
        modify("Bill-to Post Code")
        {

            Caption = 'ZIP Code';
        }
        modify("Bill-to County")
        {
            Caption = 'State';
        }
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Country/Region Code';
        }
        modify("Sell-to Post Code")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Sell-to Post Code"(Field 88)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Sell-to Post Code"(Field 88)".

            Caption = 'Sell-to ZIP Code';
        }
        modify("Sell-to County")
        {
            Caption = 'Sell-to State';
        }
        modify("Sell-to Country/Region Code")
        {
            Caption = 'Sell-to Country/Region Code';
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Ship-to Post Code"(Field 91)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Ship-to Post Code"(Field 91)".

            Caption = 'Ship-to ZIP Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to State';
        }
        modify("Ship-to Country/Region Code")
        {
            Caption = 'Ship-to Country/Region Code';
        }
        modify("Bal. Account Type")
        {
            Caption = 'Bal. Account Type';
            //OptionCaption = 'G/L Account,Bank Account';

        }
        modify("Exit Point")
        {
            Caption = 'Exit Point';
        }
        modify(Correction)
        {
            Caption = 'Correction';
        }
        modify("Document Date")
        {
            Caption = 'Document Date';
        }
        modify("External Document No.")
        {
            Caption = 'External Document No.';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("Transaction Specification")
        {
            Caption = 'Transaction Specification';
        }
        modify("Payment Method Code")
        {
            Caption = 'Payment Method Code';
        }
        modify("Pre-Assigned No. Series")
        {
            Caption = 'Pre-Assigned No. Series';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';

        }
        modify("Pre-Assigned No.")
        {
            Caption = 'Pre-Assigned No.';
        }
        modify("User ID")
        {

            Caption = 'User ID';
        }
        modify("Source Code")
        {
            Caption = 'Source Code';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Tax Bus. Posting Group';
        }
        modify("VAT Base Discount %")
        {
            Caption = 'VAT Base Discount %';
        }
        modify("Prepmt. Cr. Memo No. Series")
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
        }
        modify("Prepayment Credit Memo")
        {
            Caption = 'Prepayment Credit Memo';
        }
        modify("Prepayment Order No.")
        {
            Caption = 'Prepayment Order No.';
        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';



        }
        /* modify("Credit Card No.")
        {
            Caption = 'Credit Card No.';
        } *///B2BUpg
        modify("Campaign No.")
        {
            Caption = 'Campaign No.';
        }
        modify("Sell-to Contact No.")
        {
            Caption = 'Sell-to Contact No.';
        }
        modify("Bill-to Contact No.")
        {
            Caption = 'Bill-to Contact No.';
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }
        modify("Return Order No.")
        {
            Caption = 'Return Order No.';
        }
        modify("Return Order No. Series")
        {
            Caption = 'Return Order No. Series';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("Get Return Receipt Used")
        {
            Caption = 'Get Return Receipt Used';
        }

        field(50011; "Pallets Spaces"; Integer)
        {
            Description = 'NUB1.03';
        }
        field(50012; "Shipping Status"; Option)
        {
            Description = 'NUB1.03';
            OptionCaption = ' ,Checking,Need to Pick,Picked,Picking,Ready to Ship,Shipped';
            OptionMembers = " ",Checking,"Need to Pick",Picked,Picking,"Ready to Ship",Shipped;
        }
        field(50015; "Pallet Count"; Integer)
        {
            Description = 'NUB1.04';
        }
        field(50050; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            Description = 'NUB1.01';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(70003; "Orig. Invoice No."; Code[20])
        {
            Description = 'FP6.2.08';
            TableRelation = "Sales Invoice Header";
        }
    }
    keys
    {

    }

    // procedure ExportEDocument()
    // var
    //     TempBlob: Codeunit "Temp Blob";
    //     RBMgt: Codeunit "File Management";
    // begin
    //     CALCFIELDS("Signed Document XML");
    //     IF "Signed Document XML".HASVALUE THEN BEGIN
    //         //TempBlob.Blob := "Signed Document XML";//B2BUpg
    //         RBMgt.BLOBExport(TempBlob, "No." + '.xml', TRUE);
    //     END ELSE
    //         ERROR(Text10000, "No.");
    // end;

    // procedure RequestStampEDocument()
    // var
    //     EInvoiceMgt: Codeunit "E-Invoice Mgt.";
    //     LoCRecRef: RecordRef;
    //     Prepayment: Boolean;
    // begin
    //     LoCRecRef.GETTABLE(Rec);
    //     //EInvoiceMgt.RequestStampDocument(LoCRecRef);//B2BUPG
    //     EInvoiceMgt.RequestStampDocument(LoCRecRef, Prepayment);
    // end;

    // procedure CancelEDocument()
    // var
    //     EInvoiceMgt: Codeunit "E-Invoice Mgt.";
    //     LoCRecRef: RecordRef;
    // begin
    //     LoCRecRef.GETTABLE(Rec);
    //     EInvoiceMgt.CancelDocument(LoCRecRef);
    // end;

    procedure "---NUB1.02---"()
    begin
    end;

    procedure SetSecurityFilterOnSalesPerson()
    begin
        //NUB1.02 Start
        IF EventsandSubscribers.GetSalesPersonFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Salesperson Code", EventsandSubscribers.GetSalesPersonFilter);
        END;
        //NUB1.02 End
    end;



    var
        Text10000: Label 'There is no electronic stamp for document no. %1.';
        "--FP--": Integer;
        EventsandSubscribers: Codeunit EventsandSubscribers;
    //EmailTracking: Record "Email Tracking";
}


