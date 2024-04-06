---
sidebar_position: 3
title: Personnel
---

## Adding new personnel

Use the `Add new personnel` button to add new personnel. You will be asked to enter the following information below. The app by default only shows critical information. Click the `Show more` button to show all the fields.

- **Name (required)** - The name of the personnel.
- **Email** - The email of the personnel.
- **Phone** - The phone number of the personnel.
- **Affiliation** - The institution of the personnel.
- **Specimen care role (required)** - The role of the personnel in taking care of the specimens. See [Terminology](./personnel#terminology) for more information.
- **Field initials (required if the specimen care role is `Cataloger`)** - The initials of the personnel.
- **Field number (required if the specimen care role is `Cataloger`)** - The field number of the personnel. The initial and the number will be used for the field ID. The app auto-increment the number each time you create a new specimen. For example, if the field initial is `ABC` and the field number is `1`, the first specimen will have the field ID `ABC1`. The second specimen will have the field ID `ABC2`, and so on.
- **Notes** - Any notes about the personnel.

> **Important:** Some institutions may use a project ID and number combination for the field ID. Use this ID as the initial, instead of putting the actual initial of the person. For example, `ABC-1`. In this case, you can enter `ABC-` as the field initial and `1` as the field number.

## Editing person information

In the dashboard, click/tab the menu button (three dot icon) for the name of the person for which you want to edit information, then select edit. You will be taken to the personnel page where you can edit the information.

## Terminology

### Cataloger

A person who creates and edits records in the catalog. This includes creating new records, editing existing records, and deleting records. A `cataloger` role requires their field initial and their field number.

### Preparator only

A person who helps prepare the specimens but does not create or edit records in the catalog.

### None

In the specimen care role field, this means that the person does not have a role in taking care of the specimen. This can be a field guide, a driver, or anyone else who support data collection but does not have a role in taking care of the specimens.
