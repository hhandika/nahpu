import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/forms.dart';

class MeasurementForms extends ConsumerStatefulWidget {
  const MeasurementForms({Key? key}) : super(key: key);

  @override
  MeasurementFormsState createState() => MeasurementFormsState();
}

class MeasurementFormsState extends ConsumerState<MeasurementForms> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Measurements',
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Total length (mm)',
              hintText: 'Enter TTL',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Tail length (mm)',
              hintText: 'Enter TL',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Hind foot length (mm)',
              hintText: 'Enter HF',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ear length (mm)',
              hintText: 'Enter ER',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Weight (grams)',
              hintText: 'Enter specimen weight',
            ),
            keyboardType: TextInputType.number,
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Sex',
                hintText: 'Choose one',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text('Female'),
                ),
                DropdownMenuItem(
                  value: 'Unknown',
                  child: Text('Unknown'),
                ),
              ],
              onChanged: (String? newValue) {}),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Life stage',
                hintText: 'Choose one',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Adult',
                  child: Text('Adult'),
                ),
                DropdownMenuItem(
                  value: 'Subadult',
                  child: Text('Subadult'),
                ),
                DropdownMenuItem(
                  value: 'Juvenile',
                  child: Text('Juvenile'),
                ),
                DropdownMenuItem(
                  value: 'Unknown',
                  child: Text('Unknown'),
                ),
              ],
              onChanged: (String? newValue) {}),
        ],
      ),
    );
  }
}
