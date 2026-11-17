query 50100 "CRF Shipments by Carrier"
{
    Caption = 'Shipments by Carrier';
    QueryType = Normal;

    elements
    {
        dataitem(ShipmentHeader; "CRF Shipment Header")
        {
            column(Carrier; Carrier)
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
