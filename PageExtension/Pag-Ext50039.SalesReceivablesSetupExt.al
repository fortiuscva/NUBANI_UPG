namespace Nubani.Nubani;

using Microsoft.Sales.Setup;

pageextension 50039 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    CaptionML = ENU = 'Sales & Receivables Setup',
               ESM = 'Conf. ventas y cobros',
               FRC = 'Configuration ventes et … recevoir',
               ENC = 'Sales & Receivables Setup';
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General',
                           ESM = 'General',
                           FRC = 'G‚n‚ral',
                           ENC = 'General';
        }
        // addafter("Logo Position on Documents")
        // {
        //     field("G/L Freight Account No."; Rec."G/L Freight Account No.")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        addafter("Check Prepmt. when Posting")
        {
            field("Repop Notes on Make Order"; Rec."Repop Notes on Make Order")
            {
                ApplicationArea = All;
            }
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions',
                           ESM = 'Dimensiones',
                           FRC = 'Dimensions',
                           ENC = 'Dimensions';
        }
        modify("Background Posting")
        {
            CaptionML = ENU = 'Background Posting',
                           ESM = 'Registro de fondo',
                           FRC = 'Report arriŠre-plan',
                           ENC = 'Background Posting';
        }
        addafter("Notify On Success")
        {
            field("Days to Expire"; Rec."Days to Expire")
            {
                ApplicationArea = All;
            }
        }
        addafter("Background Posting")
        {
            group(Defaults)
            {
                CaptionML = ENU = 'Defaults',
                           ESM = 'Defaults',
                           FRC = 'Defaults',
                           ENC = 'Defaults';
            }
        }
        addfirst(Defaults)
        {
            field("Stop Print Shipper"; Rec."Stop Print Shipper")
            {
                ApplicationArea = All;
            }
        }
    }
}
