page 50100 "CRF Freight Setup"
{
    Caption = 'Cronus Freight Setup';
    PageType = Card;
    SourceTable = "CRF Freight Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    AdditionalSearchTerms = 'carrier, shipping agent, freight, shipment tracking';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Default Shipping Agent Code"; Rec."Default Shipping Agent Code")
                {
                    ToolTip = 'Specifies the shipping agent that new shipment tracking records get when the customer has no shipping agent of its own.';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Shipment Tracking Nos."; Rec."Shipment Tracking Nos.")
                {
                    ToolTip = 'Specifies the number series that is used to number new shipment tracking records.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(ShippingAgents)
            {
                Caption = 'Shipping Agents';
                ToolTip = 'Opens the shipping agents, where you choose the carrier, the API address and the API key of each one.';
                Image = Delivery;
                RunObject = page "Shipping Agents";
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
}
