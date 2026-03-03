tableextension 50008 PurchInvHeaderExt extends "Purch. Inv. Header"
{

    Caption = 'Purch. Inv. Header';
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';



        }
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Pay-to Vendor No.")
        {
            Caption = 'Vendor No.';



        }
        modify("Pay-to Name")
        {
            Caption = 'Name';
        }
        modify("Pay-to Name 2")
        {
            Caption = 'Name 2';
        }
        modify("Pay-to Address")
        {
            Caption = 'Address';
        }
        modify("Pay-to Address 2")
        {
            Caption = 'Address 2';
        }
        modify("Pay-to City")
        {

            Caption = 'City';
        }
        modify("Pay-to Contact")
        {
            Caption = 'Contact';
        }
        modify("Your Reference")
        {
            Caption = 'Your Reference';
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

            Caption = 'Ship-to City';
        }
        modify("Ship-to Contact")
        {
            Caption = 'Ship-to Contact';
        }
        modify("Order Date")
        {
            Caption = 'Order Date';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Expected Receipt Date")
        {
            Caption = 'Expected Receipt Date';
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
        modify("Vendor Posting Group")
        {
            Caption = 'Vendor Posting Group';

            //Unsupported feature: Property Modification (Editable) on ""Vendor Posting Group"(Field 31)".

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
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including VAT';
        }
        modify("Invoice Disc. Code")
        {
            Caption = 'Invoice Disc. Code';
        }
        modify("Language Code")
        {
            Caption = 'Language Code';
        }
        modify("Purchaser Code")
        {
            Caption = 'Purchaser Code';
        }
        modify("Order No.")
        {
            Caption = 'Order No.';
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
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Order No.';
        }
        modify("Vendor Invoice No.")
        {
            Caption = 'Vendor Invoice No.';
        }
        modify("VAT Registration No.")
        {
            Caption = 'Tax Registration No.';
        }
        modify("Sell-to Customer No.")
        {
            Caption = 'Sell-to Customer No.';
        }
        modify("Reason Code")
        {
            Caption = 'Reason Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
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
        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Vendor Name';
        }
        modify("Buy-from Vendor Name 2")
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        modify("Buy-from Address")
        {
            Caption = 'Buy-from Address';
        }
        modify("Buy-from Address 2")
        {
            Caption = 'Buy-from Address 2';
        }
        modify("Buy-from City")
        {



            Caption = 'Buy-from City';
        }
        modify("Buy-from Contact")
        {
            Caption = 'Buy-from Contact';
        }
        modify("Pay-to Post Code")
        {

            Caption = 'ZIP Code';
        }
        modify("Pay-to County")
        {
            Caption = 'State';
        }
        modify("Pay-to Country/Region Code")
        {
            Caption = 'Country/Region Code';
        }
        modify("Buy-from Post Code")
        {

            Caption = 'Buy-from ZIP Code';
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from State';
        }
        modify("Buy-from Country/Region Code")
        {
            Caption = 'Buy-from Country/Region Code';
        }
        modify("Ship-to Post Code")
        {

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
        modify("Order Address Code")
        {
            Caption = 'Order Address Code';
        }
        modify("Entry Point")
        {
            Caption = 'Entry Point';
        }
        modify(Correction)
        {
            Caption = 'Correction';
        }
        modify("Document Date")
        {
            Caption = 'Document Date';
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
        modify("Order No. Series")
        {
            Caption = 'Order No. Series';
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
        modify("Prepayment No. Series")
        {
            Caption = 'Prepayment No. Series';
        }
        modify("Prepayment Invoice")
        {
            Caption = 'Prepayment Invoice';
        }
        modify("Prepayment Order No.")
        {
            Caption = 'Prepayment Order No.';
        }
        modify("Quote No.")
        {
            Caption = 'Quote No.';


        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';


        }
        modify("Campaign No.")
        {
            Caption = 'Campaign No.';
        }
        modify("Buy-from Contact No.")
        {
            Caption = 'Buy-from Contact No.';
        }
        modify("Pay-to Contact No.")
        {
            Caption = 'Pay-to Contact No.';
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }

        field(50000; "Expected Receipt Time"; Time)
        {
        }
    }
    keys
    {


    }


}

