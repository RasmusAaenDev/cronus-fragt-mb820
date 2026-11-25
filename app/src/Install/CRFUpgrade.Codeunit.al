codeunit 50109 "CRF Upgrade"
{
    Access = Internal;
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
        UpgradeTags: Codeunit "CRF Upgrade Tags";
    begin
        if not UpgradeTag.HasUpgradeTag(UpgradeTags.GetDefaultCarrierTag()) then begin
            FillDefaultCarrierFromShipments();
            UpgradeTag.SetUpgradeTag(UpgradeTags.GetDefaultCarrierTag());
        end;
        // Extra (course): a second upgrade step with its own tag, using DataTransfer
        if not UpgradeTag.HasUpgradeTag(UpgradeTags.GetOrderCarrierTag()) then begin
            CopyCarrierToOpenOrders();
            UpgradeTag.SetUpgradeTag(UpgradeTags.GetOrderCarrierTag());
        end;
    end;

    local procedure CopyCarrierToOpenOrders()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        CarrierTransfer: DataTransfer;
    begin
        // "CRF Carrier" is new on the sales header: open orders get their customer's default carrier
        CarrierTransfer.SetTables(Database::Customer, Database::"Sales Header");
        CarrierTransfer.AddJoin(Customer.FieldNo("No."), SalesHeader.FieldNo("Sell-to Customer No."));
        CarrierTransfer.AddDestinationFilter(SalesHeader.FieldNo("Document Type"), '=%1', SalesHeader."Document Type"::Order);
        CarrierTransfer.AddFieldValue(Customer.FieldNo("CRF Default Carrier"), SalesHeader.FieldNo("CRF Carrier"));
        CarrierTransfer.CopyFields();
    end;

    // Customers without a default carrier get the carrier of their latest shipment (highest number).
    local procedure FillDefaultCarrierFromShipments()
    var
        Customer: Record Customer;
        ShipmentHeader: Record "CRF Shipment Header";
    begin
        Customer.SetRange("CRF Default Carrier", Customer."CRF Default Carrier"::" ");
        if Customer.FindSet(true) then
            repeat
                ShipmentHeader.SetRange("Customer No.", Customer."No.");
                ShipmentHeader.SetFilter(Carrier, '<>%1', ShipmentHeader.Carrier::" ");
                if ShipmentHeader.FindLast() then begin
                    Customer."CRF Default Carrier" := ShipmentHeader.Carrier;
                    Customer.Modify();
                end;
            until Customer.Next() = 0;
    end;
}
