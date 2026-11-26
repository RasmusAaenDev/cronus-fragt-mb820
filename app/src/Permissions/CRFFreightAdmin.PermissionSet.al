permissionset 50101 "CRF Freight Admin"
{
    Assignable = true;
    Caption = 'Cronus Freight - Admin';
    IncludedPermissionSets = "CRF Freight Basic";

    Permissions =
        tabledata "CRF Freight Setup" = RIMD,
        tabledata "Shipping Agent" = RM,
        tabledata "CRF Shipping Agent Rate" = RIMD,
        page "CRF Freight Setup" = X,
        page "CRF Cronus Freight Wizard" = X,
        xmlport "CRF Import Agent Rates" = X,
        codeunit "CRF Assisted Setup Subs" = X,
        codeunit "CRF Install" = X,
        codeunit "CRF Upgrade" = X,
        codeunit "CRF Upgrade Tags" = X;
}
