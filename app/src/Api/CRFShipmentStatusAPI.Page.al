page 50109 "CRF Shipment Status API"
{
    PageType = API;
    Caption = 'Shipment Status API';
    APIPublisher = 'cronus';
    APIGroup = 'freight';
    APIVersion = 'v1.0';
    EntityName = 'shipmentStatus';
    EntitySetName = 'shipmentStatuses';
    EntityCaption = 'Shipment Status';
    EntitySetCaption = 'Shipment Statuses';
    SourceTable = "CRF Shipment Header";
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
                field(carrier; Rec.Carrier)
                {
                    Caption = 'Carrier';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(trackingNumber; Rec."Tracking No.")
                {
                    Caption = 'Tracking No.';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                }
            }
        }
    }
}
