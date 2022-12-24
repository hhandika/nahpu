import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
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
            FormCard(
                title: 'Temperature',
                child: AdaptiveLayout(
                    useHorizontalLayout: useHorizontalLayout,
                    children: const [
                      CustomTextField(
                          labelText: 'Lowest', hintText: 'Enter lowest'),
                      CustomTextField(
                          labelText: 'Highest', hintText: 'Enter highest'),
                    ])),
            FormCard(
              title: 'Precipitation',
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: const [
                  CustomTextField(
                      labelText: 'Lowest', hintText: 'Enter lowest'),
                  CustomTextField(
                      labelText: 'Highest', hintText: 'Enter highest')
                ],
              ),
            ),
            FormCard(
              title: 'Astronomy',
              child: AdaptiveLayout(
                useHorizontalLayout: useHorizontalLayout,
                children: const [
                  CustomTextField(
                      labelText: 'Sunrise', hintText: 'Enter sunrise'),
                  CustomTextField(
                      labelText: 'Sunset', hintText: 'Enter sunset'),
                  CustomTextField(
                      labelText: 'Moon phase', hintText: 'Enter moon phase'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
