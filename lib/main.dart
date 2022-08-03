import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/configs/themes.dart';
import 'package:nahpu/database/database.dart';
import 'package:nahpu/screens/home.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return Provider(
        create: (_) => Database(),
        child: MaterialApp(
          title: 'Nahpu',
          home: const Home(),
          theme: NahpuTheme.lightTheme(lightColorScheme),
          darkTheme: NahpuTheme.darkTheme(darkColorScheme),
        ),
        dispose: (_, Database database) => database.close(),
      );
    });
  }
}

// return MaterialApp(
      //   title: 'Nahpu',
      //   theme: ThemeData(
      //     primarySwatch: lightColorScheme.primary,
      //     accentColor: lightColorScheme.accent,
      //     brightness: lightColorScheme.brightness,
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //     scaffoldBackgroundColor: lightColorScheme.background,
      //     appBarTheme: AppBarTheme(
      //       color: lightColorScheme.background,
      //       textTheme: TextTheme(
      //         headline6: TextStyle(
      //           color: lightColorScheme.onBackground,
      //           fontSize: 20,
      //         ),
      //       ),
      //     ),
      //     textTheme: TextTheme(
      //       headline6: TextStyle(
      //         color: lightColorScheme.onBackground,
      //         fontSize: 20,
      //       ),
      //     ),
      //     iconTheme: IconThemeData(
      //       color: lightColorScheme.onBackground,
      //     ),
      //     inputDecorationTheme: InputDecorationTheme(
      //       labelStyle: TextStyle(
      //         color: lightColorScheme.onBackground,
      //       ),
      //     ),
      //     buttonTheme: ButtonThemeData(
      //       buttonColor: lightColorScheme.primary,
      //       textTheme: ButtonTextTheme.primary,
      //     ),
      //     floatingActionButtonTheme: FloatingActionButtonThemeData(
      //       backgroundColor: lightColorScheme.primary,
      //     ),
      //     snackBarTheme: SnackBarThemeData(
      //       backgroundColor: lightColorScheme.background,
      //       contentTextStyle: TextStyle(
      //         color: lightColorScheme.onBackground,
      //       ),
      //     ),
      //     dialogTheme: DialogTheme(
      //       backgroundColor: lightColorScheme.background,
      //       titleTextStyle: TextStyle(
      //         color: lightColorScheme.onBackground,
      //       ),
      //     ),
      //     bottomSheetTheme: BottomSheetThemeData(
      //       backgroundColor: lightColorScheme.background,
      //     ),
      //     cardTheme: CardTheme(
      //       color: lightColorScheme.background,
      //     ),
      //     chipTheme: ChipThemeData(
      //       backgroundColor: lightColorScheme.background,
      //       label Style: TextStyle(
      //         color: lightColorScheme.onBackground,
      //       ),);
    
