codeunit 50140 "CRF Freight Tests"
{
    // [FEATURE] [Cronus Fragt] [Shipment]
    Subtype = Test;
    // Disabled: the tests run as SUPER. They test business rules, not permissions (see docs/steps/30-tests.md).
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure CarrierStatusInTransitMapsToInTransit()
    var
        CarrierA: Codeunit "CRF Carrier A";
        NewStatus: Enum "CRF Shipment Status";
    begin
        // [SCENARIO] The status text in_transit from Carrier A becomes In Transit
        // [GIVEN] The status text that the carrier service sends for a parcel on its way
        // [WHEN] Cronus Fragt maps the text
        NewStatus := CarrierA.StatusFromText('in_transit');
        // [THEN] The shipment status is In Transit
        Assert.AreEqual("CRF Shipment Status"::"In Transit", NewStatus, 'in_transit must map to In Transit');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure PackageWeightMustBePositive()
    var
        ShipmentLine: Record "CRF Shipment Line";
    begin
        // [SCENARIO] A package can't weigh zero
        // [GIVEN] A new shipment line
        ShipmentLine.Init();
        // [WHEN] The weight is set to 0
        asserterror ShipmentLine.Validate(Weight, 0);
        // [THEN] The error from the shipment line table is raised
        Assert.AreEqual('The weight of a package must be greater than zero.', GetLastErrorText(), 'Unexpected error message');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure PostingWithoutShipmentNumberSeriesCreatesNoShipment()
    var
        FreightSetup: Record "CRF Freight Setup";
        ShipmentHeader: Record "CRF Shipment Header";
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        // [SCENARIO] Posting a sales shipment must not fail in a company where the freight setup guide has not been run
        // [GIVEN] A freight setup without a shipment number series
        if not FreightSetup.Get() then
            FreightSetup.Insert();
        FreightSetup."Shipment Nos." := '';
        FreightSetup.Modify();
        // [WHEN] The posted sales shipment is handed to Cronus Fragt
        FreightMgt.CreateShipmentFromSalesShipment('10000', 'CRF-TEST-SHPT');
        // [THEN] No error is raised and no shipment exists for it
        ShipmentHeader.SetRange("Sales Shipment No.", 'CRF-TEST-SHPT');
        Assert.RecordIsEmpty(ShipmentHeader);
    end;
}
