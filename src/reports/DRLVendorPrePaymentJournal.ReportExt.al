reportextension 50101 "DRL Vendor Pre-Payment Journal" extends "Vendor Pre-Payment Journal"
{
    dataset
    {
        add("Gen. Journal Line")
        {
            column(Gen__Journal_Line__ExtDocument_No__; "External Document No.")
            {
            }
        }
    }
    requestpage
    {
        // Add changes to the requestpage here
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './layouts/VendPrePayJrnl.rdlc';
        }
    }
}
