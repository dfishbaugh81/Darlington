pageextension 50112 "DRL Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter(Closed)
        {
            field(Customer_PO; rec."DRL Customer PO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
                Editable = false;
            }
            field(BakeWeek; rec."DRL Bakeweek")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
}
