page 50008 "Item Selection"
{
    // //FP  Add 'View Sales History' to Sales Button
    //       Add 'View Purchase History' to Purchase Button
    //       Add Quick Edit to Item Button
    //       Promoted Quick Edit, History-Sales, History-Purchase into the Promoted Category of Process
    //       Promoted Ledger Entries Option
    //       Added Picture factbox to top of part section
    // //POPN6.2  Add menu items to Item Button
    //         Add global variables
    // NUB1.01,08/21/17,SK: Created new list page & declared global variables and functions.
    // NUB1.02,08/09/18,SK: Added code "<Action1100796005> - OnAction()" to insert Item Extend Text at Sales Lines & declared global variables.

    Caption = 'Item List';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item Selection"; Rec."Item Selection")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = all;
                }
                field("Inventory on Date"; Rec."Inventory on Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Unit Count"; Rec."Unit Count")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'SKU';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Product Group Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1900510507; "NUB Item Supply FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1905726507; "NUB Item Demand FB")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1100768008; "Item Picture Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            part(LotNumbersByBin; "NUB Lot Numb. By Bin Factbox")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Lot Numbers By Bin';
                SubPageLink = "Item No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Insert Items")
            {
                ApplicationArea = all;
                Caption = 'Insert Items';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LastSalesLine: Record "Sales Line";
                begin
                    SalesLines.RESET;
                    SalesLines.SETRANGE("Document Type", DocType);
                    SalesLines.SETRANGE("Document No.", DocNo);
                    if SalesLines.FINDLAST then
                        LineNo := SalesLines."Line No." + 10000
                    else
                        LineNo := 10000;

                    ItemRecGbl.RESET;
                    ItemRecGbl.SETRANGE("Item Selection", true);
                    if ItemRecGbl.FINDSET then begin
                        repeat
                            SalesLines.RESET;
                            SalesLines.INIT;
                            SalesLines."Document Type" := DocType;
                            SalesLines."Document No." := DocNo;
                            SalesLines.Type := SalesLines.Type::Item;
                            SalesLines."Line No." := LineNo;
                            SalesLines.VALIDATE("No.", ItemRecGbl."No.");
                            SalesLines.INSERT;

                            /* //NUB1.02 Start
                            if TransferExtendedText.SalesCheckIfAnyExtText(SalesLines, false) then begin
                                CurrPage.SAVERECORD;
                                COMMIT;
                                //TransferExtendedText.InsertSalesExtText2(SalesLines);//B2BUPG
                            end;
                            //NUUB102 End */

                            if TransferExtendedText.SalesCheckIfAnyExtText(SalesLines, false) then begin
                                TransferExtendedText.InsertSalesExtTextRetLast(SalesLines, LastSalesLine);
                                SalesLines."Line No." := LastSalesLine."Line No.";
                            end;

                            LineNo := LineNo + 10000;
                        until ItemRecGbl.NEXT = 0;
                    end;

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        ItemRec: Record Item;
    begin
        ItemRec.RESET;
        ItemRec.SETRANGE("Item Selection", true);
        if ItemRec.FINDSET then begin
            repeat
                ItemRec."Item Selection" := false;
                ItemRec.MODIFY;
            until ItemRec.NEXT = 0;
        end;
    end;

    var
        ItemSelc: Boolean;
        DocNo: Code[20];
        DocType: Enum "Sales Document Type";
        SalesLines: Record "Sales Line";
        ItemTemp: Record "Quick Item Search Temp Table";
        LineNo: Integer;
        ItemRecGbl: Record Item;
        "-NUB1.02-": Integer;
        TransferExtendedText: Codeunit 378;
        LineSpacing: Integer;
        TmpExtTextLine: Record "Extended Text Line";


    procedure SetValues(DocTypePar: Enum "Sales Document Type"; DocNoPar: Code[20])
    var
        Cust: Record Customer;
    begin
        DocType := DocTypePar;
        DocNo := DocNoPar;
    end;


    // procedure InsertSalesExtText2(VAR SalesLine: Record "Sales Line")//B2BUPG
    // var
    // ToSalesLine : Record "Sales Line";
    // Text000 : label 'There is not enough space to insert extended text lines.';
    // NextLineNo : Integer;
    // SalesLineCommT : Record "Sales Comment Line"; 
    // MakeUpdateRequired : Boolean;
    // begin
    //     ToSalesLine.RESET;
    //     ToSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
    //     ToSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
    //     ToSalesLine := SalesLine;
    //     IF ToSalesLine.FIND('>') THEN BEGIN
    //         LineSpacing :=
    //           (ToSalesLine."Line No." - SalesLine."Line No.") DIV
    //           (1 + TmpExtTextLine.COUNT);
    //         IF LineSpacing = 0 THEN
    //             ERROR(Text000);
    //     END ELSE
    //         LineSpacing := 100;

    //     NextLineNo := SalesLine."Line No." + LineSpacing;

    //     TmpExtTextLine.RESET;
    //     IF TmpExtTextLine.FIND('-') THEN BEGIN
    //         REPEAT
    //             //FP
    //             IF TmpExtTextLine."Use Line Comments" = FALSE THEN BEGIN
    //                 //{--original code--}
    //                 ToSalesLine.INIT;
    //                 ToSalesLine."Document Type" := SalesLine."Document Type";
    //                 ToSalesLine."Document No." := SalesLine."Document No.";
    //                 ToSalesLine."Line No." := NextLineNo;
    //                 NextLineNo := NextLineNo + LineSpacing;
    //                 ToSalesLine.Description := TmpExtTextLine.Text;
    //                 ToSalesLine."Attached to Line No." := SalesLine."Line No.";
    //                 ToSalesLine.INSERT;
    //             END ELSE BEGIN           // are using line comments
    //                                      //{--New code--}
    //                 SalesLineCommT.INIT;
    //                 SalesLineCommT."Document Type" := SalesLine."Document Type";
    //                 SalesLineCommT."No." := SalesLine."Document No.";
    //                 SalesLineCommT."Document Line No." := SalesLine."Line No.";
    //                 SalesLineCommT."Line No." := NextLineNo;
    //                 NextLineNo := NextLineNo + LineSpacing;
    //                 SalesLineCommT.Date := WORKDATE;
    //                 IF TmpExtTextLine."Use LineC Setup Print Defaults" THEN
    //                     SalesLineCommT.VALIDATE(Comment, TmpExtTextLine.Text)
    //                 ELSE BEGIN
    //                     SalesLineCommT.Comment := TmpExtTextLine.Text;
    //                     SalesLineCommT."Print On Quote" := TmpExtTextLine."Print on Sales Quote";
    //                     SalesLineCommT."Print On Order Confirmation" := TmpExtTextLine."Print on Sales Order";
    //                     SalesLineCommT."Print On Invoice" := TmpExtTextLine."Print on Sales Invoice";
    //                     SalesLineCommT."Print On Shipment" := TmpExtTextLine."Print on Sales Shipper";
    //                     SalesLineCommT."Print On Credit Memo" := TmpExtTextLine."Print on Sales Credit Memo";
    //                 END;
    //                 SalesLineCommT.INSERT;
    //             END;
    //         //end FP
    //         UNTIL TmpExtTextLine.NEXT = 0;
    //         MakeUpdateRequired := TRUE;
    //     END;
    //     TmpExtTextLine.DELETEALL;
}

