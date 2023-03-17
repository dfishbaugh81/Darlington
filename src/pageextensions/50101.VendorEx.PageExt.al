pageextension 50101 "VendorEx" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Disable Search by Name")
        {
            field(Darlington_Vendor; rec.Darlington_Vendor)
            {
                ApplicationArea = All;
            }
            field(Darlington_Company; rec.Darlington_Company)
            {
                ApplicationArea = All;
            }
            field(Darlington_CreatePO; rec.Darlington_CreatePO)
            {
                ApplicationArea = All;
            }
        }
    }
    var myInt: Integer;
}
