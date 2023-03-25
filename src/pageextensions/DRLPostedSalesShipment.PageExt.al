pageextension 50111 "DRL Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Date")
        {
            field(Customer_PO; rec."DRL Customer PO Number")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
            field(BakeWeek; Rec."DRL Bakeweek")
            {
                ApplicationArea = All;
                ToolTip = 'Custom Field';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("&Shipment")
        {
            action("Darlington Posted Shipment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Posted Shipment';
                ToolTip = 'Print Darlington Posted Shipment';
                Image = PrintReport;

                trigger OnAction();
                var
                    SalesShipHeader: Record "Sales Shipment Header";
                    MyReport: Report "DarlingPostedShip";
                begin
                    SalesShipHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesShipHeader);
                    MyReport.SetTableView(SalesShipHeader);
                    MyReport.Run();
                    PrintItemTrackingLinesReport();
                end;
            }
        }
        modify("&Print")
        {
            trigger OnAfterAction()
            begin
                PrintItemTrackingLinesReport();
            end;
        }
    }
    procedure PrintItemTrackingLinesReport()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        DRLPostedTrackingLines: Report "DRL Posted Tracking Lines";
    begin
        ItemLedgerEntry.SetRange("Document No.", rec."No.");
        if ItemLedgerEntry.FindFirst() then begin
            DRLPostedTrackingLines.SetTableView(ItemLedgerEntry);
            DRLPostedTrackingLines.Run();
        end;
    end;
}
