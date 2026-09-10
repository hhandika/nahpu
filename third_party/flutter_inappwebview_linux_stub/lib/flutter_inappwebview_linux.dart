/// Linux registration for `flutter_inappwebview` without any native code.
///
/// NAHPU draws maps with Natural Earth on Linux and never builds an
/// `InAppWebView` there (see `mapLibreRunsInWebView` in
/// `lib/services/providers/map_renderer.dart`), so the upstream plugin's WPE
/// WebKit backend is not needed.
class LinuxInAppWebViewPlatform {
  /// Called by the generated Dart plugin registrant.
  ///
  /// Leaves the web view platform instance unset, so any accidental web view
  /// on Linux fails loudly instead of rendering an empty box.
  static void registerWith() {}
}
