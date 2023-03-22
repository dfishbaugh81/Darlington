tableextension 50101 "DRL Vendor" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(50100; Darlington_Vendor; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer';
            TableRelation = Customer;

            trigger OnValidate()
            var
                customerRec: Record Customer;
            begin
                customerRec.ChangeCompany('Test2');
                customerRec.SetFilter("Search Name", '=%1', Darlington_Vendor);
                if customerRec.FindFirst() then
                    if customerRec.Darlington_CreatePO then
                        Message('True %1', customerRec."No.");


            end;
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
                customerRec.SetFilter("Search Name", '=%1', Rec."Search Name");
                if customerRec.FindFirst() then
                    if customerRec.Darlington_CreatePO then
                        Message('True %1', customerRec."No.");
            end;
        }
        field(50102; Darlington_CreatePO; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Sales Order Creation';
        }
    }
}
