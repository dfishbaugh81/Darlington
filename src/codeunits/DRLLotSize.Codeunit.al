codeunit 50103 "DRL Lot Size"
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
        prodBOMItem: Record "Production BOM Line";
    begin

        prodBOMItem.SetFilter("No.", '=%1', RawItem."No.");

        if prodBOMItem.FindSet() then
            repeat
                prodBOMItem."DRL Moisture Loss" := RawItem."DRL Moisture Loss";
                prodBOMItem."lbs. After ML" := prodBOMItem."Quantity per" - (prodBOMItem."Quantity per" * (prodBOMItem."DRL Moisture Loss" / 100));
                prodBOMItem.Modify();
                prodBOMItem.Validate("DRL Moisture Loss", RawItem."DRL Moisture Loss");
                prodBOMItem.Validate("lbs. After ML", prodBOMItem."lbs. After ML");
                calculateLotSize(prodBOMItem);
            until prodBOMItem.Next() = 0;






    end;


    /*

    //calculate batch weight
    procedure CalculateBatchWeight(var sumLbsAfterML: Decimal; finishedGoodMG: Record Item): Decimal
    var
        BatchWeight_Z: Decimal;
    begin


        BatchWeight_Z := sumLbsAfterML + (sumLbsAfterML * finishedGoodMG."DRL Moisture Gain");
        exit(BatchWeight_Z);



    end;

    //calculate yield
    local procedure CalculateYield(var BatchWeight_z: Decimal; finishedGoodW: Record Item)
    var
        yield: Decimal;
    begin

        yield := BatchWeight_z / finishedGoodW."DRL Weight After ML";
    end;
    */


    procedure calculateLotSize(productionBOMLine: Record "Production BOM Line")
    var
        FinishedGood: record Item;
        itemunitOfMeassure: Record "Item Unit of Measure";
        batchWeight: decimal;
        TotalSumLbsAfterML: Decimal;


        Yield: Decimal;

    begin

        productionBOMLine.SetFilter("Production BOM No.", '=%1', productionBOMLine."Production BOM No.");

        TotalSumLbsAfterML := 0;

        if productionBOMLine.FindSet() then begin


            repeat

                TotalSumLbsAfterML := productionBOMLine."lbs. After ML" + TotalSumLbsAfterML;

            until productionBOMLine.Next() = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', productionBOMLine."Production BOM No.");

            if FinishedGood.FindSet() then
                repeat

                    FinishedGood."DRL Weight After ML" := TotalSumLbsAfterML;
                    FinishedGood.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."DRL Moisture Gain" / 100));


                    if itemunitOfMeassure.Get(FinishedGood."No.", FinishedGood."Purch. Unit of Measure") then begin

                        if itemunitOfMeassure.Weight <> 0 then
                            Yield := batchWeight / itemunitOfMeassure.Weight;

                        FinishedGood."Lot Size" := Yield - ((FinishedGood."DRL Planned Scrap" / 100) * Yield);

                        FinishedGood.Modify();
                    end;


                until FinishedGood.Next() = 0;

        end;
    end;


}