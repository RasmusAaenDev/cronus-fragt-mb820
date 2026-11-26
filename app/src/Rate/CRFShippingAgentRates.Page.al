page 50107 "CRF Shipping Agent Rates"
{
    Caption = 'Shipping Agent Rates';
    PageType = List;
    SourceTable = "CRF Shipping Agent Rate";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Rates)
            {
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the shipping agent that the rate belongs to.';
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
                ToolTip = 'Imports shipping agent rates from an XML file.';
                Image = Import;

                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"CRF Import Agent Rates", false, true);
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
