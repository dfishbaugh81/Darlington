tableextension 50102 ProductionBOMLineEx extends "Production BOM Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "ML%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'ML%';


            trigger OnValidate()
            var
                myInt: Integer;
            begin

                SumLbsAfterML();

            end;

        }

        field(50101; "lbs. After ML"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lbs. After ML';

            trigger OnValidate()
            var
                myInt: Integer;
            begin

                SumLbsAfterML();

            end;
        }
    }

    var
        myInt: Integer;







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

            until prodBomLines.Next = 0;

            //issues: when app runs it iterates through the whole BOM table.

            finishedGood.SetFilter("Production BOM No.", '=%1', prodBomLines."Production BOM No.");

            if finishedGood.FindSet then begin

                repeat

                    finishedGood.MLWeight := sumLbsAfterML;

                    finishedGood.Modify;

                until finishedGood.Next = 0;
            end;

        end;

    end;




    trigger OnModify()
    var
        lotSize: Codeunit LotSize;
        ItemRec: Record item;

    begin

        ItemRec.SetFilter("No.", '=%1', rec."No.");

        if ItemRec.FindSet then begin

            if ItemRec."Item Category Code" = 'PRE-BATCH' then begin

                if rec.Type = type::"Production BOM" then begin

                    rec."lbs. After ML" := 0;

                end
                else
                    rec."lbs. After ML" := ItemRec.MLWeight;
                rec.Modify;

            end

            else begin

                rec."ML%" := ItemRec."ML%";
                rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."ML%" / 100));

                rec.Modify;

                //SumLbsAfterML();
                calculateLotSize();

            end;

        end;

        //rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."ML%" / 100));

        //rec.Modify;

        SumLbsAfterML();
        calculateLotSize();

    end;


    trigger OnAfterInsert()
    var
        ItemRec: Record item;
    begin

        if rec.Type = Type::"Production BOM" then begin

            rec."lbs. After ML" := 0;
            rec.Modify;
        end
        else begin


            ItemRec.SetFilter("No.", '=%1', rec."No.");

            if ItemRec.FindSet then begin

                if ItemRec."Item Category Code" = 'PRE-BATCH' then begin

                    rec."lbs. After ML" := ItemRec.MLWeight;
                    //rec.Modify;

                end

                else begin

                    rec."ML%" := ItemRec."ML%";
                    rec.Modify;

                end;

            end;

            rec."lbs. After ML" := rec."Quantity per" - (rec."Quantity per" * (rec."ML%" / 100));

            rec.Modify;

            //SumLbsAfterML();
            calculateLotSize();

        end;



    end;


    trigger OnAfterDelete()
    var
        myInt: Integer;
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

            until rec.Next = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

            if FinishedGood.FindSet then begin

                repeat

                    FinishedGood.MLWeight := TotalSumLbsAfterML;
                    FinishedGood.Modify;

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."MG%" / 100));

                    itemunitOfMeassure.SetFilter(Code, '=%1', FinishedGood."Purch. Unit of Measure");

                    if itemunitOfMeassure.FindSet then begin

                        itemunitOfMeassure.SetFilter("Item No.", '=%1', FinishedGood."No.");

                        if itemunitOfMeassure.FindSet then begin

                            //Y =Z/W
                            Yield := batchWeight / itemunitOfMeassure.Weight;
                            //F = Y-(S*Y)
                            FinishedGood."Lot Size" := Yield - ((FinishedGood."PS%" / 100) * Yield);

                            FinishedGood.Modify;
                        end;

                    end;

                until FinishedGood.next = 0;
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

            until ProdBomLine.Next = 0;

            FinishedGood.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

            if FinishedGood.FindSet then begin

                repeat

                    FinishedGood.MLWeight := TotalSumLbsAfterML;
                    FinishedGood.Modify;

                    batchWeight := TotalSumLbsAfterML + (TotalSumLbsAfterML * (FinishedGood."MG%" / 100));

                    itemunitOfMeassure.SetFilter(Code, '=%1', FinishedGood."Purch. Unit of Measure");

                    if itemunitOfMeassure.FindSet then begin

                        itemunitOfMeassure.SetFilter("Item No.", '=%1', FinishedGood."No.");

                        if itemunitOfMeassure.FindSet then begin


                            Yield := batchWeight / itemunitOfMeassure.Weight;
                            FinishedGood."Lot Size" := Yield - ((FinishedGood."PS%" / 100) * Yield);

                            FinishedGood.Modify;
                        end;

                    end;

                until FinishedGood.next = 0;
            end;


        end;

    end;


}