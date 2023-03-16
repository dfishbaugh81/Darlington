pageextension 50117 "PageOrderHeaderExt" extends "Purchase Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field(BakeWeek; Rec.BakeWeek)
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = true;
                ToolTip = 'Bake Week in Integer format';

            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action(PrintBarcodeTracking)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Darlington Item Tracking w/ Barcodes';
                Ellipsis = true;
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Create barcoded lot tracking';

                trigger OnAction()
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    if PurchaseHeader.FindFirst() then begin
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document Type", Rec."Document Type");
                        PurchaseLine.SetRange("Document No.", Rec."No.");
                        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                        if PurchaseLine.FindFirst() then
                            REPORT.RunModal(REPORT::BarCodeTrackingReport, true, false, PurchaseHeader)

                    end;


                end;
            }
        }
    }
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
    //LotNoTab: Record LotNoTable;
}