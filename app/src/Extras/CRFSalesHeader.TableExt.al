tableextension 50101 "CRF Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "CRF Carrier"; Enum "CRF Carrier")
        {
            Caption = 'Carrier';
            ToolTip = 'Specifies the carrier that ships the order. It comes from the customer''s default carrier.';
            DataClassification = CustomerContent;
        }
        field(50101; "CRF Freight ID"; Code[20])
        {
            Caption = 'Freight ID';
            ToolTip = 'Specifies the Cronus Fragt shipment that was created when the order was last shipped.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "CRF Shipment Header"."No.";
        }
    }
}
