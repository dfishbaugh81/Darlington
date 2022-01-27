pageextension 50101 ItemCardEx extends "Item Card"
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


            end;
        }
        // Add changes to page layout here
        addafter("Overhead Rate")
        {
            field("MG%"; rec."MG%")
            {
                ApplicationArea = All;

                //Visible = isVisible;
                Editable = isVisible;

                trigger OnValidate()
                var

                    lotSizeCalc: Codeunit LotSizeCalculation;

                begin

                    if rec."MG%" <> 0 then begin
                        lotSizeCalc.CalculateLotSize(Rec);

                    end
                    else
                        rec."Lot Size" := 0;



                end;


            }

            field("PS%"; rec."PS%")
            {
                ApplicationArea = All;
                //Visible = isVisible;
                Editable = isVisible;

                trigger OnValidate()
                var

                    lotSizeCalc: Codeunit LotSizeCalculation;

                begin

                    if rec."PS%" <> 0 then begin
                        lotSizeCalc.CalculateLotSize(Rec);
                    end

                    else
                        rec."Lot Size" := 0;

                end;

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


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        lockFields();

    end;



    local procedure lockFields(): Boolean
    var
        myInt: Integer;
    begin

        if rec."Production BOM No." <> '' then begin
            isVisible := true;
            exit(isVisible);
        end

        else
            if rec."Production BOM No." = '' then begin

                isVisible := false;
                exit(isVisible);
            end;


    end;

}