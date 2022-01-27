tableextension 50100 ProductionBOMLineEx extends "Production BOM Line"
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

                "lbs. After ML" := "Quantity per" - ("Quantity per" * ("ML%" / 100));

            end;
        }

        field(50101; "lbs. After ML"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lbs. After ML';
        }
    }

    var
        myInt: Integer;
}