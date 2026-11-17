page 50101 "CRF Shipment List"
{
    Caption = 'Shipments';
    PageType = List;
    SourceTable = "CRF Shipment Header";
    CardPageId = "CRF Shipment Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Shipments)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the shipment.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer that the shipment goes to.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the recipient.';
                }
                field(Carrier; Rec.Carrier)
                {
                    ToolTip = 'Specifies the carrier that transports the shipment.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies where the shipment is: open, booked, in transit or delivered.';
                }
                field("Tracking No."; Rec."Tracking No.")
                {
                    ToolTip = 'Specifies the tracking number that the carrier gave the shipment.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date of the shipment.';
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ToolTip = 'Specifies the total weight in kilograms of all packages of the shipment.';
                }
            }
        }
    }
}
