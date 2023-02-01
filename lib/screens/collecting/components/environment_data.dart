import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

class EnvironmentDataView extends ConsumerWidget {
  const EnvironmentDataView({
    super.key,
    required this.useHorizontalLayout,
    required this.eventID,
  });

  final bool useHorizontalLayout;
  final int eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const TitleForm(
          text: 'Weather Data',
        ),
        EnvironmentDataForm(
            useHorizontalLayout: useHorizontalLayout,
            weatherCtr: CollWeatherCtrModel.empty()),
      ],
    );
  }
}

class EnvironmentDataForm extends ConsumerWidget {
  const EnvironmentDataForm(
      {super.key, required this.useHorizontalLayout, required this.weatherCtr});

  final bool useHorizontalLayout;
  final CollWeatherCtrModel weatherCtr;

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
    return Column(
      children: [
        Text('Temperature (°C)',
            style: Theme.of(context).textTheme.titleMedium),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: weatherCtr.dayTempLowestCtr,
              labelText: 'Day Lowest',
              hintText: 'Enter lowest temperature',
              isLastField: false,
            ),
            CommonNumField(
              controller: weatherCtr.dayTempHighestCtr,
              labelText: 'Day Highest',
              hintText: 'Enter highest temprature',
              isLastField: false,
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: weatherCtr.nightTempLowestCtr,
              labelText: 'Night Lowest',
              hintText: 'Enter lowest temperature',
              isLastField: false,
            ),
            CommonNumField(
              controller: weatherCtr.nightTempHighestCtr,
              labelText: 'Night Highest',
              hintText: 'Enter highest temprature',
              isLastField: false,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Humidity (%)', style: Theme.of(context).textTheme.titleMedium),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            CommonNumField(
              controller: weatherCtr.avarageHumidityCtr,
              labelText: 'Average',
              hintText: 'Enter average humidity',
              isLastField: false,
            ),
            CommonNumField(
              controller: weatherCtr.dewPointCtr,
              labelText: 'Dew Point',
              hintText: 'Enter dew point',
              isLastField: false,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Astronomy', style: Theme.of(context).textTheme.titleMedium),
        AdaptiveLayout(
          useHorizontalLayout: useHorizontalLayout,
          children: [
            TextField(
              controller: weatherCtr.sunriseTimeCtr,
              decoration: const InputDecoration(
                labelText: 'Sunrise',
                hintText: 'Enter sunrise time',
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  weatherCtr.sunriseTimeCtr.text = picked.toString();
                }
              },
            ),
            TextField(
              controller: weatherCtr.sunsetTimeCtr,
              decoration: const InputDecoration(
                labelText: 'Sunset',
                hintText: 'Enter sunset time',
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  weatherCtr.sunsetTimeCtr.text = picked.toString();
                }
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: DropdownButtonFormField(
            value: weatherCtr.moonPhaseCtr,
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
    );
  }
}
