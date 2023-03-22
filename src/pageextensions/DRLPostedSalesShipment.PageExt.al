pageextension 50141 "DRL Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Total Cases"; Rec."Total Cases")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Cases';
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Weight';
            }
        }
    }
}