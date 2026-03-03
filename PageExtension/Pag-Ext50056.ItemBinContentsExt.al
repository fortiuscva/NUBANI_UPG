// Item Bin Contents has been removed in V 25.2.26449.0
/*
namespace Nubani.Nubani;

using Microsoft.Warehouse.Structure;

pageextension 50056 "Item Bin Contents Ext" extends "Item Bin Contents"
{
    CaptionML = ENU = 'Item Bin Contents',
               ESM = 'Contenidos ubic. prod.',
               FRC = 'Contenu de la zone d article',
               ENC = 'Item Bin Contents';
    layout
    {
        modify(CalcQtyUOM)
        {
            CaptionML = ENU = 'Quantity',
                           ESM = 'Cantidad',
                           FRC = 'Quantit‚',
                           ENC = 'Quantity';
        }
        addafter("Zone Code")
        {
            field("Pick Qty."; Rec."Pick Qty.")
            {
                ApplicationArea = All;
            }
            field("Bin Ranking"; Rec."Bin Ranking")
            {
                ApplicationArea = All;
            }
            field("Lot No. Filter"; Rec."Lot No. Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}
*/