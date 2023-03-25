pageextension 50203 "DRL Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        addafter("Tax Area Code")
        {
            field("DRL Shipping Instructions"; Rec."DRL Shipping Instructions")
            {
                ApplicationArea = All;
                MultiLine = true;
                ToolTip = 'Custom Field';
            }
        }
    }
}
