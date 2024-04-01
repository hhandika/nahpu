---
sidebar_position: 2
title: "Development Roadmap"
---

## Overview

NAHPU development is centered around three key areas: **efficiency**, **reproducibility**, and **inclusivity**. Drawing inspiration from the [Flutter Roadmap](https://github.com/flutter/flutter/wiki/Roadmap), we have devised a roadmap to steer the development of NAHPU. This roadmap delineates the principal features and enhancements that we aim to incorporate in the forthcoming releases. It serves as a medium to maintain transparency with the community and to collect feedback on the project’s trajectory. As is the case with most software development projects, our roadmap is flexible and may be modified based on feedback and emerging requirements. We wholeheartedly welcome contributions from the community to assist us in realizing our objectives.

## Focus of Development for the Year 2024

### Efficiency

We are in the process of incorporating more Rust code into the NAHPU codebase. The integration of Rust with Flutter not only enhances performance but also provides a more robust user experience. Furthermore, Rust boasts a high-quality GIS library, which will aid us in augmenting the spatial data processing capabilities of NAHPU.

In addition to this, we will strive to enhance code quality and performance by refactoring the existing codebase and optimizing the application for speed and memory usage. A significant portion of the NAHPU code requires documentation, and we will focus on improving this documentation to make it more developer-friendly.

### Reproducibility

Our primary goal is on the full implementation of the [Darwin Core](https://dwc.tdwg.org/) standard and [FAIR principles](https://www.go-fair.org/fair-principles/). This will enhance the interoperability and reusability of NAHPU data. We also aim to improve the data import and export capabilities of NAHPU, making it easier for users to share and collaborate on the app data. QR/Barcode scanning has been implemented in NAHPU, and we plan to enhance these scanning capabilities. A key goal is to simplify the specimen inventory process by enabling users to scan specimens and automatically populate the inventory post-fieldwork. This approach will be integrated with the development of printing capabilities for specimen tags.

### Inclusivity

The primary objective is to expand the app’s localization by incorporating more languages, thereby making it user-friendly for non-English speakers. In addition, we are enhancing the experience for users with disabilities to make NAHPU more accessible and inclusive. The current version allows users to utilize voice input through the operating system’s accessibility features. We plan to implement additional features, including screen readers.
