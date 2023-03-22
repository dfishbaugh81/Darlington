pageextension 50103 "DRL Item Card" extends "Item Card"
{
    layout
    {

        modify("Production BOM No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                lockFields();
                GetMLWeightFromBOM();

            end;
        }
        // Add changes to page layout here
        addafter("Overhead Rate")
        {


            field("DRL Moisture Loss"; rec."DRL Moisture Loss")
            {
                ApplicationArea = All;
                Editable = isVisible_ML;



            }


            field("DRL Moisture Gain"; rec."DRL Moisture Gain")
            {
                ApplicationArea = All;

                Editable = isVisible;


            }

            field("DRL Planned Scrap"; rec."DRL Planned Scrap")
            {
                ApplicationArea = All;

                Editable = isVisible;



            }

            field("DRL Weight After ML"; rec."DRL Weight After ML")
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
        [InDataSet]
        isVisible: Boolean;

        [InDataSet]
        isVisible_ML: Boolean;


    trigger OnOpenPage()
    var

    begin

        lockFields();

    end;



    local procedure lockFields(): Boolean
    var

    begin

        if rec."Production BOM No." <> '' then begin
            isVisible := true;
            isVisible_ML := false;
            exit(isVisible);
            exit(isVisible_ML);
        end

        else
            if rec."Production BOM No." = '' then begin

                isVisible := false;
                isVisible_ML := true;
                exit(isVisible);
                exit(isVisible_ML);
            end;

    end;

    //calculates the weight from the BOM when BOm in attached to item.
    local procedure GetMLWeightFromBOM()
    var
        ProdBOM: Record "Production BOM Line";
        sumLbsAfterML: Decimal;
    begin

        if rec."Production BOM No." <> '' then begin


            ProdBOM.SetFilter("Production BOM No.", '=%1', rec."Production BOM No.");

            if ProdBOM.FindSet then begin

                repeat

                    sumLbsAfterML := ProdBOM."lbs. After ML" + sumLbsAfterML;

                until ProdBOM.Next() = 0;

                rec."DRL Weight After ML" := sumLbsAfterML;
                rec.Modify();
            end;


        end;

    end;

}