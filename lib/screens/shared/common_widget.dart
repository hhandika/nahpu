import 'package:flutter/material.dart';

class BottomPadding extends StatelessWidget {
  const BottomPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Padding to avoid the bottom sheet covering the last field
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }
}
