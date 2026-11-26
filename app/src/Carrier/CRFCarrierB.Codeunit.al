codeunit 50102 "CRF Carrier B" implements "CRF ICarrier"
{
    Access = Internal;

    procedure GetRate(TrackingHeader: Record "CRF Shipment Tracking Header"): Decimal
    var
        TrackingLine: Record "CRF Shipment Tracking Line";
        CarrierRate: Record "CRF Shipping Agent Rate";
        Total: Decimal;
        NoRateErr: Label 'Shipping agent %1 has no rate for a package of %2 kg.', Comment = '%1 = shipping agent code, %2 = package weight';
    begin
        // Carrier B prices every package on its own
        TrackingLine.SetRange("Document No.", TrackingHeader."No.");
        if TrackingLine.FindSet() then
            repeat
                CarrierRate.Reset();
                CarrierRate.SetRange("Shipping Agent Code", TrackingHeader."Shipping Agent Code");
                CarrierRate.SetFilter("Weight Limit", '>=%1', TrackingLine.Weight);
                if not CarrierRate.FindFirst() then
                    Error(NoRateErr, TrackingHeader."Shipping Agent Code", TrackingLine.Weight);
                Total += CarrierRate.Price;
            until TrackingLine.Next() = 0;
        exit(Total);
    end;

    procedure GetStatus(TrackingHeader: Record "CRF Shipment Tracking Header"): Enum "CRF Tracking Status"
    begin
        exit(TrackingHeader.Status);
    end;
}
