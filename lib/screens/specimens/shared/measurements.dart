import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';

class MeasurementForm extends StatefulWidget {
  const MeasurementForm({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  State<MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Measurements',
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          thickness: 5,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
