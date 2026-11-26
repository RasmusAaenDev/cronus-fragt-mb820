tableextension 50100 "CRF Shipping Agent" extends "Shipping Agent"
{
    fields
    {
        field(50100; "CRF Carrier"; Enum "CRF Carrier")
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(50101; "CRF API Base URL"; Text[250])
        {
            Caption = 'API Base URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
    }

    /// <summary>
    /// Stores the carrier API key of this shipping agent in isolated storage (encrypted, per company).
    /// An empty key deletes the stored one.
    /// </summary>
    procedure CRFSetApiKey(NewApiKey: SecretText)
    begin
        if NewApiKey.IsEmpty() then begin
            if IsolatedStorage.Contains(ApiKeyStorageKey(), DataScope::Company) then
                IsolatedStorage.Delete(ApiKeyStorageKey(), DataScope::Company);
            exit;
        end;
        IsolatedStorage.SetEncrypted(ApiKeyStorageKey(), NewApiKey, DataScope::Company);
    end;

    /// <summary>
    /// Returns the stored API key as a SecretText, or an empty one if no key is stored.
    /// </summary>
    procedure CRFGetApiKey() ApiKey: SecretText
    begin
        if IsolatedStorage.Get(ApiKeyStorageKey(), DataScope::Company, ApiKey) then
            exit(ApiKey);
    end;

    /// <summary>
    /// Tells whether an API key is stored for this shipping agent, without reading it.
    /// </summary>
    procedure CRFHasApiKey(): Boolean
    begin
        exit(IsolatedStorage.Contains(ApiKeyStorageKey(), DataScope::Company));
    end;

    local procedure ApiKeyStorageKey(): Text
    begin
        // One key per shipping agent: the agent code is part of the storage key
        exit(ApiKeyStoragePrefixTok + Rec.Code);
    end;

    var
        ApiKeyStoragePrefixTok: Label 'CRF-CarrierApiKey-', Locked = true;
}
