tableextension 50208 "DRL Customer" extends Customer
{
    fields
    {
        field(50200; "DRL Shipping Instructions"; Text[1024])
        {
            Caption = 'Shipping Instructions';
            DataClassification = ToBeClassified;
        }
        field(50201; "DRL Customer"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor';
            TableRelation = Vendor;
        }
        field(50202; "DRL Company"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Company';
            TableRelation = Company;
        }
        field(50203; "DRL Generate PO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Generate PO';
        }
    }
}
