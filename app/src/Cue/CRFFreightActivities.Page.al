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
            cuegroup(Tracking)
            {
                Caption = 'Shipment Tracking';

                field("Open Shipments"; Rec."Open Shipments")
                {
                    DrillDownPageId = "CRF Shipment Tracking List";
                    ToolTip = 'Specifies the number of shipment tracking records that are still open.';
                }
                field("Open Default Agent"; Rec."Open Default Agent")
                {
                    ToolTip = 'Specifies the number of open shipment tracking records that go with the default shipping agent of the freight setup.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(AllTracking)
            {
                ApplicationArea = All;
                Caption = 'All Shipment Tracking';
                ToolTip = 'Opens the list of all shipment tracking records.';
                RunObject = page "CRF Shipment Tracking List";
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
        TrackingByAgent: Query "CRF Tracking by Shipping Agent";
    begin
        Rec."Open Default Agent" := 0;
        if not FreightSetup.Get() then
            exit;
        TrackingByAgent.SetRange(Status, "CRF Tracking Status"::Open);
        TrackingByAgent.SetRange(ShippingAgentCode, FreightSetup."Default Shipping Agent Code");
        TrackingByAgent.Open();
        if TrackingByAgent.Read() then
            Rec."Open Default Agent" := TrackingByAgent.NoOfShipments;
        TrackingByAgent.Close();
    end;
}
