enum 50101 "CRF Shipment Status"
{
    Caption = 'Shipment Status';
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Booked)
    {
        Caption = 'Booked';
    }
    value(2; "In Transit")
    {
        Caption = 'In Transit';
    }
    value(3; Delivered)
    {
        Caption = 'Delivered';
    }
}
