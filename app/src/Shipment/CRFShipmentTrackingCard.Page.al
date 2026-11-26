page 50102 "CRF Shipment Tracking Card"
{
    Caption = 'Shipment Tracking';
    PageType = Document;
    SourceTable = "CRF Shipment Tracking Header";
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
            part(Lines; "CRF Shipment Tracking Subform")
            {
                Caption = 'Packages';
                SubPageLink = "Document No." = field("No.");
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

    actions
    {
        area(Processing)
        {
            action(UpdateStatus)
            {
                Caption = 'Update Status';
                ToolTip = 'Asks the carrier for the latest status of the shipment and saves it.';
                Image = Refresh;
                ApplicationArea = All;

                trigger OnAction()
                var
                    FreightMgt: Codeunit "CRF Freight Mgt";
                begin
                    FreightMgt.UpdateStatus(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref(UpdateStatus_Promoted; UpdateStatus)
            {
            }
        }
    }
}
