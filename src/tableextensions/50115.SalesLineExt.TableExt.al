tableextension 50115 "SalesLineExt" extends "Sales Line"
{
    fields
    {
        field(50110; UnitOfMeaWeight; Decimal)
        {

        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                itemUnitOfMea: Record "Item Unit of Measure";
            begin
                if itemUnitOfMea.Get("No.", "Unit of Measure Code") then
                    UnitOfMeaWeight := itemUnitOfMea.Weight * Quantity;
            end;
        }
    }
}