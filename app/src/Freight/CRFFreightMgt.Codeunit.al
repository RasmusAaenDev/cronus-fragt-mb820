codeunit 50100 "CRF Freight Mgt"
{
    Access = Public;

    /// <summary>
    /// Returns the price of the shipment from the carrier on the shipment.
    /// </summary>
    procedure GetRate(var ShipmentHeader: Record "CRF Shipment Header"): Decimal
    var
        Carrier: Interface "CRF ICarrier";
    begin
        Carrier := ShipmentHeader.Carrier;
        exit(Carrier.GetRate(ShipmentHeader));
    end;

    /// <summary>
    /// Asks the carrier for the status of the shipment and saves it when it changed.
    /// Raises one error, with the technical details in the detailed message, if the carrier call fails.
    /// </summary>
    procedure UpdateStatus(var ShipmentHeader: Record "CRF Shipment Header")
    var
        UpdateFailedInfo: ErrorInfo;
        ErrorText: Text;
    begin
        if UpdateStatusNoError(ShipmentHeader, ErrorText) then
            exit;
        UpdateFailedInfo.Title := UpdateFailedTitleLbl;
        UpdateFailedInfo.Message := StrSubstNo(UpdateFailedErr, ShipmentHeader."No.");
        UpdateFailedInfo.DetailedMessage := ErrorText;
        Error(UpdateFailedInfo);
    end;

    /// <summary>
    /// Same as UpdateStatus, but returns false and the error text instead of stopping. Used by the job queue.
    /// </summary>
    procedure UpdateStatusNoError(var ShipmentHeader: Record "CRF Shipment Header"; var ErrorText: Text): Boolean
    var
        Carrier: Interface "CRF ICarrier";
        NewStatus: Enum "CRF Shipment Status";
    begin
        ErrorText := '';
        Carrier := ShipmentHeader.Carrier;
        if not TryGetStatus(Carrier, ShipmentHeader, NewStatus) then begin
            ErrorText := GetLastErrorText();
            exit(false);
        end;
        // Writes happen only after the carrier call succeeded
        if NewStatus <> ShipmentHeader.Status then begin
            ShipmentHeader.Validate(Status, NewStatus);
            ShipmentHeader.Modify(true);
        end;
        exit(true);
    end;

    /// <summary>
    /// Books an open shipment. The carrier service has no booking call (see step 19), so nothing is sent to the carrier:
    /// the shipment must have a carrier and a matching rate, and its status becomes Booked.
    /// </summary>
    procedure BookShipment(var ShipmentHeader: Record "CRF Shipment Header")
    var
        NotOpenErr: Label 'Shipment %1 cannot be booked because its status is %2.', Comment = '%1 = shipment number, %2 = status';
    begin
        if ShipmentHeader.Status <> ShipmentHeader.Status::Open then
            Error(NotOpenErr, ShipmentHeader."No.", ShipmentHeader.Status);
        GetRate(ShipmentHeader); // fails for a shipment without a carrier or without a matching rate
        ShipmentHeader.Validate(Status, ShipmentHeader.Status::Booked);
        ShipmentHeader.Modify(true);
    end;

    [TryFunction]
    local procedure TryGetStatus(Carrier: Interface "CRF ICarrier"; ShipmentHeader: Record "CRF Shipment Header"; var NewStatus: Enum "CRF Shipment Status")
    begin
        // No database writes in here: they would not be rolled back if the call fails
        NewStatus := Carrier.GetStatus(ShipmentHeader);
    end;

    var
        UpdateFailedTitleLbl: Label 'The shipment status was not updated';
        UpdateFailedErr: Label 'Cronus Fragt could not get the status of shipment %1 from the carrier. Try again later.', Comment = '%1 = shipment number';
}
