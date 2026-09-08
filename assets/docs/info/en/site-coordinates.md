---
title: "Site coordinates"
sidebar:
  order: 0
---

A site can have several coordinate records. Each one should describe a documented position, with its coordinate format, elevation, geodetic datum, uncertainty, GPS unit, and notes about the source.

Manual entry accepts decimal degrees (DD), degrees and decimal minutes (DDM), degrees-minutes-seconds (DMS), and WGS84 UTM. `Select coordinate file` imports CSV, TSV, Excel, GeoJSON/JSON, KML, zipped Shapefile, and GPX; `Scan QR` reads a NAHPU coordinate QR code. Review every imported position before saving it.

For coordinate entered in non-decimal degree format, NAHPU will store both the entered coordinates and automatically converted decimal degree values.

## Learn more

- [Sites](https://nahpu.app/en/usages/sites/#adding-coordinates)
