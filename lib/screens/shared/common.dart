import 'package:flutter/material.dart';

/// Used by specimen forms to avoid the
/// bottom sheet covering the last field
class BottomPadding extends StatelessWidget {
  const BottomPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding to avoid the bottom sheet covering the last field
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    );
  }
}

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
