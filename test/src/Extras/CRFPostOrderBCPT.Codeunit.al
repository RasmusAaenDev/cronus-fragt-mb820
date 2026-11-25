codeunit 50141 "CRF Post Order BCPT"
{
    // Performance scenario: a sales order is created and shipped, which makes Cronus Fragt create a shipment
    SingleInstance = true;

    trigger OnRun()
    begin
        if not IsInitialized then begin
            InitTest();
            IsInitialized := true;
        end;
        CreateAndShipOrder();
    end;

    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        IsInitialized: Boolean;
        CustomerNo: Code[20];
        ItemNo: Code[20];

    local procedure InitTest()
    var
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";
        LibraryUtility: Codeunit "Library - Utility";
        FreightSetup: Record "CRF Freight Setup";
        Customer: Record Customer;
        Item: Record Item;
    begin
        // Cronus Fragt only creates shipments when the setup has a number series
        if not FreightSetup.Get() then
            FreightSetup.Insert();
        FreightSetup."Shipment Nos." := LibraryUtility.GetGlobalNoSeriesCode();
        FreightSetup.Modify();
        LibrarySales.CreateCustomer(Customer);
        Customer."CRF Default Carrier" := Customer."CRF Default Carrier"::"Carrier A";
        Customer.Modify();
        CustomerNo := Customer."No.";
        LibraryInventory.CreateItem(Item);
        ItemNo := Item."No.";
        Commit();
    end;

    local procedure CreateAndShipOrder()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
    begin
        BCPTTestContext.StartScenario('Create order');
        LibrarySales.CreateSalesHeader(SalesHeader, SalesHeader."Document Type"::Order, CustomerNo);
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, SalesLine.Type::Item, ItemNo, 1);
        BCPTTestContext.EndScenario('Create order');
        BCPTTestContext.UserWait();

        BCPTTestContext.StartScenario('Ship order');
        LibrarySales.PostSalesDocument(SalesHeader, true, false); // ship, don't invoice: creates the CRF shipment
        BCPTTestContext.EndScenario('Ship order');
        BCPTTestContext.UserWait();
    end;
}
