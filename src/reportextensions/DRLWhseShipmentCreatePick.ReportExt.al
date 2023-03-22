reportextension 50102 "DRL Whse.-Shipment-Create Pick" extends "Whse.-Shipment - Create Pick"
{
    dataset
    {
    }
    requestpage
    {
        // Add changes to the requestpage here


        trigger OnOpenPage()
        var
            warehouseActivity: Enum "Warehouse Activity Type";
        begin

            Initialize('', warehouseActivity::" ", false, true, false);


        end;


    }
}
