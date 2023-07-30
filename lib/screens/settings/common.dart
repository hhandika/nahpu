import 'package:flutter/material.dart';
import 'package:nahpu/services/utility_services.dart';

class CommonSettingList extends StatelessWidget {
  const CommonSettingList({
    super.key,
    required this.sections,
  });

  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(children: sections),
      ),
    );
  }
}

class CommonSettingTile extends StatelessWidget {
  const CommonSettingTile({
    super.key,
    required this.title,
    this.label,
    required this.icon,
    this.value,
    required this.onTap,
    this.trailing,
    this.isNavigation = false,
  });

  final String title;
  final String? label;
  final IconData icon;
  final VoidCallback? onTap;
  final String? value;
  final Widget? trailing;
  final bool isNavigation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
      subtitle: label != null
          ? Text(
              label!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
                overflow: TextOverflow.ellipsis,
              ),
            )
          : null,
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          value != null
              ? Text(
                  value!,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(120)),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 4),
          trailing ?? const SizedBox.shrink(),
          isNavigation
              ? const Icon(Icons.arrow_forward_ios)
              : const SizedBox.shrink(),
        ],
      ),
      onTap: onTap,
    );
  }
}

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

class CommonSettingSection extends StatelessWidget {
  const CommonSettingSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(100),
          ),
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 8),
      ],
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
    required this.resetLabel,
    required this.onReset,
  });

  final String title;
  final String labelText;
  final String hintText;
  final List<Widget> chipList;
  final VoidCallback onPressed;
  final TextEditingController controller;
  final String resetLabel;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return CommonSettingSection(
      title: title,
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
