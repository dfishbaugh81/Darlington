pageextension 50102 "DRL Production BOM Lines" extends "Production BOM Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {

            field("DRL Moisture Loss"; rec."DRL Moisture Loss")
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