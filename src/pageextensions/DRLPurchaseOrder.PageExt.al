pageextension 50109 "DRL Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Customer PO"; Rec."DRL Customer PO Number")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer PO Number';
                ToolTip = 'Here is where you manually enter the Customer PO Number';
            }
        }
        // Add changes to page layout here
        addafter(PayToOptions)
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
    }
    actions
    {
        // Add changes to page actions here
        addlast(Documents)
        {
            //Relate -> Documents -> Purchase Order
            action("Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
                Image = SalesInvoice;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesOrderPage: Page "Sales Order";
                begin
                    SalesHeader.SetRange("No.", rec."Payment Reference");
                    SalesOrderPage.SetTableView(SalesHeader);
                    SalesOrderPage.Run();

                end;
            }
        }
    }

}
