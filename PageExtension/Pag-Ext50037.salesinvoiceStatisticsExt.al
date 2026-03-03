namespace Nubani.Nubani;

using Microsoft.Sales.History;

pageextension 50037 "sales invoice StatisticsExt" extends "Sales Invoice Statistics"
{
    CaptionML = ENU = 'Sales Invoice Statistics',
               ESM = 'Estad. factura ventas',
               FRC = 'Statistiques facture vente',
               ENC = 'Sales Invoice Statistics';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify("CustAmount + InvDiscAmount")
        {
            CaptionML = ENU = 'Amount',
                           ESM = 'Importe',
                           FRC = 'Montant',
                           ENC = 'Amount';
        }
        modify(InvDiscAmount)
        {
            CaptionML = ENU = 'Inv. Discount Amount',
                           ESM = 'Importe dto. factura',
                           FRC = 'Montant d escompte sur facture',
                           ENC = 'Inv. Discount Amount';
        }
        modify(CustAmount)
        {
            CaptionML = ENU = 'Total',
                           ESM = 'Total',
                           FRC = 'Total',
                           ENC = 'Total';
        }
        modify(VATAmount)
        {
            CaptionML = ENU = 'VAT Amount',
                           ESM = 'Importe IVA',
                           FRC = 'Montant de TVA',
                           ENC = 'Tax Amount';
        }
        modify(AmountInclVAT)
        {
            CaptionML = ENU = 'Total Incl. VAT',
                           ESM = 'Total con IVA',
                           FRC = 'Total incluant taxe',
                           ENC = 'Total Incl. Tax';
        }
        modify(AmountLCY)
        {
            CaptionML = ENU = 'Sales (LCY)',
                           ESM = 'Ventas ($)',
                           FRC = 'Ventes ($)',
                           ENC = 'Sales ($)';
        }
        modify(ProfitLCY)
        {
            CaptionML = ENU = 'Original Profit (LCY)',
                           ESM = 'Bf§ original ($)',
                           FRC = 'Profit initial ($)',
                           ENC = 'Original Profit ($)';
        }
        modify(AdjustedProfitLCY)
        {
            CaptionML = ENU = 'Adjusted Profit (LCY)',
                           ESM = 'Beneficio actualizado ($)',
                           FRC = 'Profit ajust‚ ($)',
                           ENC = 'Adjusted Profit ($)';
        }
        modify(ProfitPct)
        {
            CaptionML = ENU = 'Original Profit %',
                           ESM = '% Bf§ original',
                           FRC = '% profit initial',
                           ENC = 'Original Profit %';
        }
        modify(AdjProfitPct)
        {
            CaptionML = ENU = 'Adjusted Profit %',
                           ESM = '% beneficio ajustado',
                           FRC = '% profit ajust‚',
                           ENC = 'Adjusted Profit %';
        }
        modify(LineQty)
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify(TotalParcels)
        {
            CaptionML = ENU = 'Parcels',
                           ESM = 'Lotes',
                           FRC = 'Colis',
                           ENC = 'Parcels';
        }
        modify(TotalNetWeight)
        {
            CaptionML = ENU = 'Net Weight',
                           ESM = 'Peso neto',
                           FRC = 'Poids net',
                           ENC = 'Net Weight';
        }
        modify(TotalGrossWeight)
        {
            CaptionML = ENU = 'Gross Weight',
                           ESM = 'Peso bruto',
                           FRC = 'Poids brut',
                           ENC = 'Gross Weight';
        }
        modify(TotalVolume)
        {
            CaptionML = ENU = 'Volume',
                           ESM = 'Volumen',
                           FRC = 'Volume',
                           ENC = 'Volume';
        }
        modify(CostLCY)
        {
            CaptionML = ENU = 'Original Cost (LCY)',
                           ESM = 'Costo original ($)',
                           FRC = 'Co–t initial ($)',
                           ENC = 'Original Cost ($)';
        }
        modify(AdjustedCostLCY)
        {
            CaptionML = ENU = 'Adjusted Cost (LCY)',
                           ESM = 'Costo actualizado ($)',
                           FRC = 'Co–t ajust‚ ($)',
                           ENC = 'Adjusted Cost ($)';
        }
        modify("TotalAdjCostLCY - CostLCY")
        {
            CaptionML = ENU = 'Cost Adjmt. Amount (LCY)',
                           ESM = 'Importe costo ajustado ($)',
                           FRC = 'Montant ajustement co–t ($)',
                           ENC = 'Cost Adjmt. Amount ($)';
        }
        // addafter("TotalAdjCostLCY - CostLCY")
        // {
        //     field(TotalCommisionAmt; Rec.TotalCommisionAmt)
        //     {
        //         CaptionML = ENU = 'Commission Amount';
        //         ApplicationArea = All;
        //     }
        // }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer',
                           ESM = 'Cliente',
                           FRC = 'Client',
                           ENC = 'Customer';
        }
        modify("Cust.""Balance (LCY)""")
        {
            CaptionML = ENU = 'Balance (LCY)',
                           ESM = 'Saldo ($)',
                           FRC = 'Solde ($)',
                           ENC = 'Balance ($)';
        }
        modify("Cust.""Credit Limit (LCY)""")
        {
            CaptionML = ENU = 'Credit Limit (LCY)',
                           ESM = 'L¡mite de cr‚dito ($)',
                           FRC = 'Limite de cr‚dit ($)',
                           ENC = 'Credit Limit ($)';
        }
        modify(CreditLimitLCYExpendedPct)
        {
            CaptionML = ENU = 'Expended % of Credit Limit (LCY)',
                           ESM = '% L¡mite cr‚dito usado ($)',
                           FRC = '% limite de cr‚dit ‚tendue ($)',
                           ENC = 'Expended % of Credit Limit ($)';
            ToolTipML = ENU = 'Expended % of Credit Limit (LCY)',
                           ESM = '% L¡mite cr‚dito usado ($)',
                           FRC = '% limite de cr‚dit ‚tendue ($)',
                           ENC = 'Expended % of Credit Limit ($)';
        }
    }
    trigger OnAfterGetRecord()
    begin
        //NU1.01 Start
        TotalCommisionAmt := 0;
        //NU1.01 End
        //NU1.01 Start
        TotalCommisionAmt += (SalesInvLine."Line Amount" * SalesInvLine."Commission Perc." / 100);
        //NU1.01 End
    end;

    var
        Text000: TextConst ENU = 'VAT Amount', ESM = 'Importe IVA', FRC = 'Montant de TVA', ENC = 'Tax Amount';
        Text001: TextConst ENU = '%1% VAT', ESM = '%1% IVA', FRC = '%1% Taxe,ENC=%1% Tax';
        "-NU1.01-": Integer;
        TotalCommisionAmt: Decimal;
}
