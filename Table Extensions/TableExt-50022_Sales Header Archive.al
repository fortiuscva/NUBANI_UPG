tableextension 50022 SalesHeaderArchiveExt extends "Sales Header Archive"
{

    // NUB1.01,12/04/19,SK: Added new fields as 50011/Pallets Spaces, 50012/Shipping Status.
    // NUB1.02,05/06/20,ST: Enhancements to print pallet label.
    //                       - Added field 50015/Pallet Count.
    Caption = 'Sales Header Archive';
    fields
    {

        field(50011; "Pallets Spaces"; Integer)
        {
            Description = 'NUB1.01';
        }
        field(50012; "Shipping Status"; Option)
        {
            Description = 'NUB1.01';
            OptionCaption = ' ,Checking,Need to Pick,Picked,Picking,Ready to Ship,Shipped';
            OptionMembers = " ",Checking,"Need to Pick",Picked,Picking,"Ready to Ship",Shipped;
        }
        field(50015; "Pallet Count"; Integer)
        {
            Description = 'NUB1.02';
        }
    }

}

