codeunit 50103 "CRF Update Status"
{
    Access = Internal;

    // Run by a job queue entry (step 29) in a background session: no dialogs in here.
    trigger OnRun()
    var
        ShipmentHeader: Record "CRF Shipment Header";
        ShipmentToUpdate: Record "CRF Shipment Header";
        FreightMgt: Codeunit "CRF Freight Mgt";
        ErrorText: Text;
        Succeeded: Integer;
        Failed: Integer;
    begin
        ShipmentHeader.SetFilter(Status, '%1|%2', ShipmentHeader.Status::Booked, ShipmentHeader.Status::"In Transit");
        ShipmentHeader.SetFilter("Tracking No.", '<>%1', '');
        if ShipmentHeader.FindSet() then
            repeat
                // A second variable is updated, so the filtered set that is looped through is not changed
                ShipmentToUpdate.Get(ShipmentHeader."No.");
                if FreightMgt.UpdateStatusNoError(ShipmentToUpdate, ErrorText) then
                    Succeeded += 1
                else begin
                    Failed += 1;
                    LogFailure(ShipmentToUpdate);
                end;
            until ShipmentHeader.Next() = 0;
        LogRoundFinished(Succeeded, Failed);
    end;

    local procedure LogFailure(ShipmentHeader: Record "CRF Shipment Header")
    var
        Dimensions: Dictionary of [Text, Text];
    begin
        // The number is CustomerContent, so the SystemId is logged instead; the error text is left out on purpose
        Dimensions.Add('ShipmentSystemId', Format(ShipmentHeader.SystemId));
        Dimensions.Add('Carrier', Format(ShipmentHeader.Carrier));
        Session.LogMessage('CRF-0002', FailureTelemetryTxt, Verbosity::Warning,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

    local procedure LogRoundFinished(Succeeded: Integer; Failed: Integer)
    var
        Dimensions: Dictionary of [Text, Text];
        RoundVerbosity: Verbosity;
    begin
        // Counts only: no customer data
        Dimensions.Add('Succeeded', Format(Succeeded, 0, 9));
        Dimensions.Add('Failed', Format(Failed, 0, 9));
        RoundVerbosity := Verbosity::Normal;
        if Failed > 0 then
            RoundVerbosity := Verbosity::Warning;
        Session.LogMessage('CRF-0004', RoundFinishedTxt, RoundVerbosity,
            DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, Dimensions);
    end;

    var
        RoundFinishedTxt: Label 'Shipment status round finished', Locked = true;
        FailureTelemetryTxt: Label 'Shipment status update from the carrier failed', Locked = true;
}
