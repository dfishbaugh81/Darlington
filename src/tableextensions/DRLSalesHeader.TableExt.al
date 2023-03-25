tableextension 50204 "DRL Sales Header" extends "Sales Header"
{
    fields
    {
        field(50200; "DRL Bill-to Customer"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Customer';
        }
        field(50201; "DRL Bill-to Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Name';
        }
        field(50202; "DRL Bill-to Address"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Address';
        }
        field(50203; "DRL Bill-to Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Address 2';
        }
        field(50204; "DRL Bill-to City"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to City';
        }
        field(50205; "DRL Bill-to State"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to State';
        }
        field(50206; "DRL Bill-to Zip Code"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Zip Code';
        }
        field(50207; "DRL Bill-to Country"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Country/Region';
        }
        field(50208; "DRL Bill-to Contact"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill to Contact';
        }
        field(50209; "DRL Customer PO Number"; text[300])
        {
            Caption = 'Customer_PO_Number';
            ExtendedDatatype = URL;
        }
        field(50210; "DRL Bakeweek"; Integer)
        {
            Caption = 'Bake week';
        }
    }
}
