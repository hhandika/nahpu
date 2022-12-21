import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:intl/intl.dart';

class CaptureRecordFields extends ConsumerWidget {
  const CaptureRecordFields({Key? key, required this.specimenCtr})
      : super(key: key);

  final SpecimenFormCtrModel specimenCtr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormCard(
      title: 'Capture Records',
      child: Column(
        children: [
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Collecting Event ID',
                hintText: 'Choose a site ID',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'One',
                  child: Text('One'),
                ),
                DropdownMenuItem(
                  value: 'Two',
                  child: Text('Two'),
                ),
              ],
              onChanged: (String? newValue) {}),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Capture Method',
                hintText: 'Choose a trap type',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'One',
                  child: Text('One'),
                ),
                DropdownMenuItem(
                  value: 'Two',
                  child: Text('Two'),
                ),
              ],
              onChanged: (String? newValue) {}),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Capture date',
              hintText: 'Enter date',
            ),
            controller: specimenCtr.captureDateCtr,
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now())
                  .then((date) {
                if (date != null) {
                  specimenCtr.captureDateCtr.text =
                      DateFormat.yMMMd().format(date);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
