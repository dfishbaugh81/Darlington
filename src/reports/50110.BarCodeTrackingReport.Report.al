report 50110 "BarCodeTrackingReport"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/BarcodeTrackingReportPo.rdl';
    Caption = 'Barcode Tracking From Purchase Order';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order), Type = CONST(Item));

                dataitem("Tracking Specification"; "Tracking Specification")
                {

                    DataItemLink = "Source ID" = FIELD("Document No."),
                                    "Source Ref. No." = field("Line No.");

                    column(Entry_No_; "Entry No.")
                    {

                    }
                    column(Description; Description)
                    {

                    }
                    column(Lot_No_; "Lot No.")
                    {

                    }
                    column(Quantity_Handled__Base_; "Quantity Handled (Base)")
                    {

                    }
                    column(Item_No_; "Item No.")
                    {

                    }
                    column(Expiration_Date; "Expiration Date")
                    {

                    }
                    column(barcodeItem; PresetBarCode.Barcode)
                    {

                    }
                    column(barcodeLot; PresetBarCodeLot.Barcode)
                    {

                    }
                    column(item_description; item.Description)
                    {

                    }
                    column(DateRec; DateRec)
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
                    trigger OnAfterGetRecord()
                    var
                        itemref: Record "Item Attribute Value Selection";
                        itemattvalmap: Record "Item Attribute Value Mapping";
                        itemAtt: Record "Item Attribute";
                        itemAttVal: Record "Item Attribute Value";
                        itemattfact: Page "Item Attributes Factbox";
                    begin
                        if item.Get("Item No.") then begin
                            DateRec := WorkDate();
                            PresetBarCode.Init();
                            PresetBarCode.Validate("Barcode Format", PresetBarCode."Barcode Format"::"Code 128");
                            PresetBarCode.Validate("Image Size", PresetBarCode."Image Size"::Auto);
                            PresetBarCode.Validate(Multiplier, 8);
                            PresetBarCode.Validate("Dot Size", 2);
                            PresetBarCode.Validate(Height, 42);
                            PresetBarCode.Validate(Width, 200);
                            PresetBarCode.Validate(Content, "Item No.");
                            if PresetBarCode.Insert(true) then;

                            PresetBarCodeLot.Init();
                            PresetBarCodeLot.Validate("Barcode Format", PresetBarCodeLot."Barcode Format"::"Code 128");
                            PresetBarCodeLot.Validate("Image Size", PresetBarCodeLot."Image Size"::Auto);
                            PresetBarCodeLot.Validate(Multiplier, 8);
                            PresetBarCodeLot.Validate("Dot Size", 2);
                            PresetBarCodeLot.Validate(Height, 42);
                            PresetBarCodeLot.Validate(Width, 200);
                            PresetBarCodeLot.Validate(Content, "Lot No.");
                            if PresetBarCodeLot.Insert(true) then;

                            itemattvalmap.Reset();
                            itemattvalmap.SetRange("Table ID", Database::Item);
                            itemattvalmap.SetRange("No.", "Item No.");
                            if itemattvalmap.FindFirst() then
                                repeat

                                    if itemAttVal.Get(itemattvalmap."Item Attribute ID", itemattvalmap."Item Attribute Value ID") then
                                        allergen := itemAttVal.Value
                                    else
                                        clear(allergen);

                                until itemattvalmap.Next() = 0;
                        end else begin
                            clear(item);
                            clear(DateRec);
                            clear(PresetBarCode);
                            clear(PresetBarCodeLot);
                        end;



                    end;


                }

            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

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
        item: Record Item;
        allergen: text;
        DateRec: Date;
        PresetBarCode: Record "IWX Sample Barcode" temporary;
        PresetBarCodeLot: Record "IWX Sample Barcode" temporary;
        LotNoLabel: Label 'Lot No.:';
        ExpirationLabel: Label 'Expiration:';
        AllergensLabel: Label 'Allergens:';
        DateReceivedLabel: Label 'Date Received:';


}


