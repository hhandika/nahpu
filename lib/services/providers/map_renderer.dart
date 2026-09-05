import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Which renderer the shared map widgets should build.
enum MapRenderer {
  /// MapLibre. Native on Android and iOS, a web view on macOS and Windows.
  mapLibre,

  /// `flutter_map` drawing the bundled Natural Earth polygons. Always
  /// available and never touches the network.
  naturalEarth,
}

/// Whether this platform normally renders maps with MapLibre.
///
/// False only on Linux, where `maplibre` has no implementation at all and the
/// Natural Earth map is the only renderer rather than a fallback.
bool get mapLibreIsExpected => !Platform.isLinux;

/// Whether MapLibre runs in a web view on this platform instead of natively.
///
/// `maplibre` ships no macOS or Windows implementation, so those platforms
/// resolve to `maplibre_webview`, which runs MapLibre GL JS inside an
/// `InAppWebView`. That backend needs a loopback socket for its Dart bridge
/// and a CDN fetch for the MapLibre GL JS bundle before it can draw anything.
bool get mapLibreRunsInWebView => Platform.isMacOS || Platform.isWindows;

/// How long a web view map may stay blank before it counts as unavailable.
///
/// Matches the timeout `SpatialMapStyleService` gives the remote style so the
/// two network waits a first map can hit stay comparable. When the network is
/// up the web view has already proven the CDN reachable and loads well inside
/// this; when it is down the style fetch has failed first, and this is the
/// remaining wait before the offline map takes over for the session.
const mapLibreLoadTimeout = Duration(seconds: 8);

final mapRendererProvider = NotifierProvider<MapRendererNotifier, MapRenderer>(
  MapRendererNotifier.new,
);

/// Picks the map renderer and latches the fallback once MapLibre has failed.
///
/// Linux has no MapLibre implementation at all, so it starts on
/// [MapRenderer.naturalEarth]. Everywhere else starts on MapLibre.
///
/// A failed web view backend reports nothing: the platform view and every
/// child widget collapse to an empty box, so the map is simply absent with no
/// error and no crash. The map widgets watch for that with a timeout and call
/// [markMapLibreUnavailable], which latches for the rest of the session so
/// every later map falls back immediately instead of waiting again.
class MapRendererNotifier extends Notifier<MapRenderer> {
  @override
  MapRenderer build() =>
      mapLibreIsExpected ? MapRenderer.mapLibre : MapRenderer.naturalEarth;

  /// Records that MapLibre never finished loading on this platform.
  ///
  /// Ignored on Linux, where the fallback is not a fallback but the only
  /// renderer there has ever been.
  void markMapLibreUnavailable() {
    if (state == MapRenderer.naturalEarth) return;
    state = MapRenderer.naturalEarth;
  }

  /// Clears the latch so the next map tries MapLibre again.
  ///
  /// The usual reason a web view map fails is a missing network, so a user who
  /// reconnects should not have to restart the app to get detailed basemaps
  /// back.
  void retryMapLibre() {
    if (!mapLibreIsExpected || state == MapRenderer.mapLibre) return;
    state = MapRenderer.mapLibre;
  }
}
