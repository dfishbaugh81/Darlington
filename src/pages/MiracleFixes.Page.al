page 50100 "Miracle Fixes"
{
    Caption = 'Miracle Fixes';
    PageType = Card;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(MigrateAll)
            {
                ApplicationArea = All;
                Caption = 'Migrate All';
                ToolTip = 'Migrate All';

                trigger OnAction()
                begin
                    DRLMigrationMgmt.MigrateAll();
                end;
            }
        }
    }
    var
        DRLMigrationMgmt: Codeunit "DRL Migration Mgmt";
}
