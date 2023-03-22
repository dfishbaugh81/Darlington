codeunit 50105 "DRL Validate Description"
{
    trigger OnRun()
    begin
        ValidateDescription();

    end;


    local procedure ValidateDescription()
    var
        ProductionBOMLine: Record "Production BOM Line";
        itemDescription: Record Item;
    begin
        ProductionBOMLine.SetRange(Description, '');
        if ProductionBOMLine.FindSet() then
            repeat

                if itemDescription.Get(ProductionBOMLine."No.") then begin
                    ProductionBOMLine.Description := itemDescription.Description;
                    ProductionBOMLine.Modify();
                end;



            until ProductionBOMLine.Next() = 0;


    end;




}