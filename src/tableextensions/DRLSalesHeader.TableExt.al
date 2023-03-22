tableextension 50114 "DRL Sales Header" extends "Sales Header"
{
    fields
    {
        field(50112; BakeWeek; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bake Week';
        }

        field(50113; "Total Cases"; Decimal)
        {
            Caption = 'Total Cases';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(50114; "Total Weight"; Decimal)
        {
            Caption = 'Total Weight';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".UnitOfMeaWeight WHERE("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }
}