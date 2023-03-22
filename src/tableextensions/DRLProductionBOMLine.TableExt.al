tableextension 50102 "DRL Production BOM Line" extends "Production BOM Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "DRL Moisture Loss"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ML%';


            trigger OnValidate()
            begin

                SumLbsAfterML();

            end;

        }

        field(50101; "lbs. After ML"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lbs. After ML';

            trigger OnValidate()
            begin

                SumLbsAfterML();

            end;
        }
    }








    local procedure SumLbsAfterML()
    var
        sumLbsAfterML: Decimal;
        finishedGood: Record Item;

        prodBomLines: Record "Production BOM Line";
    begin


        prodBomLines.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

        if prodBomLines.FindSet then begin

            sumLbsAfterML := 0;

            repeat

                sumLbsAfterML := prodBomLines."lbs. After ML" + sumLbsAfterML;

            until prodBomLines.Next() = 0;

            //issues: when app runs it iterates through the whole BOM table.

            finishedGood.SetFilter("Production BOM No.", '=%1', prodBomLines."Production BOM No.");

            if finishedGood.FindSet then begin

                repeat

                    finishedGood."DRL Weight After ML" := sumLbsAfterML;

                    finishedGood.Modify();

                until finishedGood.Next() = 0;
            end;

        end;

    end;




    trigger OnModify()
    var
        lotSize: Codeunit "DRL Lot Size";
        ItemRec: Record item;

    begin

        ItemRec.SetFilter("No.", '=%1', rec."No.");

        if ItemRec.FindSet then begin

            if ItemRec."Item Category Code" = 'PRE-BATCH' then begin

                if rec.Type = type::"Production BOM" then begin

                    rec."lbs. After ML" := 0;

                end
                else
                    rec."lbs. After ML" := ItemRec."DRL Weight After ML";
                rec.Modify();

            end

            else begin

                rec."DRL Moisture Loss" := ItemRec."DRL Moisture Loss";
                rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."DRL Moisture Loss" / 100));

                rec.Modify();

                //SumLbsAfterML();
                calculateLotSize();

            end;

        end;

        //rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."DRL Moisture Loss" / 100));

        //rec.Modify();

        SumLbsAfterML();
        calculateLotSize();

    end;


    trigger OnAfterInsert()
    var
        ItemRec: Record item;
    begin

        if rec.Type = Type::"Production BOM" then begin

            rec."lbs. After ML" := 0;
            rec.Modify();
        end
        else begin


            ItemRec.SetFilter("No.", '=%1', rec."No.");

            if ItemRec.FindSet then begin

                if ItemRec."Item Category Code" = 'PRE-BATCH' then begin

                    rec."lbs. After ML" := ItemRec."DRL Weight After ML";
                    //rec.Modify();

                end

                else begin

                    rec."DRL Moisture Loss" := ItemRec."DRL Moisture Loss";
                    rec.Modify();

                end;

            end;

            rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."DRL Moisture Loss" / 100));

            rec.Modify();

            //SumLbsAfterML();
            calculateLotSize();

        end;



    end;


    trigger OnAfterDelete()
    begin
        OnDeleteBomLine();
    end;


    local procedure calculateLotSize()
    var

        batchWeight: decimal;
        TotalSumLbsAfterML: Decimal;
        FinishedGood: record Item;
        itemunitOfMeassure: Record "Item Unit of Measure";

        Yield: Decimal;

    begin

        rec.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");


        if rec.FindSet then begin

            TotalSumLbsAfterML := 0;

            repeat

                TotalSumLbsAfterML := rec."lbs. After ML" + TotalSumLbsAfterML;

            until rec.Next() = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

            if FinishedGood.FindSet then begin

                repeat

                    FinishedGood."DRL Weight After ML" := TotalSumLbsAfterML;
                    FinishedGood.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."DRL Moisture Gain" / 100));

                    itemunitOfMeassure.SetFilter(Code, '=%1', FinishedGood."Purch. Unit of Measure");

                    if itemunitOfMeassure.FindSet then begin

                        itemunitOfMeassure.SetFilter("Item No.", '=%1', FinishedGood."No.");

                        if itemunitOfMeassure.FindSet then begin

                            //Y =Z/W
                            Yield := batchWeight / itemunitOfMeassure.Weight;
                            //F = Y-(S*Y)
                            FinishedGood."Lot Size" := Yield - ((FinishedGood."DRL Planned Scrap" / 100) * Yield);

                            FinishedGood.Modify();
                        end;

                    end;

                until FinishedGood.Next() = 0;
            end;

        end;
    end;


    local procedure OnDeleteBomLine()
    var
        ProdBomLine: Record "Production BOM Line";
        TotalSumLbsAfterML: Decimal;
        FinishedGood: record Item;
        itemunitOfMeassure: Record "Item Unit of Measure";
        batchWeight: decimal;
        Yield: Decimal;

    begin

        ProdBomLine.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

        if ProdBomLine.FindSet then begin


            repeat

                TotalSumLbsAfterML := ProdBomLine."lbs. After ML" + TotalSumLbsAfterML;

            until ProdBomLine.Next() = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

            if FinishedGood.FindSet then begin

                repeat

                    FinishedGood."DRL Weight After ML" := TotalSumLbsAfterML;
                    FinishedGood.Modify();

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."DRL Moisture Gain" / 100));

                    itemunitOfMeassure.SetFilter(Code, '=%1', FinishedGood."Purch. Unit of Measure");

                    if itemunitOfMeassure.FindSet then begin

                        itemunitOfMeassure.SetFilter("Item No.", '=%1', FinishedGood."No.");

                        if itemunitOfMeassure.FindSet then begin


                            Yield := batchWeight / itemunitOfMeassure.Weight;
                            FinishedGood."Lot Size" := Yield - ((FinishedGood."DRL Planned Scrap" / 100) * Yield);

                            FinishedGood.Modify();
                        end;

                    end;

                until FinishedGood.Next() = 0;
            end;


        end;

    end;
}
