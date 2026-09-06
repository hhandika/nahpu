import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:nahpu/src/rust/frb_generated.dart';
import 'package:path/path.dart' as p;

/// Initializes the Rust bridge for a test process.
///
/// Tests run on the host without an app bundle, so the library cannot be
/// resolved as a bundled code asset and has to be opened from disk. The Native
/// Assets build hook compiles it while `flutter test` runs and writes it under
/// `build/native_assets/`, so that copy is preferred. A manual `cargo build` in
/// `rust/` remains supported as a fallback.
///
/// Integration tests run against the real app bundle and should call
/// `RustLib.init()` directly instead.
Future<void> initRustLibForTest() async {
  await RustLib.init(
    externalLibrary: ExternalLibrary.open(_resolveRustLibraryPath()),
  );
}

/// The compiled Rust library file name for the host platform.
String get _rustLibraryFileName {
  if (Platform.isMacOS) return 'librust_lib_nahpu.dylib';
  if (Platform.isWindows) return 'rust_lib_nahpu.dll';
  return 'librust_lib_nahpu.so';
}

String _resolveRustLibraryPath() {
  final candidates = [
    ..._nativeAssetsCandidates(),
    p.join('rust', 'target', 'release', _rustLibraryFileName),
    p.join('rust', 'target', 'debug', _rustLibraryFileName),
  ];
  for (final candidate in candidates) {
    if (File(candidate).existsSync()) return candidate;
  }
  throw StateError(
    'Could not find $_rustLibraryFileName for tests. The Native Assets build '
    'hook builds it during `flutter test`; otherwise build it manually with '
    '`cargo build` in rust/. Looked in: ${candidates.join(', ')}.',
  );
}

/// Native Assets writes the library into a per-target subdirectory whose name
/// depends on the host, so scan the directory rather than guessing the name.
List<String> _nativeAssetsCandidates() {
  final root = Directory(p.join('build', 'native_assets'));
  if (!root.existsSync()) return const [];
  return root
      .listSync()
      .whereType<Directory>()
      .map((dir) => p.join(dir.path, _rustLibraryFileName))
      .toList();
}
