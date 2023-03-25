codeunit 50202 "DRL LotSize"
{


    trigger OnRun()
    var
        ItemRec: Record Item;
    begin

        repeat



            if ItemRec."Production BOM No." <> '' then begin
                ItemRec.Validate("DRL Moisture Gain", ItemRec."DRL Moisture Gain");
                ItemRec.Modify();

            end;


        until ItemRec.Next() = 0;


    end;

    procedure setMlOnBom(RawItem: Record item)
    var
        ProductionBOMLine: Record "Production BOM Line";
    begin

        ProductionBOMLine.SetRange("No.", RawItem."No.");

        if ProductionBOMLine.FindSet() then
            repeat
                ProductionBOMLine."DRL Moisture Loss" := RawItem."DRL Moisture Loss";
                ProductionBOMLine."DRL Lbs. After ML" := ProductionBOMLine."Quantity per" - (ProductionBOMLine."Quantity per" * (ProductionBOMLine."DRL Moisture Loss" / 100));
                ProductionBOMLine.Modify();
                ProductionBOMLine.Validate("DRL Moisture Loss", RawItem."DRL Moisture Loss");
                ProductionBOMLine.Validate("DRL Lbs. After ML", ProductionBOMLine."DRL Lbs. After ML");
                calculateLotSize(ProductionBOMLine);
            until ProductionBOMLine.Next() = 0;
    end;


    procedure calculateLotSize(pProductionBOMLine: Record "Production BOM Line")
    var
        FGItem: record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        batchWeight: decimal;
        TotalSumLbsAfterML: Decimal;
        Yield: Decimal;
    begin

        pProductionBOMLine.SetRange("Production BOM No.", pProductionBOMLine."Production BOM No.");


        if pProductionBOMLine.FindSet() then begin

            TotalSumLbsAfterML := 0;

            repeat

                TotalSumLbsAfterML := pProductionBOMLine."DRL Lbs. After ML" + TotalSumLbsAfterML;

            until pProductionBOMLine.Next() = 0;

            FGItem.SetRange("Production BOM No.", pProductionBOMLine."Production BOM No.");

            if FGItem.FindSet() then
                repeat

                    FGItem."DRL ML Weight" := TotalSumLbsAfterML;
                    FGItem.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FGItem."DRL Moisture Gain" / 100));


                    if ItemUnitOfMeasure.Get(FGItem."No.", FGItem."Purch. Unit of Measure") then begin

                        if ItemUnitOfMeasure.Weight <> 0 then
                            Yield := batchWeight / ItemUnitOfMeasure.Weight;

                        FGItem."Lot Size" := Yield - ((FGItem."DRL Planned Scrap" / 100) * Yield);

                        FGItem.Modify();
                    end;

                until FGItem.Next() = 0;

        end;
    end;


}