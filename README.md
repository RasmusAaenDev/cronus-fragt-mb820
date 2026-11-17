# Step 10: Add an assisted setup guide

Cronus Fragt · MB-820 workbook · Build the solution › Setup and assisted setup

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When we create a new company, or a new colleague has to set up the freight, I'd like the system to guide them
> through it step by step, like the guides we used when we started with Business Central. It should be in the
> same place as the other guides, so nobody has to remember where it's hiding.

## Your task

Build an assisted setup guide for the freight setup: the NavigatePage CRF Freight Setup Guide (page 50104) with a welcome step, a step for the default carrier, a step for the shipment number series and a final step, with Back, Next and Finish buttons. The guide must not save anything until the user chooses Finish; then it writes the values to the CRF Freight Setup record. Register the guide on the Assisted Setup page through the Guided Experience codeunit, in a codeunit of its own (for example 50105 CRF Assisted Setup Subs), with a title, a short title, a description and an assisted setup group. Publish, open Assisted Setup, run the guide and check the result on the CRF Freight Setup page.

## Checklist

- [ ] Page 50104 CRF Freight Setup Guide is a NavigatePage with a welcome, a default carrier, a number series and a finish step.
- [ ] The Back, Next and Finish actions appear at the bottom of the guide and are enabled only where they make sense.
- [ ] Values are saved to CRF Freight Setup only when the user chooses Finish; closing the guide earlier changes nothing.
- [ ] An event subscriber registers the guide through the Guided Experience codeunit, and it appears on the Assisted Setup page.
- [ ] Running the guide from Assisted Setup updates the default carrier and the shipment number series on the setup page.

## In this branch

- [Notes for this step](docs/steps/10-assisted-setup.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/09-setup-and-assisted-setup/create-the-setup-page-and-open-it-from-search...10-setup-and-assisted-setup/add-an-assisted-setup-guide)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/assisted-setup

---

[← Step 9](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/09-setup-and-assisted-setup/create-the-setup-page-and-open-it-from-search/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 11 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/11-shipment/create-the-shipment-tables/README.md)
