tableextension 50209 "DRL Ship-to Address" extends "Ship-to Address"
{
    fields
    {
        field(50200; "DRL Shipping Instructions"; Text[1024])
        {
            Caption = 'Shipping Instructions';
            DataClassification = ToBeClassified;
        }
    }
}
