pageextension 50065 purchaseInvoicesExt extends "Purchase Invoices"
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("Pallets-Cases"; Rec."Pallets-Cases")
            {
                ApplicationArea = all;
            }


        }
        moveafter("Pallets-Cases"; "Your Reference")
    }

    actions
    {
        modify(Statistics)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                IF rec."Tax Area Code" = '' THEN
                    PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec)
                ELSE
                    PAGE.RUNMODAL(PAGE::"Purchase Stats.", Rec)
            end;
        }
        modify(Release)
        {
            CaptionML = ESM = 'Lanzar',
                         FRC = 'Lancer',
                         ENC = 'Release';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open';
        }
    }

    var
        myInt: Integer;
}