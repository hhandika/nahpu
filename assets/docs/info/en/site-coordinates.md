---
title: "Site coordinates"
sidebar:
  order: 0
---

A site can have several coordinate records. Each one should describe a documented position, with its coordinate format, elevation, geodetic datum, uncertainty, GPS unit, and notes about the source.

Manual entry accepts decimal degrees (DD), degrees and decimal minutes (DDM), degrees-minutes-seconds (DMS), and WGS84 UTM. `Select coordinate file` imports CSV, TSV, Excel, GeoJSON/JSON, KML, zipped Shapefile, and GPX; `Scan QR` reads a NAHPU coordinate QR code. Review every imported position before saving it.

For coordinate entered in non-decimal degree format, NAHPU will store both the entered coordinates and automatically converted decimal degree values.

## Darwin Core context

Derived decimal values export to `dwc:decimalLatitude` and `dwc:decimalLongitude`, and the entry as typed is kept in `dwc:verbatimCoordinates`, `dwc:verbatimLatitude`, `dwc:verbatimLongitude`, and `dwc:verbatimCoordinateSystem`. Datum, uncertainty, and notes become `dwc:geodeticDatum`, `dwc:coordinateUncertaintyInMeters`, and `dwc:georeferenceRemarks`. A single elevation fills both `dwc:minimumElevationInMeters` and `dwc:maximumElevationInMeters`.
