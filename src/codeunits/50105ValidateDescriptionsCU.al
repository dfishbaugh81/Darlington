codeunit 50105 ValidateDescriptionCU
{
    trigger OnRun()
    begin
        ValidateDescription();

    end;

    var
        myInt: Integer;


    local procedure ValidateDescription()
    var
        ProdBomLine: Record "Production BOM Line";
        itemDescription: Record Item;
    begin
        ProdBomLine.SetFilter(Description, '=%1', '');
        if ProdBomLine.FindSet then begin


            repeat

                itemDescription.SetFilter("No.", '=%1', ProdBomLine."No.");

                if itemDescription.FindSet then begin


                    ProdBomLine.Description := itemDescription.Description;
                    ProdBomLine.Modify;
                end;



            until ProdBomLine.Next = 0;
        end;

    end;




}