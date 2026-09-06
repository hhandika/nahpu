import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/services/templates/font_metadata.dart';
import 'package:nahpu/services/templates/font_registry.dart';
import 'package:path/path.dart' as p;

void main() {
  const reader = FontMetadataReader();

  Uint8List loadAsset(String name) =>
      File(p.join('assets', 'fonts', name)).readAsBytesSync();

  test('reads family and style from a regular TrueType font', () {
    final metadata = reader.read(loadAsset('PlusJakartaSans-Regular.ttf'));

    expect(metadata.family, 'Plus Jakarta Sans');
    expect(metadata.italic, isFalse);
    expect(metadata.weight, 400);
  });

  test('reads italic and bold styles', () {
    final italic = reader.read(loadAsset('PlusJakartaSans-Italic.ttf'));
    expect(italic.family, 'Plus Jakarta Sans');
    expect(italic.italic, isTrue);

    final bold = reader.read(loadAsset('PlusJakartaSans-Bold.ttf'));
    expect(bold.family, 'Plus Jakarta Sans');
    expect(bold.italic, isFalse);
    expect(bold.weight, 700);
  });

  test('reads the families bundled with the app', () {
    expect(
      reader.read(loadAsset('Merriweather-Regular.ttf')).family,
      'Merriweather',
    );
    expect(reader.read(loadAsset('DejaVuSans.ttf')).family, 'DejaVu Sans');
    expect(
      reader.read(loadAsset('LibertinusSerif-Regular.ttf')).family,
      'Libertinus Serif',
    );
  });

  /// `pubspec.yaml` as text with LF newlines.
  ///
  /// Windows CI checks the repo out with CRLF, and the declaration pattern
  /// below is anchored on newlines. Normalizing here keeps the pattern
  /// readable instead of threading `\r?` through every line break in it.
  String readPubspec() =>
      File('pubspec.yaml').readAsStringSync().replaceAll('\r\n', '\n');

  test('every bundled family is declared under its internal name', () {
    // Flutter resolves a canvas font by the `pubspec.yaml` family name while
    // Typst resolves the same font by the name inside the file. They only
    // agree if the declaration uses the font's own family name, so a font
    // swap that changes that name has to update `pubspec.yaml` and
    // `kBundledFontFamilies` with it.
    final pubspec = readPubspec();
    final declarations = RegExp(
      r'- family: "([^"]+)"\n((?:\s+fonts:\n)?(?:\s+- asset: [^\n]+\n(?:\s+(?:weight|style): [^\n]+\n)*)+)',
    ).allMatches(pubspec);
    expect(declarations, isNotEmpty);

    for (final declaration in declarations) {
      final family = declaration.group(1)!;
      // The icon font carries no meaningful family name of its own.
      if (family == 'NahpuIcons') continue;
      expect(
        kBundledFontFamilies,
        contains(family),
        reason: '$family is declared in pubspec.yaml but not registered',
      );
      for (final asset in RegExp(
        r'- asset: (\S+)',
      ).allMatches(declaration.group(2)!)) {
        // Asset paths in `pubspec.yaml` are POSIX regardless of host.
        final assetPath = asset.group(1)!;
        final path = p.joinAll(p.posix.split(assetPath));
        expect(
          reader.read(File(path).readAsBytesSync()).family,
          family,
          reason: '$path does not declare the family "$family"',
        );
      }
    }
  });

  test('every registered family is declared in pubspec.yaml', () {
    final pubspec = readPubspec();
    for (final family in kBundledFontFamilies) {
      expect(
        pubspec,
        contains('- family: "$family"'),
        reason: '$family is registered but not bundled',
      );
    }
  });

  test('rejects a file that is not a font', () {
    expect(
      () => reader.read(Uint8List.fromList(List<int>.filled(64, 0x42))),
      throwsA(isA<FontFormatException>()),
    );
  });

  test('rejects a truncated file', () {
    expect(
      () => reader.read(Uint8List.fromList(const [0, 1, 0, 0])),
      throwsA(isA<FontFormatException>()),
    );
  });
}
