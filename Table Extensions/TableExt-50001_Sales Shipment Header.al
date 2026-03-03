tableextension 50001 "Sales Shipment Header" extends "Sales Shipment Header"
{

    // FP7.0.08  12/01/12 - JB : Changed the External Doc. No. Caption of field 100 to Customer PO No.
    // NUB1.01,17-Mar-16,ST: Added new field 50050/Assigned user ID.
    // NUB1.02,04/27/18,SK: Added new function as "SetSecurityFilterOnSalesPerson".
    // NUB1.03,04/08/19,ST: Added field 50550/Created Date & Time.
    // NUB1.04,12/04/19,SK: Added new fields as 50011/Pallets Spaces, 50012/Shipping Status.
    // NUB1.05,05/06/20,ST: Enhancements to print pallet label.
    //                       - Added field 50015/Pallet Count.
    Caption = 'Sales Shipment Header';
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



        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';

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
        modify("Order No.")
        {
            Caption = 'Order No.';
        }
        modify(Comment)
        {

            Caption = 'Comment';

        }
        modify("No. Printed")
        {
            Caption = 'No. Printed';



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
            Caption = 'Customer PO No.';
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
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
#pragma warning disable AL0432
        modify("Package Tracking No.")
#pragma warning restore AL0432
        {
            Caption = 'Package Tracking No.';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';


        }
        modify("Order No. Series")
        {
            Caption = 'Order No. Series';
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
        modify("Requested Delivery Date")
        {
            Caption = 'Requested Delivery Date';
        }
        modify("Promised Delivery Date")
        {
            Caption = 'Promised Delivery Date';
        }
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Outbound Whse. Handling Time")
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }

        field(50000; "Allow Backorder"; Boolean)
        {
        }
        field(50011; "Pallets Spaces"; Integer)
        {
            Description = 'NUB1.04';
        }
        field(50012; "Shipping Status"; Option)
        {
            Description = 'NUB1.04';
            OptionCaption = ' ,Checking,Need to Pick,Picked,Picking,Ready to Ship,Shipped';
            OptionMembers = " ",Checking,"Need to Pick",Picked,Picking,"Ready to Ship",Shipped;
        }
        field(50015; "Pallet Count"; Integer)
        {
            Description = 'NUB1.05';
        }
        field(50050; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            Description = 'NUB1.01';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(50550; "Created Date & Time"; DateTime)
        {
            Description = 'NUB1.03';
            Editable = false;
        }
    }


    procedure "---NUB1.02---"()
    begin
    end;

    procedure SetSecurityFilterOnSalesPerson()
    begin
        //B2BUPG
        //NUB1.02 Start
        // IF UserSetupMgt.GetSalesPersonFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Salesperson Code", UserSetupMgt.GetSalesPersonFilter);
        // END;
        //NUB1.02 End    //B2BUPG
        IF EventsandSubscriber.GetSalesPersonFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Salesperson Code", EventsandSubscriber.GetSalesPersonFilter);
        END;

    end;

    var
        UserSetupMgt: Codeunit "User Setup Management";
        EventsandSubscriber: codeunit EventsandSubscribers;




}

