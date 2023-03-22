tableextension 50115 "DRL Sales Line" extends "Sales Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'UoM Weight';
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
                if ItemUnitOfMeasure.Get("No.", "Unit of Measure Code") then
                    UnitOfMeaWeight := ItemUnitOfMeasure.Weight * Quantity;
            end;
        }
    }
}