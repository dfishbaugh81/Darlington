tableextension 50111 "DRL Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50110; BakeWeek; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bake Week';
        }
    }
}