enum 50100 "CRF Carrier" implements "CRF ICarrier"
{
    Caption = 'Carrier';
    Extensible = true;
    // The blank value (and any extension value without an implementation of its own) raises a clear error
    DefaultImplementation = "CRF ICarrier" = "CRF No Carrier";

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Carrier A")
    {
        Caption = 'Carrier A';
        Implementation = "CRF ICarrier" = "CRF Carrier A";
    }
    value(2; "Carrier B")
    {
        Caption = 'Carrier B';
        Implementation = "CRF ICarrier" = "CRF Carrier B";
    }
}
