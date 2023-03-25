tableextension 50210 "DRL Production BOM Line" extends "Production BOM Line"
{
    fields
    {
        field(50200; "DRL Moisture Loss"; Decimal)
        {
            Caption = 'ML %';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DRLSumLbsAfterML();
            end;

        }

        field(50201; "DRL Lbs. After ML"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lbs. After ML';

            trigger OnValidate()
            begin
                DRLSumLbsAfterML();
            end;
        }
    }

    local procedure DRLSumLbsAfterML()
    var
        FGItem: Record Item;
        ProductionBOMLine: Record "Production BOM Line";
        sumLbsAfterML: Decimal;
    begin
        sumLbsAfterML := 0;
        ProductionBOMLine.SetRange("Production BOM No.", rec."Production BOM No.");
        if ProductionBOMLine.FindSet() then
            repeat
                sumLbsAfterML := ProductionBOMLine."DRL Lbs. After ML" + sumLbsAfterML;
            until ProductionBOMLine.Next() = 0;

        //issues: when app runs it iterates through the whole BOM table.

        FGItem.SetRange("Production BOM No.", ProductionBOMLine."Production BOM No.");

        if FGItem.FindSet() then
            repeat
                FGItem."DRL ML Weight" := sumLbsAfterML;
                FGItem.Modify();

            until FGItem.Next() = 0;


    end;




    trigger OnModify()
    var
        ItemRec: Record item;
    begin
        if ItemRec.Get("No.") then
            if ItemRec."Item Category Code" = 'PRE-BATCH' then begin

                if rec.Type = type::"Production BOM" then
                    rec."DRL Lbs. After ML" := 0
                else
                    rec."DRL Lbs. After ML" := ItemRec."DRL ML Weight";
                rec.Modify();
            end
            else begin
                rec."DRL Moisture Loss" := ItemRec."DRL Moisture Loss";
                rec."DRL Lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."DRL Moisture Loss" / 100));

                rec.Modify();
                DRLCalculateLotSize();
            end;

        DRLSumLbsAfterML();
        DRLCalculateLotSize();

    end;


    trigger OnAfterInsert()
    var
        ItemRec: Record item;
    begin

        if rec.Type = Type::"Production BOM" then begin

            rec."DRL Lbs. After ML" := 0;
            rec.Modify();
        end
        else begin

            if ItemRec.Get(Rec."No.") then
                if ItemRec."Item Category Code" = 'PRE-BATCH' then
                    rec."DRL Lbs. After ML" := ItemRec."DRL ML Weight"
                else
                    rec."DRL Moisture Loss" := ItemRec."DRL Moisture Loss";


            rec."DRL Lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."DRL Moisture Loss" / 100));

            rec.Modify();
            DRLCalculateLotSize();
        end;



    end;

    trigger OnAfterDelete()
    begin
        OnDeleteBomLine();
    end;

    local procedure DRLCalculateLotSize()
    var
        FGItem: record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        batchWeight: decimal;
        TotalSumLbsAfterML: Decimal;
        Yield: Decimal;
    begin

        rec.SetRange("Production BOM No.", rec."Production BOM No.");


        if rec.FindSet() then begin

            TotalSumLbsAfterML := 0;

            repeat

                TotalSumLbsAfterML := rec."DRL Lbs. After ML" + TotalSumLbsAfterML;

            until rec.Next() = 0;

            FGItem.SetRange("Production BOM No.", rec."Production BOM No.");

            if FGItem.FindSet() then
                repeat

                    FGItem."DRL ML Weight" := TotalSumLbsAfterML;
                    FGItem.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FGItem."DRL Moisture Gain" / 100));


                    if ItemUnitOfMeasure.Get(FGItem."No.", FGItem."Purch. Unit of Measure") then begin

                        //Y =Z/W
                        Yield := batchWeight / ItemUnitOfMeasure.Weight;
                        //F = Y-(S*Y)
                        FGItem."Lot Size" := Yield - ((FGItem."DRL Planned Scrap" / 100) * Yield);

                        FGItem.Modify();
                    end;


                until FGItem.Next() = 0;

        end;
    end;


    local procedure OnDeleteBomLine()
    var
        ProductionBOMLine: Record "Production BOM Line";
        FGItem: record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        batchWeight: decimal;
        Yield: Decimal;
        TotalSumLbsAfterML: Decimal;

    begin

        ProductionBOMLine.SetRange("Production BOM No.", rec."Production BOM No.");

        if ProductionBOMLine.FindSet() then begin
            repeat
                TotalSumLbsAfterML := ProductionBOMLine."DRL Lbs. After ML" + TotalSumLbsAfterML;
            until ProductionBOMLine.Next() = 0;

            FGItem.SetRange("Production BOM No.", rec."Production BOM No.");

            if FGItem.FindSet() then
                repeat

                    FGItem."DRL ML Weight" := TotalSumLbsAfterML;
                    FGItem.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FGItem."DRL Moisture Gain" / 100));
                    if ItemUnitOfMeasure.Get(FGItem."No.", FGItem."Purch. Unit of Measure") then begin
                        Yield := batchWeight / ItemUnitOfMeasure.Weight;
                        FGItem."Lot Size" := Yield - ((FGItem."DRL Planned Scrap" / 100) * Yield);
                        FGItem.Modify();
                    end;

                until FGItem.Next() = 0;


        end;

    end;
}
