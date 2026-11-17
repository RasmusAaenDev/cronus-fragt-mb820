page 50107 "CRF Carrier Rates"
{
    Caption = 'Carrier Rates';
    PageType = List;
    SourceTable = "CRF Carrier Rate";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Rates)
            {
                field(Carrier; Rec.Carrier)
                {
                    ToolTip = 'Specifies the carrier that the rate belongs to.';
                }
                field("Weight Limit"; Rec."Weight Limit")
                {
                    ToolTip = 'Specifies the highest weight in kilograms that the price covers.';
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the price of a package up to the weight limit.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportRates)
            {
                Caption = 'Import Rates';
                ToolTip = 'Imports carrier rates from an XML file.';
                Image = Import;

                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"CRF Import Carrier Rates", false, true);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref(ImportRates_Promoted; ImportRates)
            {
            }
        }
    }
}
