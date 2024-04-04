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
  - [Low-budget Option](#low-budget-option)
  - [Medium-budget to High-budget Option](#medium-budget-to-high-budget-option)
- [Power Bank Capacity and Number of Charges](#power-bank-capacity-and-number-of-charges)
  - [Power Bank Capacity (mAh)](#power-bank-capacity-mah)
  - [Calculating Number of Charges](#calculating-number-of-charges)
- [Strategies to manage devices battery life](#strategies-to-manage-devices-battery-life)

## Transition from Paper-based Field Catalogs

### Benefits of Using NAHPU

While paper-based field catalogs have traditionally been the go-to method for collecting natural history data due to their simplicity and ease of use, NAHPU presents a more efficient and cost-effective alternative. The long-term use of NAHPU can result in significant savings in time and money, as the costs associated with acid-free paper, ink, binders, and additional storage space are eliminated. Furthermore, the often time-consuming and error-prone process of data digitization is no longer a concern with NAHPU. Even if a hard copy is required, NAHPU catalogs can still be printed. Here are some key advantages of using NAHPU over paper-based field catalogs:

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

- **Device choice**. The app is designed to work on various devices, including smartphones, tablets, laptops, and desktops. You can start using your own smartphone. If you have the budget, we recommend using a tablet and a bluetooth keyboard for a better experience. Depending on the field conditions, you may be able to use a laptop in the field. See the [Devices Requirements](#devices-requirements) section for more information.

- **Field conditions**. NAHPU is designed for remote field sites without internet access. Consider device durability and electricity availability. Some new smartphones are water and dust resistant. Tablets and laptops may need extra protection. Use a sturdy case whenever possible. For areas without electricity, typically a 20,000 to 25,000 mAh power bank is sufficient for a week of fieldwork using a smartphone or tablet.

- **Data Backup Options**. A flash drive can be utilized for data backup. Depending on your device’s compatibility, a USB-C flash drive or an adapter may be required for connection. As an alternative or supplementary measure, cross-backup with another smartphone or tablet in the field is also an option. If you have reliable internet access, cloud services such as Google Drive or Dropbox can be used for data backup. However, it’s important to note that this data transfer process requires the installation of a specific application on your device and appropriate account access.

## Transition from Custom-built Form Apps

NAHPU, purpose-built to serve the unique requirements of natural history collections, presents a user-friendly and economically viable alternative to custom-built form apps. These custom apps often entail substantial development and maintenance expenses, whereas NAHPU offers a more cost-effective and efficient solution. We are dedicated to the ongoing enhancement of both the app and its supporting documentation to cater to our users’ evolving needs. Transitioning from custom-built form apps to NAHPU is a more straightforward process compared to the shift from paper-based field catalogs. NAHPU allows you to adapt your existing workflow with ease. The app’s user-friendly and intuitive design ensures a smooth transition. Here are some key benefits of migrating to NAHPU from custom-built form apps:

- **Cost-Effectiveness**: NAHPU is free to use, eliminating any additional development costs. In contrast, custom-built form apps can be expensive to develop and maintain. For instance, [Claris FileMaker](https://www.claris.com/), a widely-used custom-built form app, necessitates a paid subscription. More details can be found on their [pricing page](https://www.claris.com/pricing/) .

- **Enhanced Data Findability and Accessibility**: NAHPU is engineered to simplify data searching and access. We strive for full compliance with the Darwin Core standard and FAIR principles, ensuring your data is easily findable and accessible. Custom-built form apps may not offer the same level of data findability and accessibility.

- **Open Source Advantage**: NAHPU is an open-source application that utilizes open-source libraries. This allows users to contribute to the app’s development by submitting a pull request to the [GitHub repository](https://github.com/hhandika/nahpu). NAHPU supports common data formats, such as CSV and JSON, facilitating easy import into other software for further analysis. The database used is SQLite, a widely adopted open-source database, allowing you to access the database independently of the app. In contrast, custom-built form apps may not be open source and may employ proprietary data formats.

- **Accessible and User-Friendly Interface**: NAHPU, designed with inclusivity in mind, leverages the accessibility features of Flutter and Material Design. This ensures a user-friendly interface that caters to individuals with visual impairments. The application’s cross-platform design allows it to function seamlessly on a wide range of devices, including smartphones, tablets, laptops, and desktops. This broad compatibility stands in contrast to custom-built form apps, which may face limitations in device compatibility and accessibility.

## Devices Requirements

The necessary equipment for utilizing NAHPU can fluctuate based on your specific field site and budget constraints. Here’s a list of common devices and accessories typically required for various field budgets. These recommendations stem from our hands-on experience in remote tropical field sites with limited access to electricity. Please note that you might need to tailor this list to better fit your unique field conditions.

### Low-budget Option

- **A smartphone**. You can start by using your own smartphone. The NAHPU UI is designed to adapt to small screens.

- **Data Backup Solution**. You can use a 16 Gb flash for data backup. It should be sufficient for multiple backups. Our four-month fieldwork experience demonstrated that a database containing 230 high-resolution images used approximately 820 Mb of storage space.

- **A power bank**. Depending on the length of the fieldwork and your access to electricity, you may need a power bank to re-charge the device. Our experience using iPad Mini 6, a single charge can last at least for five days with limited camera usage and screen brightness.

- **A usb-c or lightning to usb adapter**. You can use this adapter to connect your flash drive to your smartphone. Some flash drives have a usb-c connector. If you are using a recent Android phone, you may not need this adapter.

### Medium-budget to High-budget Option

- **A tablet**. We recommend using an iPad Mini. You can also get a bigger iPad. Keep in mind that the iPad Mini tends to have smaller battery capacity than a bigger iPad, while still having the same battery life. It allows more recharge for the same power bank capacity.

- **An external wireless keyboard**. It helps you to type faster and avoid touching the screen with dirty hands.

- **A usb-c flash drive**. Get a high quality flash drives with USB-C connector. Some of these flash drives are waterproof.

- **A power bank**. We recommend using a 20,000 to 25,000 mAH power bank. It is usually airline approved. The weight to capacity ratio is also good. It is also good to have a power bank with a USB-C connector. It often allows to fast charging the devices. It also allows you to charge the power bank faster. For example, at the [Esseltyn's lab](https://esselstyn.github.io/), in fieldwork in remote mountains in Indonesia, we sometimes have guides that can bring the power bank to the nearest village to charge it. A 25,000 mAH power bank with USB-C connector can be charged to full in 4 hours, while a 20,000 mAH power bank with micro-USB connector can take 8 hours or more to charge to full.

- **Multi-output wall charger**. It allows you to charge multiple devices at once. We recommend at least 65W chargers. Some brands has travel compatible, featuring switchable plugs.

## Power Bank Capacity and Number of Charges

### Power Bank Capacity (mAh)

The capacity of a power bank is measured in milliampere-hours (mAh). It represents the amount of charge the power bank can store. Essentially, the higher the mAh rating, the more energy the power bank can hold.

### Calculating Number of Charges

To estimate the number of charges you can obtain from a power bank:

#### Identify Your Device’s Battery Capacity

First, determine your device’s battery capacity. This information is usually specified in milliampere-hours (mAh). For example, the iPad Mini 6 has a battery capacity of 5,124 mAh.

#### Factor in Efficiency

Power banks are not 100% efficient; some energy is lost during the charging process. INUI power banks, for example, recommend industry standard efficiency of 60% (check out FAQ [here](https://www.amazon.com/INIU-Charging-25000mAh-Ultimate-Compatible/dp/B08VDJP7WN/ref=sr_1_1_sspa?dib=eyJ2IjoiMSJ9.53831hvEg6BgPzbrb5I41tInlx-EH5hxvYNZLyLitOD4lyvpIwIoJoUmqSFJaVveExcyJ6TiTAjlJ92U55OT1Nd0sdrrEdDu-zFijYYFJlNFAAdcEPg-eU3bat1W70Y2wp83hE6iWVlwK0Rp4UaDSXuFstsFp_YO1qgpKuyCqqnljlPqHqKJycxdvKVlhGgz07IlBu3xocSCS-nWZ2DfH-WLas9wzITLcYuNZY3Fhqk.sIBitUxLYysI0KsbS_zpMyAv9At1XZ60iwVRFPFJXUY&dib_tag=se&keywords=inui&qid=1712187440&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1)). Other power banks may have different efficiency ratings.

The number of charges can be calculated using the following formula:

```math
Number of charges = (Power Bank Capacity (mAh) × Efficiency)​ ÷ Device Battery Capacity (mAh)
```

For example, to calculate the number of charges for a 25,000 mAh power bank with 60% efficiency charging an iPad Mini 6 with a 5,124 mAh battery:

```math
Number of charges = (25,000 mAh × 0.6) ÷ 5,124 mAh = 2.9 charges
```

Learn more about power bank efficiency and how to calculate it [here](https://blog.ravpower.com/2023/09/understanding-power-bank-specifications-capacity-mah-charging-efficiency-watt-hours-and-more/).

## Strategies to manage devices battery life

- **Screen Brightness**: Lower the screen brightness or enable the auto-brightness feature. A dimmer screen consumes less power.

- **Airplane Mode and Low Power Mode**:
  - Airplane Mode: Enable it to disable all wireless connections (Wi-Fi, cellular data, Bluetooth) when not in use.
  - Low Power Mode: Activate this mode on your device to optimize battery usage.
  
- **Power Off After Use**:
  - Android Devices: Turning off the device completely when not in use can be beneficial for battery conservation.
  - iPhone and iPad: Apple devices are generally good at managing battery usage, you may not need to power them off.

- **Disable Unnecessary Features**:
  - Bluetooth: Turn it off when not actively using external devices (e.g., keyboards).
  - Location Services: Limit other apps’ access to your location, as constant tracking drains the battery. NAHPU only uses location services when you generate a coordinate for a site using the device’s GPS.
  - Cellular Data: If your devices supports cellular data access, consider disabling it to save power.
