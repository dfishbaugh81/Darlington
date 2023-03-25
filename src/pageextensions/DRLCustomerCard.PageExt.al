pageextension 50202 "DRL Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("Combine Shipments")
        {
            field("DRL Shipping Instructions"; Rec."DRL Shipping Instructions")
            {
                ApplicationArea = All;
                MultiLine = true;
                ToolTip = 'Custom Field';
            }
        }
        addafter("Disable Search by Name")
        {
            field("DRL Customer"; Rec."DRL Customer")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field("DRL Company"; Rec."DRL Company")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }

            field("DRL Generate PO"; Rec."DRL Generate PO")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
}
