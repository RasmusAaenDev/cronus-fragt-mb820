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
        table "CRF Carrier Rate" = X,
        tabledata "CRF Carrier Rate" = RIMD,
        table "CRF Freight Cue" = X,
        tabledata "CRF Freight Cue" = RIMD,
        page "CRF Freight Setup" = X,
        page "CRF Cronus Freight Wizard" = X,
        page "CRF Shipment List" = X,
        page "CRF Shipment Card" = X,
        page "CRF Shipment Subform" = X,
        page "CRF Carrier Rates" = X,
        page "CRF Freight Activities" = X,
        page "CRF Shipment API" = X,
        page "CRF Shipment Line API" = X,
        page "CRF Shipment Status API" = X,
        query "CRF Shipments by Carrier" = X,
        report "CRF Warehouse Shipment List" = X,
        xmlport "CRF Import Carrier Rates" = X,
        codeunit "CRF Assisted Setup Subs" = X,
        codeunit "CRF Freight Mgt" = X,
        codeunit "CRF Update Status" = X,
        codeunit "CRF Sales Post Subs" = X,
        codeunit "CRF Install" = X,
        codeunit "CRF Upgrade" = X,
        codeunit "CRF Upgrade Tags" = X,
        codeunit "CRF Carrier A" = X,
        codeunit "CRF Carrier B" = X,
        codeunit "CRF No Carrier" = X,
        tabledata Customer = R,
        tabledata "Sales Shipment Header" = R,
        tabledata "No. Series" = R;
}
