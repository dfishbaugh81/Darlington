pageextension 50100 "CustomerEx" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Disable Search by Name")
        {
            field(Darlington_Vendor; rec.Darlington_Customer)
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

        // Add changes to page layout here
        addafter("Combine Shipments")
        {
            field(ShippingInstructions; rec.ShippingInstruction)
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }
    var
        myInt: Integer;
}
