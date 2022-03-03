pageextension 50102 ProductionBOMLineEx extends "Production BOM Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {

            field("ML%"; rec."ML%")
            {
                ApplicationArea = All;
                Editable = false;


            }

            field("lbs. After ML"; rec."lbs. After ML")
            {
                ApplicationArea = All;
                Editable = false;

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