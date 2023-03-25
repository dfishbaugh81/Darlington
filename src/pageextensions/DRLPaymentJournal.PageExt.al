pageextension 50127 "DRL Payment Journal" extends "Payment Journal"
{
    trigger OnAfterGetCurrRecord()
    var
        VendorLedgerEntry: record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Document No.", Rec."Applies-to Doc. No.");
        if VendorLedgerEntry.FindFirst() then begin
            Rec.Validate("External Document No.", VendorLedgerEntry."External Document No.");
            Rec.Modify();
        end;
    end;
}
