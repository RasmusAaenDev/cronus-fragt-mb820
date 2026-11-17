page 50108 "CRF Freight Activities"
{
    Caption = 'Freight';
    PageType = CardPart;
    SourceTable = "CRF Freight Cue";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            cuegroup(Shipments)
            {
                Caption = 'Shipments';

                field("Open Shipments"; Rec."Open Shipments")
                {
                    DrillDownPageId = "CRF Shipment List";
                    ToolTip = 'Specifies the number of shipments that are still open.';
                }
                field("Open Default Carrier"; Rec."Open Default Carrier")
                {
                    ToolTip = 'Specifies the number of open shipments that go with the default carrier of the freight setup.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AllShipments)
            {
                ApplicationArea = All;
                Caption = 'All Shipments';
                ToolTip = 'Opens the list of all shipments.';
                RunObject = page "CRF Shipment List";
                Image = List;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    var
        FreightSetup: Record "CRF Freight Setup";
        ShipmentsByCarrier: Query "CRF Shipments by Carrier";
    begin
        Rec."Open Default Carrier" := 0;
        if not FreightSetup.Get() then
            exit;
        ShipmentsByCarrier.SetRange(Status, "CRF Shipment Status"::Open);
        ShipmentsByCarrier.SetRange(Carrier, FreightSetup."Default Carrier");
        ShipmentsByCarrier.Open();
        if ShipmentsByCarrier.Read() then
            Rec."Open Default Carrier" := ShipmentsByCarrier.NoOfShipments;
        ShipmentsByCarrier.Close();
    end;
}
