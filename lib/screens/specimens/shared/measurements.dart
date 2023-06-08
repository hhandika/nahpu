import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';

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
      child: SizedBox(
        height: 490,
        child: CommonScrollbar(
          scrollController: _scrollController,
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
