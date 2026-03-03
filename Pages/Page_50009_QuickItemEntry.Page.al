page 50009 "Quick Item Entry"
{
    // NUB1.01,SP2357,09/17/12,DRH:  New page for Quick Item Entry.
    // NUB1.02,07/26/18,SK: Added code "<Action1100796008> - OnAction()" to insert Item Extend Text at Sales Lines & declared global variables.

    Permissions = TableData "Quick Item Search Temp Table" = rimd;

    layout
    {
        area(content)
        {
            group(Control1100796001)
            {
                field(OrderNo; OrderNo)
                {
                    Caption = 'Order No.';
                    ApplicationArea = all;
                }
                field(CustNo; CustNo)
                {
                    Caption = 'Customer No.';
                    ApplicationArea = all;
                }
                field(CustName; CustName)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = all;
                }
                field(InDesc; InDesc)
                {
                    Caption = 'Item Description';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Item2.RESET;
                        Item2.SETFILTER(Description, '*' + InDesc + '*');
                        if Item2.FINDSET then begin
                            repeat
                                Item2.CALCFIELDS(Inventory);
                                QuickTemp.INIT;
                                QuickTemp."Item No." := Item2."No.";
                                QuickTemp."User ID" := USERID;
                                QuickTemp."Item Description" := Item2.Description;
                                QuickTemp.UOM := Item2."Base Unit of Measure";
                                QuickTemp."Unit Price" := Item2."Unit Price";
                                QuickTemp."On Hand" := Item2.Inventory;
                                QuickTemp.Quantity := 0;
                                QuickTemp.INSERT;
                            until Item2.NEXT = 0;
                        end;

                        COMMIT;
                        CurrPage.UPDATE;
                    end;
                }
            }
            part(ItemEntries; "Quick Item Entry Subform")
            {
                Caption = 'ItemEntries';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Insert Items")
            {
                Caption = 'Insert Items';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;


                trigger OnAction()
                var
                    LastSalesLine: Record "Sales Line";
                begin
                    SalesLines.RESET;
                    SalesLines.SETRANGE("Document No.", OrderNo);
                    if SalesLines.FINDLAST then
                        LineNo := SalesLines."Line No." + 10000
                    else
                        LineNo := 10000;

                    ItemTemp.RESET;
                    ItemTemp.SETRANGE("User ID", USERID);
                    ItemTemp.SETFILTER(Quantity, '<>0');
                    if ItemTemp.FINDSET then begin
                        repeat
                            SalesLines.RESET;
                            SalesLines.INIT;
                            SalesLines."Document Type" := DocType;
                            SalesLines."Document No." := OrderNo;
                            SalesLines.Type := SalesLines.Type::Item;
                            SalesLines."Line No." := LineNo;
                            SalesLines.VALIDATE("No.", ItemTemp."Item No.");
                            SalesLines.INSERT;

                            SalesLines.VALIDATE(Quantity, ItemTemp.Quantity);
                            SalesLines.VALIDATE("Unit Price", ItemTemp."Unit Price");
                            SalesLines.MODIFY;

                            /* //NUB1.02 Start
                            if TransferExtendedText.SalesCheckIfAnyExtText(SalesLines, false) then begin
                                CurrPage.SAVERECORD;
                                COMMIT;
                                //TransferExtendedText.InsertSalesExtText2(SalesLines);//B2BUPG
                            end;
                            //NUUB102 End
                             */
                            if TransferExtendedText.SalesCheckIfAnyExtText(SalesLines, false) then begin
                                TransferExtendedText.InsertSalesExtTextRetLast(SalesLines, LastSalesLine);
                                SalesLines."Line No." := LastSalesLine."Line No.";
                            end;


                            LineNo := LineNo + 10000;

                        until ItemTemp.NEXT = 0;
                    end;

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        QuickTemp.RESET;
        QuickTemp.SETRANGE("User ID", USERID);
        QuickTemp.DELETEALL;
    end;

    trigger OnOpenPage()
    begin
        QuickTemp.RESET;
        QuickTemp.SETRANGE("User ID", USERID);
        QuickTemp.DELETEALL;
    end;

    var
        OrderNo: Code[20];
        CustNo: Code[20];
        CustName: Text[30];
        InDesc: Text[50];
        QuickTemp: Record "Quick Item Search Temp Table";
        Item2: Record Item;
        DocType: Enum "Sales Document Type";
        SalesLines: Record "Sales Line";
        ItemTemp: Record "Quick Item Search Temp Table";
        LineNo: Integer;
        "-NUBU1.02-": Integer;
        TransferExtendedText: Codeunit 378;


    procedure SetValues(var InOrd: Code[20]; var InCustNo: Code[20]; var InDocType: Enum "Sales Document Type")
    var
        Cust: Record Customer;
    begin
        OrderNo := InOrd;
        CustNo := InCustNo;
        Cust.GET(CustNo);
        CustName := Cust.Name;
        DocType := InDocType;
    end;
}

