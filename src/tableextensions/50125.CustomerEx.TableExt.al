tableextension 50125 "CustomerEx" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50104; ShippingInstructions; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipping Instructions';
        }
    }
    var myInt: Integer;
}
