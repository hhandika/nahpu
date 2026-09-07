---
title: "Site geography"
sidebar:
  order: 0
---

Geography describes the administrative hierarchy of the site, from country down to the precise locality, with remarks for context that does not fit a named field. Which geographic fields appear is configurable in Settings.

`Find existing locality` matches what you type against every locality already saved in the project. Selecting a suggestion fills the whole hierarchy at once, and each field also suggests values already recorded for that field. Localities are stored once and shared between sites, so reusing a saved one avoids creating a near-duplicate record.

Enter values according to the responsible institution’s geographic conventions. `Precise Locality` should describe the specific named place below municipality level.

## Darwin Core context

The geographic fields export to `dwc:country`, `dwc:islandGroup`, `dwc:stateProvince`, `dwc:county`, and `dwc:municipality`. The precise locality is exported as `dwc:verbatimLocality` because it is recorded as written rather than normalized, and remarks become `dwc:locationRemarks`.
