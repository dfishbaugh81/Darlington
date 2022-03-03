tableextension 50103 ItemEx extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50101; "PS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Scrap %';

            trigger OnValidate()
            var


            begin

                CalculateLotSize();

            end;

        }

        field(50102; "MG%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Gain %';

            trigger OnValidate()
            var

            begin

                CalculateLotSize();



            end;
        }

        field(50103; "ML%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Moisture Loss %';


            trigger OnValidate()
            var
                lotSize: Codeunit LotSize;
            begin

                lotSize.setMlOnBom(Rec);

            end;


        }

        field(50104; MLWeight; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Weight After ML';


        }
    }

    var
        myInt: Integer;



    local procedure calculateBatchWeight(): Decimal
    var
        BatchWeight_Z: Decimal;
    begin


        BatchWeight_Z := rec.MLWeight + (rec.MLWeight * (rec."MG%" / 100));
        exit(BatchWeight_Z);

    end;

    local procedure calculateYield(): Decimal
    var
        Yield: Decimal;
        UnitOfMeassureWeight: Record "Item Unit of Measure";

        finishedGood: Record item;
    begin


        UnitOfMeassureWeight.SetFilter("Item No.", '=%1', rec."No.");


        if UnitOfMeassureWeight.FindSet then begin

            UnitOfMeassureWeight.SetFilter(Code, '=%1', rec."Purch. Unit of Measure");

            if UnitOfMeassureWeight.FindSet then begin

                Yield := calculateBatchWeight() / UnitOfMeassureWeight.Weight;
                exit(Yield);

            end;

        end;

    end;





    procedure CalculateLotSize()
    var
    begin

        rec."Lot Size" := calculateYield() + ((rec."PS%" / 100) * calculateYield());
        rec.Modify;

    end;



}