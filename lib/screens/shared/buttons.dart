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

class ProgressButton extends StatelessWidget {
  const ProgressButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isRunning,
    required this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isRunning;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      icon: isRunning
          ? const SizedBox(
              height: 10,
              width: 10,
              child: CircularProgressIndicator(),
            )
          : Icon(icon),
      onPressed: onPressed,
      label: Text(label),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      icon: Icon(Icons.adaptive.share_outlined),
      onPressed: onPressed,
      label: const Text('Share'),
    );
  }
}

class FormElevButton extends StatelessWidget {
  const FormElevButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.enabled,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: enabled ? onPressed : null,
      label: label,
      icon: icon,
    );
  }
}

class FormButtonWithDelete extends StatelessWidget {
  const FormButtonWithDelete({
    super.key,
    required this.isEditing,
    required this.onDeleted,
    required this.onSubmitted,
  });

  final bool isEditing;
  final VoidCallback onDeleted;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onDeleted,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
              _buildFormButton(),
            ],
          )
        : _buildFormButton();
  }

  Widget _buildFormButton() {
    return FormButton(
      isEditing: isEditing,
      onSubmitted: onSubmitted,
    );
  }
}

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Icon(icon));
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.isEditing,
    required this.onSubmitted,
  });

  final bool isEditing;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SecondaryButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 10),
        PrimaryButton(
          label: isEditing ? 'Update' : 'Add',
          icon: isEditing ? Icons.check : Icons.add,
          onPressed: onSubmitted,
        ),
      ],
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
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  const TertiaryButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class DeleteMenuButton extends StatelessWidget {
  const DeleteMenuButton({
    super.key,
    required this.deleteAll,
  });

  final bool deleteAll;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        deleteAll ? Icons.delete_forever_outlined : Icons.delete_outline,
        color: Colors.red,
      ),
      title: Text(
        deleteAll ? 'Delete all records' : 'Delete record',
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

class CreateMenuButton extends StatelessWidget {
  const CreateMenuButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.create_outlined),
      title: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class DuplicateMenuButton extends StatelessWidget {
  const DuplicateMenuButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.copy_outlined),
      title: Text(text),
    );
  }
}

class PdfExportMenuButton extends StatelessWidget {
  const PdfExportMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.picture_as_pdf_outlined),
      title: Text('Export to PDF'),
    );
  }
}

class SearchMenuButton extends StatelessWidget {
  const SearchMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.search_outlined),
      title: Text('Search'),
    );
  }
}
