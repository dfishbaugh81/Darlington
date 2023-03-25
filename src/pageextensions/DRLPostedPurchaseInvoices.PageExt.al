pageextension 50124 "DRL Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {
            field(Customer_PO; rec."DRL Customer PO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BakeWeek; rec."DRL BakeWeek")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
}
