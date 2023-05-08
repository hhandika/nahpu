import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';

class MeasurementForm extends StatelessWidget {
  const MeasurementForm({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Measurements',
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
