codeunit 50100 LotSizeCalculation
{
    trigger OnRun()
    begin

    end;



    local procedure CalculateBatchWeight(var finishedGood: Record Item): Decimal
    var
        unitOfMeassure: Record "Unit of Measure";
        BatchWeight: Decimal;

        SumLbsAfterML: Decimal;

        productionBOM: Record "Production BOM Line";

    begin

        productionBOM.SetFilter("Production BOM No.", '=%1', finishedGood."Production BOM No.");

        if productionBOM.FindSet then begin

            SumLbsAfterML := 0;

            repeat

                SumLbsAfterML := productionBOM."lbs. After ML" + SumLbsAfterML;


            until productionBOM.Next = 0;

            BatchWeight := SumLbsAfterML + (SumLbsAfterML * (finishedGood."MG%" / 100));

            exit(BatchWeight);


        end;


    end;


    local procedure CalculateYield(Var finishedGood: Record Item): Decimal
    var
        itemUnitOfMeassure: Record "Item Unit of Measure";
        Yield: Decimal;

    begin

        itemUnitOfMeassure.SetFilter("Item No.", '=%1', finishedGood."No.");

        if itemUnitOfMeassure.FindSet then begin

            itemUnitOfMeassure.SetFilter(Code, '=%1', finishedGood."Purch. Unit of Measure");

            if itemUnitOfMeassure.FindSet then begin


                Yield := CalculateBatchWeight(finishedGood) / itemUnitOfMeassure.Weight;

                exit(Yield);

            end;

        end;

    end;


    procedure CalculateLotSize(var finishedGood: Record Item)
    var
        myInt: Integer;
    begin

        finishedGood."Lot Size" := CalculateYield(finishedGood) + ((finishedGood."PS%" / 100) * CalculateYield(finishedGood));

    end;

}