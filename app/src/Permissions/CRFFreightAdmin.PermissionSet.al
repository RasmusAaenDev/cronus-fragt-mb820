permissionset 50101 "CRF Freight Admin"
{
    Assignable = true;
    Caption = 'Cronus Freight - Admin';
    IncludedPermissionSets = "CRF Freight Basic";

    Permissions =
        tabledata "CRF Freight Setup" = RIMD,
        tabledata "CRF Carrier Rate" = RIMD,
        page "CRF Freight Setup" = X,
        page "CRF Cronus Freight Wizard" = X,
        xmlport "CRF Import Carrier Rates" = X,
        codeunit "CRF Assisted Setup Subs" = X,
        codeunit "CRF Install" = X,
        codeunit "CRF Upgrade" = X,
        codeunit "CRF Upgrade Tags" = X;
}
