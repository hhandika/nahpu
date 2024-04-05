---
sidebar_position: 3
title: Switch to NAHPU
---

NAHPU is specifically designed as a digital field catalog for natural history collections. It offers an alternative to other solutions such as pre-formatted traditional paper-based field catalogs and no-code custom-built form apps like [Claris FileMaker](https://www.claris.com/). This guide provides comprehensive instructions on transitioning from paper-based field catalogs and custom-built form apps to NAHPU.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Transition from Paper-based Field Catalogs](#transition-from-paper-based-field-catalogs)
  - [Benefits of Using NAHPU](#benefits-of-using-nahpu)
  - [Approaches to Transition from Paper-based Field Catalogs](#approaches-to-transition-from-paper-based-field-catalogs)
- [Transition from Custom-built Form Apps](#transition-from-custom-built-form-apps)

## Transition from Paper-based Field Catalogs

### Benefits of Using NAHPU

While paper-based field catalogs have traditionally been the go-to method for collecting natural history data due to their simplicity and ease of use, NAHPU presents a more efficient and cost-effective alternative. Here are some key advantages of using NAHPU over paper-based field catalogs:

- **Cost-Effectiveness**: NAHPU is free to use, eliminating the need for paper, ink, binders, and additional storage space. In contrast, paper-based field catalogs require ongoing expenses for these materials. Additionally, NAHPU can operate on a personal smartphone, eliminating the need for additional investment. A decent dedicated tablet from a quality brand starts at around $200-$500 and can last for five years. Even if a hard copy is required, NAHPU catalogs can still be printed.

- **Data Accessibility**: NAHPU enables you to access your data from any location and share it with collaborators, ensuring they receive an exact copy of the data. In contrast, paper-based catalogs necessitate physically transporting the catalogs, sending scanned images of the pages, or input the records to a spreadsheet, which can delay access until you return from the field and digitize the data.

- **Data Quality**: NAHPU aids in standardizing your data collection and helps prevent common secondary data entry errors that can occur when digitizing paper-based field catalogs. Future NAHPU updates will include automatic data validation features.

- **Data Association**: NAHPU allows you to link your data with other data sources, such as GPS coordinates, images, and audio recordings. You only need to enter a site once, and it can be associated with multiple data entries. Paper-based catalogs, on the other hand, require you to write the same site multiple times, typically at the top of each page.

- **Data Security**: NAHPU simplifies the process of data backup. With NAHPU, you can save time, reduce errors, and optimize storage space usage. When connected to the internet, data can be easily backed up to cloud services, such as Google Drive or Dropbox. In addition, NAHPU supports cross-device data sharing and allows data to be copied to a flash drive, many of which are designed to be water and shockproof, providing an extra layer of data security. This is a stark contrast to the process for paper-based catalogs, which requires each page to be photographed or manually entered into a spreadsheet. This method is not only time-consuming and error-prone, but it may also require additional storage space.

- **Data Findability**: NAHPU incorporates a search feature, enabling you to effortlessly locate your data. This is a significant advantage over paper-based catalogs, which require manual data searching and lack an easy method for filtering data based on specific criteria. Moreover, NAHPU adheres to the [Darwin Core](https://dwc.tdwg.org/) standard and the [FAIR (Findable, Accessible, Interoperable, and Reusable) principles](https://www.go-fair.org/). This ensures that your data is not only easily discoverable and accessible, but also interoperable and reusable.

- **Real-time Statistics**: Manual counting is no longer necessary with NAHPU. It provides summaries for species and family counts per project and site, preservation summaries per project and per species, and allows you to export your data to a spreadsheet for further analysis. Paper-based catalogs require manual data counting and make real-time data updates challenging.

### Approaches to Transition from Paper-based Field Catalogs

Two typical approaches to transition to NAHPU from paper-based field catalogs:

- Soft approach. Use NAHPU to supplement paper-based field catalogs.

- Hard approach. Use NAHPU as the only field catalog. You can bring paper-based field catalogs as backup.

Several factors to consider when transitioning to NAHPU:

- **Device choice**. The app is designed to work on various devices, including smartphones, tablets, laptops, and desktops. You can start using your own smartphone. If you have the budget, we recommend using a tablet and a bluetooth keyboard for a better experience. Depending on the field conditions, you may be able to use a laptop in the field. See the [Devices Requirements](./usages/devices) section for more information.

- **Field conditions**. NAHPU is designed for remote field sites without internet access. Consider device durability and electricity availability. Some new smartphones are water and dust resistant. Tablets and laptops may need extra protection. Use a sturdy case whenever possible. For areas without electricity, typically a 20,000 to 25,000 mAh power bank is sufficient for a week of fieldwork using a smartphone or tablet.

- **Data Backup Options**. A flash drive can be utilized for data backup. Depending on your device’s compatibility, a USB-C flash drive or an adapter may be required for connection. As an alternative or supplementary measure, cross-backup with another smartphone or tablet in the field is also an option. If you have reliable internet access, cloud services such as Google Drive or Dropbox can be used for data backup. However, it’s important to note that this data transfer process requires the installation of a specific application on your device and appropriate account access.

## Transition from Custom-built Form Apps

NAHPU, purpose-built to serve the unique requirements of natural history collections, presents a user-friendly and economically viable alternative to custom-built form apps. These custom apps often entail substantial development and maintenance expenses, whereas NAHPU offers a more cost-effective and efficient solution. We are dedicated to the ongoing enhancement of both the app and its supporting documentation to cater to our users’ evolving needs. Transitioning from custom-built form apps to NAHPU is a more straightforward process compared to the shift from paper-based field catalogs. You should be able to adapt your data entry, backup, and export method to using NAHPU. Here are some key benefits of migrating to NAHPU from custom-built form apps:

- **Cost-Effectiveness**: NAHPU is free to use, eliminating any additional development costs. In contrast, custom-built form apps can be expensive to develop and maintain. For instance, [Claris FileMaker](https://www.claris.com/), a widely-used custom-built form app, necessitates a paid subscription. More details can be found on their [pricing page](https://www.claris.com/pricing/) .

- **Enhanced Data Findability and Accessibility**: NAHPU is engineered to simplify data searching and access. We strive for full compliance with the Darwin Core standard and FAIR principles, ensuring your data is easily findable and accessible. Custom-built form apps may not offer the same level of data findability and accessibility.

- **Open Source Advantage**: NAHPU is an open-source application that utilizes open-source libraries. Additionally, the app supports common data formats, such as CSV and JSON, facilitating easy import into other software for further analysis. The database used is SQLite, a widely adopted open-source database, allowing you to access the database independently of the app. In contrast, custom-built form apps may not be open source and may employ proprietary data formats.

- **Accessible and User-Friendly Interface**: NAHPU, designed with inclusivity in mind, leverages the accessibility features of Flutter and Material Design. This ensures a user-friendly interface that caters to individuals with visual impairments. The application’s cross-platform design allows it to function seamlessly on a wide range of devices, including smartphones, tablets, laptops, and desktops. This broad compatibility stands in contrast to custom-built form apps, which may face limitations in device compatibility and accessibility.
