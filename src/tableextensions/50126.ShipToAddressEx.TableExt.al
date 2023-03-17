tableextension 50126 "ShipToAddressEx" extends "Ship-to Address"
{
    fields
    {
        // Add changes to table fields here
        field(50105; ShippingInstructions; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipping Instructions';
        }
    }
    var myInt: Integer;
}
