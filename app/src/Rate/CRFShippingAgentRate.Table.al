table 50103 "CRF Shipping Agent Rate"
{
    Caption = 'Shipping Agent Rate';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(2; "Weight Limit"; Decimal)
        {
            Caption = 'Weight Limit (kg)';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(3; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
        }
    }

    keys
    {
        key(PK; "Shipping Agent Code", "Weight Limit")
        {
            Clustered = true;
        }
    }
}
