tableextension 50017 SalesHeaderExt extends "Sales Header"
{

    // //FP     Added field 70000 - Lines Shipped Not Invoiced
    //          Added field 70001 - Ready for Shipping
    // //FP6.2  Added field 70011 - Quote Expiration Date
    // //FP6.2.06  Added code to remove Email Tracking Record
    // //FP7.0.07 11/06/12
    //           - Added the following Keys to improve Classic Role Center "Stack" Performance with large DBs
    //             -- "Document Type,Quote Expiration Date"
    //             -- "Document Type,Status,Shipment Date"
    // FP6.2.08 Oct 17 2012, Jane Feger.  Added new field "Orig. Invoice No.".  Added code to Applies-to Doc. No. validate trigger
    //   to plug the Orig. Invoice No. if it is equal to spaces.
    // FP7.0.08  12/01/12 - JB : Changed the External Doc. No. Caption of field 100 to Customer PO No.
    // //POPN  Add two Global Variable
    //         Add code in Sell-to OnValidate
    // //POPN  3.6 Corrected Problem when creating Sales Orders from the Customer Record
    //         Add new field "Delay Note" Field 14005160
    //         Code in Requested Delivery Date Field 5790
    // //POPN  3.7 Corrected Problem with createing Sales Quotes from Contact Management
    // //POPN4 - changed code "OnInsert" to use begin and end to prevent erroring
    // //POPN6  Changed which codeunit is called by NotesCU
    // //POPN6.3  Created Stop Note field to replace StopNote variable
    // //BUSS  Code OnInsert
    //         Add one global variable
    // 
    // //NUB1.01,17-Mar-16,ST: Added new function "SetShipToCode".
    //                         Added code to "Sell-to Customer No. - OnValidate()".
    // //NUB1.02,17-Mar-16,ST: Added code to "OnInsert()".
    // NUB1.03,08/24/17,SK: Adddnew function as "CheckItemTrackingLines" and delcarred global variables.
    // NUB1.04,04/27/18,SK: Added new function as "SetSecurityFilterOnSalesPerson".
    // NUB1.05,07/27/18,SK: Added new filed "No. of Pallets".
    // NUB1.06,01/17/19,SK: Created new function as "CheckSalesLineUnitPrice".
    // NUB1.07,03/26/19,SK: Added code at "Sell-to Customer No. - OnValidate()" to check the Customer Balance and popup the message.
    //                      Delcared Global variable & text constant.
    // NUB1.08,07/01/19,ST: Modifications handled to show if there is an open invt. pick exists and if there is quantity already shipped on the order.
    //                       - Added new flow fields 59010/Invt. Pick Exists, 59011/Order Shipped.
    // NUB1.09,12/04/19,SK: Added new fields as 50011/Pallets Spaces, 50012/Shipping Status.
    // NUB1.10,05/06/20,ST: Enhancements to print pallet label.
    //                       - Added field 50015/Pallet Count.
    Caption = 'Sales Header';
    fields
    {
        modify("Document Type")
        {
            Caption = 'Document Type';
            //OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 1)".

        }
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

            //Unsupported feature: Property Modification (NotBlank) on ""Bill-to Customer No."(Field 4)".

        }
        modify("Bill-to Name")
        {
            Caption = 'Bill-to Name';
        }
        modify("Bill-to Name 2")
        {
            Caption = 'Bill-to Name 2';
        }
        modify("Bill-to Address")
        {
            Caption = 'Bill-to Address';
        }
        modify("Bill-to Address 2")
        {
            Caption = 'Bill-to Address 2';
        }
        modify("Bill-to City")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Bill-to City"(Field 9)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Bill-to City"(Field 9)".

            Caption = 'Bill-to City';
        }
        modify("Bill-to Contact")
        {
            Caption = 'Bill-to Contact';
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

            //Unsupported feature: Property Modification (Editable) on ""Customer Posting Group"(Field 31)".

        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Currency Factor")
        {
            Caption = 'Currency Factor';

            //Unsupported feature: Property Modification (Editable) on ""Currency Factor"(Field 33)".

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
        modify("Order Class")
        {
            Caption = 'Order Class';
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

            //Unsupported feature: Property Modification (OptionString) on ""Applies-to Doc. Type"(Field 52)".

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
        modify(Ship)
        {
            Caption = 'Ship';

            //Unsupported feature: Property Modification (Editable) on "Ship(Field 57)".

        }
        modify(Invoice)
        {
            Caption = 'Invoice';
        }
        modify("Print Posted Documents")
        {
            Caption = 'Print Posted Documents';
        }
        modify(Amount)
        {

            //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".

            Caption = 'Amount';

            //Unsupported feature: Property Modification (Editable) on "Amount(Field 60)".

        }
        modify("Amount Including VAT")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Amount Including VAT"(Field 61)".

            Caption = 'Amount Including VAT';

            //Unsupported feature: Property Modification (Editable) on ""Amount Including VAT"(Field 61)".

        }
        modify("Shipping No.")
        {
            Caption = 'Shipping No.';
        }
        modify("Posting No.")
        {
            Caption = 'Posting No.';
        }
        modify("Last Shipping No.")
        {
            Caption = 'Last Shipping No.';

            //Unsupported feature: Property Modification (Editable) on ""Last Shipping No."(Field 64)".

        }
        modify("Last Posting No.")
        {
            Caption = 'Last Posting No.';

            //Unsupported feature: Property Modification (Editable) on ""Last Posting No."(Field 65)".

        }
        modify("Prepayment No.")
        {
            Caption = 'Prepayment No.';
        }
        modify("Last Prepayment No.")
        {
            Caption = 'Last Prepayment No.';
        }
        modify("Prepmt. Cr. Memo No.")
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        modify("Last Prepmt. Cr. Memo No.")
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
        }
        modify("VAT Registration No.")
        {
            Caption = 'VAT Registration No.';
        }
        modify("Combine Shipments")
        {
            Caption = 'Combine Shipments';
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

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Sell-to City"(Field 83)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Sell-to City"(Field 83)".

            Caption = 'Sell-to City';
        }
        modify("Sell-to Contact")
        {
            Caption = 'Sell-to Contact';
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Bill-to Post Code"(Field 85)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Bill-to Post Code"(Field 85)".

            Caption = 'Bill-to Post Code';
        }
        modify("Bill-to County")
        {
            Caption = 'Bill-to County';
        }
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country/Region Code';
        }
        modify("Sell-to Post Code")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Sell-to Post Code"(Field 88)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Sell-to Post Code"(Field 88)".

            Caption = 'Sell-to Post Code';
        }
        modify("Sell-to County")
        {
            Caption = 'Sell-to County';
        }
        modify("Sell-to Country/Region Code")
        {
            Caption = 'Sell-to Country/Region Code';
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Property Modification (ValidateTableRelation) on ""Ship-to Post Code"(Field 91)".


            //Unsupported feature: Property Modification (TestTableRelation) on ""Ship-to Post Code"(Field 91)".

            Caption = 'Ship-to Post Code';
        }
        modify("Ship-to County")
        {
            Caption = 'Ship-to County';
        }
        modify("Ship-to Country/Region Code")
        {
            Caption = 'Ship-to Country/Region Code';
        }
        modify("Bal. Account Type")
        {
            Caption = 'Bal. Account Type';
            //OptionCaption = 'G/L Account,Bank Account';

            //Unsupported feature: Property Modification (OptionString) on ""Bal. Account Type"(Field 94)".

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
        // modify("External Document No.")
        // {
        //     Caption = 'Nº documento externo';
        // }
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

            //Unsupported feature: Property Modification (Editable) on ""No. Series"(Field 107)".

        }
        modify("Posting No. Series")
        {
            Caption = 'Posting No. Series';
        }
        modify("Shipping No. Series")
        {
            Caption = 'Shipping No. Series';
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
            Caption = 'VAT Bus. Posting Group';
        }
        modify(Reserve)
        {
            Caption = 'Reserve';
            //OptionCaption = 'Never,Optional,Always';
        }
        modify("Applies-to ID")
        {
            Caption = 'Applies-to ID';
        }
        modify("VAT Base Discount %")
        {
            Caption = 'VAT Base Discount %';
        }
        modify(Status)
        {
            Caption = 'Status';
            //OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 120)".


            //Unsupported feature: Property Modification (Editable) on "Status(Field 120)".

        }
        modify("Invoice Discount Calculation")
        {
            Caption = 'Invoice Discount Calculation';
            OptionCaption = 'None,%,Amount';

            //Unsupported feature: Property Modification (OptionString) on ""Invoice Discount Calculation"(Field 121)".


            //Unsupported feature: Property Modification (Editable) on ""Invoice Discount Calculation"(Field 121)".

        }
        modify("Invoice Discount Value")
        {
            Caption = 'Invoice Discount Value';

            //Unsupported feature: Property Modification (Editable) on ""Invoice Discount Value"(Field 122)".

        }
        modify("Send IC Document")
        {
            Caption = 'Send IC Document';
        }
        modify("IC Status")
        {
            Caption = 'IC Status';
            //OptionCaption = 'New,Pending,Sent';
        }
        modify("Sell-to IC Partner Code")
        {
            Caption = 'Sell-to IC Partner Code';

            //Unsupported feature: Property Modification (Editable) on ""Sell-to IC Partner Code"(Field 125)".

        }
        modify("Bill-to IC Partner Code")
        {
            Caption = 'Bill-to IC Partner Code';

            //Unsupported feature: Property Modification (Editable) on ""Bill-to IC Partner Code"(Field 126)".

        }
        modify("IC Direction")
        {
            Caption = 'IC Direction';
            //OptionCaption = 'Outgoing,Incoming';
        }
        modify("Prepayment %")
        {
            Caption = 'Prepayment %';
        }
        modify("Prepayment No. Series")
        {
            Caption = 'Prepayment No. Series';
        }
        modify("Compress Prepayment")
        {
            Caption = 'Compress Prepayment';
        }
        modify("Prepayment Due Date")
        {
            Caption = 'Prepayment Due Date';
        }
        modify("Prepmt. Cr. Memo No. Series")
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
        }
        modify("Prepmt. Posting Description")
        {
            Caption = 'Prepmt. Posting Description';
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        modify("Prepmt. Payment Terms Code")
        {
            Caption = 'Prepmt. Payment Terms Code';
        }
        modify("Prepmt. Payment Discount %")
        {
            Caption = 'Prepmt. Payment Discount %';
        }
        modify("Quote No.")
        {
            Caption = 'Quote No.';

            //Unsupported feature: Property Modification (Editable) on ""Quote No."(Field 151)".

        }
        modify("Job Queue Status")
        {
            Caption = 'Job Queue Status';
            //OptionCaption = ' ,Scheduled for Posting,Error,Posting';

            //Unsupported feature: Property Modification (OptionString) on ""Job Queue Status"(Field 160)".


            //Unsupported feature: Property Modification (Editable) on ""Job Queue Status"(Field 160)".

        }
        modify("Job Queue Entry ID")
        {
            Caption = 'Job Queue Entry ID';

            //Unsupported feature: Property Modification (Editable) on ""Job Queue Entry ID"(Field 161)".

        }
        modify("Dimension Set ID")
        {
            Caption = 'Dimension Set ID';

            //Unsupported feature: Property Modification (Editable) on ""Dimension Set ID"(Field 480)".

        }
        /* modify("Authorization Required")
        {
            Caption = 'Authorization Required';
        }
        modify("Credit Card No.")
        {
            Caption = 'Credit Card No.';
        } *///B2BUpg
        modify("No. of Archived Versions")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""No. of Archived Versions"(Field 5043)".

            Caption = 'No. of Archived Versions';

            //Unsupported feature: Property Modification (Editable) on ""No. of Archived Versions"(Field 5043)".

        }
        modify("Doc. No. Occurrence")
        {
            Caption = 'Doc. No. Occurrence';
        }
        modify("Campaign No.")
        {
            Caption = 'Campaign No.';
        }
        /* modify("Sell-to Customer Template Code")
        {
            Caption = 'Sell-to Customer Template Code';
        } *///B2BUpg
        modify("Sell-to Contact No.")
        {
            Caption = 'Sell-to Contact No.';
        }
        modify("Bill-to Contact No.")
        {
            Caption = 'Bill-to Contact No.';
        }
        /*  modify("Bill-to Customer Template Code")
         {
             Caption = 'Bill-to Customer Template Code';
         } *///B2BUpg
        modify("Opportunity No.")
        {
            TableRelation = IF ("Document Type" = FILTER(<> Order)) Opportunity."No." WHERE("Contact No." = FIELD("Sell-to Contact No."), Closed = CONST(false)) ELSE IF ("Document Type" = CONST(Order)) Opportunity."No." WHERE("Contact No." = FIELD("Sell-to Contact No."), "Sales Document No." = FIELD("No."), "Sales Document Type" = CONST(Order));
            Caption = 'Opportunity No.';
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }
        modify("Shipping Advice")
        {
            Caption = 'Shipping Advice';
            //OptionCaption = 'Partial,Complete';
        }
        modify("Shipped Not Invoiced")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Shipped Not Invoiced"(Field 5751)".

            Caption = 'Shipped Not Invoiced';

            //Unsupported feature: Property Modification (Editable) on ""Shipped Not Invoiced"(Field 5751)".

        }
        modify("Completely Shipped")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Completely Shipped"(Field 5752)".

            Caption = 'Completely Shipped';

            //Unsupported feature: Property Modification (Editable) on ""Completely Shipped"(Field 5752)".

        }
        modify("Posting from Whse. Ref.")
        {
            Caption = 'Posting from Whse. Ref.';
        }
        modify("Location Filter")
        {
            Caption = 'Location Filter';
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
        modify("Late Order Shipping")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Late Order Shipping"(Field 5795)".

            Caption = 'Late Order Shipping';

            //Unsupported feature: Property Modification (Editable) on ""Late Order Shipping"(Field 5795)".

        }
        modify("Date Filter")
        {
            Caption = 'Date Filter';
        }
        modify(Receive)
        {
            Caption = 'Receive';
        }
        modify("Return Receipt No.")
        {
            Caption = 'Return Receipt No.';
        }
        modify("Return Receipt No. Series")
        {
            Caption = 'Return Receipt No. Series';
        }
        modify("Last Return Receipt No.")
        {
            Caption = 'Last Return Receipt No.';

            //Unsupported feature: Property Modification (Editable) on ""Last Return Receipt No."(Field 5803)".

        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("Get Shipment Used")
        {
            Caption = 'Get Shipment Used';

            //Unsupported feature: Property Modification (Editable) on ""Get Shipment Used"(Field 7200)".

        }
        modify("Assigned User ID")
        {
            Caption = 'Assigned User ID';
        }



        //end;
        // field(10005;"Ship-to UPS Zone";Code[2])
        // {
        //     Caption = 'Ship-to UPS Zone';
        // }
        // field(10009;"Outstanding Amount ($)";Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE ("Document Type"=FIELD("Document Type"),"Document No."=FIELD("No.")));
        //     Caption = 'Outstanding Amount ($)';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(10015;"Tax Exemption No.";Text[30])
        // {
        //     Caption = 'Tax Exemption No.';
        // }
        // field(10018;"STE Transaction ID";Text[20])
        // {
        //     Caption = 'STE Transaction ID';
        //     Editable = false;
        // }
        // field(12600;"Prepmt. Include Tax";Boolean)
        // {
        //     Caption = 'Prepmt. Include Tax';

        //     trigger OnValidate()
        //     var
        //         GLSetup: Record "General Ledger Setup";
        //     begin
        //         IF xRec."Prepmt. Include Tax" = "Prepmt. Include Tax" THEN
        //           EXIT;
        //         IF NOT "Prepmt. Include Tax" THEN
        //           EXIT;
        //         IF "Currency Code" = '' THEN
        //           EXIT;
        //         GLSetup.GET;
        //         IF GLSetup."LCY Code" = "Currency Code" THEN
        //           EXIT;
        //         ERROR(PrepmtIncludeTaxErr,FIELDCAPTION("Prepmt. Include Tax"));
        //     end;
        // }
        field(50000; "Allow Backorder"; Boolean)
        {
        }
        field(50006; "No. of Pallets"; Decimal)
        {
            Description = 'NUB1.05';
            Editable = false;
        }
        field(50011; "Pallets Spaces"; Integer)
        {
            Description = 'NUB1.09';
        }
        field(50012; "Shipping Status"; Option)
        {
            Description = 'NUB1.09';
            OptionCaption = ' ,Checking,Need to Pick,Picked,Picking,Ready to Ship,Shipped';
            OptionMembers = " ",Checking,"Need to Pick",Picked,Picking,"Ready to Ship",Shipped;
        }
        field(50015; "Pallet Count"; Integer)
        {
            Description = 'NUB1.10';
        }
        field(59010; "Invt. Pick Exists"; Boolean)
        {
            CalcFormula = Exist("Warehouse Activity Line" WHERE("Activity Type" = CONST("Invt. Pick"), "Source Document" = CONST("Sales Order"), "Source No." = FIELD("No.")));
            Description = 'NUB1.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59011; "Order Shipped"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Quantity Shipped" = FILTER(<> 0)));
            Description = 'NUB1.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70000; "Lines Shipped Not Invoiced"; Integer)
        {
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order), "Document No." = FIELD("No."), "Qty. Shipped Not Invoiced" = FILTER(<> 0)));
            Description = 'FP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70001; "Ready for Shipping"; Boolean)
        {
            Description = 'FP';
        }
        field(70002; "No. Pick Printed"; Integer)
        {
            Description = 'FP6';
        }
        field(70003; "Orig. Invoice No."; Code[20])
        {
            Description = 'FP6.2.08';
            TableRelation = "Sales Invoice Header"."No." WHERE("Sell-to Customer No." = FIELD("Sell-to Customer No."));
        }
        field(70011; "Quote Expiration Date"; Date)
        {
            Description = 'FP_QHist';
        }
        // field(14005160;"Delay Note";Boolean)
        // {
        //     Description = 'POPN';
        // }
        // field(14005161;"Stop Note";Boolean)
        // {
        //     Description = 'POPN6.3';
        // }
    }
    keys
    {


    }




    procedure "---NUB1.01---"()
    begin
    end;

    procedure SetShipToCode()
    var
        ShipToAddressLRec: Record "Ship-to Address";
    begin
        ShipToAddressLRec.RESET;
        ShipToAddressLRec.SETRANGE("Customer No.", "Sell-to Customer No.");
        IF ShipToAddressLRec.FINDFIRST THEN
            VALIDATE("Ship-to Code", ShipToAddressLRec.Code);
    end;

    procedure "---NUB1.03---"()
    begin
    end;

    procedure CheckItemTrackingLines()
    var
        SalesLineRecLcl: Record "Sales Line";
        ItemRecLcl: Record Item;
        ResCountVar: Integer;
        Text50000: Label 'Item Tracking Lines are missing for Item No %1 and Line No %2. Do you want to continue ?';
    begin
        //NUB1.03 Start
        TESTFIELD(Status, Status::Open);

        SalesLineRecLcl.RESET;
        SalesLineRecLcl.SETRANGE("Document Type", "Document Type");
        SalesLineRecLcl.SETRANGE("Document No.", "No.");
        SalesLineRecLcl.SETRANGE(Type, SalesLineRecLcl.Type::Item);
        IF SalesLineRecLcl.FINDSET THEN BEGIN
            REPEAT
                IF ItemRecLcl.GET(SalesLineRecLcl."No.") THEN;

                IF ItemRecLcl."Item Category Code" <> '' THEN BEGIN
                    TrackSpecRecGbl.RESET;
                    TrackSpecRecGbl.SETRANGE("Source Type", 37);
                    TrackSpecRecGbl.SETRANGE("Source Subtype", SalesLineRecLcl."Document Type");
                    TrackSpecRecGbl.SETRANGE("Source ID", SalesLineRecLcl."Document No.");
                    TrackSpecRecGbl.SETRANGE("Source Batch Name", '');
                    TrackSpecRecGbl.SETRANGE("Source Prod. Order Line", 0);
                    TrackSpecRecGbl.SETRANGE("Source Ref. No.", SalesLineRecLcl."Line No.");
                    ResCountVar := TrackSpecRecGbl.COUNT;

                    IF ResCountVar = 0 THEN
                        IF NOT CONFIRM(Text50000, TRUE, SalesLineRecLcl."No.", SalesLineRecLcl."Line No.") THEN
                            ERROR('');
                END;
            UNTIL SalesLineRecLcl.NEXT = 0;
        END;
        //NUB1.03 End
    end;

    procedure "---NUB1.04---"()
    begin
    end;

    procedure SetSecurityFilterOnSalesPerson()
    begin
        //NUB1.04 Start
        IF EventsAndSubscriber.GetSalesPersonFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Salesperson Code", EventsAndSubscriber.GetSalesPersonFilter);
        END;
        //NUB1.04 End
    end;

    procedure "---NUB1.06---"()
    begin
    end;

    procedure CheckSalesLineUnitPrice()
    var
        SalesLineRecLcl: Record "Sales Line";
    begin
        //NUB1.06 Start
        SalesLineRecLcl.RESET;
        SalesLineRecLcl.SETRANGE("Document Type", "Document Type");
        SalesLineRecLcl.SETRANGE("Document No.", "No.");
        SalesLineRecLcl.SETFILTER(Type, '<>%1', SalesLineRecLcl.Type::" ");
        SalesLineRecLcl.SETFILTER("Unit Price", '=%1', 0);
        IF SalesLineRecLcl.FINDFIRST THEN
            ERROR('Please check %1 for %2 %3', SalesLineRecLcl.FIELDCAPTION("Unit Price"), SalesLineRecLcl.FIELDCAPTION("Line No."), SalesLineRecLcl."Line No.");
        //NUB1.06 End
    end;



    var
        //SellToCustTemplate: Record "Customer Template";//B2BUPG
        SellToCustTemplate: Record "Customer Templ.";



    var
        SalesTaxDifference: Record "Sales Tax Amount Difference";

    var
        PrepmtIncludeTaxErr: Label 'You cannot select the %1 field for foreign currencies.', Comment = '%1 is the feildname Prepmt. Include Tax';
        "--FP--": Integer;
        //EmailTracking: Record "Email Tracking";
        "--POPN--": Integer;
        //NotesCU: Codeunit "Multi-Note";
        "--BSP--": Integer;
        //BusST: Codeunit "Bus. Snapshot";
        "-NUB1.03-": Integer;
        TrackSpecRecGbl: Record "Tracking Specification";
        "-NUB1.07-": Integer;
        CustRecGbl: Record Customer;
        CustBalCheckMsg: Label 'Customer Balance is greater than $5000.';
        EventsAndSubscriber: codeunit EventsandSubscribers;


}

