codeunit 50200 "DRL Migration Mgmt"
{
    Permissions = tabledata "Warehouse Setup" = rimd, tabledata Vendor = rimd, tabledata Item = rimd, tabledata "Production BOM Line" = rimd, tabledata Customer = rimd, tabledata "Ship-to Address" = rimd, tabledata Location = rimd, tabledata "Purchase Header" = rimd, tabledata "Purch. Inv. Header" = rimd, tabledata "Sales Header" = rimd, tabledata "Sales Invoice Header" = rimd, tabledata "Sales Shipment Header" = rimd;

    procedure MigrateAll()
    begin
        MigrateCustomerTable();
        MigrateLocationTable();
        MigratePurchaseHeader();
        MigratePurchInvHeader();
        MigrateSalesHeader();
        MigrateSalesInvoiceHeader();
        MigrateSalesShipmentHeader();
        MigrateYieldPlanning();
        MigrateVendorTable();
        MigrateWarehouseSetup();
    end;

    procedure MigrateWarehouseSetup()
    var
    // WarehouseSetup: Record "Warehouse Setup";
    begin
        // if WarehouseSetup.Get() then begin
        //     WarehouseSetup."DRL Create Pick Dialog" := WarehouseSetup.CreatePickDialog;
        //     WarehouseSetup.Modify();
        // end;
    end;

    procedure MigrateVendorTable()
    var
    // Vendor: Record Vendor;
    begin
        // if Vendor.FindSet() then
        //     repeat
        //         Vendor."DRL Company" := Vendor.Darlington_Company;
        //         Vendor."DRL Create SO" := Vendor.Darlington_CreatePO;
        //         Vendor."DRL Vendor" := Vendor.Darlington_Vendor;
        //         Vendor.Modify();
        //     until Vendor.Next() = 0;
    end;

    procedure MigrateYieldPlanning()
    var
    // Item: Record Item;
    // ProductionBOMLine: Record "Production BOM Line";
    begin
        // if Item.FindSet() then
        //     repeat
        //         Item."DRL ML Weight" := Item.MLWeight;
        //         Item."DRL Moisture Gain" := Item."MG%";
        //         Item."DRL Planned Scrap" := Item."PS%";
        //         Item."DRL Moisture Loss" := Item."ML%";
        //         Item.Modify();
        //     until Item.Next() = 0;


        // if ProductionBOMLine.FindSet() then
        //     repeat
        //         ProductionBOMLine."DRL Lbs. After ML" := ProductionBOMLine."lbs. After ML";
        //         ProductionBOMLine."DRL Moisture Loss" := ProductionBOMLine."ML%";
        //     until ProductionBOMLine.Next() = 0;
    end;

    procedure MigrateCustomerTable()
    var
    // Customer: Record Customer;
    // ShiptoAddress: Record "Ship-to Address";
    begin
        // if (Customer.FindSet()) then
        //     repeat
        //         Customer."DRL Shipping Instructions" := Customer.ShippingInstructions;
        //         Customer."DRL Company" := Customer.Darlington_Company;
        //         Customer."DRL Customer" := Customer.Darlington_Customer;
        //         Customer."DRL Generate PO" := Customer.Darlington_CreatePO;
        //         Customer.Modify();
        //     until Customer.Next() = 0;

        // if (ShiptoAddress.FindSet()) then
        //     repeat
        //         ShiptoAddress."DRL Shipping Instructions" := ShiptoAddress.ShippingInstructions;
        //         ShiptoAddress.Modify();
        //     until ShiptoAddress.Next() = 0;

    end;

    procedure MigrateLocationTable()
    var
    // Location: Record Location;
    begin
        // if Location.FindSet() then
        //     repeat
        //         Location."DRL Drop Ship" := Location.DropShipLocation;
        //         Location."DRL Vendor No." := Location.Vendor;
        //         Location.Modify();
        //     until Location.Next() = 0;
    end;

    procedure MigratePurchaseHeader()
    var
    // PurchaseHeader: Record "Purchase Header";
    begin
        // if PurchaseHeader.FindSet() then
        //     repeat
        //         PurchaseHeader."DRL Bill-to Address" := PurchaseHeader."DRL Bill-to Address";
        //         PurchaseHeader."DRL Bill-to Address 2" := PurchaseHeader."DRL Bill-to Address 2";
        //         PurchaseHeader."DRL Bill-to City" := PurchaseHeader."DRL Bill-to City";
        //         PurchaseHeader."DRL Bill-to Contact" := PurchaseHeader."DRL Bill-to Contact";
        //         PurchaseHeader."DRL Bill-to Country" := PurchaseHeader."DRL Bill-to Country";
        //         PurchaseHeader."DRL Bill-to Customer" := PurchaseHeader."DRL Bill-to Customer";
        //         PurchaseHeader."DRL Bill-to Name" := PurchaseHeader."DRL Bill-to Name";
        //         PurchaseHeader."DRL Bill-to State" := PurchaseHeader."DRL Bill-to State";
        //         PurchaseHeader."DRL Bill-to Zip Code" := PurchaseHeader."DRL Bill-to Zip Code";
        //         PurchaseHeader."DRL Customer PO Number" := PurchaseHeader.Customer_PO;
        //         PurchaseHeader."DRL Bakeweek" := PurchaseHeader.BakeWeek;
        //         PurchaseHeader.Modify();
        //     until PurchaseHeader.Next() = 0;
    end;

    procedure MigratePurchInvHeader()
    var
    // PurchInvHeader: Record "Purch. Inv. Header";
    begin
        // if PurchInvHeader.FindSet() then
        //     repeat
        //         PurchInvHeader."DRL Bill-to Address" := PurchInvHeader."DRL Bill-to Address";
        //         PurchInvHeader."DRL Bill-to Address 2" := PurchInvHeader."DRL Bill-to Address 2";
        //         PurchInvHeader."DRL Bill-to City" := PurchInvHeader."DRL Bill-to City";
        //         PurchInvHeader."DRL Bill-to Contact" := PurchInvHeader."DRL Bill-to Contact";
        //         PurchInvHeader."DRL Bill-to Country" := PurchInvHeader."DRL Bill-to Country";
        //         PurchInvHeader."DRL Bill-to Customer" := PurchInvHeader."DRL Bill-to Customer";
        //         PurchInvHeader."DRL Bill-to Name" := PurchInvHeader."DRL Bill-to Name";
        //         PurchInvHeader."DRL Bill-to State" := PurchInvHeader."DRL Bill-to State";
        //         PurchInvHeader."DRL Bill-to Zip Code" := PurchInvHeader."DRL Bill-to Zip Code";
        //         PurchInvHeader."DRL Customer PO Number" := PurchInvHeader.Customer_PO;
        //         PurchInvHeader."DRL BakeWeek" := PurchInvHeader.BakeWeek;
        //         PurchInvHeader.Modify();
        //     until PurchInvHeader.Next() = 0;
    end;


    procedure MigrateSalesHeader()
    var
    // SalesHeader: Record "Sales Header";
    begin
        // if SalesHeader.FindSet() then
        //     repeat
        //         SalesHeader."DRL Bill-to Address" := SalesHeader.BOL_BillToAddress;
        //         SalesHeader."DRL Bill-to Address 2" := SalesHeader.BOL_BillToAddress2;
        //         SalesHeader."DRL Bill-to City" := SalesHeader.BOL_BillToCity;
        //         SalesHeader."DRL Bill-to Contact" := SalesHeader.BOL_BillToContact;
        //         SalesHeader."DRL Bill-to Country" := SalesHeader.BOL_BillToCountry;
        //         SalesHeader."DRL Bill-to Customer" := SalesHeader.BOL_BillToCustomer;
        //         SalesHeader."DRL Bill-to Name" := SalesHeader.BOL_BillToName;
        //         SalesHeader."DRL Bill-to State" := SalesHeader.BOL_BillToState;
        //         SalesHeader."DRL Bill-to Zip Code" := SalesHeader.BOL_BillToZipCode;
        //         SalesHeader."DRL Customer PO Number" := SalesHeader.Customer_PO;
        //         SalesHeader."DRL Bakeweek" := SalesHeader.BakeWeek;
        //         SalesHeader.Modify();
        //     until SalesHeader.Next() = 0;
    end;

    procedure MigrateSalesInvoiceHeader()
    var
    // SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        // if SalesInvoiceHeader.FindSet() then
        //     repeat
        //         SalesInvoiceHeader."DRL Bill-to Address" := SalesInvoiceHeader.BOL_BillToAddress;
        //         SalesInvoiceHeader."DRL Bill-to Address 2" := SalesInvoiceHeader.BOL_BillToAddress2;
        //         SalesInvoiceHeader."DRL Bill-to City" := SalesInvoiceHeader.BOL_BillToCity;
        //         SalesInvoiceHeader."DRL Bill-to Contact" := SalesInvoiceHeader.BOL_BillToContact;
        //         SalesInvoiceHeader."DRL Bill-to Country" := SalesInvoiceHeader.BOL_BillToCountry;
        //         SalesInvoiceHeader."DRL Bill-to Customer" := SalesInvoiceHeader.BOL_BillToCustomer;
        //         SalesInvoiceHeader."DRL Bill-to Name" := SalesInvoiceHeader.BOL_BillToName;
        //         SalesInvoiceHeader."DRL Bill-to State" := SalesInvoiceHeader.BOL_BillToState;
        //         SalesInvoiceHeader."DRL Bill-to Zip Code" := SalesInvoiceHeader.BOL_BillToZipCode;
        //         SalesInvoiceHeader."DRL Customer PO Number" := SalesInvoiceHeader.Customer_PO;
        //         SalesInvoiceHeader."DRL Bakeweek" := SalesInvoiceHeader.BakeWeek;
        //         SalesInvoiceHeader.Modify();
        //     until SalesInvoiceHeader.Next() = 0;
    end;

    procedure MigrateSalesShipmentHeader()
    var
    // SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        // if SalesShipmentHeader.FindSet() then
        //     repeat
        //         SalesShipmentHeader."DRL Bill-to Address" := SalesShipmentHeader.BOL_BillToAddress;
        //         SalesShipmentHeader."DRL Bill-to Address 2" := SalesShipmentHeader.BOL_BillToAddress2;
        //         SalesShipmentHeader."DRL Bill-to City" := SalesShipmentHeader.BOL_BillToCity;
        //         SalesShipmentHeader."DRL Bill-to Contact" := SalesShipmentHeader.BOL_BillToContact;
        //         SalesShipmentHeader."DRL Bill-to Country" := SalesShipmentHeader.BOL_BillToCountry;
        //         SalesShipmentHeader."DRL Bill-to Customer" := SalesShipmentHeader.BOL_BillToCustomer;
        //         SalesShipmentHeader."DRL Bill-to Name" := SalesShipmentHeader.BOL_BillToName;
        //         SalesShipmentHeader."DRL Bill-to State" := SalesShipmentHeader.BOL_BillToState;
        //         SalesShipmentHeader."DRL Bill-to Zip Code" := SalesShipmentHeader.BOL_BillToZipCode;
        //         SalesShipmentHeader."DRL Customer PO Number" := SalesShipmentHeader.Customer_PO;
        //         SalesShipmentHeader."DRL Bakeweek" := SalesShipmentHeader.BakeWeek;
        //         SalesShipmentHeader.Modify();
        //     until SalesShipmentHeader.Next() = 0;
    end;
}
