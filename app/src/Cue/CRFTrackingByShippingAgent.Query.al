query 50100 "CRF Tracking by Shipping Agent"
{
    Caption = 'Tracking by Shipping Agent';
    QueryType = Normal;

    elements
    {
        dataitem(TrackingHeader; "CRF Shipment Tracking Header")
        {
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            filter(Status; Status)
            {
            }
            column(NoOfShipments)
            {
                Method = Count;
            }
        }
    }
}
