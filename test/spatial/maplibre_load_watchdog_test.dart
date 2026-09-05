import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/screens/shared/maps/maplibre_load_watchdog.dart';

/// The web view MapLibre backend reports nothing when it fails, so silence is
/// the only signal there is. These tests pin down when the watchdog reads
/// silence as failure and, just as importantly, when it must not.
///
/// Real timers with a short timeout and a generous wait keep this free of a
/// fake-async dependency the package does not otherwise need.
const _timeout = Duration(milliseconds: 20);
const _wellPastTimeout = Duration(milliseconds: 200);

void main() {
  test('reports a map that never draws', () async {
    var timedOut = false;
    final watchdog = MapLibreLoadWatchdog(
      onTimeout: () => timedOut = true,
      enabled: true,
      timeout: _timeout,
    )..start();
    addTearDown(watchdog.dispose);

    expect(watchdog.isWaiting, isTrue);
    await Future<void>.delayed(_wellPastTimeout);

    expect(timedOut, isTrue);
    expect(watchdog.isWaiting, isFalse);
  });

  test('a map that draws in time never reports', () async {
    var timedOut = false;
    final watchdog = MapLibreLoadWatchdog(
      onTimeout: () => timedOut = true,
      enabled: true,
      timeout: _timeout,
    )..start();
    addTearDown(watchdog.dispose);

    expect(watchdog.markReady(), isTrue);
    await Future<void>.delayed(_wellPastTimeout);

    expect(timedOut, isFalse);
    expect(watchdog.isWaiting, isFalse);
  });

  test('markReady only asks for one rebuild', () {
    final watchdog = MapLibreLoadWatchdog(
      onTimeout: () {},
      enabled: true,
      timeout: _timeout,
    )..start();
    addTearDown(watchdog.dispose);

    expect(watchdog.markReady(), isTrue);
    expect(watchdog.markReady(), isFalse);
  });

  test('platforms with a native backend are never armed', () async {
    var timedOut = false;
    final watchdog = MapLibreLoadWatchdog(
      onTimeout: () => timedOut = true,
      enabled: false,
      timeout: _timeout,
    )..start();
    addTearDown(watchdog.dispose);

    expect(watchdog.isWaiting, isFalse);
    await Future<void>.delayed(_wellPastTimeout);

    expect(timedOut, isFalse);
  });

  test('disposing stops a pending timeout', () async {
    var timedOut = false;
    MapLibreLoadWatchdog(
        onTimeout: () => timedOut = true,
        enabled: true,
        timeout: _timeout,
      )
      ..start()
      ..dispose();

    await Future<void>.delayed(_wellPastTimeout);

    expect(timedOut, isFalse);
  });
}
