pageextension 50146 "BinContentsExt" extends "Bin Contents"
{
    actions
    {
        addafter("Warehouse Entries")
        {

            action("Nav-to-Edit")
            {
                ApplicationArea = All;
                Caption = 'Nav-to-Edit';
                ToolTip = 'Nav-to-Edit';

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    WarEntEd: Page "Warehouse Entries - Editable";
                begin
                    if UserSetup.Get(UserId()) then
                        if UserSetup."User ID" = 'BCADMIN' then
                            WarEntEd.Run();
                end;
            }
        }
    }
}