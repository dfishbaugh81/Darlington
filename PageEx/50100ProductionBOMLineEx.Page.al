pageextension 50100 ProductionBOMLineEx extends "Production BOM Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {

            field("ML%"; rec."ML%")
            {
                ApplicationArea = All;

            }

            field("lbs. After ML"; rec."lbs. After ML")
            {
                ApplicationArea = All;

            }


        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}