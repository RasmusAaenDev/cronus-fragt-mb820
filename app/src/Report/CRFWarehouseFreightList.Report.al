report 50100 "CRF Warehouse Freight List"
{
    Caption = 'Warehouse Freight List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WarehouseListWord;

    dataset
    {
        dataitem(TrackingHeader; "CRF Shipment Tracking Header")
        {
            RequestFilterFields = Status, "Shipping Agent Code";
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
            column(ShippingAgentCode; "Shipping Agent Code")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(TrackingNo; "Package Tracking No.")
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

            dataitem(TrackingLine; "CRF Shipment Tracking Line")
            {
                DataItemLink = "Document No." = field("No.");

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
                        ToolTip = 'Specifies if the packages of each shipment tracking record are printed below it.';
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
            Caption = 'Warehouse freight list (print)';
            Summary = 'Shipment tracking records with their packages, for the warehouse to print.';
            LayoutFile = 'src/Report/CRFWarehouseFreightList.docx';
        }
    }

    labels
    {
        ReportTitleLbl = 'Warehouse Freight List';
        PageLbl = 'Page';
    }

    trigger OnInitReport()
    begin
        ShowPackages := true;
    end;

    var
        ShowPackages: Boolean;
}
