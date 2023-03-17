pageextension 50125 "CustomerPageEx" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Combine Shipments")
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
