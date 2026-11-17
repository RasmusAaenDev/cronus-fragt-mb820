page 50100 "CRF Freight Setup"
{
    Caption = 'Cronus Freight Setup';
    PageType = Card;
    SourceTable = "CRF Freight Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    AdditionalSearchTerms = 'carrier, shipping, freight, shipment';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Default Carrier"; Rec."Default Carrier")
                {
                    ToolTip = 'Specifies the carrier that new shipments get when the customer has no default carrier of its own.';
                }
                field("API Base URL"; Rec."API Base URL")
                {
                    ToolTip = 'Specifies the base address of the carrier service that the extension calls.';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Shipment Nos."; Rec."Shipment Nos.")
                {
                    ToolTip = 'Specifies the number series that is used to number new shipments.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
