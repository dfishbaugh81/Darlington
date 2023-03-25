pageextension 50107 "DRL Location Card" extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Use As In-Transit")
        {
            field(DropShipLocation; rec."DRL Drop Ship")
            {
                ApplicationArea = All;
                ToolTip = 'Drop Ship';
            }
            field(Vendor; rec."DRL Vendor No.")
            {
                ApplicationArea = All;
                ToolTip = 'Vendor No.';
            }
        }
    }
}
