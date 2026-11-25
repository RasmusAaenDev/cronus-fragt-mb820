page 50101 "CRF Shipment List"
{
    Caption = 'Shipments';
    PageType = List;
    SourceTable = "CRF Shipment Header";
    CardPageId = "CRF Shipment Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    AboutTitle = 'About shipments';  // Extra (course): teaching tips
    AboutText = 'Every posted sales shipment becomes a shipment here. Follow its carrier and status until it is delivered.';

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
                    AboutTitle = 'Where is the shipment?';
                    AboutText = 'The status is updated from the carrier by a job queue entry.';
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

    // Extra (course): views
    views
    {
        view(Open)
        {
            Caption = 'Open';
            Filters = where(Status = const(Open));
        }
        view(InTransit)
        {
            Caption = 'In Transit';
            Filters = where(Status = const("In Transit"));
        }
        view(CarrierA)
        {
            Caption = 'Carrier A';
            Filters = where(Carrier = const("Carrier A"));
            OrderBy = descending("Posting Date");
        }
    }
}
