---
title: "Collecting event overview"
sidebar:
  order: 0
---

A collecting event records one defined sampling effort at a site and time. Specimens link to an event for their site, dates, sampling context, and field team, so many specimen records can share a single event.

NAHPU builds the Event ID from the Site ID and the start date. Add a suffix only when another event would otherwise have the same identifier. 

How you create an event depends on the sampling protocol and whether you keep track of environmental data. For example, if you sample multiple days at the same site using the same protocol and no environmental data is recorded, you can keep the same event for all days. However, we recommend to create a new event at least once a day to keep track environmental data and potential changes in field team and equipment and ensure the event is recorded consistently. The `Duplicate` button in the top-right corner, can be used to create a new event with the same setup as an existing event.

## Darwin Core context

The event is exported as a sampling event: the Event ID becomes `dwc:eventID`, the site becomes `dwc:locationID`, and the dates and times become `dwc:eventDate` and `dwc:eventTime`. A date range is exported as a single ISO 8601 interval.
