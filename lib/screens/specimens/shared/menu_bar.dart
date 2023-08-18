import 'package:flutter/material.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/services/specimen_services.dart';

Future<void> createNewSpecimens(BuildContext context, WidgetRef ref) async {
  await SpecimenServices(ref: ref).createSpecimen();
  if (context.mounted) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SpecimenViewer()),
    );
  }
}

class NewSpecimensTextButton extends ConsumerStatefulWidget {
  const NewSpecimensTextButton({super.key});

  @override
  NewSpecimensTextButtonState createState() => NewSpecimensTextButtonState();
}

class NewSpecimensTextButtonState
    extends ConsumerState<NewSpecimensTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await createNewSpecimens(context, ref);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        }
      },
      child: const Text('Create specimen'),
    );
  }
}

class NewSpecimens extends ConsumerStatefulWidget {
  const NewSpecimens({super.key});

  @override
  NewSpecimensState createState() => NewSpecimensState();
}

class NewSpecimensState extends ConsumerState<NewSpecimens> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        try {
          await createNewSpecimens(context, ref);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        }
      },
    );
  }
}

class SpecimenMenu extends ConsumerStatefulWidget {
  const SpecimenMenu({
    super.key,
    required this.specimenUuid,
    required this.catalogFmt,
  });

  final String? specimenUuid;
  final CatalogFmt? catalogFmt;

  @override
  SpecimenMenuState createState() => SpecimenMenuState();
}

class SpecimenMenuState extends ConsumerState<SpecimenMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: CreateMenuButton(text: _getNewSpecimenLabel()),
                onTap: () => createNewSpecimens(context, ref),
              ),
              PopupMenuItem(
                onTap: widget.specimenUuid == null
                    ? null
                    : () async {
                        await _duplicatePart();
                      },
                child: const DuplicateMenuButton(text: 'Duplicate part'),
              ),
              const PopupMenuDivider(height: 10),
              PopupMenuItem(
                child: const DeleteMenuButton(
                  deleteAll: false,
                ),
                onTap: () => _deleteSpecimen(),
              ),
              PopupMenuItem(
                child: const DeleteMenuButton(
                  deleteAll: true,
                ),
                onTap: () => _deleteAllSpecimens(),
              ),
            ]);
  }

  String _getNewSpecimenLabel() {
    return 'Create specimen';
  }

  Future<void> _duplicatePart() async {
    try {
      await SpecimenServices(ref: ref)
          .createSpecimenDuplicatePart(widget.specimenUuid!);
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SpecimenViewer()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  void _deleteSpecimen() {
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete specimen?',
      deletePrompt:
          'You will delete this specimen record, all measurements, and specimen parts.\n'
          'You will need to manually update the field number.',
      onDelete: () async {
        if (widget.specimenUuid != null && widget.catalogFmt != null) {
          try {
            await SpecimenServices(ref: ref).deleteSpecimen(
              widget.specimenUuid!,
              widget.catalogFmt!,
            );
            if (context.mounted) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SpecimenViewer()),
              );
            }
          } catch (e) {
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'Error deleting specimen: $e',
                  textAlign: TextAlign.center,
                )),
              );
            }
          }
        }
      },
    );
  }

  void _deleteAllSpecimens() {
    showDeleteAlertOnMenu(
        context: context,
        title: 'Delete all specimens?',
        deletePrompt: 'It will remove all specimens records'
            ', measurements, and specimen parts',
        onDelete: () async {
          try {
            await SpecimenServices(ref: ref).deleteAllSpecimens();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'Error deleting all specimens: $e',
                  textAlign: TextAlign.center,
                )),
              );
            }
          }
        });
  }
}
