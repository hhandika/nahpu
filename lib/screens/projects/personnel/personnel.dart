import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/personnel/avatars.dart';
import 'package:nahpu/screens/projects/personnel/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/personnel_services.dart';

enum PersonnelMenuAction { edit, delete }

class PersonnelViewer extends ConsumerStatefulWidget {
  const PersonnelViewer({Key? key}) : super(key: key);

  @override
  PersonnelViewerState createState() => PersonnelViewerState();
}

class PersonnelViewerState extends ConsumerState<PersonnelViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Personnel',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 300,
            child: PersonnelList(),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewPersonnel(),
                ),
              );
            },
            text: 'Add personnel',
          ),
        ],
      ),
    );
  }
}

class PersonnelList extends ConsumerStatefulWidget {
  const PersonnelList({super.key});

  @override
  PersonnelListState createState() => PersonnelListState();
}

class PersonnelListState extends ConsumerState<PersonnelList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final personnel = ref.watch(personnelListProvider);
    return personnel.when(
      data: (data) {
        return data.isEmpty
            ? const Center(
                child: Text(
                  'No personnel found!\n'
                  'Add at least a cataloger to use the app.',
                  textAlign: TextAlign.center,
                ),
              )
            : CommonScrollbar(
                scrollController: _scrollController,
                child: ListView.builder(
                  itemCount: data.length,
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PersonalListTile(
                      personnelData: data[index],
                      trailing: PersonnelMenu(
                        data: data[index],
                      ),
                    );
                  },
                ),
              );
      },
      loading: () => const CommonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class PersonalListTile extends StatelessWidget {
  const PersonalListTile({
    super.key,
    required this.personnelData,
    required this.trailing,
  });

  final PersonnelData personnelData;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
          height: 48,
          width: 48,
          child: AvatarViewer(
            filePath:
                TextEditingController(text: personnelData.photoPath ?? ''),
          )),
      title: Text(
        _getTitle(personnelData.name, personnelData.initial),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: PersonnelSubtitle(
        role: personnelData.role,
        affiliation: personnelData.affiliation,
        currentFieldNumber: personnelData.currentFieldNumber,
      ),
      trailing: trailing,
    );
  }

  String _getTitle(String? name, String? personInitial) {
    if (name != null && personInitial != null) {
      return personInitial.isEmpty ? name : '$name ($personInitial)';
    } else if (name != null) {
      return name;
    } else if (personInitial != null) {
      return personInitial;
    } else {
      return '';
    }
  }
}

class PersonnelSubtitle extends StatelessWidget {
  const PersonnelSubtitle({
    super.key,
    required this.role,
    required this.affiliation,
    required this.currentFieldNumber,
  });

  final String? role;
  final String? affiliation;
  final int? currentFieldNumber;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      role != null
          ? TextSpan(children: [
              const WidgetSpan(
                  child: TileIcon(icon: Icons.account_circle_outlined),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(
                text: '$role ',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ])
          : const TextSpan(),
      affiliation != null
          ? TextSpan(
              children: [
                const WidgetSpan(
                    child: TileIcon(icon: Icons.business_rounded),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                  text: '$affiliation ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            )
          : const TextSpan(),
      currentFieldNumber == null || currentFieldNumber! == 0
          ? const TextSpan()
          : TextSpan(
              children: [
                const WidgetSpan(
                    child: TileIcon(icon: MdiIcons.counter),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                  text: '$currentFieldNumber',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
    ]));
  }
}

class PersonnelMenu extends ConsumerStatefulWidget {
  const PersonnelMenu({super.key, required this.data});

  final PersonnelData data;

  @override
  PersonnelMenuState createState() => PersonnelMenuState();
}

class PersonnelMenuState extends ConsumerState<PersonnelMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PersonnelMenuAction>(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: PersonnelMenuAction.edit,
          child: ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditPersonnelForm(
                    personnelData: widget.data,
                  ),
                ),
              );
            },
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
            value: PersonnelMenuAction.delete,
            child: ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _deletePersonnel();
              },
            )),
      ],
    );
  }

  void _deletePersonnel() {
    showDeleteAlertOnMenu(
      () async {
        try {
          await PersonnelServices(ref: ref).deletePersonnel(widget.data.uuid);
        } catch (e) {
          _showError(e.toString());
        }
      },
      'Delete this person?',
      context,
    );
  }

  void _showError(String errors) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errors.contains('SqliteException(787)')
              ? 'Cannot delete personnel. Being used by other records.'
              : errors.toString(),
        ),
      ),
    );
  }
}
