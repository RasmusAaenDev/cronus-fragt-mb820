page 50101 "CRF Shipment Tracking List"
{
    Caption = 'Shipment Tracking';
    PageType = List;
    SourceTable = "CRF Shipment Tracking Header";
    CardPageId = "CRF Shipment Tracking Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Tracking)
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
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the shipping agent that transports the shipment.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies where the shipment is: open, booked, in transit or delivered.';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
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

    actions
    {
        area(Processing)
        {
            // Temporary: lets the polling round be tested by hand until the job queue entry exists (step 29)
            action(UpdateAllStatuses)
            {
                Caption = 'Update All Statuses';
                ToolTip = 'Asks the carriers for the status of all booked and in-transit shipments with a tracking number. Shipments where the carrier fails are skipped.';
                Image = Refresh;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"CRF Update Status");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
