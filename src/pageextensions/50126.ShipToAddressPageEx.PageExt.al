pageextension 50126 "ShipToAddressPageEx" extends "Ship-to Address"
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
            }
        }
    }
    var myInt: Integer;
}
