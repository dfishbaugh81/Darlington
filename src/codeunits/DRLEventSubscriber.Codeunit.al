codeunit 50201 "DRL Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment + Print", 'OnAfterCode', '', false, false)]
    local procedure printItemTrackingLines()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemTrackingReport: Report "DRL Posted Tracking Lines";
    begin
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        if (ItemLedgerEntry.FindLast()) then begin
            ItemLedgerEntry.SetRange("Document No.", ItemLedgerEntry."Document No.");
            ItemTrackingReport.SetTableView(itemLedgerEntry);
            ItemTrackingReport.Run();
        end;
    end;
}