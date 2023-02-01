import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class EnvironmentDataForm extends ConsumerWidget {
  const EnvironmentDataForm({Key? key, required this.useHorizontalLayout})
      : super(key: key);

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> moonPhase = [
      'New Moon',
      'Waxing Crescent',
      'First Quarter',
      'Waxing Gibbous',
      'Full Moon',
      'Waning Gibbous',
      'Last Quarter',
      'Waning Crescent'
    ];
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          children: [
            const TitleForm(
              text: 'Weather Data',
            ),
            const SizedBox(height: 15),
            Text('Temperature (°C)',
                style: Theme.of(context).textTheme.titleMedium),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Day Lowest',
                      hintText: 'Enter lowest temperature'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Day Highest',
                      hintText: 'Enter highest temprature'),
                ),
              ],
            ),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Night Lowest',
                      hintText: 'Enter lowest temperature'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Night Highest',
                      hintText: 'Enter highest temprature'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Humidity (%)',
                style: Theme.of(context).textTheme.titleMedium),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Average', hintText: 'Enter average humidity'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Dew Point', hintText: 'Enter dew point'),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text('Astronomy', style: Theme.of(context).textTheme.titleMedium),
            AdaptiveLayout(
              useHorizontalLayout: useHorizontalLayout,
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Sunrise', hintText: 'Enter sunrise time'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Sunset', hintText: 'Enter sunset time'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Moon Phase',
                  hintText: 'Select moon phase',
                ),
                items: moonPhase
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {},
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
