import 'package:flutter/material.dart';
import 'package:nahpu/screens/projects/taxonomy/specimen_list.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/types/types.dart';
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

class NewSpecimens extends ConsumerWidget {
  const NewSpecimens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        createNewSpecimens(context, ref);
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
                  child: const FindMenuButton(),
                  onTap: () async {
                    List<SpecimenData> specimens =
                        await SpecimenServices(ref: ref).getAllSpecimens();
                    if (mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => SpecimenListPage(data: specimens)),
                      );
                    }
                  }),
              // const PopupMenuItem<MenuSelection>(
              //   value: MenuSelection.duplicate,
              //   child: DuplicateMenuButton(text: 'Duplicate record'),
              // ),
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error deleting specimen: $e',
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.red,
              ),
            );
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error deleting all specimens: $e',
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
  }
}
