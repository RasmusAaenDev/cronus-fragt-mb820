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
            field(CRFApiKey; ApiKeyText)
            {
                ApplicationArea = All;
                Caption = 'API Key';
                ExtendedDatatype = Masked;
                ToolTip = 'Specifies the key that the carrier service gave Cronus. The key is stored in isolated storage, not in the shipping agent table. Clear the field to delete the key.';

                trigger OnValidate()
                begin
                    SaveApiKey();
                    ShowApiKeyPlaceholder();
                end;
            }
        }
    }

    var
        ApiKeyText: Text;
        ApiKeyPlaceholderTxt: Label '********', Locked = true;

    trigger OnAfterGetRecord()
    begin
        ShowApiKeyPlaceholder();
    end;

    local procedure ShowApiKeyPlaceholder()
    begin
        // The stored key is never loaded into the page, only a placeholder that shows that one exists
        if Rec.CRFHasApiKey() then
            ApiKeyText := ApiKeyPlaceholderTxt
        else
            ApiKeyText := '';
    end;

    [NonDebuggable]
    local procedure SaveApiKey()
    var
        NewApiKey: SecretText;
    begin
        // The placeholder means the user did not type a new key
        if ApiKeyText = ApiKeyPlaceholderTxt then
            exit;
        NewApiKey := ApiKeyText;
        Rec.CRFSetApiKey(NewApiKey);
    end;
}
