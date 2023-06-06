import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/pdf/services.dart';
import 'package:nahpu/services/export/site_writer.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/site_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:pdf/widgets.dart' as pw;

class SpecimenPdfWriter extends PdfServices {
  SpecimenPdfWriter({
    required super.ref,
    required super.pageFormat,
    required super.filePath,
    required super.pageOrientation,
  });

  Future<void> generatePdf() async {
    List<SpecimenData> specimenList =
        await SpecimenServices(ref: ref).getSpecimenList();
    generateProjectPage();
    for (var specimen in specimenList) {
      await _generateSpecimenPage(specimen);
    }
    writePdf(pdf);
  }

  Future<void> _generateSpecimenPage(SpecimenData data) async {
    pw.Widget collectingRecord = await _generateCollectingRecord(data);
    pw.Widget taxonomy = await _generateTaxonomyData(data);
    CollEventData? captureRecord =
        await CollEventServices(ref: ref).getCollEvent(data.collEventID);
    pw.Widget siteRecord = await _generateSiteRecord(captureRecord);
    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        orientation: pageOrientation,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Specimen UUID: ${data.uuid}',
                style: const pw.TextStyle(fontSize: 10),
                textAlign: pw.TextAlign.left,
              ),
              siteRecord,
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    width: (pageFormat.availableWidth / 2),
                    child: collectingRecord,
                  ),
                  pw.SizedBox(width: 10),
                  pw.SizedBox(
                    width: (pageFormat.availableWidth / 2) - 10,
                    child: taxonomy,
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Future<pw.Widget> _generateSiteRecord(CollEventData? record) async {
    if (record == null) {
      return container(pw.Text('No site record'));
    }
    String verbatimLocality =
        await SiteWriterServices(ref: ref).getVerbatimLocality(record.siteID);
    List<CoordinateData> coordinates = record.siteID != null
        ? await CoordinateServices(ref: ref)
            .getCoordinatesBySiteID(record.siteID!)
        : [];
    return container(
      pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          textContent(verbatimLocality),
          pw.Column(
            children: _generateCoordinateList(coordinates),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _generateCoordinateList(List<CoordinateData> coordinates) {
    return coordinates.map((e) {
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          textContent(e.nameId ?? '', fontSize: 10),
          textContent(' ${e.decimalLatitude ?? ''}', fontSize: 10),
          textContent(', ${e.decimalLongitude ?? ''}', fontSize: 10),
          textContent(' ${e.elevationInMeter ?? '?'}m', fontSize: 10),
        ],
      );
    }).toList();
  }

  Future<pw.Widget> _generateCollectingRecord(SpecimenData data) async {
    PersonnelData? cataloger = data.catalogerID != null
        ? await PersonnelServices(ref: ref)
            .getPersonnelByUuid(data.catalogerID!)
        : null;
    PersonnelData? preparator = data.preparatorID != null
        ? await PersonnelServices(ref: ref)
            .getPersonnelByUuid(data.preparatorID!)
        : null;
    return container(
      pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText('Collecting record'),
          pw.SizedBox(height: 10),
          textContent('Cataloger: ${cataloger?.name ?? ''}'),
          textContent('Field number: ${data.fieldNumber ?? ''}'),
          textContent('Preparator: ${preparator?.name ?? ''}'),
          textContent('Specimen condition: ${data.condition}'),
          data.condition == 'Freshly Euthanized'
              ? textContent(
                  'Specimen collection time: ${data.collectionTime ?? ''}')
              : pw.SizedBox.shrink(),
          textContent('Preparation date: ${data.prepDate}'),
          textContent('Preparation time: ${data.prepTime}'),
        ],
      ),
    );
  }

  Future<pw.Widget> _generateTaxonomyData(SpecimenData data) async {
    TaxonomyData? taxonomy = data.speciesID != null
        ? await TaxonomyService(ref: ref).getTaxonById(data.speciesID!)
        : null;
    if (taxonomy == null) {
      return container(pw.Text('No taxonomy data'));
    }
    return container(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText('Taxonomy'),
          pw.SizedBox(height: 10),
          textContent('Class: ${taxonomy.taxonClass ?? ''}'),
          textContent('Order: ${taxonomy.taxonOrder ?? ''}'),
          textContent('Family: ${taxonomy.taxonFamily ?? ''}'),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              textContent('Species: '),
              textContent(
                '${taxonomy.genus ?? ''} ${taxonomy.specificEpithet ?? ''}',
                isItalic: true,
              ),
            ],
          ),
          taxonomy.commonName != null || taxonomy.commonName != ''
              ? textContent('Common name: ${taxonomy.commonName}')
              : pw.SizedBox.shrink(),
        ],
      ),
    );
  }
}
