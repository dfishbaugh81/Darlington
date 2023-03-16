tableextension 50100 "CustomerEx" extends Customer
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
                myInt: Integer;
                companyInfo: Record Company;
                vendorRec: Record Vendor;
                customerRec: Record Customer;
            begin
                //customerRec.ChangeCompany('CRONUS USA, Inc.');
                customerRec.ChangeCompany('Test2');
                customerRec.FindFirst;
                if customerRec.Darlington_CreatePO then begin
                    Message('True %1', customerRec."No.");
                end;
            end;
        }
        field(50102; Darlington_CreatePO; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Generate PO';
        }
    }
    var myInt: Integer;
}
