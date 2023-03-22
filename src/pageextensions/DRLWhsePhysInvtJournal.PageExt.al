pageextension 50114 "DRL Whse. Phys. Invt. Journal" extends "Whse. Phys. Invt. Journal"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Expiration Date';

            }
        }
    }
}