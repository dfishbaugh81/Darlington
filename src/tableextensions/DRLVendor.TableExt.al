tableextension 50212 "DRL Vendor" extends Vendor
{
    fields
    {
        field(50200; "DRL Vendor"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer';
            TableRelation = Customer;
        }
        field(50201; "DRL Company"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Company';
            TableRelation = Company;
        }
        field(50202; "DRL Create SO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Sales Order Creation';
        }
    }
}
