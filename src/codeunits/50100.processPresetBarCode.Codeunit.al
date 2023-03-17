codeunit 50100 "processPresetBarCode"
{
    Permissions = tabledata "Item Ledger Entry" = rimd;
    procedure insertTempBarCodeRecs(var iwxSampleBarcode: Record "IWX Sample Barcode"; LotNo: code[50]; updatedCount: Integer)
    begin
        iwxSampleBarcode.Init();
        iwxSampleBarcode.ID := updatedCount;
        iwxSampleBarcode."Barcode Format" := iwxSampleBarcode."Barcode Format"::"Code 128";
        iwxSampleBarcode."Image Size" := iwxSampleBarcode."Image Size"::Auto;
        iwxSampleBarcode.Multiplier := 8;
        iwxSampleBarcode."Dot Size" := 2;
        iwxSampleBarcode.Height := 42;
        iwxSampleBarcode.Width := 200;
        iwxSampleBarcode.Content := LotNo;
        iwxSampleBarcode.Insert(true);
        Commit();
    end;

    procedure insertTempBarCodeItemRecs(var iwxSampleBarcode: Record "IWX Sample Barcode"; ItemNo: code[20]; updatedCount: Integer)
    begin
        iwxSampleBarcode.Init();
        iwxSampleBarcode.ID := updatedCount;
        iwxSampleBarcode."Barcode Format" := iwxSampleBarcode."Barcode Format"::"Code 128";
        iwxSampleBarcode."Image Size" := iwxSampleBarcode."Image Size"::Auto;
        iwxSampleBarcode.Multiplier := 8;
        iwxSampleBarcode."Dot Size" := 2;
        iwxSampleBarcode.Height := 42;
        iwxSampleBarcode.Width := 200;
        iwxSampleBarcode.Content := ItemNo;
        iwxSampleBarcode.Type := iwxSampleBarcode.Type::Item;
        iwxSampleBarcode.Insert(true);
        Commit();
    end;

    procedure modifyItemLedgEntryWithPerm(var itemLedgerEntry: Record "Item Ledger Entry")
    begin
        itemLedgerEntry.Modify(true);
        Commit();
    end;
}
