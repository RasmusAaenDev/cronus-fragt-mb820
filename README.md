# Step 20: Keep the API key out of the table

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The carrier has sent us a password for their system. It must not sit somewhere that anyone can find it, and it
> must not show in clear text on the screen if someone looks over my shoulder. But I need to be able to change
> it myself on the freight setup when they send a new one.

## Your task

Store the carrier's API key in isolated storage, not in a table field. Add procedures to CRF Freight Setup (table 50100) that set, get and clear the key: SetEncrypted with DataScope::Company to store it, Get into a SecretText to read it, Delete to clear it, and Contains to tell the page whether a key is stored. Add an API Key field to the CRF Freight Setup page that is bound to a page variable, not to a table field, uses ExtendedDatatype = Masked, saves the key through the table procedure when it is validated and shows only a placeholder afterwards. Finally send the key to the fictional service as a header with HttpHeaders.Add(Text, SecretText). Tell Mette in two sentences why the key isn't a field in the setup table.

## Checklist

- [ ] CRF Freight Setup has no API key field; the key is stored with IsolatedStorage.SetEncrypted and DataScope::Company under a locked key name.
- [ ] The table procedure that returns the key returns SecretText, and the key reaches the request only through HttpHeaders.Add(Text, SecretText).
- [ ] The API Key field on the setup page is bound to a page variable with ExtendedDatatype = Masked, and the stored key is never loaded into it.
- [ ] Entering a new key replaces the stored one, clearing the field deletes it, and the page shows whether a key is stored.
- [ ] Your note for Mette explains that a field in the setup table can be read by anyone who can read that table, and that masking only changes how a value is shown.

## In this branch

- [Notes for this step](docs/steps/20-api-key-storage.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/19-carriers-and-the-outbound-api/call-the-carrier-s-service...20-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/api-key-storage

---

[← Step 19](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/19-carriers-and-the-outbound-api/call-the-carrier-s-service/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 21 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/21-carriers-and-the-outbound-api/update-shipment-status-from-the-carrier/README.md)
