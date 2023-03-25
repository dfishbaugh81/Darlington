report 50104 "DarlingPostedShip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Darlington_Posted_Shipment.rdlc';
    Caption = 'Darlington Posted Shipment';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = Sorting("No.");
            RequestFilterFields = "No.";

            //General Info
            column(PSH_Order_No; "No.")
            {
            }
            column(PSH_Posting_Date; "Posting Date")
            {
            }
            column(PSH_Document_Date; "Document Date")
            {
            }
            column(PSH_Requested_Delivery_Date; "Requested Delivery Date")
            {
            }
            column(PSH_Promised_Delivery_Date; "Promised Delivery Date")
            {
            }
            column(PSH_Shipment_Date; "Shipment Date")
            {
            }
            column(PSH_Sales_Order_Num; "Order No.")
            {
            }
            column(PSH_Sales_Quote_Num; "Quote No.")
            {
            }
            column(PSH_External_Doc_Num; "External Document No.")
            {
            }
            column(PSH_SalesPerson; "Salesperson Code")
            {
            }
            //Ship to Information
            column(PSH_Sell_to_Cust; "Sell-to Customer No.")
            {
            }
            column(PSH_Sell_to_Cust_Name; "Sell-to Customer Name")
            {
            }
            column(PSH_Sell_to_Address; "Sell-to Address")
            {
            }
            column(PSH_Sell_to_City; "Sell-to City")
            {
            }
            column(PSH_Sell_to_Contact; "Sell-to Contact")
            {
            }
            column(PSH_Sell_to_Zip; "Sell-to Post Code")
            {
            }
            column(PSH_Sell_to_County; "Sell-to County")
            {
            }
            column(PSH_PackageTracking; "Package Tracking No.")
            {
            }
            //Ship-to Information
            column(PSH_Ship_to_Cust_Name; "Ship-to Name")
            {
            }
            column(PSH_Ship_to_Address; "Ship-to Address")
            {
            }
            column(PSH_Ship_to_City; "Ship-to City")
            {
            }
            column(PSH_Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(PSH_Ship_to_Zip; "Ship-to Post Code")
            {
            }
            column(PSH_Ship_to_County; "Ship-to County")
            {
            }
            //Bill To Information
            column(PSH_Bill_to_Cust_Name; "Bill-to Name")
            {
            }
            column(PSH_Bill_to_Address; "Bill-to Address")
            {
            }
            column(PSH_Bill_to_City; "Bill-to City")
            {
            }
            column(PSH_Bill_to_Contact; "Bill-to Contact")
            {
            }
            column(PSH_Bill_to_Zip; "Bill-to Post Code")
            {
            }
            column(PSH_Bill_to_County; "Bill-to County")
            {
            }
            column(PSH_Customer_PO; "DRL Customer PO Number")
            {
            }
            column(BOL_BillToAddress; "DRL Bill-to Address")
            {
            }
            column(BOL_BillToAddress2; "DRL Bill-to Address 2")
            {
            }
            column(BOL_BillToCity; "DRL Bill-to City")
            {
            }
            column(BOL_BillToContact; "DRL Bill-to Contact")
            {
            }
            column(BOL_BillToCountry; "DRL Bill-to Country")
            {
            }
            column(BOL_BillToCustomer; "DRL Bill-to Customer")
            {
            }
            column(BOL_BillToName; "DRL Bill-to Name")
            {
            }
            column(BOL_BillToState; "DRL Bill-to State")
            {
            }
            column(BOL_BillToZipCode; "DRL Bill-to Zip Code")
            {
            }
            //Shipment Lines
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line No.");

                column(PSL_Line_No; "Line No.")
                {
                }
                column(PSL_Line_Order_No; "Order No.")
                {
                }
                column(PSL_Item_Number; "No.")
                {
                }
                column(PSL_Item_Description; "Description")
                {
                }
                column(PSL_Item_UOM; "Unit of Measure")
                {
                }
                column(PSL_Item_Qty_Shipped_Not_Inv; "Qty. Shipped Not Invoiced")
                {
                }
                column(PSL_Item_Qty_Base; "Quantity (Base)")
                {
                }
                column(PSL_Item_Type; "Type")
                {
                }
                column(PSL_Item_Qty; "Quantity")
                {
                }
                column(TotalPallets; TotalPallets)
                {
                }
                column(TotalWeight; TotalWeight)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) then
                        ItemUnitOfMeasure.Get("No.", 'PL');

                    TotalPallets := (Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure");

                    if ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) then
                        ItemUnitOfMeasure.Get("No.", 'CS');

                    TotalWeight := ("Quantity (Base)" * ItemUnitOfMeasure.Weight);
                end;
            }
            trigger OnAfterGetRecord()
            begin
            end;
        }
    }
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        TotalWeight: Decimal;
        TotalPallets: Decimal;
}
