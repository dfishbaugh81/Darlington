pageextension 50130 "DRL Posted Sales Invoice" extends "Posted Sales Invoice"
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











