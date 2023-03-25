pageextension 50121 "DRL Purchase Order List" extends "Purchase Order List"
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
            field(BakeWeek; rec."DRL Bakeweek")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
}
