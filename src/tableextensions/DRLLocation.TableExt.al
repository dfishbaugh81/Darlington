tableextension 50200 "DRL Location" extends Location
{
    fields
    {
        field(50200; "DRL Drop Ship"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Use for Drop Ship';
        }
        field(50201; "DRL Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
        }
    }
}
