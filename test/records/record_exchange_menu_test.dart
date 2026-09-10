import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/screens/events/components/menu_bar.dart';
import 'package:nahpu/screens/sites/components/menu_bar.dart';
import 'package:nahpu/screens/specimens/shared/menu_bar.dart';

void main() {
  testWidgets('site menu exposes record exchange actions', (tester) async {
    await _pumpMenu(tester, const SiteMenu(siteId: null));

    await tester.tap(find.byTooltip('Site actions'));
    await tester.pumpAndSettle();

    expect(find.text('Show QR'), findsOneWidget);
    expect(find.text('Export site'), findsOneWidget);
    expect(find.text('Copy from project ...'), findsOneWidget);
    expect(find.text('Scan QR'), findsOneWidget);
    expect(find.text('Import site'), findsOneWidget);
  });

  testWidgets('event menu exposes record exchange actions', (tester) async {
    await _pumpMenu(tester, const CollEventMenu(collEventId: null));

    await tester.tap(find.byTooltip('Event actions'));
    await tester.pumpAndSettle();

    expect(find.text('Show QR'), findsOneWidget);
    expect(find.text('Export event'), findsOneWidget);
    expect(find.text('Scan QR'), findsOneWidget);
    expect(find.text('Import event'), findsOneWidget);
  });

  testWidgets('specimen menu exposes JSON exchange without QR actions', (
    tester,
  ) async {
    await _pumpMenu(
      tester,
      const SpecimenMenu(specimenUuid: null, catalogFmt: null),
    );

    await tester.tap(find.byTooltip('Specimen actions'));
    await tester.pumpAndSettle();

    expect(find.text('Export specimen'), findsOneWidget);
    expect(find.text('Import specimen'), findsOneWidget);
    expect(find.text('Show QR'), findsNothing);
    expect(find.text('Scan QR'), findsNothing);
  });

  testWidgets('site menu uses a bottom sheet on compact screens', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(500, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await _pumpMenu(tester, const SiteMenu(siteId: null));

    expect(find.byType(PopupMenuButton), findsNothing);
    await tester.tap(find.byTooltip('Site actions'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    for (final label in [
      'Create site',
      'Sort records',
      'Show QR',
      'Import site',
      'Delete all records',
    ]) {
      await tester.ensureVisible(find.text(label));
      expect(find.text(label), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpMenu(WidgetTester tester, Widget menu) {
  return tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(appBar: AppBar(actions: [menu])),
      ),
    ),
  );
}
