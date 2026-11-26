# Step 4: Design document, part 1: the object list

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 3](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/b0c0af354f882f8dc6e12705f8a813705661a431...b03477bb2d0810d172b951c2b5595f30ec417b92)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Hi! Before you get started, I've collected what we need. For every shipment we send to a customer we want to
> keep track of the delivery address, the shipping agent, the status and the package tracking number, and a
> shipment can consist of several packages with weight and dimensions. Our shipping agents are already in
> Business Central, and so is each customer's regular shipping agent. We need one place where we choose our
> regular shipping agent, and somewhere to store the address and access to each shipping agent's system. The
> warehouse wants a freight list they can print, the webshop must be able to see and create shipment tracking,
> and the status should preferably update itself. When the warehouse posts a delivery, the tracking should be
> created automatically. We use several shipping agents today, and there will definitely be more. Can you
> write down what needs to be built?

## Your task

**What you hand in:** A written design document, not AL code. You build nothing in this step: you write down which objects the extension will need and how they relate. Keep it in a document or text file of your own, and compare it with the model answer when you are done.

Mette has told you what Cronus Fragt must be able to do. Turn her wishes into the first part of the design document: a list of the AL objects the extension will contain, and a description of how they relate. The code comes later, in phase 3, and this list is what you will build from.

**For every object, write down**

- Its type, for example table, page, codeunit, enum, interface, report or permission set.
- Its name, starting with the CRF affix, for example CRF Shipment Tracking Header.
- Its id, in the project range 50100-50149. An interface has a name but no id.
- One line on what it is for.

**Make sure the list covers at least**

- The setup, as a table and a page.
- The shipment tracking document, with a header and lines.
- The settings Cronus Fragt adds to the standard shipping agent.
- The carrier and tracking status lists.
- The carrier contract and its implementations.
- The business logic.
- The warehouse report.
- The pages for users and for the webshop.
- The permission sets.

**Then describe the relations**

- How a shipment tracking line belongs to its header.
- How the header points to a customer and a shipping agent.
- How a shipping agent leads to the carrier implementation that talks to its web service.

## Checklist

- [ ] Every object in your list has a type, a name that starts with CRF and an id between 50100 and 50149.
- [ ] Shipment tracking is designed as a document, with a header table and a line table and a relation between them.
- [ ] The shipping agent is the standard Shipping Agent table, extended with a table extension; there is no Carrier master table of your own and no extension of Customer.
- [ ] Carriers are an enum that implements an interface, with one codeunit per carrier, and each shipping agent names its carrier.
- [ ] The list includes the setup table and page, the report, the API pages and the permission sets.
- [ ] You have written down the relations between tracking header, tracking lines, customer, shipping agent and carrier.

## In this branch

- [Notes for this step](docs/steps/04-requirements-to-objects.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/b0c0af354f882f8dc6e12705f8a813705661a431...b03477bb2d0810d172b951c2b5595f30ec417b92): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/requirements-to-objects

---

[← Step 3](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/03-environment-and-tools/publish-a-first-extension-and-attach-the-debugger/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 5 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/05-solution-design/extend-standard-or-build-your-own/README.md)
