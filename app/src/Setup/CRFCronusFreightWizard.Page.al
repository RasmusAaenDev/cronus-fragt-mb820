page 50104 "CRF Cronus Freight Wizard"
{
    Caption = 'Set up Cronus Freight';
    PageType = NavigatePage;
    SourceTable = "CRF Freight Setup";
    SourceTableTemporary = true;

    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(StandardBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(Step1)
            {
                ShowCaption = false;
                Visible = Step1Visible;
                group("Welcome to CRF Cronus Freight")
                {
                    Caption = 'Welcome';
                    Visible = Step1Visible;
                    group(Group18)
                    {
                        ShowCaption = false;
                        InstructionalText = 'This guide sets up the default carrier and the numbering of shipments.';
                    }
                }
                group(StepCarrier)
                {
                    Caption = 'Default carrier';
                    group(Group22)
                    {
                        ShowCaption = false;
                        InstructionalText = 'Select the carrier that you want to use on shipments, when there is no other carriers selected.';

                        field("Default Carrier"; Rec."Default Carrier")
                        {
                            ToolTip = 'Specifies the carrier that new shipments get by default.';
                        }
                    }
                }
            }

            group(Step2)
            {
                ShowCaption = false;
                Visible = Step2Visible;
                group(Group35)
                {
                    Caption = 'Shipment numbers';
                    InstructionalText = 'Select the number series you want to use, when you create new shipments';
                    Visible = Step2Visible;

                    field("Shipment Nos."; Rec."Shipment Nos.")
                    {
                        ToolTip = 'Specifies the number series that is used to number new shipments.';
                    }
                }
            }


            group(Step3)
            {
                ShowCaption = false;
                Visible = Step3Visible;
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Group25)
                    {
                        ShowCaption = false;
                        InstructionalText = 'Choose Finish to save the freight setup';
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction()
                begin
                    FinishAction();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    var
        FreightSetup: Record "CRF Freight Setup";
    begin
        Rec.Init();
        if FreightSetup.Get() then
            Rec.TransferFields(FreightSetup);

        Rec.Insert();

        Step := Step::Start;
        EnableControls();
    end;

    var
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Step2,Finish;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        TopBannerVisible: Boolean;

    local procedure EnableControls()
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep1();
            Step::Step2:
                ShowStep2();
            Step::Finish:
                ShowStep3();
        end;
    end;

    local procedure StoreFreightSetup()
    var
        FreightSetup: Record "CRF Freight Setup";
    begin
        if not FreightSetup.Get() then begin
            FreightSetup.Init();
            FreightSetup.Insert();
        end;

        FreightSetup.TransferFields(Rec, false);
        FreightSetup.Modify(true);
    end;


    local procedure FinishAction()
    begin
        StoreFreightSetup();
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1()
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep2()
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3()
    begin
        Step3Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls()
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
        then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}
