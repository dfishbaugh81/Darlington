tableextension 50202 "DRL Purchase Line" extends "Purchase Line"
{
    fields
    {

    }

    procedure DRLUpdateQty()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("Your Reference", "Document No.");
        if SalesHeader.FindFirst() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange("No.", "No.");
            SalesLine.SetRange("Line No.", "Line No.");
            if SalesLine.FindFirst() and (SalesLine.Quantity <> Quantity) then begin
                SalesLine.Validate(Quantity, Quantity);
                SalesLine.Modify();
            end;
        end
    end;

    trigger OnAfterModify()
    begin
        DRLUpdateQty();
    end;
}
