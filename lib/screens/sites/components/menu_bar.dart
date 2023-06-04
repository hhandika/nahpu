import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/sites/site_view.dart';
import 'package:nahpu/services/site_services.dart';

Future<void> createNewSite(BuildContext context, WidgetRef ref) {
  String projectUuid = ref.watch(projectUuidProvider);

  return SiteServices(ref: ref).createNewSite(projectUuid).then((_) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const SiteViewer()));
  });
}

class NewSite extends ConsumerWidget {
  const NewSite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        createNewSite(context, ref);
      },
    );
  }
}

class SiteMenu extends ConsumerStatefulWidget {
  const SiteMenu({
    super.key,
    required this.siteId,
  });

  final int? siteId;

  @override
  SiteMenuState createState() => SiteMenuState();
}

class SiteMenuState extends ConsumerState<SiteMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SiteMenuSelection>(
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<SiteMenuSelection>>[
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.newSite,
                child: const CreateMenuButton(
                  text: 'Create site',
                ),
                onTap: () => createNewSite(context, ref),
              ),
              // const PopupMenuItem<SiteMenuSelection>(
              //   value: SiteMenuSelection.duplicate,
              //   child: DuplicateMenuButton(
              //     text: 'Duplicate site',
              //   ),
              // ),
              const PopupMenuDivider(height: 10),
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.deleteRecords,
                child: const DeleteMenuButton(
                  deleteAll: false,
                ),
                onTap: () => _deleteSite(),
              ),
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.deleteAllRecords,
                child: const DeleteMenuButton(
                  deleteAll: true,
                ),
                onTap: () => _deleteAllSites(),
              ),
            ]);
  }

  Future<void> _deleteSite() async {
    showDeleteAlertOnMenu(() async {
      if (widget.siteId != null) {
        try {
          await SiteServices(ref: ref).deleteSite(widget.siteId!);

          // Trigger page changes to update the view.
          if (mounted) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SiteViewer()));
          }
        } catch (e) {
          _showError(e.toString());
        }
      }
    }, 'Delete this site?', context);
  }

  void _deleteAllSites() {
    showDeleteAlertOnMenu(() async {
      try {
        await SiteServices(ref: ref).deleteAllSites();
      } catch (e) {
        _showError(e.toString());
      }
    }, 'Delete all sites?\nTHIS ACTION CANNOT BE UNDONE!', context);
  }

  void _showError(String errors) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errors.contains('SqliteException(787)')
              ? 'Cannot delete sites. Being used by other records.'
              : errors.toString(),
        ),
      ),
    );
  }
}
