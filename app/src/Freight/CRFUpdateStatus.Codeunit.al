codeunit 50103 "CRF Update Status"
{
    Access = Internal;

    // Run by a job queue entry (step 29) in a background session: no dialogs in here.
    trigger OnRun()
    var
        TrackingHeader: Record "CRF Shipment Tracking Header";
        TrackingToUpdate: Record "CRF Shipment Tracking Header";
        FreightMgt: Codeunit "CRF Freight Mgt";
        ErrorText: Text;
        Succeeded: Integer;
        Failed: Integer;
    begin
        TrackingHeader.SetFilter(Status, '%1|%2', TrackingHeader.Status::Booked, TrackingHeader.Status::"In Transit");
        TrackingHeader.SetFilter("Package Tracking No.", '<>%1', '');
        if TrackingHeader.FindSet() then
            repeat
                // A second variable is updated, so the filtered set that is looped through is not changed
                TrackingToUpdate.Get(TrackingHeader."No.");
                if FreightMgt.UpdateStatusNoError(TrackingToUpdate, ErrorText) then
                    Succeeded += 1
                else begin
                    Failed += 1;
                    LogFailure(TrackingToUpdate);
                end;
            until TrackingHeader.Next() = 0;
        LogRoundFinished(Succeeded, Failed);
    end;

    local procedure LogFailure(TrackingHeader: Record "CRF Shipment Tracking Header")
    var
        FreightMgt: Codeunit "CRF Freight Mgt";
        Dimensions: Dictionary of [Text, Text];
    begin
        // The number is CustomerContent, so the SystemId is logged instead; the error text is left out on purpose
        Dimensions.Add('TrackingSystemId', Format(TrackingHeader.SystemId));
        Dimensions.Add('Carrier', Format(FreightMgt.CarrierOf(TrackingHeader)));
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
        RoundFinishedTxt: Label 'Tracking status round finished', Locked = true;
        FailureTelemetryTxt: Label 'Tracking status update from the carrier failed', Locked = true;
}
