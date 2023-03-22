pageextension 50101 "DRL Vendor Card" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Disable Search by Name")
        {
            field(Darlington_Vendor; rec.Darlington_Vendor)
            {
                ApplicationArea = All;
                ToolTip = 'Darlington Vendor';
            }
            field(Darlington_Company; rec.Darlington_Company)
            {
                ApplicationArea = All;
                ToolTip = 'Darlington Company';
            }
            field(Darlington_CreatePO; rec.Darlington_CreatePO)
            {
                ApplicationArea = All;
                ToolTip = 'Darlington CreatePO';
            }
        }
    }
}
