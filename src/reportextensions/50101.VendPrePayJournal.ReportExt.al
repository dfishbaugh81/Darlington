reportextension 50101 "VendPrePayJournal" extends "Vendor Pre-Payment Journal"
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
            LayoutFile = 'VendPrePayJrnl.rdl';
        }
    }
}
