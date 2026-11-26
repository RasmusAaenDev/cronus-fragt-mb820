page 50105 "CRF Shipment Tracking API"
{
    PageType = API;
    Caption = 'Shipment Tracking API';
    APIPublisher = 'cronus';
    APIGroup = 'freight';
    APIVersion = 'v1.0';
    EntityName = 'shipmentTracking';
    EntitySetName = 'shipmentTrackings';
    EntityCaption = 'Shipment Tracking';
    EntitySetCaption = 'Shipment Trackings';
    SourceTable = "CRF Shipment Tracking Header";
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
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                }
                field(customerNumber; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                }
                field(trackingNumber; Rec."Package Tracking No.")
                {
                    Caption = 'Package Tracking No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(totalWeight; Rec."Total Weight")
                {
                    Caption = 'Total Weight';
                    Editable = false;
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
                part(shipmentTrackingLines; "CRF Shipment Tracking Line API")
                {
                    Caption = 'Shipment Tracking Lines';
                    EntityName = 'shipmentTrackingLine';
                    EntitySetName = 'shipmentTrackingLines';
                    SubPageLink = "Document No." = field("No.");
                }
            }
        }
    }

    [ServiceEnabled]
    procedure book(var ActionContext: WebServiceActionContext)
    var
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        FreightMgt.Book(Rec);
        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::"CRF Shipment Tracking API");
        ActionContext.AddEntityKey(Rec.FieldNo(SystemId), Rec.SystemId);
        ActionContext.SetResultCode(WebServiceActionResultCode::Updated);
    end;
}
