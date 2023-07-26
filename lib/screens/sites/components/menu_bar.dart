import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/sites/site_view.dart';
import 'package:nahpu/services/site_services.dart';

enum SiteMenuSelection {
  newSite,
  duplicate,
  pdfExport,
  deleteRecords,
  deleteAllRecords
}

Future<void> createNewSite(BuildContext context, WidgetRef ref) {
  return SiteServices(ref: ref).createNewSite().then((_) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const SiteViewer()));
  });
}

class NewSiteTextButton extends ConsumerWidget {
  const NewSiteTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        try {
          await createNewSite(context, ref);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: const Text('Create site'),
    );
  }
}

class NewSite extends ConsumerWidget {
  const NewSite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outline_rounded),
      onPressed: () async {
        try {
          await createNewSite(context, ref);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
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
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.duplicate,
                onTap: () async => await _duplicateSite(),
                child: const DuplicateMenuButton(
                  text: 'Duplicate site',
                ),
              ),
              const PopupMenuDivider(height: 10),
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.deleteRecords,
                enabled: widget.siteId != null,
                onTap: () => _deleteSite(),
                child: const DeleteMenuButton(
                  deleteAll: false,
                ),
              ),
              PopupMenuItem<SiteMenuSelection>(
                value: SiteMenuSelection.deleteAllRecords,
                enabled: widget.siteId != null,
                onTap: () => _deleteAllSites(),
                child: const DeleteMenuButton(
                  deleteAll: true,
                ),
              ),
            ]);
  }

  Future<void> _duplicateSite() async {
    try {
      await SiteServices(ref: ref).duplicateSite(widget.siteId!);
      if (mounted) {
        setState(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SiteViewer()));
        });
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _deleteSite() async {
    showDeleteAlertOnMenu(
        context: context,
        title: 'Delete site?',
        deletePrompt: 'You will delete all records in this site form',
        onDelete: () async {
          if (widget.siteId != null) {
            try {
              await SiteServices(ref: ref).deleteSite(widget.siteId!);

              // Trigger page changes to update the view.
              if (mounted) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SiteViewer()));
              }
            } catch (e) {
              _showError(e.toString());
            }
          }
        });
  }

  void _deleteAllSites() {
    showDeleteAlertOnMenu(
        context: context,
        title: 'Delete all sites?',
        deletePrompt: 'You will delete all site records',
        onDelete: () async {
          try {
            await SiteServices(ref: ref).deleteAllSites();
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            _showError(e.toString());
          }
        });
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
