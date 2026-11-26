codeunit 50104 "CRF Sales Post Subs"
{
    Access = Internal;

    // Keep this small: an error here shows up in the user's posting (and rolls it back when commits are suppressed).
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure CreateTrackingOnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        FreightMgt: Codeunit "CRF Freight Mgt";
    begin
        if PreviewMode or (SalesShptHdrNo = '') then
            exit;
        FreightMgt.CreateTrackingFromSalesShipment(SalesHeader."Sell-to Customer No.", SalesShptHdrNo);
    end;
}
