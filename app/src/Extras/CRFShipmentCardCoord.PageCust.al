pagecustomization "CRF Shipment Card Coord." customizes "CRF Shipment Card"
{
    layout
    {
        moveafter("No."; Status, "Tracking No.")
        modify("Posting Date")
        {
            Visible = false;
        }
    }
}
