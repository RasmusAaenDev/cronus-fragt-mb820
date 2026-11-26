# Step 03: Publish a first extension and attach the debugger

Delivers the page extension `app/src/Customer/CRFCustomerList.PageExt.al` (pageextension 50100 "CRF Customer List": an action "Hello from Cronus Fragt" in the processing area that builds a greeting in a local variable and shows it) and an attach configuration in `app/.vscode/launch.json` (`request` attach, `breakOnNext` WebClient). It compiles with the Business Central 28 compiler, 0 errors. Breakpoint suggestion: the `Message(Greeting);` line, where `Greeting` can be read in the Variables pane.

| Checklist item | Status |
|---|---|
| Page extension compiles and is published | Compiles: yes. Published: **not done**, no sandbox here. |
| Action appears on the Customer List and shows the greeting | **Not verified.** Needs the sandbox. |
| launch.json has an attach configuration that breaks on the next web client session | Done: "Attach to Cronus Fragt sandbox" in `app/.vscode/launch.json`. |
| Debugger stops at the breakpoint and the greeting is readable | **Not done.** Needs a sandbox and VS Code. |

For a person: publish with Ctrl+F5, start "Attach to Cronus Fragt sandbox" with F5, set a breakpoint on the `Message` line, run the action in the browser and read `Greeting`. Publish again after every code change, because an attach session does not publish.

The page extension id 50100 is recorded in `docs/design/object-ids.md` from step 04. This is the only extension of the Customer pages in the project: the shipping agent settings go on the Shipping Agent table and page (step 13), not on Customer.
