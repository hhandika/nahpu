---
sidebar_position: 3
title: Switch to NAHPU
---

NAHPU is specifically designed as a digital field catalog for natural history collections. It offers an alternative to other solutions such as pre-formatted traditional paper-based field catalogs and no-code custom-built form apps like [Claris FileMaker](https://www.claris.com/). This guide provides comprehensive instructions on transitioning from paper-based field catalogs and custom-built form apps to NAHPU. Additionally, it offers valuable recommendations on device selection and strategies for managing battery life in the field.

## Table of Contents

- [Transition from Paper-based Field Catalogs](#transition-from-paper-based-field-catalogs)
  - [Benefits of Using NAHPU](#benefits-of-using-nahpu)
  - [Approaches to Transition from Paper-based Field Catalogs](#approaches-to-transition-from-paper-based-field-catalogs)
- [Transition from Custom-built Form Apps](#transition-from-custom-built-form-apps)
- [Devices Requirements](#devices-requirements)
- [Strategies to manage devices battery life](#strategies-to-manage-devices-battery-life)

## Transition from Paper-based Field Catalogs

### Benefits of Using NAHPU

While paper-based field catalogs have traditionally been the go-to method for collecting natural history data due to their simplicity and ease of use, NAHPU presents a more efficient and cost-effective alternative. The long-term use of NAHPU can result in significant savings in time and money, as the costs associated with acid-free paper, ink, binders, and additional storage space are eliminated. Furthermore, the often time-consuming and error-prone process of data digitization is no longer a concern with NAHPU. Even if a hard copy is required, NAHPU catalogs can still be printed. Here are some key advantages of using NAHPU over paper-based field catalogs:

- **Data Accessibility**: NAHPU enables you to access your data from any location and share it with collaborators, ensuring they receive an exact copy of the data. In contrast, paper-based catalogs necessitate physically transporting the catalogs, sending scanned images of the pages, or input the records to a spreadsheet, which can delay access until you return from the field and digitize the data.

- **Data Quality**: NAHPU aids in standardizing your data collection and helps prevent common secondary data entry errors that can occur when digitizing paper-based field catalogs. Future NAHPU updates will include automatic data validation features.

- **Data Association**: NAHPU allows you to link your data with other data sources, such as GPS coordinates, images, and audio recordings. You only need to enter a site once, and it can be associated with multiple data entries. Paper-based catalogs, on the other hand, require you to write the same site multiple times, typically at the top of each page.

- **Data Security**: NAHPU simplifies the process of data backup. With NAHPU, you can save time, reduce errors, and optimize storage space usage. When connected to the internet, data can be easily backed up to cloud services such as Google Drive or Dropbox. In addition, NAHPU supports cross-device data sharing and allows data to be copied to a flash drive, many of which are designed to be water and shockproof, providing an extra layer of data security. This is a stark contrast to the process for paper-based catalogs, which requires each page to be photographed or manually entered into a spreadsheet. This method is not only time-consuming and error-prone, but it may also require additional storage space.

- **Data Findability**: NAHPU incorporates a search feature, enabling you to effortlessly locate your data. This is a significant advantage over paper-based catalogs, which require manual data searching and lack an easy method for filtering data based on specific criteria. Moreover, NAHPU adheres to the [Darwin Core](https://dwc.tdwg.org/) standard and the [FAIR (Findable, Accessible, Interoperable, and Reusable) principles](https://www.go-fair.org/). This ensures that your data is not only easily discoverable and accessible, but also interoperable and reusable.

- **Real-time Statistics**: Manual counting is no longer necessary with NAHPU. It provides summaries for species and family counts per project and site, preservation summaries per project and per species, and allows you to export your data to a spreadsheet for further analysis. Paper-based catalogs require manual data counting and make real-time data updates challenging.

### Approaches to Transition from Paper-based Field Catalogs

Two typical approaches to transition to NAHPU from paper-based field catalogs:

- Soft approach. Use NAHPU to supplement paper-based field catalogs.

- Hard approach. Use NAHPU as the only field catalog. You can bring paper-based field catalogs as backup.

Several factors to consider when transitioning to NAHPU:

- **Field conditions**. NAHPU is designed to work in remote field sites without an internet connection. However, you need to consider the durability of your devices and the availability of electricity in the field. You may need to bring a power bank to charge your devices.

- **Device choice**. The app is designed to work on various devices, including smartphones, tablets, laptop, and desktop. You can start using your own smartphone to test the app. If you have the budget, we recommend using a tablet and a bluetooth keyboard for a better experience. Depending on the field conditions, you may be able to use a laptop in the field. See the [Devices Requirements](#devices-requirements) section for more information.

- **Data backup**. You can back up your data to cloud providers like Google Drive, Dropbox, etc. You can also use a flash drive to back up your data. If you are using a tablet, you may need a USB-C flash drive or an adapter to connect your flash drive to your device.

## Transition from Custom-built Form Apps

NAHPU, purpose-built to serve the unique requirements of natural history collections, presents a user-friendly and economically viable alternative to custom-built form apps. These custom apps often entail substantial development and maintenance expenses, whereas NAHPU offers a more cost-effective and efficient solution. We are dedicated to the ongoing enhancement of both the app and its supporting documentation to cater to our users’ evolving needs. Transitioning from custom-built form apps to NAHPU is a more straightforward process compared to the shift from paper-based field catalogs. NAHPU allows you to adapt your existing workflow with ease. The app’s user-friendly and intuitive design ensures a smooth transition. Here are some key benefits of migrating to NAHPU from custom-built form apps:

- **Cost-Effectiveness**: NAHPU is free to use, eliminating any additional development costs. In contrast, custom-built form apps can be expensive to develop and maintain. For instance, [Claris FileMaker](https://www.claris.com/), a widely-used custom-built form app, necessitates a paid subscription. More details can be found on their [pricing page](https://www.claris.com/pricing/) .

- **Enhanced Data Findability and Accessibility**: NAHPU is engineered to simplify data searching and access. We strive for full compliance with the Darwin Core standard and FAIR principles, ensuring your data is easily findable and accessible. Custom-built form apps may not offer the same level of data findability and accessibility.

- **Open Source Advantage**: NAHPU is an open-source application that utilizes open-source libraries. This allows users to contribute to the app’s development by submitting a pull request to the [GitHub repository](https://github.com/hhandika/nahpu). NAHPU supports common data formats, such as CSV and JSON, facilitating easy import into other software for further analysis. The database used is SQLite, a widely adopted open-source database, allowing you to access the database independently of the app. In contrast, custom-built form apps may not be open source and may employ proprietary data formats.

- **Accessible and User-Friendly Interface**: NAHPU, designed with inclusivity in mind, leverages the accessibility features of Flutter and Material Design. This ensures a user-friendly interface that caters to individuals with visual impairments. The application’s cross-platform design allows it to function seamlessly on a wide range of devices, including smartphones, tablets, laptops, and desktops. This broad compatibility stands in contrast to custom-built form apps, which may face limitations in device compatibility and accessibility.

## Devices Requirements

The devices you need for using NAHPU will vary depending on your field site and budget. The following is a list of typical devices and accessories you need for different field budgets. This recommendation is based on our experience working in remote field sites in the tropics. You may need to adjust the list to suit your field sites.

### Low-budget Option

- **A smartphone**. You can start by using your own smartphone. The NAHPU UI is designed to adapt to small screens.
- **A flash drive**. You can use a flash drive to back up your data. If you have internet connection in the field, NAHPU allow you to share data to cloud providers such as Google Drive, Dropbox, etc.
- **A power bank**. You can use a power bank to charge your smartphone in the field when there is lack of electricity.
- **A usb-c or lightning to usb adapter**. You can use this adapter to connect your flash drive to your smartphone. Some flash drives have a usb-c connector. If you are using a recent Android phone, you may not need this adapter.

### Medium-budget to High-budget Option

- **A tablet**. We recommend using an iPad Mini. You can also get a bigger iPad. Keep in mind that the iPad Mini tends to have smaller battery capacity than a bigger iPad, while still having the same battery life. It allows more charge for the same power bank capacity

- **An external wireless keyboard**. It helps you to type faster and avoid touching the screen with dirty hands.

- **A usb-c flash drive**. Get a high quality flash drives with USB-C connector. Some of these flash drives are waterproof.

- **A power bank**. We recommend using a 20,000 to 25,000 mAH power bank. It is usually airline approved. The weight to capacity ratio is also good. It is also good to have a power bank with a USB-C connector. It often allows to fast charging the devices. It also allows you to charge the power bank faster. For example, at the [Esseltyn's lab](https://esselstyn.github.io/), in fieldwork in remote mountains in Indonesia, we sometimes have guides that can bring the power bank to the nearest village to charge it. A 25,000 mAH power bank with USB-C connector can be charged to full in 4 hours, while a 20,000 mAH power bank with micro-USB connector can take 8 hours or more to charge to full.

- **Multi-output wall charger**. It allows you to charge multiple devices at once. We recommend at least 65W chargers. Some brands has travel compatible, featuring switchable plugs.

## Strategies to manage devices battery life

- **Turn off the screen**. Or keep it at the lowest setting possible.

- **Turn on the airplane mode and switch to the low power mode**.

- **Turn off the device after using them**. It is more useful for Android devices. iPhone and iPad tend to be good at managing battery usages.

- **Turn off other unnecessary features**. For example, turn off the bluetooth when you are not using an external keyboard. Other features that you can turn off are the location service and the cellular data.
