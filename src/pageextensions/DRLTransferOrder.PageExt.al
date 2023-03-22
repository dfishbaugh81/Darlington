pageextension 50104 "DRL Transfer Order" extends "Transfer Order"
{
    actions
    {
        addafter(Release)
        {
            action("Release & Pick")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = CreateWarehousePick;
                ToolTip = 'Release & Pick';

                // RunObject = Codeunit "Release Transfer Document";

                trigger OnAction()
                var
                    DRLCreateWhseShipmentPick: Codeunit "DRL Create Whse. Shipment/Pick";
                begin
                    DRLCreateWhseShipmentPick.CreateWhseShipmentPickFromTransOrder(Rec);
                end;


            }
        }
    }
}
