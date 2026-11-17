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
        field(2; "Default Carrier"; Enum "CRF Carrier")
        {
            Caption = 'Default Carrier';
            DataClassification = CustomerContent;
        }
        field(3; "API Base URL"; Text[250])
        {
            Caption = 'API Base URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(4; "Shipment Nos."; Code[20])
        {
            Caption = 'Shipment Nos.';
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
