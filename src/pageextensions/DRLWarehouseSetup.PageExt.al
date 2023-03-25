pageextension 50108 "DRL Warehouse Setup" extends "Warehouse Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group(ReleasePick)
            {
                Caption = 'Release & Pick';
                field("DRL Create Pick Dialog"; Rec."DRL Create Pick Dialog")
                {
                    ApplicationArea = All;
                    ToolTip = 'Create Pick Dialog';
                }
            }
        }
    }
}
