tableextension 50100 "DRL Customer" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50100; Darlington_Customer; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor';
            TableRelation = Vendor;
        }
        field(50101; Darlington_Company; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Company';
            TableRelation = Company;

            trigger OnValidate()
            var
                customerRec: Record Customer;
            begin
                //customerRec.ChangeCompany('CRONUS USA, Inc.');
                customerRec.ChangeCompany('Test2');
                customerRec.FindFirst();
                if customerRec.Darlington_CreatePO then
                    Message('True %1', customerRec."No.");
            end;
        }
        field(50102; Darlington_CreatePO; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Generate PO';
        }
        // Add changes to table fields here
        field(50104; DRL_ShippingInstructions; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipping Instructions';
        }
    }
}
