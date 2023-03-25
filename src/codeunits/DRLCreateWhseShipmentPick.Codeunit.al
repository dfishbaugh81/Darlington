codeunit 50101 "DRL Create Whse. Shipment/Pick"
{
    procedure CreateWhseShipment_Pick(var SalesHeader: Record "Sales Header")
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WhseShipmentRelease: Codeunit "Whse.-Shipment Release";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        ReleaseSalesDocument.ReleaseSalesHeader(SalesHeader, false);
        GetSourceDocOutbound.CreateFromSalesOrderHideDialog(SalesHeader);
        WarehouseShipmentLine.SetRange("Source No.", SalesHeader."No.");
        if WarehouseShipmentLine.FindFirst() then
            if WarehouseShipmentHeader.Get(WarehouseShipmentLine."No.") then begin
                WhseShipmentRelease.Release(WarehouseShipmentHeader);
                CreatePickDocument(WarehouseShipmentLine, WarehouseShipmentHeader);
            end;
    end;

    procedure CreateWhseShipmentPickFromTransOrder(var TransferHeader: Record "Transfer Header")
    var

        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhseShipmentRelease: Codeunit "Whse.-Shipment Release";
    begin
        GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);
        WarehouseShipmentLine.SetRange("Source No.", TransferHeader."No.");

        if WarehouseShipmentLine.FindFirst() then
            if WarehouseShipmentHeader.Get(WarehouseShipmentLine."No.") then begin
                WhseShipmentRelease.Release(WarehouseShipmentHeader);
                CreatePickDocument(WarehouseShipmentLine, WarehouseShipmentHeader);
            end;
    end;




    procedure CreatePickDocument(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        WarehouseShipmentHeader.TestField(Status, WarehouseShipmentHeader.Status::Released);
        WarehouseShipmentLine.SetFilter(Quantity, '>0');
        WarehouseShipmentLine.SetRange("Completely Picked", false);
        if WarehouseShipmentLine.Find('-') then
            CreatePickDocFromWhseShpt(WarehouseShipmentLine, WarehouseShipmentHeader, HideValidationDialogBln)
        else
            if not HideValidationDialogBln then
                Message(NothingToHandleLbl);
    end;

    local procedure CreatePickDocFromWhseShpt(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; HideValidationDialog: Boolean)
    var
        WhseShipmentCreatePick: Report "Whse.-Shipment - Create Pick";
    begin
        WhseShipmentCreatePick.SetWhseShipmentLine(WarehouseShipmentLine, WarehouseShipmentHeader);

        WarehouseSetup.Get();

        if WarehouseSetup."DRL Create Pick Dialog" then
            WhseShipmentCreatePick.RunModal()
        else
            WhseShipmentCreatePick.Execute('OK');

        WhseShipmentCreatePick.SetHideValidationDialog(HideValidationDialog);
        WhseShipmentCreatePick.UseRequestPage(not HideValidationDialog);
        WhseShipmentCreatePick.GetResultMessage();
        Clear(WhseShipmentCreatePick);
    end;

    var
        WarehouseSetup: Record "Warehouse Setup";
        HideValidationDialogBln: Boolean;
        NothingToHandleLbl: Label 'Nothing to handle.';



}
