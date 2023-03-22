tableextension 50113 "DRL Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; BarcodeItem; Media)
        {
            DataClassification = ToBeClassified;

            Caption = 'Barcode Item';
        }
        field(50101; BarCodeLot; Media)
        {
            DataClassification = ToBeClassified;
            Caption = 'Barcode Lot';
        }
    }
}