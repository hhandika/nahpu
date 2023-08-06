import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/personnel/add_personnel.dart';
import 'package:nahpu/screens/projects/personnel/avatars.dart';
import 'package:nahpu/screens/projects/personnel/new_personnel.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/personnel_services.dart';

enum PersonnelMenuAction { edit, delete }

const int avatarSize = 48;

class PersonnelViewer extends ConsumerStatefulWidget {
  const PersonnelViewer({Key? key}) : super(key: key);

  @override
  PersonnelViewerState createState() => PersonnelViewerState();
}

class PersonnelViewerState extends ConsumerState<PersonnelViewer> {
  @override
  Widget build(BuildContext context) {
    return const FormCard(
      title: 'Personnel',
      infoContent: PersonnelInfoContent(),
      mainAxisAlignment: MainAxisAlignment.start,
      child: PersonnelList(),
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
    final personnel = ref.watch(projectPersonnelProvider);
    return personnel.when(
      data: (data) {
        return data.isEmpty
            ? const EmptyPersonnel()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 310,
                    child: CommonScrollbar(
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  const AddPersonnelButton(),
                  const SizedBox(height: 8),
                ],
              );
      },
      loading: () => const CommonProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }
}

class EmptyPersonnel extends StatelessWidget {
  const EmptyPersonnel({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 375),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No personnel found.',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const AddPersonnelButton(),
          ],
        )));
  }
}

class AddPersonnelButton extends StatelessWidget {
  const AddPersonnelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddPersonnel(),
          ),
        );
      },
      label: 'Add personnel',
      icon: Icons.add,
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
          height: avatarSize.toDouble(),
          width: avatarSize.toDouble(),
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
                WidgetSpan(
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
              Navigator.of(context).pop();
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
              leading: Icon(Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error),
              title: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () {
                _deletePersonnel();
                Navigator.of(context).pop();
              },
            )),
      ],
    );
  }

  void _deletePersonnel() {
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete personnel?',
      deletePrompt: 'You will delete the personnel for this project.'
          ' The record will still be available in the database.',
      onDelete: () async {
        try {
          await PersonnelServices(ref: ref)
              .deleteProjectPersonnel(widget.data.uuid);
          if (mounted) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          _showError(e.toString());
        }
      },
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

class PersonnelInfoContent extends StatelessWidget {
  const PersonnelInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(
      content: [
        InfoContent(
          header: 'Overview',
          content: 'List of personnel for this project.'
              ' Use the add button to add personnel.'
              ' To edit or delete the personnel, use the menu button.'
              ' You need at least a cataloger to start adding specimens.',
        ),
        InfoContent(
          content: 'When you create a personnel,'
              ' their data will be saved in the database'
              ' for reuse in other projects. Deleting a personnel will'
              ' only remove them from this project. '
              'You can permanently delete a personnel in the settings.',
        ),
        InfoContent(
          content: 'Some institutions use project ID'
              ' instead of initial for the specimen field ID.'
              ' Replace the initial with the project ID.',
        ),
        InfoContent(
          header: 'Role definitions',
          content: 'Cataloger - responsible for cataloging the specimens.'
              ' They are the ones who responsible for recording the specimen data.'
              ' You cannot change the cataloger role once the personnel is created.'
              ' Their names will be listed in'
              ' any field that ask for personnel name input.'
              '\n\n'
              'Preparator only - help prepare the specimens, '
              ' but does not record the specimen data.'
              ' Their name will only be listed in the preparator and collector field.'
              '\n\n'
              'None - does not have any role in taking care of the specimens.',
        ),
      ],
    );
  }
}
