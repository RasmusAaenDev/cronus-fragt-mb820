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
    var
        ShippingAgent: Record "Shipping Agent";
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseText: Text;
        Body: JsonObject;
        StatusToken: JsonToken;
        ServiceStatusErr: Label 'The carrier service answered %1 %2.', Comment = '%1 = HTTP status code, %2 = reason phrase';
        InvalidResponseErr: Label 'The carrier service sent an answer that Cronus Fragt cannot read.';
    begin
        // The shipping agent is read before the call; nothing is written while waiting for the service
        ShippingAgent.Get(TrackingHeader."Shipping Agent Code");
        ShippingAgent.TestField("CRF API Base URL");
        TrackingHeader.TestField("Package Tracking No.");
        Client.Timeout := 30000; // milliseconds
        SendWithRetry(Client, StatusUrl(ShippingAgent."CRF API Base URL", TrackingHeader."Package Tracking No."), Response);
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
        // GET {API Base URL}/shipments/{Package Tracking No.}/status
        exit(BaseUrl.TrimEnd('/') + '/shipments/' + TrackingNo + '/status');
    end;

    local procedure SendWithRetry(var Client: HttpClient; Url: Text; var Response: HttpResponseMessage)
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
            // Step 21 adds the API key header here
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

    local procedure StatusFromText(StatusText: Text): Enum "CRF Tracking Status"
    var
        UnknownStatusErr: Label 'The carrier service reported the unknown status %1.', Comment = '%1 = status text';
    begin
        case LowerCase(StatusText) of
            'booked':
                exit("CRF Tracking Status"::Booked);
            'in_transit':
                exit("CRF Tracking Status"::"In Transit");
            'delivered':
                exit("CRF Tracking Status"::Delivered);
            else
                Error(UnknownStatusErr, StatusText);
        end;
    end;
}
