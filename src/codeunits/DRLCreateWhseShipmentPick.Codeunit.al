codeunit 50101 "DRL Create Whse. Shipment/Pick"
{
    procedure CreateWhseShipment_Pick(var SalesHeader: Record "Sales Header")
    var

        whseShipment: Record "Warehouse Shipment Header";
        whseShipmentLine: Record "Warehouse Shipment Line";

        releaseOrder: Codeunit "Release Sales Document";

        createWhseShipmentDoc: Codeunit "Get Source Doc. Outbound";

        releaseShipmentDoc: Codeunit "Whse.-Shipment Release";


    begin

        releaseOrder.ReleaseSalesHeader(SalesHeader, false);

        createWhseShipmentDoc.CreateFromSalesOrderHideDialog(SalesHeader);



        whseShipmentLine.SetRange("Source No.", SalesHeader."No.");
        whseShipment.SetRange("No.", whseShipmentLine."No.");

        if whseShipment.FindSet() then begin

            releaseShipmentDoc.Release(whseShipment);

            CreatePickDocument(whseShipmentLine, whseShipment);


        end;

    end;



    procedure CreateWhseShipmentPickFromTransOrder(var TransferOrder: Record "Transfer Header")
    var

        whseShipment: Record "Warehouse Shipment Header";

        CreatePickDialog: Record "Warehouse Setup";

        whseShipmentLine: Record "Warehouse Shipment Line";
        createWhseShipmentDoc: Codeunit "Get Source Doc. Outbound";

        releaseShipmentDoc: Codeunit "Whse.-Shipment Release";


    begin


        createWhseShipmentDoc.CreateFromOutbndTransferOrderHideDialog(TransferOrder);

        whseShipmentLine.SetFilter("Source No.", '=%1', TransferOrder."No.");

        if whseShipmentLine.FindSet() then begin

            whseShipment.SetFilter("No.", '=%1', whseShipmentLine."No.");

            if whseShipment.FindSet() then begin

                releaseShipmentDoc.Release(whseShipment);

                CreatePickDocument(whseShipmentLine, whseShipment);
            end;

        end;


    end;




    procedure CreatePickDocument(var WhseShptLine: Record "Warehouse Shipment Line"; WhseShptHeader2: Record "Warehouse Shipment Header")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnCreatePickDocOnBeforeCreatePickDoc(WhseShptLine, WhseShptLine, WhseShptHeader2, HideValidationDialog, IsHandled);
        if IsHandled then
            exit;

        WhseShptHeader2.TestField(Status, WhseShptHeader2.Status::Released);
        WhseShptLine.SetFilter(Quantity, '>0');
        WhseShptLine.SetRange("Completely Picked", false);
        if WhseShptLine.Find('-') then
            CreatePickDocFromWhseShpt(WhseShptLine, WhseShptHeader2, HideValidationDialog)
        else
            if not HideValidationDialog then
                Message(NothingToHandleLbl);
    end;




    local procedure OnCreatePickDocOnBeforeCreatePickDoc(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var WhseShptLine: Record "Warehouse Shipment Line"; var WhseShptHeader2: Record "Warehouse Shipment Header"; HideValidationDialog: Boolean; var IsHandled: Boolean)
    begin
    end;


    local procedure CreatePickDocFromWhseShpt(var WhseShptLine: Record "Warehouse Shipment Line"; WhseShptHeader: Record "Warehouse Shipment Header"; HideValidationDialog: Boolean)
    var
        WhseShipmentCreatePick: Report "Whse.-Shipment - Create Pick";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCreatePickDoc(WhseShptLine, WhseShptHeader, HideValidationDialog, IsHandled);
        if not IsHandled then begin
            WhseShipmentCreatePick.SetWhseShipmentLine(WhseShptLine, WhseShptHeader);

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
        OnAfterCreatePickDoc(WhseShptHeader, WhseShptLine);
    end;


    local procedure OnBeforeCreatePickDoc(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; HideValidationDialog: Boolean; var IsHandled: Boolean)
    begin
    end;


    local procedure OnAfterCreatePickDoc(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WhseShptLine: Record "Warehouse Shipment Line")
    begin
    end;




    var
        WarehouseSetup: Record "Warehouse Setup";
        HideValidationDialog: Boolean;
        NothingToHandleLbl: Label 'Nothing to handle.';
}
