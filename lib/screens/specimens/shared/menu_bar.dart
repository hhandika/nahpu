import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
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
  await SpecimenServices(ref).createSpecimen();
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
        onSelected: _onPopupMenuSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuSelection>>[
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.newSpecimen,
                child: CreateMenuButton(text: 'Create record'),
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
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteRecords,
                child: DeleteMenuButton(
                  deleteAll: false,
                ),
              ),
              const PopupMenuItem<MenuSelection>(
                value: MenuSelection.deleteAllRecords,
                child: DeleteMenuButton(
                  deleteAll: true,
                ),
              ),
            ]);
  }

  Future<void> _onPopupMenuSelected(MenuSelection item) async {
    switch (item) {
      case MenuSelection.newSpecimen:
        createNewSpecimens(context, ref);
        break;
      case MenuSelection.duplicate:
        break;
      case MenuSelection.pdfExport:
        break;
      case MenuSelection.deleteRecords:
        if (widget.specimenUuid != null && widget.catalogFmt != null) {
          await SpecimenServices(ref).deleteSpecimen(
            widget.specimenUuid!,
            widget.catalogFmt!,
          );
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SpecimenViewer()),
            );
          }
        }
        break;
      case MenuSelection.deleteAllRecords:
        SpecimenServices(ref).deleteAllSpecimens();
        break;
    }
  }
}
