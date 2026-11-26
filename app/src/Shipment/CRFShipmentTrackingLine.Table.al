table 50102 "CRF Shipment Tracking Line"
{
    Caption = 'Shipment Tracking Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "CRF Shipment Tracking Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Weight; Decimal)
        {
            Caption = 'Weight (kg)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(5; Length; Decimal)
        {
            Caption = 'Length (cm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(6; Width; Decimal)
        {
            Caption = 'Width (cm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(7; Height; Decimal)
        {
            Caption = 'Height (cm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
