import 'package:flutter/material.dart';

class CommmonProgressIndicator extends StatelessWidget {
  const CommmonProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
