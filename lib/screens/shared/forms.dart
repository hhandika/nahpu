import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.title,
      required this.child,
      this.isPrimary = false})
      : super(key: key);

  final Widget child;
  final String title;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPrimary
          ? Theme.of(context).colorScheme.secondaryContainer
          : Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
