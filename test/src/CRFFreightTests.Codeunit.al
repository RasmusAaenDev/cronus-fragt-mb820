codeunit 50140 "CRF Freight Tests"
{
    // [FEATURE] [Cronus Fragt] [Shipment Tracking]
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
        NewStatus: Enum "CRF Tracking Status";
    begin
        // [SCENARIO] The status text in_transit from Carrier A becomes In Transit
        // [GIVEN] The status text that the carrier service sends for a parcel on its way
        // [WHEN] Cronus Fragt maps the text
        NewStatus := CarrierA.StatusFromText('in_transit');
        // [THEN] The tracking status is In Transit
        Assert.AreEqual("CRF Tracking Status"::"In Transit", NewStatus, 'in_transit must map to In Transit');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure PackageWeightMustBePositive()
    var
        TrackingLine: Record "CRF Shipment Tracking Line";
    begin
        // [SCENARIO] A package can't weigh zero
        // [GIVEN] A new shipment tracking line
        TrackingLine.Init();
        // [WHEN] The weight is set to 0
        asserterror TrackingLine.Validate(Weight, 0);
        // [THEN] The error from the shipment tracking line table is raised
        Assert.AreEqual('The weight of a package must be greater than zero.', GetLastErrorText(), 'Unexpected error message');
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure PostingWithoutNumberSeriesCreatesNoTracking()
    var
        FreightSetup: Record "CRF Freight Setup";
        TrackingHeader: Record "CRF Shipment Tracking Header";
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        // [SCENARIO] Posting a sales shipment must not fail in a company where the freight setup wizard has not been run
        // [GIVEN] A freight setup without a number series for shipment tracking
        if not FreightSetup.Get() then
            FreightSetup.Insert();
        FreightSetup."Shipment Tracking Nos." := '';
        FreightSetup.Modify();
        // [WHEN] The posted sales shipment is handed to Cronus Fragt
        FreightMgt.CreateTrackingFromSalesShipment('10000', 'CRF-TEST-SHPT');
        // [THEN] No error is raised and no shipment tracking record exists for it
        TrackingHeader.SetRange("Sales Shipment No.", 'CRF-TEST-SHPT');
        Assert.RecordIsEmpty(TrackingHeader);
    end;

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure TrackingWithoutShippingAgentHasNoCarrier()
    var
        TrackingHeader: Record "CRF Shipment Tracking Header";
        FreightMgt: Codeunit "CRF Freight Mgt";
        Carrier: Interface "CRF ICarrier";
    begin
        // [SCENARIO] The carrier is found through the shipping agent, so a record without one can't be sent anywhere
        // [GIVEN] A shipment tracking record without a shipping agent
        TrackingHeader.Init();
        TrackingHeader."No." := 'CRF-TEST-NOAGENT';
        // [WHEN] The facade is asked for the carrier
        asserterror Carrier := FreightMgt.GetCarrier(TrackingHeader);
        // [THEN] The error names the record and asks for a shipping agent
        Assert.ExpectedError('Shipment tracking CRF-TEST-NOAGENT has no shipping agent.');
    end;
}
