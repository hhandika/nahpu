import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NarrativePdfWriter extends DbAccess {
  const NarrativePdfWriter({
    required super.ref,
    required this.pageFormat,
  });

  final PdfPageFormat pageFormat;

  Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();

    return pdf;
  }

  Future<pw.Document> generateNarrativePage(
      pw.Document pdf, NarrativeData data) async {
    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Text(
                data.date ?? 'No date',
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Text(
                data.narrative ?? 'No narrative',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
          ]);
        },
      ),
    );
    return pdf;
  }
}
