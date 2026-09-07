import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nahpu/screens/shared/media/media_export_dialog.dart';
import 'package:nahpu/screens/shared/media/qr.dart';
import 'package:nahpu/services/media/media_export_service.dart';

class QrCodeDialog extends ConsumerStatefulWidget {
  const QrCodeDialog({
    super.key,
    required this.title,
    required this.data,
    required this.description,
  });

  final String title;
  final String data;
  final String description;

  @override
  ConsumerState<QrCodeDialog> createState() => _QrCodeDialogState();
}

class _QrCodeDialogState extends ConsumerState<QrCodeDialog> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrCodeViewer(data: widget.data),
            const SizedBox(height: 12),
            Text(widget.description, textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.download_outlined),
              tooltip: 'Export QR code as an image',
              onPressed: _isExporting ? null : _exportImage,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _exportImage() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isExporting = true);
    try {
      final bytes = await renderQrCodePng(data: widget.data);
      if (!mounted) return;
      if (bytes == null) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('This data is too large for a QR code image.'),
          ),
        );
        return;
      }
      // Built before the pop because this route owns [ref].
      final service = MediaExportService(ref: ref);
      navigator.pop();
      await showMediaExportDialog(
        context: navigator.context,
        prepare: () =>
            service.prepareImageBytes(bytes: bytes, fileStem: widget.title),
        onExport:
            ({
              required source,
              required format,
              required fileStem,
              destinationDirectory,
              width,
              height,
              required jpegQuality,
            }) => service.export(
              source: source,
              format: format,
              fileStem: fileStem,
              destinationDirectory: destinationDirectory,
              width: width,
              height: height,
              jpegQuality: jpegQuality,
            ),
      );
    } catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }
}
