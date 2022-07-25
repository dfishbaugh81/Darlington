codeunit 50103 LotSize
{


    trigger OnRun()
    var
        ItemRec: Record Item;
    begin

        repeat



            if ItemRec."Production BOM No." <> '' then begin
                ItemRec.Validate("MG%", ItemRec."MG%");
                ItemRec.Modify;

            end;


        until ItemRec.Next = 0;


    end;

    procedure setMlOnBom(RawItem: Record item)
    var
        prodBOMItem: Record "Production BOM Line";
    begin

        prodBOMItem.SetFilter("No.", '=%1', RawItem."No.");

        if prodBOMItem.FindSet then begin

            repeat

                prodBOMItem."ML%" := RawItem."ML%";
                prodBOMItem."lbs. After ML" := prodBOMItem."Quantity per" - (prodBOMItem."Quantity per" * (prodBOMItem."ML%" / 100));
                prodBOMItem.Modify;
                prodBOMItem.Validate("ML%", RawItem."ML%");
                prodBOMItem.Validate("lbs. After ML", prodBOMItem."lbs. After ML");
                calculateLotSize(prodBOMItem);
            until prodBOMItem.Next = 0;





        end;

    end;


    /*

    //calculate batch weight
    procedure CalculateBatchWeight(var sumLbsAfterML: Decimal; finishedGoodMG: Record Item): Decimal
    var
        BatchWeight_Z: Decimal;
    begin


        BatchWeight_Z := sumLbsAfterML + (sumLbsAfterML * finishedGoodMG."MG%");
        exit(BatchWeight_Z);



    end;

    //calculate yield
    local procedure CalculateYield(var BatchWeight_z: Decimal; finishedGoodW: Record Item)
    var
        yield: Decimal;
    begin

        yield := BatchWeight_z / finishedGoodW.MLWeight;
    end;
    */


    procedure calculateLotSize(prodBomRecord: Record "Production BOM Line")
    var

        batchWeight: decimal;
        TotalSumLbsAfterML: Decimal;
        FinishedGood: record Item;
        itemunitOfMeassure: Record "Item Unit of Measure";

        Yield: Decimal;

    begin

        prodBomRecord.SetFilter("Production BOM No.", '=%1', prodBomRecord."Production BOM No.");


        if prodBomRecord.FindSet then begin

            TotalSumLbsAfterML := 0;

            repeat

                TotalSumLbsAfterML := prodBomRecord."lbs. After ML" + TotalSumLbsAfterML;

            until prodBomRecord.Next = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', prodBomRecord."Production BOM No.");

            if FinishedGood.FindSet then begin

                repeat

                    FinishedGood.MLWeight := TotalSumLbsAfterML;
                    FinishedGood.Modify;

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."MG%" / 100));

                    itemunitOfMeassure.SetFilter(Code, '=%1', FinishedGood."Purch. Unit of Measure");

                    if itemunitOfMeassure.FindSet then begin

                        itemunitOfMeassure.SetFilter("Item No.", '=%1', FinishedGood."No.");

                        if itemunitOfMeassure.FindSet then begin

                            if itemunitOfMeassure.Weight <> 0 then begin
                                Yield := batchWeight / itemunitOfMeassure.Weight;
                            end;

                            FinishedGood."Lot Size" := Yield - ((FinishedGood."PS%" / 100) * Yield);

                            FinishedGood.Modify;
                        end;

                    end;

                until FinishedGood.next = 0;
            end;

        end;
    end;


}