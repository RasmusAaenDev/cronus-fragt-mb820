report 50100 "CRF Warehouse Shipment List"
{
    Caption = 'Warehouse Shipment List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WarehouseListWord;

    dataset
    {
        dataitem(ShipmentHeader; "CRF Shipment Header")
        {
            RequestFilterFields = Status, Carrier;
            CalcFields = "Total Weight";

            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(CustomerNo; "Customer No.")
            {
                IncludeCaption = true;
            }
            column(ShipToName; "Ship-to Name")
            {
                IncludeCaption = true;
            }
            column(ShipToAddress; "Ship-to Address")
            {
                IncludeCaption = true;
            }
            column(ShipToPostCode; "Ship-to Post Code")
            {
                IncludeCaption = true;
            }
            column(ShipToCity; "Ship-to City")
            {
                IncludeCaption = true;
            }
            column(Carrier; Carrier)
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(TrackingNo; "Tracking No.")
            {
                IncludeCaption = true;
            }
            column(TotalWeight; "Total Weight")
            {
                IncludeCaption = true;
            }
            column(ShowPackages; ShowPackages)
            {
            }

            dataitem(ShipmentLine; "CRF Shipment Line")
            {
                DataItemLink = "Shipment No." = field("No.");

                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Weight; Weight)
                {
                    IncludeCaption = true;
                }
                column(Length; Length)
                {
                    IncludeCaption = true;
                }
                column(Width; Width)
                {
                    IncludeCaption = true;
                }
                column(Height; Height)
                {
                    IncludeCaption = true;
                }

                trigger OnPreDataItem()
                begin
                    if not ShowPackages then
                        CurrReport.Break();
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ShowPackagesField; ShowPackages)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Packages';
                        ToolTip = 'Specifies if the packages of each shipment are printed below it.';
                    }
                }
            }
        }
    }

    rendering
    {
        layout(WarehouseListWord)
        {
            Type = Word;
            Caption = 'Warehouse shipment list (print)';
            Summary = 'Shipments with their packages, for the warehouse to print.';
            LayoutFile = 'src/Report/CRFWarehouseShipmentList.docx';
        }
    }

    labels
    {
        ReportTitleLbl = 'Warehouse Shipment List';
        PageLbl = 'Page';
    }

    trigger OnInitReport()
    begin
        ShowPackages := true;
    end;

    var
        ShowPackages: Boolean;
}
