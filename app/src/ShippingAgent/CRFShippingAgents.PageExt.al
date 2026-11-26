pageextension 50101 "CRF Shipping Agents" extends "Shipping Agents"
{
    layout
    {
        addlast(Control1)
        {
            field("CRF Carrier"; Rec."CRF Carrier")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies which carrier implementation Cronus Fragt uses for this shipping agent. Leave it blank if the shipping agent has no web service.';
            }
            field("CRF API Base URL"; Rec."CRF API Base URL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the base address of the carrier service that Cronus Fragt calls for this shipping agent.';
            }
        }
    }
}
