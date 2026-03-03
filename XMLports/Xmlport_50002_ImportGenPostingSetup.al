xmlport 50002 "Import Gen Posting Setup"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("General Posting Setup"; "General Posting Setup")
            {
                XmlName = 'GenPostingSetup';
                fieldelement(f1; "General Posting Setup"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(f2; "General Posting Setup"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(f3; "General Posting Setup"."Sales Account")
                {
                }
                fieldelement(f4; "General Posting Setup"."Sales Credit Memo Account")
                {
                }
                fieldelement(f5; "General Posting Setup"."Sales Line Disc. Account")
                {
                }
                fieldelement(f6; "General Posting Setup"."Sales Inv. Disc. Account")
                {
                }
                fieldelement(f7; "General Posting Setup"."Sales Pmt. Disc. Debit Acc.")
                {
                }
                fieldelement(f8; "General Posting Setup"."Sales Pmt. Disc. Credit Acc.")
                {
                }
                fieldelement(f9; "General Posting Setup"."Sales Pmt. Tol. Debit Acc.")
                {
                }
                fieldelement(f10; "General Posting Setup"."Sales Pmt. Tol. Credit Acc.")
                {
                }
                fieldelement(f11; "General Posting Setup"."Sales Prepayments Account")
                {
                }
                fieldelement(f12; "General Posting Setup"."Purch. Account")
                {
                }
                fieldelement(f13; "General Posting Setup"."Purch. Credit Memo Account")
                {
                }
                fieldelement(f14; "General Posting Setup"."Purch. Line Disc. Account")
                {
                }
                fieldelement(f15; "General Posting Setup"."Purch. Inv. Disc. Account")
                {
                }
                fieldelement(f16; "General Posting Setup"."Purch. Pmt. Disc. Debit Acc.")
                {
                }
                fieldelement(f17; "General Posting Setup"."Purch. Pmt. Disc. Credit Acc.")
                {
                }
                fieldelement(f18; "General Posting Setup"."Purch. Pmt. Tol. Debit Acc.")
                {
                }
                fieldelement(f19; "General Posting Setup"."Purch. Pmt. Tol. Credit Acc.")
                {
                }
                fieldelement(f20; "General Posting Setup"."Purch. Prepayments Account")
                {
                }
                fieldelement(f21; "General Posting Setup"."COGS Account")
                {
                }
                fieldelement(f22; "General Posting Setup"."COGS Account (Interim)")
                {
                }
                fieldelement(f23; "General Posting Setup"."Inventory Adjmt. Account")
                {
                }
                fieldelement(f24; "General Posting Setup"."Invt. Accrual Acc. (Interim)")
                {
                }
                fieldelement(f25; "General Posting Setup"."Direct Cost Applied Account")
                {
                }
                fieldelement(f26; "General Posting Setup"."Overhead Applied Account")
                {
                }
                fieldelement(f27; "General Posting Setup"."Purchase Variance Account")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

