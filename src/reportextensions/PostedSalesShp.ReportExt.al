reportextension 50103 "Posted Sales Shp" extends "Sales Shipment NA"
{
    dataset
    {
        add("Sales Shipment Line")
        {
            column("SSL_Item_No"; "No.")
            {
            IncludeCaption = true;
            }
            column("SSL_Item_Desc"; "Description")
            {
            IncludeCaption = true;
            }
            column("SSL_Item_UOM"; "Unit of Measure Code")
            {
            IncludeCaption = true;
            }
            column("SSL_Qty_Shp_NI"; "Qty. Shipped Not Invoiced")
            {
            IncludeCaption = true;
            }
            column("SSL_Qty_Base"; "Quantity (Base)")
            {
            IncludeCaption = true;
            }
            column("SSL_Qty"; "Quantity")
            {
            IncludeCaption = true;
            }
        }
        addlast("Sales Shipment Line")
        {
            dataitem(ItemLedgerTable; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No."), "Document No."=field("Document No.");

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
