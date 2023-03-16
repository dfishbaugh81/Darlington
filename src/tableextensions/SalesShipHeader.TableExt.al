tableextension 50119 "SalesShipHeader" extends "Sales Shipment Header"
{
    fields
    {
        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".Quantity WHERE("Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Shipment Line".UnitOfMeaWeight WHERE("Document No." = field("No.")));
        }
    }
}