tableextension 50211 "DRL Item" extends Item
{
    fields
    {
        field(50201; "DRL Planned Scrap"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Scrap %';

            trigger OnValidate()
            var


            begin

                DRLCalculateLotSize();

            end;

        }

        field(50202; "DRL Moisture Gain"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Gain %';

            trigger OnValidate()
            var

            begin

                DRLCalculateLotSize();



            end;
        }

        field(50203; "DRL Moisture Loss"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Loss %';


            trigger OnValidate()
            var
                lotSize: Codeunit "DRL LotSize";
            begin

                lotSize.setMlOnBom(Rec);

            end;


        }

        field(50204; "DRL ML Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Weight After ML';


        }
    }
    local procedure calculateBatchWeight(): Decimal
    var
        BatchWeight_Z: Decimal;
    begin


        BatchWeight_Z := rec."DRL ML Weight" + (rec."DRL ML Weight" * (rec."DRL Moisture Gain" / 100));
        exit(BatchWeight_Z);

    end;

    local procedure calculateYield(): Decimal
    var

        ItemUnitOfMeasureWeight: Record "Item Unit of Measure";

        Yield: Decimal;
    begin
        if ItemUnitOfMeasureWeight.Get(Rec."No.", Rec."Purch. Unit of Measure") then begin

            Yield := calculateBatchWeight() / ItemUnitOfMeasureWeight.Weight;
            exit(Yield);

        end;

    end;





    procedure DRLCalculateLotSize()
    var
    begin

        rec."Lot Size" := calculateYield() - ((rec."DRL Planned Scrap" / 100) * calculateYield());
        rec.Modify();

    end;
}
