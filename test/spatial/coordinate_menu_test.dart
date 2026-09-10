import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/screens/sites/components/coordinates.dart';
import 'package:nahpu/services/database/database.dart';

void main() {
  testWidgets('coordinate menu uses a popup on wide screens', (tester) async {
    await _pumpMenu(tester, const Size(900, 900));

    await tester.tap(find.byTooltip('Coordinate actions'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.byType(PopupMenuDivider), findsNWidgets(2));
    expect(find.text('Open in map'), findsOneWidget);
  });

  testWidgets('coordinate menu uses a bottom sheet on compact screens', (
    tester,
  ) async {
    await _pumpMenu(tester, const Size(500, 900));

    await tester.tap(find.byTooltip('Coordinate actions'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    for (final label in ['Edit', 'Show QR', 'Copy', 'Open in map', 'Details']) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.byType(Divider), findsNWidgets(2));
  });
}

Future<void> _pumpMenu(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: CoordinateMenu(
              coordinateId: 1,
              siteId: 10,
              coordinate: _coordinate,
            ),
          ),
        ),
      ),
    ),
  );
}

const _coordinate = CoordinateData(
  id: 1,
  nameId: 'Alpha',
  decimalLatitude: 45,
  decimalLongitude: -93,
  datum: 'WGS84',
  siteID: 10,
);
