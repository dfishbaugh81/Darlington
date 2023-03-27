pageextension 50101 "DRL Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
                ToolTip = 'Posting Description';
            }
        }
    }
}
