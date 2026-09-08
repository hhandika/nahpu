---
title: "Tabular export presets"
sidebar:
  order: 0
---

A tabular export preset saves a repeatable definition: the record type, the specimen taxon group, the selected fields and their order, the generated header format, and how repeated values are written. The output format, file name, and destination are chosen during exports.

`Generated header format` chooses how headers are named: `table::fieldName`, `fieldName`, Darwin Core, or the NAHPU namespace. Repeated values can be written as one column with a separator, or spread into indexed columns such as `field_1`, `field_2`. Test a preset with representative records, including missing and repeated values, before relying on it, and transfer user configurations when collaborators need the same definition.

Settings are saved as you change them, but the preset name is not: type a new name and select `Rename` to commit it. Export a single preset from its row, or all presets from the options menu; either file imports through the same action.

## Learn more

- [Export Records](https://nahpu.app/en/usages/export/export-records/)
- [Bundle Records](https://nahpu.app/en/usages/export/export-bundles/)
