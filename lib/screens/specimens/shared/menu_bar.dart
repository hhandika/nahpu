import 'package:flutter/material.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/specimens/specimen_view.dart';
import 'package:nahpu/services/specimen_services.dart';

enum MenuSelection {
  newSpecimen,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

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
    return PopupMenuButton<MenuSelection>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.newSpecimen,
                child: const CreateMenuButton(text: 'Create record'),
                onTap: () => createNewSpecimens(context, ref),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.duplicate,
                child: DuplicateMenuButton(text: 'Duplicate record'),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.pdfExport,
                child: PdfExportMenuButton(),
              ),
              const PopupMenuDivider(height: 10),
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteRecords,
                child: const DeleteMenuButton(
                  deleteAll: false,
                ),
                onTap: () => _deleteSpecimen(),
              ),
              PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteAllRecords,
                child: const DeleteMenuButton(
                  deleteAll: true,
                ),
                onTap: () => _deleteAllSpecimens(),
              ),
            ]);
  }

  void _deleteSpecimen() {
    showDeleteAlertOnMenu(
      () async {
        if (widget.specimenUuid != null && widget.catalogFmt != null) {
          await SpecimenServices(ref: ref).deleteSpecimen(
            widget.specimenUuid!,
            widget.catalogFmt!,
          );
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SpecimenViewer()),
            );
          }
        }
      },
      'Deleting a specimen WILL NOT '
      'update the cataloger field number.\n'
      'Make sure to correct the field number after deleting.\n\n'
      'Delete this specimen?',
      context,
    );
  }

  void _deleteAllSpecimens() {
    showDeleteAlertOnMenu(() async {
      await SpecimenServices(ref: ref).deleteAllSpecimens();
    }, 'Delete all specimens?\nTHIS ACTION CANNOT BE UNDONE!', context);
  }
}
