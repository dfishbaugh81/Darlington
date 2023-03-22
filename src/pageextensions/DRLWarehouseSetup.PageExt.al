pageextension 50105 "DRL Warehouse Setup" extends "Warehouse Setup"
{
    layout
    {
        addafter(Numbering)
        {

            group("Release & Pick")
            {
                Caption = 'Release & Pick';

                field(CreatePickDialog; Rec."DRL Create Pick Dialog")
                {
                    ApplicationArea = All;
                    ToolTip = 'Create Pick Dialog';
                }

            }
        }
    }
}
