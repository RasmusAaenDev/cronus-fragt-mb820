pageextension 50102 "CRF Order Processor RC" extends "Order Processor Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(CRFFreightActivities; "CRF Freight Activities")
            {
                ApplicationArea = All;
            }
        }
    }
}
