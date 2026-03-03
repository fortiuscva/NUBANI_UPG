page 50013 "Regular Items"
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
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Item Category Code" = FILTER('REGULAR'));

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
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Inventory on Date"; Rec."Inventory on Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Count"; Rec."Unit Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'SKU';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Visible = false;
                    ApplicationArea = All;
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
            }//B2B these are Addon factbox pages 
            part(Control1100768008; "Item Picture Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
            part(LotNumbersByBin; "NUB Lot Numb. By Bin Factbox")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Lot Numbers By Bin';
                SubPageLink = "Item No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = all;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
                Visible = true;
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
                                //TransferExtendedText.InsertSalesExtText2(SalesLines);//
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


    procedure SetValues(DocTypePar: Enum "Sales Document Type"; DocNoPar: Code[20])
    var
        Cust: Record Customer;
    begin
        DocType := DocTypePar;
        DocNo := DocNoPar;
    end;
}

