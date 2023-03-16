tableextension 50118 "SalesInvHeader" extends "Sales Invoice Header"
{
    fields
    {
        field(50113; "Total Cases"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".UnitOfMeaWeight WHERE("Document No." = field("No.")));
        }
    }
}