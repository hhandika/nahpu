import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';

class ToolManagement extends ConsumerWidget {
  const ToolManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TitleForm(text: 'Tool Management'),
        PrimaryButton(
          text: 'Manage Tool',
          onPressed: () {},
        ),
      ],
    );
  }
}
