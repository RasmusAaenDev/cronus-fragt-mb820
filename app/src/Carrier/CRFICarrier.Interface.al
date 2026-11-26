interface "CRF ICarrier"
{
    /// <summary>
    /// Returns the price the carrier charges for the shipment tracking record.
    /// </summary>
    procedure GetRate(TrackingHeader: Record "CRF Shipment Tracking Header"): Decimal;

    /// <summary>
    /// Returns the current status of the shipment, as the carrier sees it.
    /// </summary>
    procedure GetStatus(TrackingHeader: Record "CRF Shipment Tracking Header"): Enum "CRF Tracking Status";
}
