interface "CRF ICarrier"
{
    /// <summary>
    /// Returns the price the carrier charges for the shipment.
    /// </summary>
    procedure GetRate(ShipmentHeader: Record "CRF Shipment Header"): Decimal;

    /// <summary>
    /// Returns the current status of the shipment, as the carrier sees it.
    /// </summary>
    procedure GetStatus(ShipmentHeader: Record "CRF Shipment Header"): Enum "CRF Shipment Status";
}
