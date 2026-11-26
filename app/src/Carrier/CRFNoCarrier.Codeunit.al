codeunit 50106 "CRF No Carrier" implements "CRF ICarrier"
{
    Access = Internal;

    procedure GetRate(TrackingHeader: Record "CRF Shipment Tracking Header"): Decimal
    begin
        Error(NoCarrierErr, TrackingHeader."Shipping Agent Code", TrackingHeader."No.");
    end;

    procedure GetStatus(TrackingHeader: Record "CRF Shipment Tracking Header"): Enum "CRF Tracking Status"
    begin
        Error(NoCarrierErr, TrackingHeader."Shipping Agent Code", TrackingHeader."No.");
    end;

    var
        NoCarrierErr: Label 'Shipping agent %1 on shipment tracking %2 has no carrier. Choose a carrier on the shipping agent first.', Comment = '%1 = shipping agent code, %2 = shipment tracking number';
}
