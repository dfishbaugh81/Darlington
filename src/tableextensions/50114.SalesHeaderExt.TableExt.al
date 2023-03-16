tableextension 50114 "SalesHeaderExt" extends "Sales Header"
{
    fields
    {
        field(50112; BakeWeek; Integer)
        {

        }

        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".UnitOfMeaWeight WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }
}