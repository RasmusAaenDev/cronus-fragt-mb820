codeunit 50100 "CRF Freight Mgt"
{
    Access = Public;

    /// <summary>
    /// Returns the carrier implementation of the shipping agent on the shipment tracking record.
    /// Raises an error when the record has no shipping agent.
    /// </summary>
    procedure GetCarrier(TrackingHeader: Record "CRF Shipment Tracking Header") Carrier: Interface "CRF ICarrier"
    var
        ShippingAgent: Record "Shipping Agent";
        NoShippingAgentErr: Label 'Shipment tracking %1 has no shipping agent. Choose a shipping agent on it first.', Comment = '%1 = shipment tracking number';
    begin
        if TrackingHeader."Shipping Agent Code" = '' then
            Error(NoShippingAgentErr, TrackingHeader."No.");
        ShippingAgent.Get(TrackingHeader."Shipping Agent Code");
        Carrier := ShippingAgent."CRF Carrier";
    end;

    /// <summary>
    /// Returns the price of the shipment from the carrier of the shipping agent on the shipment tracking record.
    /// </summary>
    procedure GetRate(var TrackingHeader: Record "CRF Shipment Tracking Header"): Decimal
    var
        Carrier: Interface "CRF ICarrier";
    begin
        Carrier := GetCarrier(TrackingHeader);
        exit(Carrier.GetRate(TrackingHeader));
    end;

    /// <summary>
    /// The carrier of the shipping agent on the record, or blank. Used for telemetry, which must not log the agent code.
    /// </summary>
    internal procedure CarrierOf(TrackingHeader: Record "CRF Shipment Tracking Header"): Enum "CRF Carrier"
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.Get(TrackingHeader."Shipping Agent Code") then
            exit(ShippingAgent."CRF Carrier");
    end;

    /// <summary>
    /// Asks the carrier for the status of the shipment and saves it when it changed.
    /// Raises one error, with the technical details in the detailed message, if the carrier call fails.
    /// </summary>
    procedure UpdateStatus(var TrackingHeader: Record "CRF Shipment Tracking Header")
    var
        UpdateFailedInfo: ErrorInfo;
        ErrorText: Text;
    begin
        if UpdateStatusNoError(TrackingHeader, ErrorText) then
            exit;
        UpdateFailedInfo.Title := UpdateFailedTitleLbl;
        UpdateFailedInfo.Message := StrSubstNo(UpdateFailedErr, TrackingHeader."No.");
        UpdateFailedInfo.DetailedMessage := ErrorText;
        Error(UpdateFailedInfo);
    end;

    /// <summary>
    /// Same as UpdateStatus, but returns false and the error text instead of stopping. Used by the job queue.
    /// </summary>
    procedure UpdateStatusNoError(var TrackingHeader: Record "CRF Shipment Tracking Header"; var ErrorText: Text): Boolean
    var
        NewStatus: Enum "CRF Tracking Status";
    begin
        ErrorText := '';
        if not TryGetStatus(TrackingHeader, NewStatus) then begin
            ErrorText := GetLastErrorText();
            exit(false);
        end;
        // Writes happen only after the carrier call succeeded
        if NewStatus <> TrackingHeader.Status then begin
            TrackingHeader.Validate(Status, NewStatus);
            TrackingHeader.Modify(true);
        end;
        exit(true);
    end;

    /// <summary>
    /// Books an open shipment tracking record. The carrier service has no booking call (see step 20), so nothing is sent
    /// to the carrier: the shipping agent must have a carrier and a matching rate, and the status becomes Booked.
    /// </summary>
    procedure Book(var TrackingHeader: Record "CRF Shipment Tracking Header")
    var
        NotOpenErr: Label 'Shipment tracking %1 cannot be booked because its status is %2.', Comment = '%1 = shipment tracking number, %2 = status';
    begin
        if TrackingHeader.Status <> TrackingHeader.Status::Open then
            Error(NotOpenErr, TrackingHeader."No.", TrackingHeader.Status);
        GetRate(TrackingHeader); // fails without a shipping agent, without a carrier on it or without a matching rate
        TrackingHeader.Validate(Status, TrackingHeader.Status::Booked);
        TrackingHeader.Modify(true);
    end;

    [TryFunction]
    local procedure TryGetStatus(TrackingHeader: Record "CRF Shipment Tracking Header"; var NewStatus: Enum "CRF Tracking Status")
    var
        Carrier: Interface "CRF ICarrier";
    begin
        // No database writes in here: they would not be rolled back if the call fails.
        // Finding the carrier is in here too, because a missing shipping agent is an error like any other.
        Carrier := GetCarrier(TrackingHeader);
        NewStatus := Carrier.GetStatus(TrackingHeader);
    end;

    var
        UpdateFailedTitleLbl: Label 'The tracking status was not updated';
        UpdateFailedErr: Label 'Cronus Fragt could not get the status of shipment tracking %1 from the carrier. Try again later.', Comment = '%1 = shipment tracking number';
}
