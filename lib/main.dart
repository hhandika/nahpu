// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:dynamic_color/dynamic_color.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nahpu/src/rust/api/common.dart';
// import 'package:nahpu/src/rust/frb_generated.dart';
// import 'package:nahpu/styles/themes.dart';
// import 'package:nahpu/providers/settings.dart';
// import 'package:nahpu/screens/home/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   await RustLib.init();
//   if (kDebugMode) {
//     print('Test: ${testRust()}');
//   }
//   runApp(ProviderScope(
//       overrides: [settingProvider.overrideWithValue(prefs)],
//       child: const NahpuApp()));
// }
//
// class NahpuApp extends ConsumerWidget {
//   const NahpuApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
//       return MaterialApp(
//         title: 'Nahpu',
//         home: const Home(),
//         debugShowCheckedModeBanner: false,
//         theme: NahpuTheme.lightTheme(lightColorScheme),
//         darkTheme: NahpuTheme.darkTheme(darkColorScheme),
//         themeMode: ref.watch(themeSettingProvider).when(
//               data: (theme) => theme,
//               loading: () => ThemeMode.system,
//               error: (error, stackTrace) => ThemeMode.system,
//             ),
//       );
//     });
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:nahpu/src/rust/api/simple.dart';
import 'package:nahpu/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Center(
          child: Text(
              'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`'),
        ),
      ),
    );
  }
}
