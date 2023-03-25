pageextension 50122 "DRL Sales Order List" extends "Sales Order List"
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
