pageextension 50106 "DRL Transfer Order" extends "Transfer Order"
{
    actions
    {
        addafter(Release)
        {
            action("Release-Pick")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = CreateWarehousePick;

                RunObject = Codeunit "Release Transfer Document";
                Caption = 'Release & Pick';
                ToolTip = 'Release & Pick';

                trigger OnAction()
                var
                    ReleasePick: Codeunit "DRL Create Whse. Shipment/Pick";
                begin
                    ReleasePick.CreateWhseShipmentPickFromTransOrder(Rec);

                end;


            }
        }
    }
}
