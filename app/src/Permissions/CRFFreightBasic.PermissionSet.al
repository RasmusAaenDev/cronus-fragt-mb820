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
        table "CRF Freight Cue" = X,
        tabledata "CRF Freight Cue" = RIMD,
        page "CRF Shipment List" = X,
        page "CRF Shipment Card" = X,
        page "CRF Shipment Subform" = X,
        page "CRF Carrier Rates" = X,
        page "CRF Freight Activities" = X,
        page "CRF Shipment API" = X,
        page "CRF Shipment Line API" = X,
        query "CRF Shipments by Carrier" = X,
        report "CRF Warehouse Shipment List" = X,
        codeunit "CRF Freight Mgt" = X,
        codeunit "CRF Update Status" = X,
        codeunit "CRF Carrier A" = X,
        codeunit "CRF Carrier B" = X,
        codeunit "CRF No Carrier" = X,
        tabledata Customer = R,
        tabledata "No. Series" = R;
}
