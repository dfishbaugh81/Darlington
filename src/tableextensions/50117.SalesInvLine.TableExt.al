tableextension 50117 "SalesInvLine" extends "Sales Invoice Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {

        }
    }
    trigger OnAfterInsert()
    var
        itemUnitOfMea: Record "Item Unit of Measure";
    begin
        if itemUnitOfMea.Get("No.", "Unit of Measure Code") then
            UnitOfMeaWeight := itemUnitOfMea.Weight * Quantity;
    end;
}