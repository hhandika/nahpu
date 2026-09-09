import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nahpu/screens/shared/dialogs/qr_code_dialog.dart';
import 'package:nahpu/screens/shared/media/qr.dart';

void main() {
  testWidgets('QR dialog places the export icon opposite the close button', (
    tester,
  ) async {
    await _pumpDialog(tester, 'NAHPU record');

    final exportButton = find.widgetWithIcon(
      IconButton,
      Icons.download_outlined,
    );
    expect(exportButton, findsOneWidget);
    final actionRow = find.ancestor(
      of: exportButton,
      matching: find.byType(Row),
    );
    expect(
      tester.widget<Row>(actionRow.first).mainAxisAlignment,
      MainAxisAlignment.spaceBetween,
    );
    expect(
      find.descendant(of: actionRow.first, matching: find.text('Close')),
      findsOneWidget,
    );
    expect(
      tester.getCenter(exportButton).dx,
      lessThan(tester.getCenter(find.text('Close')).dx),
    );
  });

  testWidgets('oversized payloads report that no image can be exported', (
    tester,
  ) async {
    await _pumpDialog(tester, List.filled(60000, 'x').join());

    await tester.tap(find.widgetWithIcon(IconButton, Icons.download_outlined));
    await tester.pumpAndSettle();

    expect(
      find.text('This data is too large for a QR code image.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('exporting closes the QR dialog before the export flow opens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final appDirectory = Directory.systemTemp.createTempSync('nahpu-qr-');
    addTearDown(() => appDirectory.deleteSync(recursive: true));
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (_) async => appDirectory.path,
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            null,
          ),
    );

    await _pumpLauncher(tester, 'NAHPU record');
    await tester.tap(find.text('Show QR'));
    await tester.pumpAndSettle();
    expect(find.byType(QrCodeDialog), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.download_outlined));
    await tester.pump();
    // The QR dialog pops itself and opens the export dialog once the encode
    // finishes, so waiting for that dialog waits for the whole sequence.
    await _pumpUntilFound(tester, find.text('Export media'));
    // Let the popped QR route finish its exit transition.
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(QrCodeDialog), findsNothing);
    expect(find.text('Export media'), findsOneWidget);

    // The export dialog stages its source with real IO, so close it instead of
    // settling on its loading spinner.
    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('renders the QR code as a square PNG', (tester) async {
    final bytes = await tester.runAsync(
      () => renderQrCodePng(data: 'NAHPU record', size: 128),
    );

    expect(bytes, isNotNull);
    expect(bytes!.sublist(0, 8), [137, 80, 78, 71, 13, 10, 26, 10]);
  });

  testWidgets('oversized payloads render no image', (tester) async {
    final bytes = await tester.runAsync(
      () => renderQrCodePng(data: List.filled(60000, 'x').join()),
    );

    expect(bytes, isNull);
  });
}

/// Pumps until [finder] matches, advancing both real and animation time.
///
/// The PNG encode runs on the real event loop, so the test has to yield to it
/// rather than only pumping frames. How long it takes varies with the machine:
/// a fixed delay long enough for a developer laptop can expire mid-encode on a
/// slower CI runner, which then fails on a later expectation instead of here.
Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final stopwatch = Stopwatch()..start();
  while (stopwatch.elapsed < timeout) {
    if (finder.evaluate().isNotEmpty) return;
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
  fail('Timed out after $timeout waiting for $finder');
}

Future<void> _pumpDialog(WidgetTester tester, String data) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: QrCodeDialog(
            title: 'Project QR code',
            data: data,
            description: 'Scan this code in NAHPU.',
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpLauncher(WidgetTester tester, String data) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) => QrCodeDialog(
                  title: 'Project QR code',
                  data: data,
                  description: 'Scan this code in NAHPU.',
                ),
              ),
              child: const Text('Show QR'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
