import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class SettingChip extends StatelessWidget {
  const SettingChip({
    super.key,
    required this.title,
    required this.controller,
    required this.labelText,
    required this.chipList,
    required this.hintText,
    required this.onPressed,
  });

  final String title;
  final String labelText;
  final String hintText;
  final List<Widget> chipList;
  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Wrap(
          spacing: 15,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: chipList,
        ),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: labelText,
                    hintText: hintText,
                  ),
                ),
              ),
              IconButton(
                iconSize: 25,
                color: Theme.of(context).colorScheme.onSurface,
                icon: const Icon(Icons.add),
                onPressed: onPressed,
              ),
            ])
      ],
    );
  }
}

class CommonChip extends StatelessWidget {
  const CommonChip({
    super.key,
    required this.text,
    required this.onDeleted,
  });

  final String text;
  final void Function() onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
      backgroundColor: Color.lerp(
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).colorScheme.surface,
          0.9),
      onDeleted: onDeleted,
    );
  }
}
