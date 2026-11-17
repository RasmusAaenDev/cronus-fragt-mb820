codeunit 50101 "CRF Carrier A" implements "CRF ICarrier"
{
    Access = Internal;

    procedure GetRate(ShipmentHeader: Record "CRF Shipment Header"): Decimal
    var
        CarrierRate: Record "CRF Carrier Rate";
        NoRateErr: Label 'Carrier A has no rate for a shipment of %1 kg.', Comment = '%1 = total weight';
    begin
        // Carrier A prices the shipment as a whole, by its total weight
        ShipmentHeader.CalcFields("Total Weight");
        CarrierRate.SetRange(Carrier, "CRF Carrier"::"Carrier A");
        CarrierRate.SetFilter("Weight Limit", '>=%1', ShipmentHeader."Total Weight");
        if not CarrierRate.FindFirst() then
            Error(NoRateErr, ShipmentHeader."Total Weight");
        exit(CarrierRate.Price);
    end;

    procedure GetStatus(ShipmentHeader: Record "CRF Shipment Header"): Enum "CRF Shipment Status"
    begin
        // Placeholder: step 19 asks the carrier's service instead
        exit(ShipmentHeader.Status);
    end;
}
