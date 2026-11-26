codeunit 50109 "CRF Upgrade"
{
    Access = Internal;
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
        UpgradeTags: Codeunit "CRF Upgrade Tags";
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTags.GetDefaultShippingAgentTag()) then
            exit;
        FillDefaultShippingAgentFromTracking();
        UpgradeTag.SetUpgradeTag(UpgradeTags.GetDefaultShippingAgentTag());
    end;

    // A setup without a default shipping agent gets the shipping agent of the latest shipment tracking record (highest number).
    local procedure FillDefaultShippingAgentFromTracking()
    var
        FreightSetup: Record "CRF Freight Setup";
        TrackingHeader: Record "CRF Shipment Tracking Header";
    begin
        if not FreightSetup.Get() then
            exit;
        if FreightSetup."Default Shipping Agent Code" <> '' then
            exit;
        TrackingHeader.SetFilter("Shipping Agent Code", '<>%1', '');
        if TrackingHeader.FindLast() then begin
            FreightSetup."Default Shipping Agent Code" := TrackingHeader."Shipping Agent Code";
            FreightSetup.Modify();
        end;
    end;
}
