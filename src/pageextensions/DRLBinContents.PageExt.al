pageextension 50102 "DRL Bin Contents" extends "Bin Contents"
{
    actions
    {
        addafter("Warehouse Entries")
        {
            action("Nav-to-Edit")
            {
                ApplicationArea = All;
                ToolTip = 'Bin Content';

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    WarEntEd: Page "DRL Warehouse Entries-Editable";
                begin
                    if UserSetup.Get(UserId()) then
                        if UserSetup."User ID" = 'BCADMIN' then WarEntEd.Run();
                end;
            }
        }
    }
}
