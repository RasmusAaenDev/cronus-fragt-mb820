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
}
