report 50110 BarCodeTrackingReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './BarcodeTrackingReportPo.rdl';
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
                            PresetBarCode.Init;
                            PresetBarCode.Validate("Barcode Format", PresetBarCode."Barcode Format"::"Code 128");
                            PresetBarCode.Validate("Image Size", PresetBarCode."Image Size"::Auto);
                            PresetBarCode.Validate(Multiplier, 8);
                            PresetBarCode.Validate("Dot Size", 2);
                            PresetBarCode.Validate(Height, 42);
                            PresetBarCode.Validate(Width, 200);
                            PresetBarCode.Validate(Content, "Item No.");
                            if PresetBarCode.Insert(true) then;

                            PresetBarCodeLot.Init;
                            PresetBarCodeLot.Validate("Barcode Format", PresetBarCodeLot."Barcode Format"::"Code 128");
                            PresetBarCodeLot.Validate("Image Size", PresetBarCodeLot."Image Size"::Auto);
                            PresetBarCodeLot.Validate(Multiplier, 8);
                            PresetBarCodeLot.Validate("Dot Size", 2);
                            PresetBarCodeLot.Validate(Height, 42);
                            PresetBarCodeLot.Validate(Width, 200);
                            PresetBarCodeLot.Validate(Content, "Lot No.");
                            if PresetBarCodeLot.Insert(true) then;

                            itemattvalmap.Reset;
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


report 50112 BarCodeTrackingReport1
{
    DefaultLayout = RDLC;
    RDLCLayout = './BarcodeTrackingReportPo1.rdl';
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

                column(pl_ItemNo; "No.")
                {

                }
                column(item_description; Description)
                {

                }
                column(LotNoLabel1; LotNoLabel1)
                {

                }
                column(AllergensLabel1; AllergensLabel1)
                {

                }
                column(ExpirationLabel1; ExpirationLabel1)
                {

                }
                column(allergen1; allergen1)
                {

                }
                column(DateReceivedLabel1; DateReceivedLabel1)
                {

                }
                column(barcodeItem1; PresetBarCode1.Barcode)
                {

                }
                column(DateRec; WorkDate())
                {

                }
                trigger OnAfterGetRecord()
                var
                    itemref1: Record "Item Attribute Value Selection";
                    itemattvalmap1: Record "Item Attribute Value Mapping";
                    itemAtt1: Record "Item Attribute";
                    itemAttVal1: Record "Item Attribute Value";
                    itemattfact1: Page "Item Attributes Factbox";
                begin
                    if item1.Get("No.") then begin
                        DateRec := WorkDate();
                        PresetBarCode1.Init;
                        PresetBarCode1.Validate("Barcode Format", PresetBarCode1."Barcode Format"::"Code 128");
                        PresetBarCode1.Validate("Image Size", PresetBarCode1."Image Size"::Auto);
                        PresetBarCode1.Validate(Multiplier, 8);
                        PresetBarCode1.Validate("Dot Size", 2);
                        PresetBarCode1.Validate(Height, 42);
                        PresetBarCode1.Validate(Width, 200);
                        PresetBarCode1.Validate(Content, "No.");
                        if PresetBarCode1.Insert(true) then;



                        itemattvalmap1.Reset;
                        itemattvalmap1.SetRange("Table ID", Database::Item);
                        itemattvalmap1.SetRange("No.", "No.");
                        if itemattvalmap1.FindFirst() then
                            repeat

                                if itemAttVal1.Get(itemattvalmap1."Item Attribute ID", itemattvalmap1."Item Attribute Value ID") then
                                    allergen1 := itemAttVal1.Value
                                else
                                    clear(allergen1);

                            until itemattvalmap1.Next() = 0;
                    end;
                end;

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
        item1: Record Item;
        allergen1: text;
        DateRec: Date;
        PresetBarCode1: Record "IWX Sample Barcode" temporary;
        LotNoLabel1: Label 'Lot No.:';
        ExpirationLabel1: Label 'Expiration:';
        AllergensLabel1: Label 'Allergens:';
        DateReceivedLabel1: Label 'Date Received:';


}