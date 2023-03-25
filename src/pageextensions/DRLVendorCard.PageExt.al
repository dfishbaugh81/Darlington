pageextension 50105 "DRL Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("DRL Vendor"; Rec."DRL Vendor")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field("DRL Company"; Rec."DRL Company")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }

            field("DRL Create SO"; Rec."DRL Create SO")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
}
