table 50101 "CRF Shipment Tracking Header"
{
    Caption = 'Shipment Tracking Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    FreightSetup.Get();
                    NoSeries.TestManual(FreightSetup."Shipment Tracking Nos.");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
                CustomerFreightSetup: Record "CRF Freight Setup";
            begin
                if not Customer.Get(Rec."Customer No.") then
                    exit;
                Rec."Ship-to Name" := Customer.Name;
                Rec."Ship-to Address" := Customer.Address;
                Rec."Ship-to City" := Customer.City;
                Rec."Ship-to Post Code" := Customer."Post Code";
                // The customer's own shipping agent wins; a blank one falls back to the freight setup
                Rec."Shipping Agent Code" := Customer."Shipping Agent Code";
                if (Rec."Shipping Agent Code" = '') and CustomerFreightSetup.Get() then
                    Rec."Shipping Agent Code" := CustomerFreightSetup."Default Shipping Agent Code";
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
        field(7; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(8; Status; Enum "CRF Tracking Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(9; "Package Tracking No."; Text[50])
        {
            Caption = 'Package Tracking No.';
            DataClassification = CustomerContent;
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Total Weight"; Decimal)
        {
            Caption = 'Total Weight (kg)';
            FieldClass = FlowField;
            CalcFormula = sum("CRF Shipment Tracking Line".Weight where("Document No." = field("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        FreightSetup: Record "CRF Freight Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if Rec."Posting Date" = 0D then
            Rec."Posting Date" := WorkDate();
        if Rec."No." = '' then begin
            FreightSetup.Get();
            FreightSetup.TestField("Shipment Tracking Nos.");
            Rec."No. Series" := FreightSetup."Shipment Tracking Nos.";
            if NoSeries.AreRelated(FreightSetup."Shipment Tracking Nos.", xRec."No. Series") then
                Rec."No. Series" := xRec."No. Series";
            Rec."No." := NoSeries.GetNextNo(Rec."No. Series", Rec."Posting Date");
        end;
    end;

    trigger OnDelete()
    var
        TrackingLine: Record "CRF Shipment Tracking Line";
    begin
        TrackingLine.SetRange("Document No.", Rec."No.");
        TrackingLine.DeleteAll(true);
    end;
}
