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
    begin
        TrackingHeader.SetFilter(Status, '%1|%2', TrackingHeader.Status::Booked, TrackingHeader.Status::"In Transit");
        TrackingHeader.SetFilter("Package Tracking No.", '<>%1', '');
        if TrackingHeader.FindSet() then
            repeat
                // A second variable is updated, so the filtered set that is looped through is not changed
                TrackingToUpdate.Get(TrackingHeader."No.");
                if not FreightMgt.UpdateStatusNoError(TrackingToUpdate, ErrorText) then
                    LogFailure(TrackingToUpdate);
            until TrackingHeader.Next() = 0;
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

    var
        FailureTelemetryTxt: Label 'Tracking status update from the carrier failed', Locked = true;
}
