permissionset 50100 "CRF Freight Basic"
{
    Assignable = true;
    Caption = 'Cronus Freight - Basic';

    Permissions =
        table "CRF Freight Setup" = X,
        tabledata "CRF Freight Setup" = R,
        table "CRF Shipment Tracking Header" = X,
        tabledata "CRF Shipment Tracking Header" = RIMD,
        table "CRF Shipment Tracking Line" = X,
        tabledata "CRF Shipment Tracking Line" = RIMD,
        table "CRF Shipping Agent Rate" = X,
        tabledata "CRF Shipping Agent Rate" = R,
        page "CRF Shipment Tracking List" = X,
        page "CRF Shipment Tracking Card" = X,
        page "CRF Shipment Tracking Subform" = X,
        page "CRF Shipping Agent Rates" = X,
        tabledata Customer = R,
        tabledata "Shipping Agent" = R,
        tabledata "No. Series" = R;
}
