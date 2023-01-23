import 'package:flutter/material.dart';

class NahpuColor {
  static Color? navColor(BuildContext context) => Color.lerp(
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.secondary,
      0.1);

  static Color? tabBarColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
}
