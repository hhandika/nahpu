---
title: "Sampling effort"
sidebar:
  order: 0
---

Effort records describe how sampling was carried out. Add each method separately and record the number of units, the brand and model of the equipment, its size or dimensions, and notes. Include the units in the size values (e.g. "10cm x 10cm x 10cm").

Use the same units and controlled method names throughout the project so efforts can be compared. State enough context for another person to understand the effort without inferring missing details. Using duplicate events will copy the effort records.

## Darwin Core context

In a tabular export, the method maps to `dwc:samplingProtocol` and the notes to `dwc:samplingEffort`. Count, brand, and size have no Darwin Core equivalent and keep their NAHPU headers. Darwin Core Archives and Data Packages carry the event’s own activity and notes instead, so record anything an archive must report at the event level as well.
