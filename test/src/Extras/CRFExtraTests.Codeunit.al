codeunit 50142 "CRF Extra Tests"
{
    // Tests for the course extras (not part of the workbook solution)
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    [TransactionModel(TransactionModel::AutoRollback)]
    procedure BookingRequestHasOnePackagePerLine()
    var
        ShipmentHeader: Record "CRF Shipment Header";
        ShipmentLine: Record "CRF Shipment Line";
        CarrierA: Codeunit "CRF Carrier A";
        Request: JsonObject;
        PackagesToken: JsonToken;
    begin
        // [SCENARIO] The booking request for Carrier A lists every package of the shipment
        // [GIVEN] A shipment with two packages
        ShipmentHeader."No." := 'CRF-TEST';
        ShipmentHeader."Ship-to City" := 'Aarhus';
        ShipmentHeader.Insert(false);
        ShipmentLine."Shipment No." := ShipmentHeader."No.";
        ShipmentLine."Line No." := 10000;
        ShipmentLine.Weight := 4.5;
        ShipmentLine.Insert(false);
        ShipmentLine."Line No." := 20000;
        ShipmentLine.Weight := 12;
        ShipmentLine.Insert(false);
        // [WHEN] The request is built
        Request := CarrierA.BuildBookingRequest(ShipmentHeader);
        // [THEN] It has the city and an array with two packages
        Request.Get('packages', PackagesToken);
        Assert.AreEqual(2, PackagesToken.AsArray().Count(), 'One package per shipment line');
        Assert.IsTrue(Request.Contains('city'), 'The request must contain the city');
    end;
}
