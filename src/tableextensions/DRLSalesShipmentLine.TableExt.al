tableextension 50116 "DRL Sales Shipment Line" extends "Sales Shipment Line"
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