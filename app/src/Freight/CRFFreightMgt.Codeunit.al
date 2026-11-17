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

    /// <summary>
    /// Creates a shipment for a posted sales shipment, with the customer's address and default carrier.
    /// Does nothing when a shipment for that posted sales shipment already exists, or when the freight setup
    /// has no shipment number series (posting a sales shipment must not fail because freight is not set up).
    /// </summary>
    procedure CreateShipmentFromSalesShipment(CustomerNo: Code[20]; SalesShipmentNo: Code[20])
    var
        ExistingShipment: Record "CRF Shipment Header";
        ShipmentHeader: Record "CRF Shipment Header";
        FreightSetup: Record "CRF Freight Setup";
    begin
        if (CustomerNo = '') or (SalesShipmentNo = '') then
            exit;
        ExistingShipment.SetRange("Sales Shipment No.", SalesShipmentNo);
        if not ExistingShipment.IsEmpty() then
            exit;
        if not FreightSetup.Get() then
            exit;
        if FreightSetup."Shipment Nos." = '' then
            exit;
        ShipmentHeader.Init();
        ShipmentHeader.Insert(true); // OnInsert takes the number from the number series
        ShipmentHeader.Validate("Customer No.", CustomerNo); // ship-to fields and carrier
        ShipmentHeader."Sales Shipment No." := SalesShipmentNo;
        ShipmentHeader.Modify(true);
        LogShipmentCreated(ShipmentHeader);
        OnAfterCreateShipmentFromSalesShipment(ShipmentHeader, SalesShipmentNo);
    end;

    local procedure LogShipmentCreated(ShipmentHeader: Record "CRF Shipment Header")
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        // The number is CustomerContent, so the SystemId is logged instead
        Dimensions.Add('ShipmentSystemId', Format(ShipmentHeader.SystemId));
        Dimensions.Add('Carrier', Format(ShipmentHeader.Carrier));
        Session.LogMessage('CRF-0003', ShipmentCreatedTxt, Verbosity::Normal,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

    /// <summary>
    /// Raised after a shipment was created and saved from a posted sales shipment.
    /// </summary>
    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateShipmentFromSalesShipment(var CRFShipmentHeader: Record "CRF Shipment Header"; SalesShipmentNo: Code[20])
    begin
    end;

    [TryFunction]
    local procedure TryGetStatus(Carrier: Interface "CRF ICarrier"; ShipmentHeader: Record "CRF Shipment Header"; var NewStatus: Enum "CRF Shipment Status")
    begin
        // No database writes in here: they would not be rolled back if the call fails
        NewStatus := Carrier.GetStatus(ShipmentHeader);
    end;

    var
        ShipmentCreatedTxt: Label 'Shipment created from sales shipment', Locked = true;
        UpdateFailedTitleLbl: Label 'The shipment status was not updated';
        UpdateFailedErr: Label 'Cronus Fragt could not get the status of shipment %1 from the carrier. Try again later.', Comment = '%1 = shipment number';
}
