page 50109 "CRF Tracking Status API"
{
    PageType = API;
    Caption = 'Tracking Status API';
    APIPublisher = 'cronus';
    APIGroup = 'freight';
    APIVersion = 'v1.0';
    EntityName = 'trackingStatus';
    EntitySetName = 'trackingStatuses';
    EntityCaption = 'Tracking Status';
    EntitySetCaption = 'Tracking Statuses';
    SourceTable = "CRF Shipment Tracking Header";
    ODataKeyFields = SystemId;
    Editable = false;
    DataAccessIntent = ReadOnly;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(trackingNumber; Rec."Package Tracking No.")
                {
                    Caption = 'Package Tracking No.';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                }
            }
        }
    }
}
