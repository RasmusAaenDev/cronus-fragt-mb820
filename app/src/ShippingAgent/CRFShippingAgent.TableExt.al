tableextension 50100 "CRF Shipping Agent" extends "Shipping Agent"
{
    fields
    {
        field(50100; "CRF Carrier"; Enum "CRF Carrier")
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(50101; "CRF API Base URL"; Text[250])
        {
            Caption = 'API Base URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
    }
}
