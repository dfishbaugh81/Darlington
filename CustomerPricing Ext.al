// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50115 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addafter("Opportunity No.")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Selects the Pricing Group for the Customer';

                trigger OnValidate()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.Reset;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if SalesLine.FindFirst() then
                        repeat
                            SalesLine.Validate("Customer Price Group", Rec."Customer Price Group");
                            SalesLine.Modify(True);
                        until SalesLine.Next() = 0;

                end;
            }

            field(BakeWeek; Rec.BakeWeek)
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Input Bake Week';
            }

            field("Total Cases"; Rec."Total Cases")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Cases';
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Weight';
            }

        }
    }
}

pageextension 50130 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Total Cases"; Rec."Total Cases")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Cases';
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Weight';
            }
        }
    }
}

pageextension 50131 PostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Total Cases"; Rec."Total Cases")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Cases';
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Weight';
            }
        }
    }
}

tableextension 50113 itemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50100; BarcodeItem; Media)
        {

        }
        field(50101; BarCodeLot; Media)
        {

        }
    }
}
tableextension 50115 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {

        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                itemUnitOfMea: Record "Item Unit of Measure";
            begin
                if itemUnitOfMea.Get("No.", "Unit of Measure Code") then
                    UnitOfMeaWeight := itemUnitOfMea.Weight * Quantity;
            end;
        }
    }
}
tableextension 50116 SalesShipLine extends "Sales Shipment Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {

        }
    }
    trigger OnAfterInsert()
    var
        itemUnitOfMea: Record "Item Unit of Measure";
    begin
        if itemUnitOfMea.Get("No.", "Unit of Measure Code") then
            UnitOfMeaWeight := itemUnitOfMea.Weight * Quantity;
    end;
}

tableextension 50117 SalesInvLine extends "Sales Invoice Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {

        }
    }
    trigger OnAfterInsert()
    var
        itemUnitOfMea: Record "Item Unit of Measure";
    begin
        if itemUnitOfMea.Get("No.", "Unit of Measure Code") then
            UnitOfMeaWeight := itemUnitOfMea.Weight * Quantity;
    end;
}

tableextension 50118 SalesInvHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".UnitOfMeaWeight WHERE("Document No." = field("No.")));
        }
    }
}

tableextension 50119 SalesShipHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".Quantity WHERE("Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".UnitOfMeaWeight WHERE("Document No." = field("No.")));
        }
    }
}

tableextension 50114 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50112; BakeWeek; Integer)
        {

        }

        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".UnitOfMeaWeight WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }
}
pageextension 50116 SalesOrderLineExt extends "Sales Order Subform"
{
    layout
    {
        addafter("Tax Group Code")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Selects the Pricing Group for the Customer';
            }
        }
    }
}

tableextension 50111 PurchHeadExt extends "Purchase Header"
{
    fields
    {
        field(50110; BakeWeek; Integer)
        {

        }
    }
}
pageextension 50117 PageOrderHeaderExt extends "Purchase Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field(BakeWeek; Rec.BakeWeek)
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Bake Week in Integer format';

            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action(PrintBarcodeTracking)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Item Tracking w/ Barcodes';
                Ellipsis = true;
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Create barcoded lot tracking';

                trigger OnAction()
                var
                    pickTickStubRep: Report BarCodeTrackingReport;
                    pickTickStubRep1: Report BarCodeTrackingReport1;
                begin
                    purchHead.Reset;
                    purchHead.SetRange("No.", Rec."No.");
                    if purchHead.FindFirst() then begin
                        PurchLine.Reset;
                        PurchLine.SetRange("Document Type", Rec."Document Type");
                        PurchLine.SetRange("Document No.", Rec."No.");
                        PurchLine.SetRange(Type, PurchLine.Type::Item);
                        if PurchLine.FindFirst() then begin
                            LotNoTab.Reset;
                            LotNoTab.SetRange("Dcc SO Number", PurchLine."Document No.");
                            LotNoTab.SetRange(ItemNo, PurchLine."No.");
                            LotNoTab.SetRange(RecNo, PurchLine."Line No.");
                            if LotNoTab.Find() then
                                REPORT.RunModal(REPORT::BarCodeTrackingReport, true, false, purchHead)
                            else
                                REPORT.RunModal(REPORT::BarCodeTrackingReport1, true, false, purchHead);
                        end;

                    end;


                end;
            }
        }
    }
    var
        purchLine: Record "Purchase Line";
        purchHead: Record "Purchase Header";
        LotNoTab: Record LotNoTable;
}

pageextension 50113 ItemListExt extends "Item List"
{
    actions
    {
        addafter("Inventory Availability")
        {
            action(PrintBarcodeTracking)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Item Tracking w/ Barcodes';
                Ellipsis = true;
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Create barcoded lot tracking';

                trigger OnAction()
                var
                    pickTickStubRep: Report BarCodeItemTrackingReport;
                    itemCountTotal: Integer;
                    itemCounter: Integer;

                    Window: Dialog;
                begin

                    CurrPage.SetSelectionFilter(item);
                    Window.Open('Processing Items:\Item Nos #1###### of #2######');
                    itemCountTotal := item.Count();
                    if item.FindFirst() then
                        repeat
                            itemCounter := itemCounter + 1;
                            Window.Update(1, format(itemCounter));
                            Window.Update(2, format(itemCountTotal));
                            itemLedgEnt.Reset;
                            itemLedgEnt.Setrange("Item No.", item."No.");
                            itemLedgEnt.SetFilter("Remaining Quantity", '<>0');
                            itemLedgEnt.SetFilter("Lot No.", '<>%1', '');
                            if itemLedgEnt.FindFirst() then
                                repeat
                                    if itemLedgEnt."Lot No." <> LotNo then begin

                                        updatedCount := updatedCount + 1;
                                        LotNo := itemLedgEnt."Lot No.";

                                        processPresetBarCode.insertTempBarCodeRecs(PresetBarCode, itemLedgEnt."Lot No.", updatedCount);
                                        itemLedgEnt.BarCodeLot := PresetBarCode.Barcode;
                                        processPresetBarCode.insertTempBarCodeItemRecs(PresetBarCodeLot, itemLedgEnt."Item No.", updatedCount);
                                        itemLedgEnt.BarcodeItem := PresetBarCodeLot.Barcode;
                                        processPresetBarCode.modifyItemLedgEntryWithPerm(itemLedgEnt);
                                    end
                                until itemLedgEnt.Next() = 0;
                        until item.Next = 0;


                    pickTickStubRep.SetTableView(itemLedgEnt);
                    Window.Close();
                    pickTickStubRep.RunModal();
                end;
            }
        }
    }
    var
        item: Record Item;
        itemLedgEnt: Record "Item Ledger Entry";
        PresetBarCode: Record "IWX Sample Barcode" temporary;
        PresetBarCodeLot: Record "IWX Sample Barcode" temporary;
        LotNo: Code[20];
        updatedCount: Integer;
        processPresetBarCode: Codeunit processPresetBarCode;
}

pageextension 50114 WhrsePhysInvJrnl extends "Whse. Phys. Invt. Journal"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Expiration Date';

            }
        }
    }
}

codeunit 50100 processPresetBarCode
{
    Permissions = tabledata "Item Ledger Entry" = rimd;
    procedure insertTempBarCodeRecs(var presetBarCode: Record "IWX Sample Barcode"; LotNo: code[20]; updatedCount: Integer)
    begin
        presetBarCode.Init;
        presetBarCode.ID := updatedCount;
        presetBarCode."Barcode Format" := PresetBarCode."Barcode Format"::"Code 128";
        presetBarCode."Image Size" := PresetBarCode."Image Size"::Auto;
        presetBarCode.Multiplier := 8;
        presetBarCode."Dot Size" := 2;
        presetBarCode.Height := 42;
        presetBarCode.Width := 200;
        presetBarCode.Content := LotNo;
        presetBarCode.Insert(true);
        commit;
    end;

    procedure insertTempBarCodeItemRecs(var presetBarCodeLot: Record "IWX Sample Barcode"; ItemNo: code[20]; updatedCount: Integer)
    begin
        presetBarCodeLot.Init;
        presetBarCodeLot.ID := updatedCount;
        presetBarCodeLot."Barcode Format" := presetBarCodeLot."Barcode Format"::"Code 128";
        presetBarCodeLot."Image Size" := presetBarCodeLot."Image Size"::Auto;
        presetBarCodeLot.Multiplier := 8;
        presetBarCodeLot."Dot Size" := 2;
        presetBarCodeLot.Height := 42;
        presetBarCodeLot.Width := 200;
        presetBarCodeLot.Content := ItemNo;
        presetBarCodeLot.Type := presetBarCodeLot.Type::Item;
        presetBarCodeLot.Insert(true);
        commit;
    end;

    procedure modifyItemLedgEntryWithPerm(var itemLedgerEntry: Record "Item Ledger Entry")
    begin
        itemLedgerEntry.Modify(true);
        commit;
    end;
}
