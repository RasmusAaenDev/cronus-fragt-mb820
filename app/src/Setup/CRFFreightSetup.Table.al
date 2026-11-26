table 50100 "CRF Freight Setup"
{
    Caption = 'Cronus Freight Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Default Shipping Agent Code"; Code[10])
        {
            Caption = 'Default Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(3; "Shipment Tracking Nos."; Code[20])
        {
            Caption = 'Shipment Tracking Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
