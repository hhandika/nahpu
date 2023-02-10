import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/projects/dashboard.dart';

class ProjectBackButton extends ConsumerWidget {
  const ProjectBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Dashboard();
        }));
        ref.read(projectNavbarIndexProvider.notifier).state = 0;
      },
    );
  }
}

class FormElevButton extends StatelessWidget {
  const FormElevButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.enabled,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return PrimaryButton(
        onPressed: onPressed,
        text: text,
      );
    } else {
      return PrimaryButton(
        onPressed: null,
        text: text,
      );
    }
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        // elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
