pageextension 50134 "DRL Warehouse Shipment" extends "Warehouse Shipment"
{
    actions
    {
        addlast("P&osting")
        {
            action("Darlington Post & Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Posted Shipment';
                ToolTip = 'Print Darlington Posted Shipment';
                Image = PrintReport;

                trigger OnAction();
                var
                    WarehouseShipmentHeader: Record "Warehouse Shipment Header";
                    DarlingPostedShip: Report "DarlingPostedShip";
                begin
                    WarehouseShipmentHeader := Rec;
                    CurrPage.SetSelectionFilter(WarehouseShipmentHeader);
                    DarlingPostedShip.SetTableView(WarehouseShipmentHeader);
                    DarlingPostedShip.Run();
                end;
            }
        }
    }
}
