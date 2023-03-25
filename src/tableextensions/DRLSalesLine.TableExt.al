tableextension 50207 "DRL Sales Line" extends "Sales Line"
{
    fields
    {
        field(50200; "DRL Lot No."; Integer)
        {
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;
        }
    }

    procedure DRLUpdateQty()
    var
        SalesHeader: Record "Sales Header";
        PurchaseLine: Record "Purchase Line";
    begin
        if SalesHeader.Get("Document Type", "Document No.") then begin
            PurchaseLine.SetRange("Document No.", SalesHeader."Your Reference");
            PurchaseLine.SetRange("No.", "No.");
            PurchaseLine.SetRange("Line No.", "Line No.");
            if PurchaseLine.FindSet() and (PurchaseLine.Quantity <> Quantity) then begin
                PurchaseLine.Validate(Quantity, Quantity);
                PurchaseLine.Modify();
            end
        end;
    end;

    trigger OnAfterModify()
    begin
        DRLUpdateQty();
    end;
}
