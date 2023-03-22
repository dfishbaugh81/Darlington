// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50115 "DRL Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Opportunity No.")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Selects the Pricing Group for the Customer';

                trigger OnValidate()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if SalesLine.FindFirst() then
                        repeat
                            SalesLine.Validate("Customer Price Group", Rec."Customer Price Group");
                            SalesLine.Modify(True);
                        until SalesLine.Next() = 0;

                end;
            }

            field(BakeWeek; Rec.BakeWeek)
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Input Bake Week';
            }

            field("Total Cases"; Rec."Total Cases")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Cases';
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Total Order Weight';
            }

        }
    }
}

