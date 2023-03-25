pageextension 50123 "DRL Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field(Customer_PO; rec."DRL Customer PO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BakeWeek; rec."DRL Bakeweek")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }

}
