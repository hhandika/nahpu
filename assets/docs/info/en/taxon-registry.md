---
title: "Taxon registry"
sidebar:
  order: 0
---

The registry contains the taxonomic names available to this project. Specimen records point to a registered taxon for their identification.

Add taxa manually or import `.xlsx`, `.csv`, or `.tsv` files. Manual registration asks for a `Taxon rank` first and then shows the name fields down to that rank. Imports accept class, order, family, genus, species, and subspecies records. Each row requires the classification fields from class through its selected rank. Review every detected column mapping before import.

A file may omit `Taxon rank`, `Kingdom`, `Phylum`, and `Class`. If `Class` is not mapped, select the supported class shared by all rows in `Select the class shared by all rows`. NAHPU fills missing kingdom and phylum values for known classes and preserves supplied values. If no rank is provided, order, family, genus, and specific epithet must be complete; the rank is species, or subspecies when a subspecific epithet is present. Files containing multiple classes need a `Class` column.

The panel counts the distinct orders, families, and full species names held in the registry. A total taxa count appears when the registry also holds names above or below species rank. These are registry counts; the statistics panel reports the taxa that specimen records actually use.

For QR import, select `Scan QR`, then `Single taxon` or `Multiple taxa`. A single valid scan opens the preview; multiple mode keeps the camera open until `Done`. Review and import the selected taxa to save them. Existing taxa are disabled and never overwritten.

Editing a registered taxon changes the shared name record. To correct only one specimen’s identification, select the appropriate taxon on that specimen instead.

## Learn more

- [Taxon Registry](https://nahpu.app/en/usages/taxon/)
