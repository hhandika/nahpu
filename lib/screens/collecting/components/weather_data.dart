import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class WeatherDataView extends ConsumerWidget {
  const WeatherDataView({
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
        ref.watch(weatherDataProvider(eventID)).when(
              data: (weatherData) => WeatherDataForm(
                useHorizontalLayout: useHorizontalLayout,
                eventID: eventID,
                weatherCtr: _getweatherData(weatherData),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => const Center(
                child: Text('Error'),
              ),
            ),
      ],
    );
  }

  CollWeatherCtrModel _getweatherData(WeatherData weatherData) {
    return CollWeatherCtrModel.fromData(weatherData);
  }
}

class WeatherDataForm extends ConsumerStatefulWidget {
  const WeatherDataForm({
    super.key,
    required this.useHorizontalLayout,
    required this.eventID,
    required this.weatherCtr,
  });

  final bool useHorizontalLayout;
  final int eventID;
  final CollWeatherCtrModel weatherCtr;

  @override
  WeatherDataFormState createState() => WeatherDataFormState();
}

class WeatherDataFormState extends ConsumerState<WeatherDataForm> {
  @override
  void dispose() {
    widget.weatherCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonNumField(
              controller: widget.weatherCtr.lowestDayTempCtr,
              labelText: 'Day Lowest',
              hintText: 'Enter lowest temperature',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        lowestDayTempC: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
            CommonNumField(
              controller: widget.weatherCtr.highestDayTempCtr,
              labelText: 'Day Highest',
              hintText: 'Enter highest temprature',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        highestDayTempC: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
          ],
        ),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonNumField(
              controller: widget.weatherCtr.lowestNightTempCtr,
              labelText: 'Night Lowest',
              hintText: 'Enter lowest temperature',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        lowestNightTempC: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
            CommonNumField(
              controller: widget.weatherCtr.highestNightTempCtr,
              labelText: 'Night Highest',
              hintText: 'Enter highest temprature',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        highestNightTempC: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Humidity (%)', style: Theme.of(context).textTheme.titleMedium),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            CommonNumField(
              controller: widget.weatherCtr.averageHumidityCtr,
              labelText: 'Average',
              hintText: 'Enter average humidity',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        averageHumidity: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
            CommonNumField(
              controller: widget.weatherCtr.dewPointCtr,
              labelText: 'Dew Point',
              hintText: 'Enter dew point',
              isLastField: false,
              onChanged: (String? value) {
                if (value != null) {
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        dewPointTemp: db.Value(double.tryParse(value)),
                      ));
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Astronomy', style: Theme.of(context).textTheme.titleMedium),
        AdaptiveLayout(
          useHorizontalLayout: widget.useHorizontalLayout,
          children: [
            TextField(
              controller: widget.weatherCtr.sunriseTimeCtr,
              decoration: const InputDecoration(
                labelText: 'Sunrise',
                hintText: 'Enter sunrise time',
              ),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (picked != null) {
                  if (!mounted) return;
                  widget.weatherCtr.sunriseTimeCtr.text =
                      picked.format(context);
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        sunriseTime:
                            db.Value(widget.weatherCtr.sunriseTimeCtr.text),
                      ));
                }
              },
            ),
            TextField(
              controller: widget.weatherCtr.sunsetTimeCtr,
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
                  widget.weatherCtr.sunsetTimeCtr.text =
                      DateFormat.yMMMd().format(picked);
                  CollEventServices(ref).updateWeatherData(
                      widget.eventID,
                      WeatherCompanion(
                        sunsetTime:
                            db.Value(widget.weatherCtr.sunsetTimeCtr.text),
                      ));
                }
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: DropdownButtonFormField(
            value: widget.weatherCtr.moonPhaseCtr,
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
            onChanged: (String? value) {
              if (value != null) {
                widget.weatherCtr.moonPhaseCtr = value;
                CollEventServices(ref).updateWeatherData(
                    widget.eventID,
                    WeatherCompanion(
                      moonPhase: db.Value(value),
                    ));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: CommonTextField(
            controller: widget.weatherCtr.noteCtr,
            labelText: 'Notes',
            hintText: 'Enter notes',
            maxLines: 3,
            isLastField: true,
            onChanged: (String? value) {
              if (value != null) {
                CollEventServices(ref).updateWeatherData(
                    widget.eventID,
                    WeatherCompanion(
                      notes: db.Value(value),
                    ));
              }
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
