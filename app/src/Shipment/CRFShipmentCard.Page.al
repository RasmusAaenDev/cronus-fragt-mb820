page 50102 "CRF Shipment Card"
{
    Caption = 'Shipment';
    PageType = Document;
    SourceTable = "CRF Shipment Header";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the shipment. It is filled in from the number series when you create the shipment.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer that the shipment goes to. The ship-to address is copied from the customer.';
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
            part(Lines; "CRF Shipment Subform")
            {
                Caption = 'Packages';
                SubPageLink = "Shipment No." = field("No.");
                UpdatePropagation = Both;
            }
            group(Shipping)
            {
                Caption = 'Ship-to';

                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the recipient.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the delivery address.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the delivery address.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the delivery address.';
                }
            }
        }
    }
}
