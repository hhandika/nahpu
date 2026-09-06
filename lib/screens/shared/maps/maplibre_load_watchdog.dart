import 'dart:async';

import 'package:nahpu/services/providers/map_renderer.dart';

/// Detects a MapLibre web view that never finishes loading.
///
/// The web view backend has no failure callback. When its loopback bridge
/// cannot bind or the MapLibre GL JS bundle cannot be fetched, `onMapCreated`
/// and `onStyleLoaded` never fire, the platform view collapses to an empty
/// box, and the map is simply absent -- no error, no crash, nothing to log.
/// [start] arms a timer that reads that silence as a failure.
///
/// Native MapLibre platforms cannot fail this way and are never armed, so
/// their maps behave exactly as they did before.
class MapLibreLoadWatchdog {
  MapLibreLoadWatchdog({
    required this.onTimeout,
    bool? enabled,
    this.timeout = mapLibreLoadTimeout,
  }) : enabled = enabled ?? mapLibreRunsInWebView;

  /// Called once when the map has stayed blank for longer than [timeout].
  final void Function() onTimeout;

  /// Whether this platform can fail the way the watchdog looks for.
  final bool enabled;

  final Duration timeout;

  Timer? _timer;
  bool _isWaiting = false;

  /// Whether the map is still blank and worth showing progress for.
  bool get isWaiting => _isWaiting;

  /// Arms the watchdog. A no-op where MapLibre renders natively.
  void start() {
    if (!enabled || _timer != null || _isWaiting) return;
    _isWaiting = true;
    _timer = Timer(timeout, () {
      _timer = null;
      if (!_isWaiting) return;
      _isWaiting = false;
      onTimeout();
    });
  }

  /// Records that the map drew. Returns whether the caller should rebuild.
  bool markReady() {
    _timer?.cancel();
    _timer = null;
    if (!_isWaiting) return false;
    _isWaiting = false;
    return true;
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _isWaiting = false;
  }
}
