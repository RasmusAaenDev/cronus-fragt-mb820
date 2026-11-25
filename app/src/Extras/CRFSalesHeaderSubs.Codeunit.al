codeunit 50111 "CRF Sales Header Subs"
{
    // runs on every sales order: salespeople don't have the CRF Freight Basic permission set
    InherentEntitlements = X;
    InherentPermissions = X;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    [InherentPermissions(PermissionObjectType::TableData, Database::"CRF Freight Setup", 'r')]
    local procedure SetCarrierOnAfterValidateSellToCustomerNo(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        FreightSetup: Record "CRF Freight Setup";
    begin
        if Rec.IsTemporary() then
            exit;
        if Customer.Get(Rec."Sell-to Customer No.") then
            Rec."CRF Carrier" := Customer."CRF Default Carrier";
        if (Rec."CRF Carrier" = Rec."CRF Carrier"::" ") and FreightSetup.Get() then
            Rec."CRF Carrier" := FreightSetup."Default Carrier";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRF Freight Mgt", 'OnAfterCreateShipmentFromSalesShipment', '', false, false)]
    [InherentPermissions(PermissionObjectType::TableData, Database::"CRF Shipment Header", 'm')]
    local procedure SetFreightIdOnAfterCreateShipment(var CRFShipmentHeader: Record "CRF Shipment Header"; SalesShipmentNo: Code[20])
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
    begin
        if not SalesShipmentHeader.Get(SalesShipmentNo) then
            exit;
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, SalesShipmentHeader."Order No.") then
            exit; // the order is gone when it was shipped and invoiced in full
        if SalesHeader."CRF Carrier" <> SalesHeader."CRF Carrier"::" " then begin
            CRFShipmentHeader.Carrier := SalesHeader."CRF Carrier"; // the carrier on the order wins
            CRFShipmentHeader.Modify(true);
        end;
        SalesHeader."CRF Freight ID" := CRFShipmentHeader."No.";
        SalesHeader.Modify();
    end;
}
