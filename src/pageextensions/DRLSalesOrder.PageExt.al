pageextension 50104 "DRL Sales Order" extends "Sales Order"
{
    layout
    {
        addafter(BakeWeek)
        {
            field("DRL Bakeweek"; Rec."DRL Bakeweek")
            {
                ApplicationArea = All;
                ToolTip = 'Bake week';
            }
        }
        modify(BakeWeek)
        {
            Visible = false;
        }
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
        addafter("Shipping and Billing")
        {
            group("BOL Bill-To")
            {
                field(BOL_BillToCustomer; rec."DRL Bill-to Customer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToName; rec."DRL Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToAddress; rec."DRL Bill-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToAddress2; rec."DRL Bill-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToCity; rec."DRL Bill-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToState; rec."DRL Bill-to State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToZipCode; rec."DRL Bill-to Zip Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToCountry; rec."DRL Bill-to Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
                field(BOL_BillToContact; rec."DRL Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom Field';
                }
            }
        }
    }
    actions
    {
        // Actions -> Functions -> Create Purchase Order
        addafter("Create Purchase Document")
        {
            action("Create HS Baking PO")
            {
                ApplicationArea = All;
                ToolTip = 'Create HS Baking PO';
                Caption = 'Create HS Baking PO';
                Image = CreateDocument;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    if rec."Your Reference" <> '' then begin
                        PurchaseHeader.SetRange("No.", Rec."Your Reference");
                        if PurchaseHeader.IsEmpty() then
                            Message('PO Already Exist, PO No. is %1', rec."Your Reference")
                        else
                            PurchaseHeaderHeader();
                    end
                    else
                        PurchaseHeaderHeader();
                end;
            }
        }
        addafter(Invoices)
        {
            //Relate -> Documents -> Purchase Order
            action("Purchase Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order';
                ToolTip = 'Purchase Order';
                Image = PurchaseInvoice;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseOrderPage: Page "Purchase Order";
                begin
                    PurchaseHeader.SetRange("No.", rec."Your Reference");
                    PurchaseOrderPage.SetTableView(PurchaseHeader);
                    PurchaseOrderPage.Run();
                end;
            }
        }
        addafter(Release)
        {
            action("Release-Pick")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category5;
                Image = CreateWarehousePick;
                Caption = 'Release & Pick';
                ToolTip = 'Release & Pick';
                trigger OnAction()
                var
                    ReleasePick: Codeunit "DRL Create Whse. Shipment/Pick";
                begin
                    ReleasePick.CreateWhseShipment_Pick(Rec);
                end;
            }
        }
    }

    //Procedure creates PO Header
    local procedure PurchaseHeaderHeader()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DropShipLocation: Record Location;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchaseOrderPage: Page "Purchase Order";
    begin
        PurchaseHeader.Init();
        if PurchaseHeader."No." = '' then begin
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("Order Nos.");
            NoSeriesManagement.InitSeries(PurchasesPayablesSetup."Order Nos.", xRec."No. Series", 0D, PurchaseHeader."No.", PurchaseHeader."No. Series");
        end;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader.Validate("Posting Date", WorkDate());
        rec.Validate("Your Reference", PurchaseHeader."No.");
        PurchaseHeader.Validate("Payment Reference", rec."No.");
        PurchaseHeader.validate("DRL Customer PO Number", rec."DRL Customer PO Number");
        PurchaseHeader.Validate("DRL Bakeweek", rec."DRL Bakeweek");
        PurchaseHeader.Validate("DRL Bill-to Customer", rec."Bill-to Customer No.");
        PurchaseHeader.Validate("DRL Bill-to Name", rec."Bill-to Name");
        PurchaseHeader.Validate("DRL Bill-to Address", rec."Bill-to Address");
        PurchaseHeader.Validate("DRL Bill-to Address 2", rec."Bill-to Address 2");
        PurchaseHeader.Validate("DRL Bill-to City", rec."Bill-to City");
        PurchaseHeader.Validate("DRL Bill-to State", rec."Bill-to County");
        PurchaseHeader.Validate("DRL Bill-to Zip Code", rec."Bill-to Post Code");
        PurchaseHeader.Validate("DRL Bill-to Country", rec."Bill-to Country/Region Code");
        //The following line of code, checks the location table to see if the "Use for Drop Ship" option is enabled and vendor is selected to create a PO
        DropShipLocation.Get(rec."Location Code");
        if DropShipLocation."DRL Drop Ship" then
            PurchaseHeader.Validate("Buy-from Vendor No.", DropShipLocation."DRL Vendor No.");

        PurchaseHeader.Validate("Sell-to Customer No.", rec."Sell-to Customer No.");
        if rec."Ship-to Code" <> '' then
            PurchaseHeader.Validate("Ship-to Code", rec."Ship-to Code");

        PurchaseHeader.SetShipToAddress(rec."Ship-to Name", rec."Ship-to Name 2", rec."Ship-to Address", rec."Ship-to Address 2", rec."Ship-to City", rec."Ship-to Post Code", rec."Ship-to County", rec."Ship-to Country/Region Code");
        if PurchaseHeader.Insert() then begin
            CreatePurchaseLines(PurchaseHeader);
            PurchaseOrderPage.SetTableView(PurchaseHeader);
            PurchaseOrderPage.Run();
        end;
    end;
    //Procedure creates PO Lines
    local procedure CreatePurchaseLines(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", rec."No.");
        if SalesLine.FindSet() then
            repeat
                PurchaseLine.Init();
                PurchaseLine.Validate("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
                PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                PurchaseLine.Validate("No.", SalesLine."No.");
                PurchaseLine.Validate("Line No.", SalesLine."Line No.");
                PurchaseLine.Validate(Quantity, SalesLine.Quantity);
                PurchaseLine.Validate("Location Code", rec."Location Code");
                PurchaseLine.Insert();
            until SalesLine.Next() = 0;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        ICPartner: Record "IC Partner";
    begin
        if ICPartner.Get('DCC') then begin
            PurchaseHeader.ChangeCompany(ICPartner."Inbox Details");
            PurchaseHeader.SetRange("No.", rec."External Document No.");
            if PurchaseHeader.FindFirst() then begin
                if rec."Bill-to Address" = '' then begin
                    rec.Validate(Rec."DRL Customer PO Number", PurchaseHeader."DRL Customer PO Number");
                    rec.Validate("Bill-to Customer No.", PurchaseHeader."DRL Bill-to Customer");
                    rec.Validate("Bill-to Name", PurchaseHeader."DRL Bill-to Name");
                    rec.Validate("Bill-to Address", PurchaseHeader."DRL Bill-to Address");
                    rec.Validate("Bill-to Address 2", PurchaseHeader."DRL Bill-to Address 2");
                    rec.Validate("Bill-to City", PurchaseHeader."DRL Bill-to City");
                    rec.Validate("Bill-to County", PurchaseHeader."DRL Bill-to State");
                    rec.Validate("Bill-to Post Code", PurchaseHeader."DRL Bill-to Zip Code");
                    rec.Validate("Bill-to Country/Region Code", PurchaseHeader."DRL Bill-to Country");
                    rec.Validate("Bill-to Contact", PurchaseHeader."DRL Bill-to Contact");
                    rec.Modify();
                end;
                rec.Validate("DRL Customer PO Number", PurchaseHeader."DRL Customer PO Number");
                rec.Validate("DRL Bill-to Customer", PurchaseHeader."DRL Bill-to Customer");
                rec.Validate("DRL Bill-to Name", PurchaseHeader."DRL Bill-to Name");
                rec.Validate("DRL Bill-to Address", PurchaseHeader."DRL Bill-to Address");
                rec.Validate("DRL Bill-to Address 2", PurchaseHeader."DRL Bill-to Address 2");
                rec.Validate("DRL Bill-to City", PurchaseHeader."DRL Bill-to City");
                rec.Validate("DRL Bill-to State", PurchaseHeader."DRL Bill-to State");
                rec.Validate("DRL Bill-to Zip Code", PurchaseHeader."DRL Bill-to Zip Code");
                rec.Validate("DRL Bill-to Country", PurchaseHeader."DRL Bill-to Country");
                rec.Validate("DRL Bill-to Contact", PurchaseHeader."DRL Bill-to Contact");
                rec.Modify();
            end;
        end;
    end;

    trigger OnOpenPage()
    var
        PurchaseHeader: Record "Purchase Header";
        ICPartner: Record "IC Partner";
    begin
        if ICPartner.Get('DCC') then begin
            PurchaseHeader.ChangeCompany(ICPartner."Inbox Details");
            PurchaseHeader.SetRange("No.", Rec."External Document No.");
            if PurchaseHeader.FindFirst() then
                if rec.Status <> rec.Status::Released then begin
                    if rec."DRL Customer PO Number" = '' then
                        rec.Validate("DRL Customer PO Number", PurchaseHeader."DRL Customer PO Number");

                    if rec."DRL Bakeweek" = 0 then
                        rec.Validate("DRL Bakeweek", PurchaseHeader."DRL Bakeweek");

                    if rec."Bill-to Address" = '' then begin
                        rec.Validate("Bill-to Customer No.", PurchaseHeader."DRL Bill-to Customer");
                        rec.Validate("Bill-to Name", PurchaseHeader."DRL Bill-to Name");
                        rec.Validate("Bill-to Address", PurchaseHeader."DRL Bill-to Address");
                        rec.Validate("Bill-to Address 2", PurchaseHeader."DRL Bill-to Address 2");
                        rec.Validate("Bill-to City", PurchaseHeader."DRL Bill-to City");
                        rec.Validate("Bill-to County", PurchaseHeader."DRL Bill-to State");
                        rec.Validate("Bill-to Post Code", PurchaseHeader."DRL Bill-to Zip Code");
                        rec.Validate("Bill-to Country/Region Code", PurchaseHeader."DRL Bill-to Country");
                        rec.Validate("Bill-to Contact", PurchaseHeader."DRL Bill-to Contact");
                    end;
                    rec.Validate("DRL Customer PO Number", PurchaseHeader."DRL Customer PO Number");
                    rec.Validate("DRL Bill-to Customer", PurchaseHeader."DRL Bill-to Customer");
                    rec.Validate("DRL Bill-to Name", PurchaseHeader."DRL Bill-to Name");
                    rec.Validate("DRL Bill-to Address", PurchaseHeader."DRL Bill-to Address");
                    rec.Validate("DRL Bill-to Address 2", PurchaseHeader."DRL Bill-to Address 2");
                    rec.Validate("DRL Bill-to City", PurchaseHeader."DRL Bill-to City");
                    rec.Validate("DRL Bill-to State", PurchaseHeader."DRL Bill-to State");
                    rec.Validate("DRL Bill-to Zip Code", PurchaseHeader."DRL Bill-to Zip Code");
                    rec.Validate("DRL Bill-to Country", PurchaseHeader."DRL Bill-to Country");
                    rec.Validate("DRL Bill-to Contact", PurchaseHeader."DRL Bill-to Contact");
                    rec.Modify();
                end;
        end;
    end;
}
