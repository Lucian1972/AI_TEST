# Gift Card Enhancement for Manage Sales Orders - Version 2

## What This Project Does

This project implements SAP S/4HANA Cloud developer extensibility to enhance the standard
Manage Sales Orders - Version 2 Fiori application with gift card discount functionality.
A custom RAP Business Object (ZXE4_I_GIFTCARD) is created to store and maintain gift card
master data (number, description, amount, currency). The standard Sales Order RAP BO
(R_SalesOrderTP / I_SalesOrderTP) is then extended at the persistent table level (VBAK via
SDSALESDOC_INCL_EEW_PS), at the interface CDS view level, and at the behavior definition
level to surface a custom action "Use Gift Card" (zz_use_gift_card). This action is enabled
only when the sales order net value exceeds EUR 50 and, when triggered, deducts the gift
card amount from the sales order net price by creating a DRV1 pricing element. A dedicated
OData V4 Fiori Elements List Report app (deployed via SAP Business Application Studio)
provides the gift card maintenance UI.

---

## All Objects

| # | Object Name                        | Type                           | Description                                    |
|---|------------------------------------|--------------------------------|------------------------------------------------|
| 1 | ZXE4_GIFTCARDNUMBER                | Domain (NUMC 10)               | Data element domain for gift card number       |
| 2 | ZXE4_GIFTCARDDESC                  | Data Element (CHAR 40)         | Gift card description                          |
| 3 | ZXE4_GIFTCARDAMT                   | Data Element (CURR 15,2)       | Gift card amount                               |
| 4 | zxe4_giftcard                      | Database Table                 | Persistent gift card data                      |
| 5 | zxe4_giftcard_d                    | Database Table (Draft)         | Draft table for gift card BO                   |
| 6 | ZXE4_I_GIFTCARD                    | CDS Interface View             | Root view entity for gift card BO              |
| 7 | ZXE4_C_GIFTCARD                    | CDS Consumption View           | Projection view for gift card Fiori app        |
| 8 | ZXE4_C_GIFTCARD (mext)             | CDS Metadata Extension         | UI annotations for gift card list/object page  |
| 9 | ZXE4_GIFTCARDVH                    | CDS View (Value Help)          | Value help for gift card number                |
|10 | ZXE4_ASSIGNGIFTCARDTOSOP           | CDS Abstract Entity            | Action parameter entity for gift card action   |
|11 | ZXE4_SALESORDER_APPEND             | Append Structure               | Extends SDSALESDOC_INCL_EEW_PS (VBAK)         |
|12 | ZXE4_E_SALESDOCUMENT_EXT           | CDS View Extension             | Extends E_SALESDOCUMENTBASIC                   |
|13 | ZXE4_R_SALESORDERTP_EXT            | CDS View Extension             | Extends R_SALESORDERTP                         |
|14 | ZXE4_I_SALESORDERTP_EXT            | CDS View Extension             | Extends I_SALESORDERTP                         |
|15 | ZXE4_C_SALESORDERMANAGE_EXT        | CDS View Extension             | Extends C_SalesOrderManage (projection)        |
|16 | ZXE4_I_GIFTCARD (bdef)             | Behavior Definition (managed)  | Gift card BO: create/update/delete + draft     |
|17 | ZXE4_C_GIFTCARD (bdef)             | Behavior Definition (proj.)    | Gift card projection behavior                  |
|18 | ZXE4_GIFTCARD_EXT (bdef)           | Behavior Definition Extension  | Extends R_SalesOrderTP with zz_use_gift_card   |
|19 | ZXE4_C_SALESORDERMANAGE_B_EXT      | Behavior Definition Extension  | Extends C_SalesOrderManage projection          |
|20 | ZBP_XE4_I_GIFTCARD                 | ABAP Class (behv impl)         | Handler class for gift card BO                 |
|21 | ZBP_XE4_GIFTCARD_EXT               | ABAP Class (behv impl)         | Handler class for sales order extension        |
|22 | ZXE4_SD_GIFTCARD                   | Service Definition             | OData service exposing gift card entities      |
|23 | ZXE4_UI_GIFTCARD_V4                | Service Binding (OData V4 UI)  | Published service for the Fiori app            |
|24 | ZXE4_GIFTCARDNUMBER (domain)       | Domain XML                     | NUMC(10) domain definition                     |
|25 | ZXE4_GIFTCARD_UI_EXT               | IAM App (EXT)                  | IAM app for gift card Fiori UI                 |
|26 | ZBC_XE4_GIFTCARD                   | Business Catalog               | Business catalog for gift card scenario        |

---

## Prerequisites

Before activating the objects in ADT, ensure the following business roles are assigned to
your development user:

- `SAP_BR_DEVELOPER` - required for ABAP development in ADT
- `SAP_BR_ADMINISTRATOR` - required for managing business roles and communication systems
- `SAP_BR_EXTENSIBILITY_SPEC` - required for key user adaptation (UI adaptation step)
- `SAP_BR_INTERNAL_SALES_REP` - required to access Manage Sales Orders - Version 2
- `Business_Application_Studio_Developer` (SAP BTP) - required for the Fiori app deployment

Also ensure:
- SAP BTP subaccount with SAP Business Application Studio entitlement
- A destination configured in SAP BTP pointing to the SAP S/4HANA Cloud API endpoint
- A Communication System created in S/4HANA Cloud (Inbound Only, SAML Bearer)

---

## Activation Order in ADT (Eclipse)

Follow this exact sequence to avoid dependency errors:

1. **Domain** - Activate `ZXE4_GIFTCARDNUMBER` domain (NUMC 10)
2. **Data Elements** - Activate `ZXE4_GIFTCARDNUMBER`, `ZXE4_GIFTCARDDESC`, `ZXE4_GIFTCARDAMT`
   (create manually in ADT, not generated as files here)
3. **Append Structure** - Activate `ZXE4_SALESORDER_APPEND`
   (extends SDSALESDOC_INCL_EEW_PS - this extends the VBAK table)
4. **Database Tables** - Activate `zxe4_giftcard` then `zxe4_giftcard_d`
5. **CDS Interface View** - Activate `ZXE4_I_GIFTCARD`
6. **CDS View Extensions** (activate in order):
   - `ZXE4_E_SALESDOCUMENT_EXT` (extends E_SALESDOCUMENTBASIC)
   - `ZXE4_R_SALESORDERTP_EXT` (extends R_SALESORDERTP)
   - `ZXE4_I_SALESORDERTP_EXT` (extends I_SALESORDERTP)
7. **Interface-layer Behavior Definition** - Activate `ZXE4_I_GIFTCARD` behavior definition
8. **Behavior Extension on R_SalesOrderTP** - Activate `ZXE4_GIFTCARD_EXT` behavior definition
   (then create implementation class `ZBP_XE4_GIFTCARD_EXT` via Quick Fix in ADT)
9. **Behavior Implementation Classes** - Activate `ZBP_XE4_I_GIFTCARD` and
   `ZBP_XE4_GIFTCARD_EXT` (paste Local Types code from
   `zbp_xe4_giftcard_ext.clas.locals_imp.abap`)
10. **Value Help CDS View** - Activate `ZXE4_GIFTCARDVH`
11. **Abstract Entity** - Activate `ZXE4_ASSIGNGIFTCARDTOSOP`
12. **CDS Consumption View** - Activate `ZXE4_C_GIFTCARD` and metadata extension
13. **Projection Behavior Definitions** - Activate `ZXE4_C_GIFTCARD` bdef
14. **Sales Order Projection Extension** - Activate `ZXE4_C_SALESORDERMANAGE_EXT` and
    `ZXE4_C_SALESORDERMANAGE_B_EXT`
15. **Service Definition** - Activate `ZXE4_SD_GIFTCARD`
16. **Service Binding** - Activate `ZXE4_UI_GIFTCARD_V4` then choose Publish
17. **IAM App** - Create `ZXE4_GIFTCARD_UI` (EXT type), link to `ZXE4_GIFTCARD_UI5R`,
    choose Publish Locally
18. **Business Catalog** - Create `ZBC_XE4_GIFTCARD`, add IAM apps, choose Publish Locally

---

## Fiori App Deployment (SAP Business Application Studio)

1. Open SAP Business Application Studio, create a folder `zxe4_giftcard` in your projects
2. Use Start from Template > SAP Fiori Application > List Report Page
3. Connect to your S/4HANA Cloud destination, select service `ZXE4_UI_GIFTCARD_V4`
4. Main entity: `GiftCard`
5. Project Attributes:
   - Module Name: `zxe4_giftcard`
   - Application Title: `Gift Card Details`
   - Application Namespace: `zxe4_giftcard`
6. Deployment Config:
   - SAPUI5 ABAP Repository: `ZXE4_GIFTCARD`
   - Package: `ZXE_S4`
7. FLP Config:
   - Semantic Object: `GiftCard`, Action: `maintain`
   - Title: `Gift Card Details`, Subtitle: `Maintain`
8. Run `npm run deploy` to deploy to S/4HANA Cloud
9. Verify objects `ZXE4_GIFTCARD_UI5R` and `ZXE4_GIFTCARD` appear in package `ZXE_S4`

---

## Runtime Setup

### Business Role and User Assignment

1. Log on to SAP Fiori launchpad as Administrator
2. Open the Maintain Business Roles app
3. Create business role `ZBR_XE4_GIFTCARD` (description: Gift Card Scenario)
4. Assign business catalog `ZBC_XE4_GIFTCARD`
5. Set Write/Read/Value Help access to Unrestricted
6. Assign the business user who will maintain gift cards

### Key User UI Adaptation (to display gift card amount in Sales Order)

1. Log on with a user having `SAP_BR_EXTENSIBILITY_SPEC` and `SAP_BR_INTERNAL_SALES_REP`
2. Navigate to Manage Sales Orders - Version 2
3. Choose Create Sales Order (any org data)
4. Open the Actions menu and choose Adapt UI
5. On the General Information tab, under Order Data, right-click and choose Add: Field
6. Search for and add "Gift Card Amount"
7. Choose Activate New Version (name it "Gift Card") then Publish Version

---

## End-to-End Walkthrough

### Step 1 - Create a Gift Card

1. Log on with the user assigned the `ZBR_XE4_GIFTCARD` business role
2. Open the Gift Card Details tile on the SAP Fiori launchpad
3. Choose Create and enter:
   - Gift Card Number: `1001`
   - Description: `EUR 20 Gift Card`
   - Gift Card Amount: `20.00`
   - Currency: `EUR`
4. Choose Create - a EUR 20.00 gift card is now available

### Step 2 - Apply the Gift Card to a Sales Order

1. Log on with a user assigned the `SAP_BR_INTERNAL_SALES_REP` role
2. Open Manage Sales Orders - Version 2 and create a new Standard Order (OR)
3. Set Sales Organization 1010, Distribution Channel 10, Division 00
4. Add sold-to party and a line item (e.g. product TG11, quantity 10)
5. When the net value exceeds EUR 50, the "Use Gift Card" action becomes active
6. Click Use Gift Card, enter Gift Card `1001` (EUR 20 Gift Card), confirm
7. Navigate to the Prices tab - a DRV1 price element for EUR -20.00 is visible,
   reflecting the deduction from the sales order net price

---

## Notes and Assumptions

- **Namespace**: The package `ZXE_S4` and namespace prefix `ZXE4_` are used exactly as
  specified in the PDF (Extensibility Explorer Scenario 4).
- **Condition type DRV1**: The PDF uses `DRV1` as the pricing condition type for the
  gift card deduction. Ensure this condition type is configured in your system. If it is
  not available, substitute with your system's custom discount condition type (the code
  comment `"conditiontype = 'XXXX'` in the PDF hints at this).
- **EUR 50 threshold**: The action is disabled when `TotalNetAmount < '50'`. The currency
  is not checked separately - this matches the PDF example where EUR 175.50 triggers it.
- **Draft support**: The gift card BO uses draft, enabling the Fiori Elements list report
  to support optimistic locking and the standard Edit/Discard/Activate draft flow.
- **No number range object**: The PDF does not define a number range object for gift cards.
  Gift card numbers are entered manually by the user (NUMC 10 field, not auto-generated).
  The `ZXE4_GIFTCARDNUMBER` data element and domain define the field type only.
- **SAP BTP Fiori deployment**: The Fiori app source code is generated by the SAP Fiori
  tools wizard in Business Application Studio. Only the ABAP backend artifacts are included
  in this project. Run the wizard as described in the Fiori App Deployment section above.
