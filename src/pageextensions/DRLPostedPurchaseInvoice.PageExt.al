pageextension 50110 "DRL Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("IRS 1099 Code")
        {
            field(BillToCustomer; rec."DRL Bill-to Customer")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToName; rec."DRL Bill-to Name")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToAddress; rec."DRL Bill-to Address")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToAddress2; rec."DRL Bill-to Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToCity; rec."DRL Bill-to City")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToState; rec."DRL Bill-to State")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToZipCode; rec."DRL Bill-to Zip Code")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToCountry; rec."DRL Bill-to Country")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BillToContact; rec."DRL Bill-to Contact")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
        addafter(Corrective)
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
