reportextension 50102 "Warehouse Shipment Ext" extends "Whse. - Shipment"
{
    dataset
    {
        addlast("Warehouse Shipment Line")
        {
            dataitem(ReservationInfo; "Reservation Entry")
            {
                DataItemTableView = sorting("Source ID");
                DataItemLink = "Source ID"=field("Source No."), "Source Ref. No."=field("Source Line No.");

                column(LotNo; "Lot No.")
                {
                IncludeCaption = true;
                }
            }
        }
    }
    requestpage
    {
    // Add changes to the requestpage here
    }
}
