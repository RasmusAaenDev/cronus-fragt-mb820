xmlport 50100 "CRF Import Agent Rates"
{
    Caption = 'Import Shipping Agent Rates';
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(AgentRates)
        {
            textattribute(shippingAgent)
            {
            }
            tableelement(Rate; "CRF Shipping Agent Rate")
            {
                AutoReplace = true;

                fieldelement(WeightLimit; Rate."Weight Limit")
                {
                }
                fieldelement(Price; Rate.Price)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    Rate."Shipping Agent Code" := ShippingAgentCodeFromFile(shippingAgent);
                end;
            }
        }
    }

    local procedure ShippingAgentCodeFromFile(AgentCode: Text): Code[10]
    var
        ShippingAgent: Record "Shipping Agent";
        UnknownAgentErr: Label 'The rate file is for shipping agent "%1", which does not exist.', Comment = '%1 = the shipping agent code from the file';
    begin
        if (AgentCode.Trim() = '') or (StrLen(AgentCode) > MaxStrLen(ShippingAgent.Code)) then
            Error(UnknownAgentErr, AgentCode);
        if not ShippingAgent.Get(CopyStr(AgentCode, 1, MaxStrLen(ShippingAgent.Code))) then
            Error(UnknownAgentErr, AgentCode);
        exit(ShippingAgent.Code);
    end;
}
