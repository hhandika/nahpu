import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
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

CustomSettingsTile get androidPadding {
  return Platform.isAndroid
      ? const CustomSettingsTile(
          child: SizedBox(
            height: 20,
          ),
        )
      : const CustomSettingsTile(
          child: SizedBox.shrink(),
        );
}

class SettingChip extends StatelessWidget {
  const SettingChip({
    super.key,
    required this.controller,
    required this.labelText,
    required this.chipList,
    required this.hintText,
    required this.onPressed,
    required this.resetLabel,
    required this.onReset,
  });

  final String labelText;
  final String hintText;
  final List<Widget> chipList;
  final VoidCallback onPressed;
  final TextEditingController controller;
  final String resetLabel;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
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
              constraints: const BoxConstraints(maxWidth: 270),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                ),
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    controller.value = TextEditingValue(
                      text: value.toSentenceCase(),
                      selection: controller.selection,
                    );
                  }
                },
                onSubmitted: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    onPressed();
                  }
                },
              ),
            ),
            IconButton(
              iconSize: 25,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.add),
              onPressed: onPressed,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: TextButton(
            onPressed: onReset,
            child: Text(
              resetLabel,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CommonChip extends StatelessWidget {
  const CommonChip({
    super.key,
    required this.text,
    required this.primaryColor,
    required this.onDeleted,
  });

  final String text;
  final Color primaryColor;
  final void Function() onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
      backgroundColor: Color.lerp(
        primaryColor,
        Theme.of(context).colorScheme.surface,
        0.85,
      ),
      onDeleted: onDeleted,
    );
  }
}
