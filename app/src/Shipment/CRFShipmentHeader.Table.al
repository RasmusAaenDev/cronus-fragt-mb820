table 50101 "CRF Shipment Header"
{
    Caption = 'Shipment Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if not Customer.Get(Rec."Customer No.") then
                    exit;
                Rec."Ship-to Name" := Customer.Name;
                Rec."Ship-to Address" := Customer.Address;
                Rec."Ship-to City" := Customer.City;
                Rec."Ship-to Post Code" := Customer."Post Code";
            end;
        }
        field(3; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(4; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(5; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
        }
        field(6; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
        }
        field(7; Carrier; Enum "CRF Carrier")
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(8; Status; Enum "CRF Shipment Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(9; "Tracking No."; Text[50])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        ShipmentLine: Record "CRF Shipment Line";
    begin
        ShipmentLine.SetRange("Shipment No.", Rec."No.");
        ShipmentLine.DeleteAll(true);
    end;
}
