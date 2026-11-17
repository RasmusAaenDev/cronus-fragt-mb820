permissionset 50100 "CRF Freight"
{
    Assignable = true;
    Caption = 'Cronus Freight';

    Permissions =
        table "CRF Freight Setup" = X,
        tabledata "CRF Freight Setup" = RIMD,
        table "CRF Shipment Header" = X,
        tabledata "CRF Shipment Header" = RIMD,
        table "CRF Shipment Line" = X,
        tabledata "CRF Shipment Line" = RIMD,
        page "CRF Freight Setup" = X,
        page "CRF Freight Setup Guide" = X,
        page "CRF Shipment List" = X,
        page "CRF Shipment Card" = X,
        page "CRF Shipment Subform" = X,
        codeunit "CRF Assisted Setup Subs" = X,
        tabledata Customer = R,
        tabledata "No. Series" = R;
}
