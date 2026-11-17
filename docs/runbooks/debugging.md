# Runbook: why is one shipment's status never updated

Written from the code and the workbook text. Nothing here was run: it needs a sandbox, a carrier service and the AL debugger.

## What we know from the code

- The polling round (`CRF Update Status`) catches the error of each shipment and logs CRF-0002 without the error text (the text could hold customer data). Other shipments keep updating, which matches what Mette sees.
- The error text exists only inside `UpdateStatusNoError` in `CRF Freight Mgt`: after `TryGetStatus` returns false, `GetLastErrorText()` holds it.
- Carrier A's `GetStatus` fails with "The carrier service reported the unknown status ..." when `StatusFromText` gets a text other than booked, in_transit or delivered. That is the first suspect. Other candidates: a blank or wrong tracking number, an HTTP error for that one parcel, an answer the code cannot read. It is a hypothesis until someone runs the steps below.

## Reproduce in your own session

1. Publish (Ctrl+F5), start the configuration "Attach to Cronus Fragt sandbox" (`breakOnNext: WebClient`; `breakOnError` is All on the launch configuration, so the debugger also stops on errors that the code handles, such as inside the try function).
2. Breakpoint in `UpdateStatusNoError` (`CRF Freight Mgt`) on the line after `TryGetStatus`. Inspect `GetLastErrorText()` in the Variables pane.
3. Conditional breakpoint in `GetStatus` of `CRF Carrier A`, expression `ShipmentHeader."No." = '<number of the failing shipment>'`, so it stops only for that shipment, also during polling.
4. On the shipment card choose Update Status. Note the error text.

(Learn's attach article restricts sandboxes to some session types and its support table lists the web client. If the attach does not stop, check what the sandbox allows. For the job queue run, use Run once (Foreground) on the entry.)

## If it only happens in another user's session: snapshot debugging

- Configuration `Snapshot Cronus Fragt sandbox` in `app/.vscode/launch.json` (`request: snapshotInitialize`, `breakOnNext: WebClient`, `userId` = the colleague's user security ID).
- Permissions: the developer needs the permission set D365 SNAPSHOT DEBUG and, because the session belongs to another user, D365 ATTACH DEBUG.
- Set snappoints in `UpdateStatusNoError` and `GetStatus` (they log state and do not stop the code). Start with F7, let the colleague reproduce the problem, finish with Alt+F7, open the finished snapshot from the list that Shift+F7 shows.
- Time limits: an unattached session closes after 30 minutes, a started one must be finished within 10. Symbols must match the server. The snapshot can contain customer data: handle it under Cronus' privacy rules and delete it afterwards.

## Cause and proposed fix (to be confirmed)

Likely cause: the carrier reports a status that `StatusFromText` does not know (for example `returned`), so the shipment fails in every round. Options for Mette:

1. Add a value to `CRF Shipment Status` (Cronus owns the enum), map it in `StatusFromText` and add a test for it in the test app (recommended if the status is a real business state).
2. Keep the error and let the warehouse handle such shipments by hand.

## Danish captions

See `docs/steps/32-debug-and-danish.md`. Publish normally before switching language: RAD publishing and Incremental Build ignore translations.
