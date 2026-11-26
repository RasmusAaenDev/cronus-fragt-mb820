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
        table "CRF Freight Cue" = X,
        tabledata "CRF Freight Cue" = RIMD,
        page "CRF Shipment Tracking List" = X,
        page "CRF Shipment Tracking Card" = X,
        page "CRF Shipment Tracking Subform" = X,
        page "CRF Shipping Agent Rates" = X,
        page "CRF Freight Activities" = X,
        query "CRF Tracking by Shipping Agent" = X,
        codeunit "CRF Freight Mgt" = X,
        codeunit "CRF Carrier A" = X,
        codeunit "CRF Carrier B" = X,
        codeunit "CRF No Carrier" = X,
        tabledata Customer = R,
        tabledata "Shipping Agent" = R,
        tabledata "No. Series" = R;
}
