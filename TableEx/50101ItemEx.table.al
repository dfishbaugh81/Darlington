tableextension 50101 ItemEx extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50101; "PS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PS%';

        }

        field(50102; "MG%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'MG%';
        }
    }

    var
        myInt: Integer;



}