pageextension 50126 "DRL Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
        addafter("Tax Area Code")
        {
            field(ShippingInstructions; rec.ShippingInstructions)
            {
                ApplicationArea = All;
                MultiLine = true;
                ToolTip = 'Ship-to Address';
            }
        }
    }
}
