page 50103 "CRF Shipment Tracking Subform"
{
    Caption = 'Packages';
    PageType = ListPart;
    SourceTable = "CRF Shipment Tracking Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Packages)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what the package contains.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the weight of the package in kilograms. It must be greater than zero.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Length; Rec.Length)
                {
                    ToolTip = 'Specifies the length of the package in centimetres.';
                }
                field(Width; Rec.Width)
                {
                    ToolTip = 'Specifies the width of the package in centimetres.';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the height of the package in centimetres.';
                }
            }
        }
    }
}
