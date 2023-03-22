pageextension 50113 "DRL Item List" extends "Item List"
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
                    pickTickStubRep: Report "DRL BarCodeItem Tracking";
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
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.Setrange("Item No.", item."No.");
                            ItemLedgerEntry.SetFilter("Remaining Quantity", '<>0');
                            ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');
                            if ItemLedgerEntry.FindFirst() then
                                repeat
                                    if ItemLedgerEntry."Lot No." <> LotNo then begin

                                        updatedCount := updatedCount + 1;
                                        LotNo := ItemLedgerEntry."Lot No.";

                                        processPresetBarCode.insertTempBarCodeRecs(tempiwxSampleBarcode, ItemLedgerEntry."Lot No.", updatedCount);
                                        ItemLedgerEntry.BarCodeLot := tempiwxSampleBarcode.Barcode;
                                        processPresetBarCode.insertTempBarCodeItemRecs(tempiwxSampleBarcodeLot, ItemLedgerEntry."Item No.", updatedCount);
                                        ItemLedgerEntry.BarcodeItem := tempiwxSampleBarcodeLot.Barcode;
                                        processPresetBarCode.modifyItemLedgEntryWithPerm(ItemLedgerEntry);
                                    end
                                until ItemLedgerEntry.Next() = 0;
                        until item.Next() = 0;


                    pickTickStubRep.SetTableView(ItemLedgerEntry);
                    Window.Close();
                    pickTickStubRep.RunModal();
                end;
            }
        }
    }
    var
        item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        tempiwxSampleBarcode: Record "IWX Sample Barcode" temporary;
        tempiwxSampleBarcodeLot: Record "IWX Sample Barcode" temporary;
        processPresetBarCode: Codeunit processPresetBarCode;
        LotNo: Code[50];
        updatedCount: Integer;

}