namespace NubaniNubaniUPG.NubaniNubaniUPG;

using Microsoft.Bank.Deposit;

reportextension 50001 "Bank Deposit Test Report" extends "Bank Deposit Test Report"
{
    RDLCLayout = './Reports/Layout/BankDepositTestReport.rdl';
    dataset
    {
        add("Gen. Journal Line")
        {
            column(External_Document_No_; "External Document No.")
            { }
        }
    }
}
