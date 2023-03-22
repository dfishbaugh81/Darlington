tableextension 50117 "DRL Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'UoM Weight';
        }
    }
    trigger OnAfterInsert()
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        if ItemUnitOfMeasure.Get("No.", "Unit of Measure Code") then
            UnitOfMeaWeight := ItemUnitOfMeasure.Weight * Quantity;
    end;
}