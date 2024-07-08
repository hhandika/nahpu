---
sidebar_position: 2
---

# NAHPU Day 1

NAHPU is a project-based cataloging app. The data is managed and organized based on a project. Each project can have multiple people, sites, narratives, collecting events, and specimen records. The app is designed for use in the field, but it can also be used in the lab.

## Typical Workflow

### 1. Create a new project

Use the `+` button in the bottom right corner of the home screen. The project name must be 3 to 25 characters long.

You can add a project description. This is optional, but it is useful for remembering the project's purpose and scope.

Then, select the main catalog format. The app currently supports mammal and bird catalog formats. We separate bats from other mammal. The bat format will have a forearm field in the measurement form. You can change the catalog format later in the project settings. NAHPU allows the cataloging of all supported taxon groups within the same project.

After creating a project, the app automatically generates a project UUID. This unique identifier is used throughout the database to distinguish records from different projects. We used [UUID version 4](https://en.wikipedia.org/wiki/Universally_unique_identifier). It is almost impossible for two UUIDs to collide.

### 2. Add a new personnel

You can just navigate to the project and add new personnel. You need at least one person to take on the role of specimen care cataloger. You can add more people with different roles.

[Cataloger](./usages/personnel#cataloger) is responsible for cataloging the specimen. In some institutions, this could be called a collector. In the app, we call a collector, anyone who collects the specimen, whether they are involved in cataloging the app or not. Their initial and field number will be used to generate the Field ID on the specimen catalog page. Their name will also appear whenever the field asks for a personnel name, such as collecting personnel and preparator. The app does not allow changing the cataloger role after it is created.

[Preparator only](./usages/personnel#preparator-only) is a person who helps prepare the specimen but is not involved in managing the data. Their names will not appear in the specimen page cataloger field but somewhere else, such as in the `Preparator` and `Collecting personnel` fields on the specimen page.

For the other personnel not directly involved in the specimen care, select [None](./usages/personnel#none) as their role. Their names will only appear in the `Collecting personnel` field.

### 3. Add a new taxon

You can add a taxon manually using the add taxon button or import from a comma-delimited (.csv) file.

The app requires `UTF-8` format for CSV import. This should be the default .csv export format for [Apple Numbers](https://www.apple.com/numbers/) or [Google Spreadsheet](https://www.google.com/sheets/about/). If you use Microsoft Excel, save the file as `CSV UTF-8` format.

Your csv files requires all of these column: `taxonClass`, `taxonFamily`, `genus`, `specificEpithet`. You can also have `commonName` and `notes` columns. The app will automatically detect the column headers with those names. You can manually select the column type using the dropdown menu if the app does not automatically assign the right column for each data. Other columns will be ignored.

Example taxon import table:

| taxonClass | taxonFamily | genus   | specificEpithet | commonName        | notes |
| ---------- | ----------- | ------- | --------------- | ----------------- | ----- |
| Mammalia   | Muridae     | Bunomys | coelestis       | Heavenly hill rat |       |
| Mammalia   | Muridae     | Bunomys | penitus         | Inland hill rat   |       |

### 4. Create a site

To create a new site, use the `+` button in the top right corner of the site. Fill at least the `Site ID`. The app limits the site ID to 20 characters. You will refer to this ID throughout the record field whenever it asks for a site. You can make it short but descriptive. We often label ID city, town, or village as it is. For example, the city of Bogor will be BOGOR. On the other hand, the trap line often uses an ID with locality abbreviation and `L` to indicate a line. For example, line 1 in Mt. Gede-Pangrango will be `GP-L1`.

### 5. Add narrative

To create a narrative, use the `+` button in the top right corner of the narrative. Select the date and site ID. Then, write the narrative.

### 6. Add collecting events

Collecting events helps you keep track of the collecting efforts, personnel, and weather data for each event. The specimen records link to the event instead of the site. This way, you can have multiple collecting events on a single site.

To create a collecting event, use the `+` button in the top right corner of the collecting event. Select `site ID`, `start date`, `start time`, `end date`, and `end time`. Then, fill out the rest of the form.

Unlike the site you will only create each time you move to a new site, collecting events are created for each collection effort. For example, when studying nocturnal rodents, we often set traps the night before and check them the next day. We will create a collecting event after we collect the specimen. The start date will be a day earlier, and the end date will be today.

The app combines site ID and start date to create a unique ID for each collecting event. For example, `GP-L1-March, 23 2023`. You will use this ID to refer to the collecting event in the specimen record. In some edge cases where you have multiple collecting events in a single day on the same site, you can add a suffix to the ID. For example, `Line1-Mar 26, 2023-1` and `Line1-Mar 26, 2023-2`.

### 7. Add specimen records

To create a specimen record, use the `+` button in the top right corner of the specimen record. The specimen record icon in the navigation bar tells you about the current active format. It will generate the matching format for the currently active catalog. The only difference between different catalog formats is the measurement fields. After creating a new specimen record, fill in the relevant information. Repeat the process for the next specimens.

:::tip
NAHPU is designed to allow collectors to collect different taxa. For the current version, you can have birds, bats, and other mammals in the same project. Change the catalog format in the setting when you add a different taxon group that differs from the currently active catalog format. NAHPU will generate a form for that taxon group when you create a new specimen record. When scrolling through different specimen records. You can check which catalog format is on the current page by looking at the icon in the specimen parts. The mammal catalog will be a `paw,` and the bird will be a `bird head.` 
:::

### 8. Exporting records

To export records, go to the dashboard's menu (indicated by the hamburger icon/three horizontal lines in the top left corner). We have multiple export options:

- Create a report. Generate species list, media, and site coordinates h in delimited format (.csv or .tsv).

- Bundle projects. Generate available reports (e.g., species count), narratives, sites, collecting events, and specimen records. They are all in a comma-delimited (.csv) format. The app will generate a zip file that contains all the files and media. You can use this option to back up your data.

- Export records. You can choose which records to export. It supports exporting in delimited format (.csv or .tsv).

### 9. Backing up database

To back up the database, go to the menu in the dashboard and select backup database. By default, the database will be exported as a sqlite3 file. Use the toggle button `include project data` to add the project data to the backup. The app will generate a zip file that contains the database and media.

:::info
Backing up the database will back up all the data of all projects in the apps. For future releases, NAHPU will improve the bundle as a data backup method.
:::
