import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/layout.dart';

class EnvironmentDataForm extends ConsumerWidget {
  const EnvironmentDataForm({Key? key, required this.useHorizontalLayout})
      : super(key: key);

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          children: [
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Lowest Temperature',
                      hintText: 'Enter lowest'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Highest Temperature',
                      hintText: 'Enter highest'),
                )
              ],
            ),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Lowest Precipitation',
                      hintText: 'Enter lowest'),
                ),
                TextField(
                    decoration: InputDecoration(
                        labelText: 'Highest Precipitation',
                        hintText: 'Enter highest'))
              ],
            ),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Sunrise', hintText: 'Enter sunrise'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Sunset', hintText: 'Enter sunset'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Moon phase', hintText: 'Enter moon phase'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
