page 50110 "CRF Freight Coordinator RC"
{
    PageType = RoleCenter;
    Caption = 'Freight Coordinator';
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(Activities; "CRF Freight Activities") { }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(Shipments)
            {
                Caption = 'Shipments';
                ToolTip = 'Opens the list of shipments.';
                RunObject = page "CRF Shipment List";
            }
            action(CarrierRates)
            {
                Caption = 'Carrier Rates';
                ToolTip = 'Opens the rates of the carriers.';
                RunObject = page "CRF Carrier Rates";
            }
            action(Customers)
            {
                Caption = 'Customers';
                ToolTip = 'Opens the list of customers.';
                RunObject = page "Customer List";
            }
        }
        area(Creation)
        {
            action(NewShipment)
            {
                Caption = 'Shipment';
                ToolTip = 'Creates a shipment by hand.';
                RunObject = page "CRF Shipment Card";
                RunPageMode = Create;
            }
        }
        area(Processing)
        {
            action(FreightSetup)
            {
                Caption = 'Freight Setup';
                ToolTip = 'Opens the freight setup.';
                Image = Setup;
                RunObject = page "CRF Freight Setup";
            }
        }
    }
}
