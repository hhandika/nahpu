import 'package:drift/drift.dart' as db;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/collevents.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/database/database.dart';

class CollPersonnelForm extends ConsumerStatefulWidget {
  const CollPersonnelForm({
    super.key,
    required this.eventID,
  });

  final int eventID;

  @override
  CollPersonnelFormState createState() => CollPersonnelFormState();
}

class CollPersonnelFormState extends ConsumerState<CollPersonnelForm> {
  final List<CollPersonnelCtrModel> _personnel = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    ref.watch(collPersonnelProvider(widget.eventID)).whenData((data) {
      _personnel.clear();
      if (data.isNotEmpty) {
        for (var person in data) {
          _personnel.add(
            _addPersonnel(person),
          );
        }
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TitleForm(text: 'Collecting Personnel'),
        _personnel.isEmpty
            ? const Flexible(child: Center(child: Text('No personnel added')))
            : SizedBox(
                height: 312,
                child: CommonScrollbar(
                  scrollController: scrollController,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: _personnel.length,
                    itemBuilder: (context, index) {
                      return CollPersonnelField(
                        eventID: widget.eventID,
                        controller: _personnel[index],
                      );
                    },
                  ),
                ),
              ),
        const SizedBox(height: 8),
        PrimaryButton(
          label: 'Add personnel',
          icon: Icons.add,
          onPressed: () {
            CollEventServices(ref: ref)
                .createCollPersonnel(CollPersonnelCompanion(
              eventID: db.Value(widget.eventID),
            ));
            setState(() {});
          },
        ),
      ],
    );
  }

  CollPersonnelCtrModel _addPersonnel(CollPersonnelData form) {
    final CollPersonnelCtrModel newPersonnel =
        CollPersonnelCtrModel.fromData(form);
    return newPersonnel;
  }
}

class CollPersonnelField extends ConsumerStatefulWidget {
  const CollPersonnelField({
    super.key,
    required this.eventID,
    required this.controller,
  });

  final int eventID;
  final CollPersonnelCtrModel controller;

  @override
  CollPersonnelFieldState createState() => CollPersonnelFieldState();
}

class CollPersonnelFieldState extends ConsumerState<CollPersonnelField> {
  @override
  Widget build(BuildContext context) {
    return CommonPadding(
        child: Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: widget.controller.nameIDCtr,
            decoration: const InputDecoration(
              labelText: 'Personnel',
              hintText: 'Enter a name',
            ),
            items: ref.watch(personnelListProvider).when(
                  data: (value) => value
                      .map((person) => DropdownMenuItem(
                            value: person.uuid,
                            child: CommonDropdownText(
                              text: person.name ?? '',
                            ),
                          ))
                      .toList(),
                  loading: () => const [],
                  error: (error, stack) => const [],
                ),
            onChanged: (value) {
              widget.controller.nameIDCtr = value ?? '';

              CollEventServices(ref: ref).updateCollPersonnel(
                widget.controller.id!,
                CollPersonnelCompanion(
                  eventID: db.Value(widget.eventID),
                  personnelId: db.Value(value),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: PersonnelRole(
            eventID: widget.eventID,
            controller: widget.controller,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            _deletePersonnel();
          },
        ),
      ],
    ));
  }

  void _deletePersonnel() {
    showDeleteAlertOnMenu(
      context: context,
      title: 'Delete collecting personnel?',
      deletePrompt: 'You will delete this personnel from the event',
      onDelete: () async {
        try {
          await CollEventServices(ref: ref)
              .deleteCollPersonnel(widget.controller.id!);
          if (mounted) {
            Navigator.of(context).pop();
          }
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

class PersonnelRole extends ConsumerStatefulWidget {
  const PersonnelRole({
    super.key,
    required this.eventID,
    required this.controller,
  });

  final int eventID;
  final CollPersonnelCtrModel controller;

  @override
  PersonnelRoleState createState() => PersonnelRoleState();
}

class PersonnelRoleState extends ConsumerState<PersonnelRole> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(collPersonnelRoleProvider).when(
          data: (data) {
            return DropdownButtonFormField<String>(
              isExpanded: true,
              value: widget.controller.roleCtr,
              decoration: const InputDecoration(
                labelText: 'Role',
                hintText: 'Enter a role',
              ),
              items: data
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: CommonDropdownText(text: role),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.controller.roleCtr = value;
                  CollEventServices(ref: ref).updateCollPersonnel(
                    widget.controller.id!,
                    CollPersonnelCompanion(
                      eventID: db.Value(widget.eventID),
                      role: db.Value(value),
                    ),
                  );
                }
              },
            );
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, _) {
            return const Text('Error');
          },
        );
  }
}
