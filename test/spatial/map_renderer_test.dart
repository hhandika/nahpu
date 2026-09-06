import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/services/providers/map_renderer.dart';

/// The renderer latch is what turns a silently blank MapLibre map into a
/// working offline one, so its transitions are worth pinning down. The tests
/// run on the host platform, which is why they compare against
/// [mapLibreIsExpected] rather than asserting a fixed starting renderer.
void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  MapRendererNotifier notifier() =>
      container.read(mapRendererProvider.notifier);

  MapRenderer renderer() => container.read(mapRendererProvider);

  final expectedStart = mapLibreIsExpected
      ? MapRenderer.mapLibre
      : MapRenderer.naturalEarth;

  test('starts on the renderer this platform actually has', () {
    expect(renderer(), expectedStart);
  });

  test('a failed MapLibre map falls back and stays fallen back', () {
    notifier().markMapLibreUnavailable();
    expect(renderer(), MapRenderer.naturalEarth);

    notifier().markMapLibreUnavailable();
    expect(renderer(), MapRenderer.naturalEarth);
  });

  test('retrying returns to MapLibre only where it exists', () {
    notifier()
      ..markMapLibreUnavailable()
      ..retryMapLibre();

    expect(renderer(), expectedStart);
  });

  test('only a web view backend can reach the fallback', () {
    // The watchdog is armed only where MapLibre runs in a web view, and that
    // is always a platform where MapLibre is the expected renderer. Linux has
    // neither, so it can never be latched away from Natural Earth.
    if (mapLibreRunsInWebView) expect(mapLibreIsExpected, isTrue);

    if (!mapLibreIsExpected) {
      notifier().markMapLibreUnavailable();
      expect(renderer(), MapRenderer.naturalEarth);
    }
  });
}
