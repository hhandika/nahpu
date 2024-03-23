---
sidebar_position: 2
title: "Development Roadmap"
---

## Overview

NAHPU development focuses on three key areas: **efficiency**, **reproducibility**, and **inclusivity**. Inspired by the [Flutter Roadmap](https://github.com/flutter/flutter/wiki/Roadmap), we have created a roadmap to guide the development of NAHPU. The roadmap outlines the key features and improvements that we plan to implement in the upcoming releases. It is also a way to provide transparency to the community and gather feedback on the direction of the project. Just like most software development projects, the roadmap is subject to change based on feedback and new requirements. We welcome contributions from the community to help us achieve our goals.

## Year 2024

Our focus for 2024:

### Efficiency

We are working on adding more Rust code to the NAHPU codebase. Rust integration with Flutter offers a performance boost and a more robust user experience. Rust also has a high quality GIS library, which will help us improve the spatial data processing capabilities of NAHPU.

We will also work toward improving code quality and performance by refactoring the existing codebase and optimizing the application for speed and memory usage. Many NAHPU code requires documentation, and we will work on improving the documentation to make it more accessible to developers.

### Reproducibility

The main focus is to fully implement the [Darwin Core](https://dwc.tdwg.org/) standard and [FAIR principles](https://www.go-fair.org/fair-principles/). This will help us make NAHPU data more interoperable and reusable. We will also work on improving the data import and export capabilities of NAHPU to make it easier for users to share and collaborate on data. QR/Barcode scanning have been implemented in NAHPU. We will work on improving the scanning capabilities. One main goal is to simplify the specimens inventory process by allowing users to scan specimens and automatically populate the inventory after fieldwork. This approach will be integrated by developing printing capabilities for specimen tags.

### Inclusivity

We’re enhancing NAHPU’s accessibility with screen reader support and other assistive technologies. We’re also broadening its localization by adding more languages and making it user-friendly for non-English speakers. Additionally, we’re improving the experience for users with disabilities to make NAHPU more accessible and inclusive.
