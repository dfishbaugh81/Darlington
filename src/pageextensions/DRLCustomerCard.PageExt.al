pageextension 50125 "DRL Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Combine Shipments")
        {
            field(ShippingInstructions; rec.DRL_ShippingInstructions)
            {
                ApplicationArea = All;
                MultiLine = true;
                ToolTip = 'Shipping Instructions';
            }
        }

        addafter("Disable Search by Name")
        {
            field(Darlington_Vendor; rec.Darlington_Customer)
            {
                ApplicationArea = All;
                ToolTip = 'Vendor';
            }
            field(Darlington_Company; rec.Darlington_Company)
            {
                ApplicationArea = All;
                ToolTip = 'Company';
            }
            field(Darlington_CreatePO; rec.Darlington_CreatePO)
            {
                ApplicationArea = All;
                ToolTip = 'Create PO';
            }
        }
    }
}
