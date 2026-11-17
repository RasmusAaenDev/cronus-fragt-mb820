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
    begin
        ShipmentHeader.SetFilter(Status, '%1|%2', ShipmentHeader.Status::Booked, ShipmentHeader.Status::"In Transit");
        ShipmentHeader.SetFilter("Tracking No.", '<>%1', '');
        if ShipmentHeader.FindSet() then
            repeat
                // A second variable is updated, so the filtered set that is looped through is not changed
                ShipmentToUpdate.Get(ShipmentHeader."No.");
                if not FreightMgt.UpdateStatusNoError(ShipmentToUpdate, ErrorText) then
                    LogFailure(ShipmentToUpdate);
            until ShipmentHeader.Next() = 0;
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

    var
        FailureTelemetryTxt: Label 'Shipment status update from the carrier failed', Locked = true;
}
