import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/screens/shared/maps/offline_basemap_notice.dart';
import 'package:nahpu/services/providers/map_renderer.dart';

void main() {
  testWidgets('the notice attributes the bundled basemap', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: OfflineBasemapNotice())),
      ),
    );

    expect(find.textContaining('Natural Earth'), findsOneWidget);
  });

  testWidgets('retrying asks for the detailed map again', (tester) async {
    late WidgetRef ref;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, widgetRef, child) {
                ref = widgetRef;
                return const OfflineBasemapNotice();
              },
            ),
          ),
        ),
      ),
    );

    ref.read(mapRendererProvider.notifier).markMapLibreUnavailable();
    await tester.pump();
    expect(ref.read(mapRendererProvider), MapRenderer.naturalEarth);

    await tester.tap(find.byTooltip('Try the detailed map again'));
    await tester.pump();

    expect(
      ref.read(mapRendererProvider),
      mapLibreIsExpected ? MapRenderer.mapLibre : MapRenderer.naturalEarth,
    );
  });
}
