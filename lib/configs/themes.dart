import 'package:flutter/material.dart';

class NahpuTheme {
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.teal);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    return ThemeData(
      colorScheme: lightColorScheme ?? _defaultLightColorScheme,
      useMaterial3: true,
      // primaryColor: primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: cardTheme,
    );
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    return ThemeData(
      colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: cardTheme,
    );
  }

  static CardTheme get cardTheme {
    return const CardTheme(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
