import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.lerp(Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.surface, 0.95),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
