# Step 07: Sketch the architecture

Delivers `docs/design/04-architecture.md`: a mermaid diagram of users, the Business Central server, the webshop and the carriers, an arrow table saying who starts each call and whether a user waits, a table of where each part sits, and the notes to remember (outbound HTTP, API key, job queue, telemetry). It uses the same names and ids as `docs/design/object-ids.md`. The mermaid source was written by hand and has not been rendered here.

| Checklist item | Where |
|---|---|
| Users, BC service, webshop and carriers with direction of every call | The diagram (arrows 1-17) and the arrow table. |
| Carrier calls from a codeunit behind `CRF ICarrier`, not a page | Arrow 13 starts at `CRF Carrier A/B`; pages only reach the facade (arrow 4). |
| Polling from the job queue in the background, webshop uses API pages | Arrows 10-11 and 5-6. |
| Setup, assisted setup, telemetry, permission set each placed | "Where the parts are", and nodes in the diagram. |
| Allow HttpClient Requests noted | "Things to remember", first bullet. |

Not verified: that the diagram renders (mermaid is not installed here); do not take its layout for checked. No AL changed; `scripts/compile.sh app` is still 0 errors.
