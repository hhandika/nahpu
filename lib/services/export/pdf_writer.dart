import 'dart:io';

import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/export/site_writer.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/narrative_services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NarrativePdfWriter extends DbAccess {
  const NarrativePdfWriter({
    required super.ref,
    required this.pageFormat,
    required this.filePath,
  });

  final PdfPageFormat pageFormat;
  final File filePath;

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    List<NarrativeData> narrativeList =
        await NarrativeServices(ref: ref).getAllNarrative();
    for (var narrative in narrativeList) {
      await generateNarrativePage(pdf, narrative);
    }

    filePath.writeAsBytes(await pdf.save());
  }

  Future<void> generateNarrativePage(
      pw.Document pdf, NarrativeData data) async {
    String verbatimLocality =
        await SiteWriterServices(ref: ref).getVerbatimLocality(data.siteID);
    PdfDecorator decorator = PdfDecorator(pageFormat: pageFormat);
    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Text(
              data.date ?? 'No date',
              style: const pw.TextStyle(fontSize: 12),
              textAlign: pw.TextAlign.left,
            ),
            decorator.container(pw.Text(
              verbatimLocality,
              style: const pw.TextStyle(fontSize: 12),
            )),
            decorator.container(
              pw.Text(
                data.narrative ?? 'No narrative',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class PdfDecorator {
  const PdfDecorator({required this.pageFormat});
  final PdfPageFormat pageFormat;
  pw.Widget container(pw.Widget widget) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(top: 8),
        child: pw.Container(
          width: pageFormat.availableWidth,
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: const pw.EdgeInsets.all(8),
          constraints: const pw.BoxConstraints(maxWidth: 500),
          child: widget,
        ));
  }
}
