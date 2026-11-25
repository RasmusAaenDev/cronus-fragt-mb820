permissionset 50100 "CRF Freight Basic"
{
    Assignable = true;
    Caption = 'Cronus Freight - Basic';

    Permissions =
        table "CRF Freight Setup" = X,
        tabledata "CRF Freight Setup" = R,
        table "CRF Shipment Header" = X,
        tabledata "CRF Shipment Header" = RIMD,
        table "CRF Shipment Line" = X,
        tabledata "CRF Shipment Line" = RIMD,
        table "CRF Carrier Rate" = X,
        tabledata "CRF Carrier Rate" = R,
        page "CRF Shipment List" = X,
        page "CRF Shipment Card" = X,
        page "CRF Shipment Subform" = X,
        page "CRF Carrier Rates" = X,
        tabledata Customer = R,
        tabledata "No. Series" = R;
}
