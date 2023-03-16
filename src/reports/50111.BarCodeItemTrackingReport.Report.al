report 50111 "BarCodeItemTrackingReport"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/BarcodeTrackingReportItem.rdl';
    Caption = 'Barcode Tracking From Item';
    TransactionType = Report;

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    UseRequestPage = true;
    PreviewMode = PrintLayout;

    dataset
    {

        dataitem(itemledgerEnt; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Lot No.");
            RequestFilterFields = "Item No.", "Lot No.", "Remaining Quantity";

            column(Entry_No_; "Entry No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Lot_No_; "Lot No.")
            {

            }
            column(Quantity; "Remaining Quantity")
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(Expiration_Date; "Expiration Date")
            {

            }

            column(item_description; item.Description)
            {

            }
            column(DateRec; Workdate())
            {

            }
            column(LotNoLabel; LotNoLabel)
            {

            }
            column(AllergensLabel; AllergensLabel)
            {

            }
            column(ExpirationLabel; ExpirationLabel)
            {

            }
            column(allergen; allergen)
            {

            }
            column(DateReceivedLabel; DateReceivedLabel)
            {

            }
            column(updatedCount; updatedCount)
            {

            }
            column(barcodeLot; BarCodeLot)
            {

            }

            column(barcodeItem; BarcodeItem)
            {

            }



            trigger OnAfterGetRecord()
            var
                itemattvalmap: Record "Item Attribute Value Mapping";
                itemAttVal: Record "Item Attribute Value";

                DateRec: Date;
            begin
                if itemledgerEnt."Lot No." <> LotNo then
                    LotNo := itemledgerEnt."Lot No."
                else
                    CurrReport.Skip();

                updatedCount := updatedCount + 1;

                if item.Get(itemledgerEnt."Item No.") then;

                DateRec := WorkDate();

                itemattvalmap.Reset();
                itemattvalmap.SetRange("Table ID", Database::Item);
                itemattvalmap.SetRange("No.", itemledgerEnt."Item No.");
                if itemattvalmap.FindFirst() then
                    repeat

                        if itemAttVal.Get(itemattvalmap."Item Attribute ID", itemattvalmap."Item Attribute Value ID") then
                            allergen := itemAttVal.Value
                        else
                            clear(allergen);

                    until itemattvalmap.Next() = 0;
            end;

        }


    }


    requestpage
    {
        layout
        {
            area(Content)
            {


                group(Options)
                {
                    Caption = 'Options';


                }

            }

        }


        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        allergen: text;
        DateRec: Date;
        bCode: Record "IWX Barcode";
        bLotCode: Record "IWX Barcode";
        LotNo: code[50];
        LotNoLabel: Label 'Lot No.:';
        ExpirationLabel: Label 'Expiration:';
        AllergensLabel: Label 'Allergens:';
        DateReceivedLabel: Label 'Date Received:';
        item: Record item;
        myCounter: Integer;
        updatedCount: Integer;
        recBarcodeLot: Page "IWX Sample Barcode List";
        recBarcode: Record "IWX Sample Barcode";
        cuBarcodeGeneration: codeunit "IWX Library - Barcode Gen";
        pcuTempCode: codeunit "SFI Barcode Mgmt";
        sfiBcEntry: Record "IWX Sample Barcode";
        itemRec: Report "IWX Sample Barcode List";
        testLotRec: Codeunit "IWX Barcode Generation";
        testNewRec: Report "IWX Sample Barcode List";


}