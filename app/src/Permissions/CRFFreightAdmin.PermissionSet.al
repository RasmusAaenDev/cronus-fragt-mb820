permissionset 50101 "CRF Freight Admin"
{
    Assignable = true;
    Caption = 'Cronus Freight - Admin';
    IncludedPermissionSets = "CRF Freight Basic";

    Permissions =
        tabledata "CRF Freight Setup" = RIMD,
        page "CRF Freight Setup" = X,
        page "CRF Cronus Freight Wizard" = X,
        codeunit "CRF Assisted Setup Subs" = X;
}
