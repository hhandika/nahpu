---
title: "Weather and astronomy"
sidebar:
  order: 0
---

Weather fields describe the conditions observed during the collecting event, including air temperature and humidity, cloud cover, rainfall. You can select the fields to show in the environmental data in the event settings.

Do not copy weather between events unless the measurement truly applies to both.

## Darwin Core context

Weather, water, and astronomy values have no Darwin Core term of their own. Structured exports carry each recorded value as a measurement of the event, keeping its type and unit, and the environment notes become `dwc:eventRemarks`.
