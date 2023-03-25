report 50101 "DRL Posted Tracking Lines"
{
    Caption = 'Item Tracking Lines';
    EnableHyperlinks = true;
    Permissions = TableData "Item Ledger Entry" = rimd;
    PreviewMode = PrintLayout;
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Item Tracking Lines.rdlc';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
        }
        dataitem(Header; "Item Ledger Entry")
        {
            DataItemTableView = Sorting("Document No.");
            RequestFilterFields = "Document No.";

            column(Document_No_; Header."Document No.")
            {
            }
            //DataItemLink = "Document No." = field("Document No.");
            column(Entry_No_; Header."Entry No.")
            {
            }
            column(Item_No_; Header."Item No.")
            {
            }
            column(Description; Header.Description)
            {
            }
            column(Quantity; Header.Quantity)
            {
            }
            column(Lot_No_; Header."Lot No.")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                }
            }
        }

    }
}
