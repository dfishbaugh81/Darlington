pageextension 50116 "SalesOrderLineExt" extends "Sales Order Subform"
{
    layout
    {
        addafter("Tax Group Code")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Selects the Pricing Group for the Customer';
            }
        }
    }
}
