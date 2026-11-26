codeunit 50101 "CRF Carrier A" implements "CRF ICarrier"
{
    Access = Internal;

    procedure GetRate(TrackingHeader: Record "CRF Shipment Tracking Header"): Decimal
    var
        CarrierRate: Record "CRF Shipping Agent Rate";
        NoRateErr: Label 'Shipping agent %1 has no rate for a shipment of %2 kg.', Comment = '%1 = shipping agent code, %2 = total weight';
    begin
        // Carrier A prices the shipment as a whole, by its total weight
        TrackingHeader.CalcFields("Total Weight");
        CarrierRate.SetRange("Shipping Agent Code", TrackingHeader."Shipping Agent Code");
        CarrierRate.SetFilter("Weight Limit", '>=%1', TrackingHeader."Total Weight");
        if not CarrierRate.FindFirst() then
            Error(NoRateErr, TrackingHeader."Shipping Agent Code", TrackingHeader."Total Weight");
        exit(CarrierRate.Price);
    end;

    procedure GetStatus(TrackingHeader: Record "CRF Shipment Tracking Header"): Enum "CRF Tracking Status"
    begin
        // Placeholder: step 20 asks the carrier's service instead
        exit(TrackingHeader.Status);
    end;
}
