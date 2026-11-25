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
    var
        FreightSetup: Record "CRF Freight Setup";
        Client: HttpClient;
        Response: HttpResponseMessage;
        ApiKey: SecretText;
        ResponseText: Text;
        Body: JsonObject;
        StatusToken: JsonToken;
        ServiceStatusErr: Label 'The carrier service answered %1 %2.', Comment = '%1 = HTTP status code, %2 = reason phrase';
        InvalidResponseErr: Label 'The carrier service sent an answer that Cronus Fragt cannot read.';
        MissingApiKeyErr: Label 'No API key for the carrier service is stored. Enter it on the Cronus Freight Setup page.';
    begin
        // Setup is read before the call; nothing is written while waiting for the service
        FreightSetup.Get();
        FreightSetup.TestField("API Base URL");
        ShipmentHeader.TestField("Tracking No.");
        if not FreightSetup.HasApiKey() then
            Error(MissingApiKeyErr);
        ApiKey := FreightSetup.GetApiKey();
        Client.Timeout := 30000; // milliseconds
        SendWithRetry(Client, StatusUrl(FreightSetup."API Base URL", ShipmentHeader."Tracking No."), ApiKey, Response);
        if not Response.IsSuccessStatusCode() then
            Error(ServiceStatusErr, Response.HttpStatusCode(), Response.ReasonPhrase());
        Response.Content().ReadAs(ResponseText);
        if not Body.ReadFrom(ResponseText) then
            Error(InvalidResponseErr);
        if not Body.Get('status', StatusToken) then
            Error(InvalidResponseErr);
        if not StatusToken.IsValue() then
            Error(InvalidResponseErr);
        exit(StatusFromText(StatusToken.AsValue().AsText()));
    end;

    local procedure StatusUrl(BaseUrl: Text; TrackingNo: Text): Text
    begin
        // GET {API Base URL}/shipments/{Tracking No.}/status
        exit(BaseUrl.TrimEnd('/') + '/shipments/' + TrackingNo + '/status');
    end;

    local procedure SendWithRetry(var Client: HttpClient; Url: Text; ApiKey: SecretText; var Response: HttpResponseMessage)
    var
        Request: HttpRequestMessage;
        Headers: HttpHeaders;
        Attempt: Integer;
        Sent: Boolean;
        ServiceUnreachableErr: Label 'The carrier service could not be reached.';
    begin
        for Attempt := 1 to MaxAttempts() do begin
            Clear(Request);
            Request.Method('GET');
            Request.SetRequestUri(Url);
            Request.GetHeaders(Headers);
            Headers.Add('Accept', 'application/json');
            Headers.Add('X-Api-Key', ApiKey);
            Sent := Client.Send(Request, Response);
            if Sent then
                if not IsTransient(Response.HttpStatusCode()) then
                    exit;
            if Attempt < MaxAttempts() then
                Sleep(2000 * Attempt);
        end;
        if not Sent then begin
            LogUnreachable();
            Error(ServiceUnreachableErr);
        end;
    end;

    local procedure MaxAttempts(): Integer
    begin
        exit(3);
    end;

    local procedure IsTransient(StatusCode: Integer): Boolean
    begin
        exit(StatusCode in [429, 502, 503, 504]);
    end;

    local procedure LogUnreachable()
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        Dimensions.Add('Carrier', Format("CRF Carrier"::"Carrier A"));
        Session.LogMessage('CRF-0001', 'The carrier service could not be reached', Verbosity::Warning,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

    // Extra (course): the body a booking call would send, as a JSON exercise (the carrier service has no booking call)
    internal procedure BuildBookingRequest(ShipmentHeader: Record "CRF Shipment Header") Request: JsonObject
    var
        ShipmentLine: Record "CRF Shipment Line";
        Packages: JsonArray;
        Package: JsonObject;
    begin
        Request.Add('reference', ShipmentHeader."No.");
        Request.Add('name', ShipmentHeader."Ship-to Name");
        Request.Add('address', ShipmentHeader."Ship-to Address");
        Request.Add('postCode', ShipmentHeader."Ship-to Post Code");
        Request.Add('city', ShipmentHeader."Ship-to City");
        ShipmentLine.SetRange("Shipment No.", ShipmentHeader."No.");
        if ShipmentLine.FindSet() then
            repeat
                Clear(Package);
                Package.Add('description', ShipmentLine.Description);
                Package.Add('weightKg', ShipmentLine.Weight);
                Package.Add('lengthCm', ShipmentLine.Length);
                Package.Add('widthCm', ShipmentLine.Width);
                Package.Add('heightCm', ShipmentLine.Height);
                Packages.Add(Package);
            until ShipmentLine.Next() = 0;
        Request.Add('packages', Packages);
    end;

    internal procedure StatusFromText(StatusText: Text): Enum "CRF Shipment Status"
    var
        UnknownStatusErr: Label 'The carrier service reported the unknown status %1.', Comment = '%1 = status text';
    begin
        case LowerCase(StatusText) of
            'booked':
                exit("CRF Shipment Status"::Booked);
            'in_transit':
                exit("CRF Shipment Status"::"In Transit");
            'delivered':
                exit("CRF Shipment Status"::Delivered);
            else
                Error(UnknownStatusErr, StatusText);
        end;
    end;
}
