tableextension 50126 "DRL Ship-to Address" extends "Ship-to Address"
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

}
