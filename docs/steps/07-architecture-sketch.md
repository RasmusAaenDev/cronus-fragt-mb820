# Step 07: Sketch the architecture

Delivers `docs/design/04-architecture.md`: a mermaid diagram of users, the Business Central server, the webshop and the carriers, an arrow table saying who starts each call and whether a user waits, a table of where each part sits, and the notes to remember (outbound HTTP, API key, job queue, telemetry). It uses the same names and ids as `docs/design/object-ids.md`. In this design the setup table holds the default shipping agent and the number series, the Shipping Agent extension holds the carrier, the API address and the API key, and the facade reads the carrier from the shipping agent. The mermaid source was written by hand and has not been rendered here.

| Checklist item | Where |
|---|---|
| Users, BC service, webshop and carriers with direction of every call | The diagram and the arrow table. |
| Carrier calls from a codeunit behind `CRF ICarrier`, not a page; the shipping agent decides the carrier | The arrow from `CRF Carrier A/B` to the carrier; pages only reach the facade; the facade reads `CRF Carrier` from the shipping agent. |
| Polling from the job queue in the background, webshop uses API pages | The job queue arrows and the API page arrows. |
| Setup, assisted setup, Shipping Agent extension, telemetry, permission sets each placed | "Where the parts are", and nodes in the diagram. |
| Allow HttpClient Requests noted | "Things to remember", first bullet. |

Not verified: that the diagram renders (mermaid is not installed here); do not take its layout for checked. No AL changed; `scripts/compile.sh app` is still 0 errors. The document itself is rewritten for v2 separately from this note.
