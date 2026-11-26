page 50106 "CRF Shipment Tracking Line API"
{
    PageType = API;
    Caption = 'Shipment Tracking Line API';
    APIPublisher = 'cronus';
    APIGroup = 'freight';
    APIVersion = 'v1.0';
    EntityName = 'shipmentTrackingLine';
    EntitySetName = 'shipmentTrackingLines';
    EntityCaption = 'Shipment Tracking Line';
    EntitySetCaption = 'Shipment Tracking Lines';
    SourceTable = "CRF Shipment Tracking Line";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
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
                    Editable = false;
                }
                field(documentNumber; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNumber; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight';
                }
                field(length; Rec.Length)
                {
                    Caption = 'Length';
                }
                field(width; Rec.Width)
                {
                    Caption = 'Width';
                }
                field(height; Rec.Height)
                {
                    Caption = 'Height';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
            }
        }
    }
}
