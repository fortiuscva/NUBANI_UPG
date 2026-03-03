tableextension 50035 WarehouseEntryExt extends "Warehouse Entry"
{
    // NUB1.01,10/25/19,SK: Added new Key as "Item No.", "Lot No." to use in Report 50015.
    // NUB1.02,05/21/20,ST: Enhancements to export bin movement entries based on registering date.
    //                       - Added new key "Registering Date".
    Caption = 'Warehouse Entry';
    fields
    {
        modify("Entry No.")
        {
            Caption = 'Entry No.';
        }
        modify("Journal Batch Name")
        {
            Caption = 'Journal Batch Name';
        }
        modify("Line No.")
        {
            Caption = 'Line No.';

        }
        modify("Registering Date")
        {
            Caption = 'Registering Date';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Zone Code")
        {
            Caption = 'Zone Code';
        }
        modify("Bin Code")
        {
            Caption = 'Bin Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Item No.")
        {
            Caption = 'Item No.';
        }
        modify(Quantity)
        {
            Caption = 'Quantity';
        }
        modify("Qty. (Base)")
        {
            Caption = 'Qty. (Base)';
        }
        modify("Source Type")
        {
            Caption = 'Source Type';
        }
        modify("Source Subtype")
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';

            //Unsupported feature: Property Modification (OptionString) on ""Source Subtype"(Field 21)".

        }
        modify("Source No.")
        {
            Caption = 'Source No.';
        }
        modify("Source Line No.")
        {
            Caption = 'Source Line No.';

        }
        modify("Source Subline No.")
        {
            Caption = 'Source Subline No.';
        }
        modify("Source Document")
        {
            Caption = 'Source Document';
            //OptionCaption = ',S. Order,S. Invoice,S. Credit Memo,S. Return Order,P. Order,P. Invoice,P. Credit Memo,P. Return Order,Inb. Transfer,Outb. Transfer,Prod. Consumption,Item Jnl.,Phys. Invt. Jnl.,Reclass. Jnl.,Consumption Jnl.,Output Jnl.,BOM Jnl.,Serv. Order,Job Jnl.,Assembly Consumption,Assembly Order';

        }
        modify("Source Code")
        {
            Caption = 'Source Code';
        }
        modify("Reason Code")
        {
            Caption = 'Reason Code';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';
        }
        modify("Bin Type Code")
        {
            Caption = 'Bin Type Code';
        }
        modify(Cubage)
        {
            Caption = 'Cubage';
        }
        modify(Weight)
        {
            Caption = 'Weight';
        }
        modify("Journal Template Name")
        {
            Caption = 'Journal Template Name';
        }
        modify("Whse. Document No.")
        {
            Caption = 'Whse. Document No.';
        }
        modify("Whse. Document Type")
        {
            Caption = 'Whse. Document Type';
            //OptionCaption = 'Whse. Journal,Receipt,Shipment,Internal Put-away,Internal Pick,Production,Whse. Phys. Inventory, ,Assembly';

        }
        modify("Whse. Document Line No.")
        {
            Caption = 'Whse. Document Line No.';

        }
        modify("Entry Type")
        {
            Caption = 'Entry Type';
            OptionCaption = 'Negative Adjmt.,Positive Adjmt.,Movement';



        }
        modify("Reference Document")
        {
            Caption = 'Reference Document';
            //OptionCaption = ' ,Posted Rcpt.,Posted P. Inv.,Posted Rtrn. Rcpt.,Posted P. Cr. Memo,Posted Shipment,Posted S. Inv.,Posted Rtrn. Shipment,Posted S. Cr. Memo,Posted T. Receipt,Posted T. Shipment,Item Journal,Prod.,Put-away,Pick,Movement,BOM Journal,Job Journal,Assembly';

        }
        modify("Reference No.")
        {
            Caption = 'Reference No.';
        }
        modify("User ID")
        {

            Caption = 'User ID';
        }
        modify("Variant Code")
        {
            Caption = 'Variant Code';
        }
        modify("Qty. per Unit of Measure")
        {
            Caption = 'Qty. per Unit of Measure';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }
        modify("Serial No.")
        {
            Caption = 'Serial No.';
        }
        modify("Lot No.")
        {
            Caption = 'Lot No.';
        }
        modify("Warranty Date")
        {
            Caption = 'Warranty Date';
        }
        modify("Expiration Date")
        {
            Caption = 'Expiration Date';
        }
        modify("Phys Invt Counting Period Code")
        {
            Caption = 'Phys Invt Counting Period Code';

        }
        modify("Phys Invt Counting Period Type")
        {
            Caption = 'Phys Invt Counting Period Type';
            OptionCaption = ' ,Item,SKU';



        }
        modify(Dedicated)
        {
            Caption = 'Dedicated';



        }
    }
    keys

    {
        key(Key50000; "Registering Date")
        {
        }
    }


}









