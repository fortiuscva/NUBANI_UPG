namespace Nubani.Nubani;

using Microsoft.Sales.Document;

pageextension 50038 "Sales order StatisticsExtt" extends "Sales Order Statistics"
{
    CaptionML = ENU = 'Sales Order Statistics',
               ESM = 'Estad. pedido ventas',
               FRC = 'Statistiques document de vente',
               ENC = 'Sales Order Statistics';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        modify(InvDiscountAmount_General)
        {

            CaptionML = ENU = 'Inv. Discount Amount',
                           ESM = 'Importe dto. factura',
                           FRC = 'Montant d escompte sur facture',
                           ENC = 'Inv. Discount Amount';
            Editable = FALSE;
        }
        modify(VATAmount)
        {
            CaptionML = ENU = 'VAT Amount',
                           ESM = 'Importe IVA',
                           FRC = 'Montant de TVA',
                           ENC = 'Tax Amount';
        }
        modify("TotalSalesLineLCY[1].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)',
                           ESM = 'Ventas ($)',
                           FRC = 'Ventes ($)',
                           ENC = 'Sales ($)';
        }
        modify("TotalSalesLine[1].Quantity")
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify("TotalSalesLine[2].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels',
                           ESM = 'Lotes',
                           FRC = 'Colis',
                           ENC = 'Parcels';
        }
        modify("TotalSalesLine[1].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight',
                           ESM = 'Peso neto',
                           FRC = 'Poids net',
                           ENC = 'Net Weight';
        }
        modify("TotalSalesLine[1].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight',
                           ESM = 'Peso bruto',
                           FRC = 'Poids brut',
                           ENC = 'Gross Weight';
        }
        modify("TotalSalesLine[2].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume',
                           ESM = 'Volumen',
                           FRC = 'Volume',
                           ENC = 'Volume';
        }
        modify(NoOfVATLines_General)
        {
            CaptionML = ENU = 'No. of VAT Lines',
                           ESM = 'N§ de l¡neas de IVA',
                           FRC = 'Nombre de lignes TVA',
                           ENC = 'No. of Tax Lines';
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing',
                           ESM = 'Facturaci¢n',
                           FRC = 'Facturation',
                           ENC = 'Invoicing';
        }
        modify(InvDiscountAmount_Invoicing)
        {
            CaptionML = ENU = 'Inv. Discount Amount',
                           ESM = 'Importe dto. factura',
                           FRC = 'Montant d escompte sur facture',
                           ENC = 'Inv. Discount Amount';
        }
        modify("TotalSalesLineLCY[2].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)',
                           ESM = 'Ventas ($)',
                           FRC = 'Ventes ($)',
                           ENC = 'Sales ($)';
        }
        modify("TotalSalesLine[2].Quantity")
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify("TotalSalesLine[1].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels',
                           ESM = 'Lotes',
                           FRC = 'Colis',
                           ENC = 'Parcels';
        }
        modify("TotalSalesLine[2].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight',
                           ESM = 'Peso neto',
                           FRC = 'Poids net',
                           ENC = 'Net Weight';
        }
        modify("TotalSalesLine[2].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight',
                           ESM = 'Peso bruto',
                           FRC = 'Poids brut',
                           ENC = 'Gross Weight';
        }
        modify("TotalSalesLine[1].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume',
                           ESM = 'Volumen',
                           FRC = 'Volume',
                           ENC = 'Volume';
        }
        modify(NoOfVATLines_Invoicing)
        {
            CaptionML = ENU = 'No. of VAT Lines',
                           ESM = 'N§ de l¡neas de IVA',
                           FRC = 'Nombre de lignes TVA',
                           ENC = 'No. of Tax Lines';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping',
                           ESM = 'Env¡o',
                           FRC = 'Livraison',
                           ENC = 'Shipping';
        }
        modify("TotalSalesLine[3].""Inv. Discount Amount""")
        {
            CaptionML = ENU = 'Inv. Discount Amount',
                           ESM = 'Importe dto. factura',
                           FRC = 'Montant d escompte sur facture',
                           ENC = 'Inv. Discount Amount';
        }
        modify("TotalSalesLineLCY[3].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)',
                           ESM = 'Ventas ($)',
                           FRC = 'Ventes ($)',
                           ENC = 'Sales ($)';
        }
        modify("TotalSalesLine[3].Quantity")
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        modify("TotalSalesLine[3].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels',
                           ESM = 'Lotes',
                           FRC = 'Colis',
                           ENC = 'Parcels';
        }
        modify("TotalSalesLine[3].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight',
                           ESM = 'Peso neto',
                           FRC = 'Poids net',
                           ENC = 'Net Weight';
        }
        modify("TotalSalesLine[3].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight',
                           ESM = 'Peso bruto',
                           FRC = 'Poids brut',
                           ENC = 'Gross Weight';
        }
        modify("TotalSalesLine[3].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume',
                           ESM = 'Volumen',
                           FRC = 'Volume',
                           ENC = 'Volume';
        }
        modify("TempVATAmountLine3.COUNT")
        {
            CaptionML = ENU = 'No. of VAT Lines',
                           ESM = 'N§ de l¡neas de IVA',
                           FRC = 'Nombre de lignes TVA',
                           ENC = 'No. of Tax Lines';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment',
                           ESM = 'Anticipo',
                           FRC = 'Paiement anticip‚',
                           ENC = 'Prepayment';
        }
        modify(PrepmtVATAmount)
        {
            CaptionML = ENU = 'Prepayment Amount Invoiced',
                           ESM = 'Importe anticipo facturado',
                           FRC = 'Montant de paiement anticip‚ factur‚',
                           ENC = 'Prepayment Amount Invoiced';
        }
        modify(PrepmtInvPct)
        {
            CaptionML = ENU = 'Invoiced % of Prepayment Amt.',
                           ESM = '% facturado de importe anticipo',
                           FRC = '% factur‚ sur montant de paiement anticip‚',
                           ENC = 'Invoiced % of Prepayment Amt.';
            ToolTipML = ENU = 'Invoiced % of Prepayment Amt.',
                           ESM = '% facturado de importe anticipo',
                           FRC = '% factur‚ sur montant de paiement anticip‚',
                           ENC = 'Invoiced % of Prepayment Amt.';
        }
        modify(PrepmtDeductedPct)
        {
            CaptionML = ENU = 'Deducted % of Prepayment Amt. to Deduct',
                           ESM = '% descontado del importe anticipo que se debe descontar',
                           FRC = '% d‚duit sur montant de paiement anticip‚ … d‚duire',
                           ENC = 'Deducted % of Prepayment Amt. to Deduct';
            ToolTipML = ENU = 'Deducted % of Prepayment Amt. to Deduct',
                           ESM = '% descontado del importe anticipo que se debe descontar',
                           FRC = '% d‚duit sur montant de paiement anticip‚ … d‚duire',
                           ENC = 'Deducted % of Prepayment Amt. to Deduct';
        }
        modify("TempVATAmountLine4.COUNT")
        {
            CaptionML = ENU = 'No. of VAT Lines',
                           ESM = 'N§ de l¡neas de IVA',
                           FRC = 'Nombre de lignes TVA',
                           ENC = 'No. of Tax Lines';
        }
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
    var
        Text000: TextConst ENU = 'Sales %1 Statistics', ESM = 'Estad¡sticas %1 ventas', FRC = 'Statistiques %1 vente', ENC = 'Sales %1 Statistics';
        Text001: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        Text002: TextConst ENU = 'Amount', ESM = 'Importe', FRC = 'Montant', ENC = 'Amount';
        Text003: TextConst ENU = '%1 must not be 0.', ESM = '%1 no debe ser 0.', FRC = '%1 ne doit pas ˆtre 0.', ENC = '%1 must not be 0.';
        Text004: TextConst ENU = '%1 must not be greater than %2.', ESM = '%1 no debe ser m s grande que %2', FRC = '%1 ne doit pas ˆtre sup‚rieur(e) … %2.', ENC = '%1 must not be greater than %2.';
        Text005: TextConst ENU = 'You cannot change the invoice discount because a customer invoice discount with the code %1 exists.', ESM = 'No puede cambiar el dto. factura porque existe un descuento de factura de cliente con el c¢digo %1.', FRC = 'Vous ne pouvez pas modifier l escompte facture car il existe un escompte facture client avec le code %1.', ENC = 'You cannot change the invoice discount because a customer invoice discount with the code %1 exists.';
        Text006: TextConst ENU = 'Prepmt. Amount', ESM = 'Importe anticipo', FRC = 'Montant de paiement anticip‚', ENC = 'Prepmt. Amount';
        Text007: TextConst ENU = 'Prepmt. Amt. Invoiced', ESM = 'Importe anticipo facturado', FRC = 'Montant de paiement anticip‚ factur‚', ENC = 'Prepmt. Amt. Invoiced';
        Text008: TextConst ENU = 'Prepmt. Amt. Deducted', ESM = 'Importe anticipo descontado', FRC = 'Montant de paiement anticip‚ d‚duit', ENC = 'Prepmt. Amt. Deducted';
        Text009: TextConst ENU = 'Prepmt. Amt. to Deduct', ESM = 'Importe anticipo para descontar', FRC = 'Montant de paiement anticip‚ … d‚duire', ENC = 'Prepmt. Amt. to Deduct';
}
