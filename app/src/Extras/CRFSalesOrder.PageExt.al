pageextension 50103 "CRF Sales Order" extends "Sales Order"
{
    layout
    {
        addlast("Shipping and Billing")
        {
            field("CRF Carrier"; Rec."CRF Carrier")
            {
                ApplicationArea = All;
            }
            field("CRF Freight ID"; Rec."CRF Freight ID")
            {
                ApplicationArea = All;
            }
            field(CRFFreightStatus; FreightStatus)
            {
                ApplicationArea = All;
                Caption = 'Freight Status';
                Editable = false;
                ToolTip = 'Specifies how far the Cronus Fragt shipment for the order has come.';
            }
        }
    }

    var
        FreightStatus: Text;

    trigger OnAfterGetRecord()
    var
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        FreightStatus := FreightMgt.GetShipmentStatus(Rec."CRF Freight ID");
    end;
}
