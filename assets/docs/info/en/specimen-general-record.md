---
title: "Specimen general record"
sidebar:
  order: 0
---

The general record holds the specimen’s working identifier, the people responsible for it, its taxon, and its preparation context and condition. Depending on project settings, the Field ID combines a Cataloger’s initials with a personal field number, or the project prefix and suffix with a project catalog number.

Choose the taxon from the taxon registry. If it doesn't exist, check if you have registered that taxon in the project's taxon registry first.

Record Cataloger, Preparator, and Determiner according to the work each person actually did. Describe condition at preparation from direct evidence, and preserve collection and preparation dates and times when they are known.

## Darwin Core context

The specimen record is exported as a `dwc:Occurrence`: its internal identifier becomes `dwc:occurrenceID` and the Field ID becomes `dwc:catalogNumber`. NAHPU writes `dwc:basisOfRecord` as `PreservedSpecimen`, or as `HumanObservation` when the condition is `Released`. The identification method maps to `dwc:identificationType` and ID confidence to `dwc:identificationVerificationStatus`.
