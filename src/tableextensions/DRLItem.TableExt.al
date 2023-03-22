tableextension 50104 "DRL Item" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50101; "DRL Planned Scrap"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Scrap %';

            trigger OnValidate()
            var
            begin
                CalculateLotSize();
            end;

        }

        field(50102; "DRL Moisture Gain"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Gain %';

            trigger OnValidate()
            var

            begin

                CalculateLotSize();
            end;
        }

        field(50103; "DRL Moisture Loss"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Loss %';


            trigger OnValidate()
            var
                lotSize: Codeunit "DRL Lot Size";
            begin

                lotSize.setMlOnBom(Rec);

            end;


        }

        field(50104; "DRL Weight After ML"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Weight After ML';


        }
    }




    local procedure calculateBatchWeight(): Decimal
    var
        BatchWeight_Z: Decimal;
    begin


        BatchWeight_Z := rec."DRL Weight After ML" + (rec."DRL Weight After ML" * (rec."DRL Moisture Gain" / 100));
        exit(BatchWeight_Z);

    end;

    local procedure calculateYield(): Decimal
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        Yield: Decimal;
    begin


        ItemUnitOfMeasure.SetFilter("Item No.", '=%1', rec."No.");


        if ItemUnitOfMeasure.Get(Rec."No.", Rec."Purch. Unit of Measure") then begin

            Yield := calculateBatchWeight() / ItemUnitOfMeasure.Weight;
            exit(Yield);
        end;
        exit(0);
    end;





    procedure CalculateLotSize()
    var
    begin

        rec."Lot Size" := calculateYield() - ((rec."DRL Planned Scrap" / 100) * calculateYield());
    end;
}
