---
sidebar_position: 2
---

# NAHPU Day 1

NAHPU is a project based cataloging app. The data is manage and organize based on a project. Each project can have multiple personnel, sites, narratives, collecting events, and specimen records. The app is designed to be used in the field, but you can also use it in the lab.

## Typical Workflow

### 1. Create a new project

Use the `+` button in the bottom right corner of the home screen. Project name must be in the range of 3 to 25 characters.

You can add project description. This is optional, but it is useful to help you remember the project purpose and scope.

Then, select the main catalog format. The app currently support mammal and bird catalog format. We separate bat and other mammmal. The bat format will have forearm field in the measurement form. You can change the catalog format later in the project setting. NAHPU allows to catalog all supported taxon group within the same project.

After you create a project, the app will automatically generate a project UUID. This is a unique identifier used throughout the database to distinguish records from different projects. We used [UUID version 4](https://en.wikipedia.org/wiki/Universally_unique_identifier). It almost impossible to collide while still protecting your privacy.

### 2. In the project Dashboard, add a new personnel

You need at least a person with specimen care role as a cataloger. You can add more people with different roles.

[Cataloger](./usages/personnel#cataloger) is the person that will be responsible for cataloging the specimen. In some institutions, this could be called a collector. In the app, we call collector as someone who collects the specimen, whether they are involved in cataloging the app or not. Their initial and field number will be used to generate the Field ID on the specimen catalog page. Their name will also appear whenever the field asks for a personnel name, such as collecting personnel and preparator. The app does not allow changing the cataloger role after it is created.

[Preparator only](./usages/personnel#preparator-only) is a person that helps prepare the specimen, but does not involve in managing the data. Their names will not appear in the cataloger field in the specimen page, but will appear somewhere else, such as in the `Preparator` and `Collecting personnel` field in the specimen page.

For the other personnel that does not directly involve in the specimen care, select [None](./usages/personnel#none) as their role. Their names will only appear in the `Collecting personnel` field.

### 3. Add a new taxon

You can add a taxon manually using the add taxon button or import from a comma-delimited (.csv) file.

For CSV import, the app requires `UTF-8` format. It should be the default .csv export format for [Apple Numbers](https://www.apple.com/numbers/) or [Google Spreadsheet](https://www.google.com/sheets/about/). If you use Microsoft Excel, save the file as `CSV UTF-8` format.

Your csv files requires all of these column: `taxonClass`, `taxonFamily`, `genus`, `specificEpithet`. You can also have `commonName` and `notes` columns. The app will automatically detect the column headers with those names. You can manually select the column type using dropdown menu if the app does not automatically assign the right column for each respective data. Other columns will be ignored.

Example taxon import table:

| taxonClass | taxonFamily | genus   | specificEpithet | commonName        | notes |
| ---------- | ----------- | ------- | --------------- | ----------------- | ----- |
| Mammalia   | Muridae     | Bunomys | coelestis       | Heavenly hill rat |       |
| Mammalia   | Muridae     | Bunomys | penitus         | Inland hill rat   |       |

### 4. Create a site

To create a new site, use the `+` button in the top right corner of the site. Fill at least the `Site ID`. The app limit the site ID to 20 characters. You will refer to this ID throughout the record field whenever it asks for a site. Try to make it short but descriptive. We often label ID city, town, or village as it is. For example, the city of Bogor will be BOGOR. The trap line, on the other hand, often the ID will be with locality abbreviation and `L` to indicate a line. For example, line 1 in Mt. Gede-Pangrango will be `GP-L1`.

### 5. Add narrative

To create a narrative, use the `+` button in the top right corner of the narrative. Select the date and site ID. Then, write the narrative.

### 6. Add collecting events

Collecting events helps you keep track of the collecting efforts, personnel, and weather data for each event. The specimen records link to the event instead of the site. This way, you can have multiple collecting events in a single site.

To create a collecting event, use the `+` button in the top right corner of the collecting event. Select `site ID`, `start date`, `start time`, `end date`, and `end time`. Then, fill out the rest of the form.

Unlike the site that you will only create each time you move to a new site, collecting events are created for each collecting effort. For example, for studying nocturnal rodents, we often set traps the night before and check them the next day. We will create a collecting event after we collect the specimen. The start date will be a day earlier, and the end date will be today's date.

The app uses the combination of site ID and start date to create a unique ID for each collecting event. For example, `GP-L1-March, 23 2023`. You will use this ID to refer to the collecting event in the specimen record. In some edge cases where you have multiple collecting events in a single day in the same site, you can add a suffix to the ID. For example, `Line1-Mar 26, 2023-1` and `Line1-Mar 26, 2023-2`.

### 7. Add specimen records

To create a specimen record, use the `+` button in the top right corner of the specimen record. Fill in all the relevant information. The only difference between different catalog formats is the measurement fields. You can check which catalog format in the current page by looking at the icon in the specimen parts. Mammal will be `paws`, bird will be `bird head`. The specimen record icon in the navigation bar tells you about the current active format.

### 8. Exporting records

To export records, go to the menu (indicated by the hamburger icon/three horizontal line in the top left corner) in the dashboard. We have multiple export options:

- Create report. Generate species list, media, or both in delimited format (.csv or .tsv).

- Bundle projects. Generate available reports (e.g., species count), narratives, sites, collecting events, and specimen records. They are all in a comma-delimited (.csv) format. The app will generate a zip file that contains all the files and media. You can use this option to back up your data.

- Export records. You can choose which records to export. It supports exporting in delimited format (.csv or .tsv).

### 9. Backing up database

To back up the database, go to the menu in the dashboard and select backup database. The database will be exported as a sqlite3 file. Current version does not export the media. We are working on a way to export the media as a part of database as well.
