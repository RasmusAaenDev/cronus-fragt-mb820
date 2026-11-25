reportextension 50100 "CRF Order Conf." extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(CRFCarrier; "CRF Carrier") { IncludeCaption = true; }
            column(CRFFreightID; "CRF Freight ID") { IncludeCaption = true; }
        }
    }

    rendering
    {
        layout(CRFOrderConfWord)
        {
            Type = Word;
            Caption = 'Order confirmation with carrier and freight ID';
            Summary = 'The standard order confirmation with the Cronus Fragt carrier and freight ID.';
            LayoutFile = 'layouts/CRFOrderConf.docx';
        }
    }
}
