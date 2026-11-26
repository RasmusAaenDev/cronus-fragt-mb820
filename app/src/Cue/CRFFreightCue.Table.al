table 50104 "CRF Freight Cue"
{
    Caption = 'Freight Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Open Shipments"; Integer)
        {
            Caption = 'Open Shipment Tracking';
            FieldClass = FlowField;
            CalcFormula = count("CRF Shipment Tracking Header" where(Status = const(Open)));
            Editable = false;
        }
        field(3; "Open Default Agent"; Integer)
        {
            Caption = 'Open with Default Shipping Agent';
            DataClassification = SystemMetadata;
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
