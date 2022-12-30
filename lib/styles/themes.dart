import 'package:flutter/material.dart';
import 'dart:io';

class NahpuTheme {
  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
  );

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme(ColorScheme? lightColorScheme) {
    return ThemeData(
      colorScheme: lightColorScheme ?? _defaultLightColorScheme,
      useMaterial3: Platform.isIOS ? false : true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarLightTheme,
      cardTheme: cardTheme,
    );
  }

  static ThemeData darkTheme(ColorScheme? darkColorScheme) {
    return ThemeData(
      colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
      useMaterial3: Platform.isIOS ? false : true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: appBarDarkTheme,
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

  static AppBarTheme get appBarLightTheme {
    return AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Merriweather',
        color: Colors.grey[800],
        fontSize: 24,
      ),
    );
  }

  static AppBarTheme get appBarDarkTheme {
    return AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Merriweather',
        color: Colors.grey[50],
        fontSize: 24,
      ),
    );
  }
}
