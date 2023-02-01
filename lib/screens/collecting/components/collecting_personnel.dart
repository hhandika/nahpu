import 'package:drift/drift.dart' as db;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/services/collevent_queries.dart';
import 'package:nahpu/services/database.dart';

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
    ref.watch(collPersonnelProvider(widget.eventID)).when(
        data: (data) {
          _personnel.clear();
          if (data.isNotEmpty) {
            for (var person in data) {
              _personnel.add(
                _addPersonnel(
                  person.id,
                  person.personnelId,
                  person.role,
                ),
              );
            }
          }
        },
        loading: () => null,
        error: (e, s) => null);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _personnel.isNotEmpty
              ? ListView.builder(
                  itemCount: _personnel.length,
                  itemBuilder: (context, index) {
                    return CollPersonnelField(
                      eventID: widget.eventID,
                      controller: _personnel[index],
                    );
                  },
                )
              : const Center(
                  child: Text('No personnel added'),
                ),
        ),
        PrimaryButton(
          text: 'Add Personnel',
          onPressed: () async {
            await CollectingPersonnelQuery(ref.read(databaseProvider))
                .createCollectingPersonnel(CollectingPersonnelCompanion(
              eventID: db.Value(widget.eventID),
            ));
            ref.invalidate(collPersonnelProvider);
            setState(() {});
          },
        ),
        const CommonTextField(
            maxLines: 5,
            labelText: 'Notes',
            hintText: 'Enter notes',
            isLastField: true),
      ],
    );
  }

  CollPersonnelCtrModel _addPersonnel(int id, String? nameID, String? role) {
    final CollPersonnelCtrModel newPersonnel = CollPersonnelCtrModel(
      id: id,
      nameIDCtr: nameID,
      roleCtr: role,
    );
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
  final List<String> collRoles = [
    'Leader',
    'Field Assistant',
    'Observer',
    'Driver',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
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
                            child: Text(person.name ?? ''),
                          ))
                      .toList(),
                  loading: () => const [],
                  error: (error, stack) => const [],
                ),
            onChanged: (value) {
              widget.controller.nameIDCtr = value ?? '';

              CollectingPersonnelQuery(ref.read(databaseProvider))
                  .updateCollectingPersonnelEntry(
                widget.controller.id!,
                CollectingPersonnelCompanion(
                  eventID: db.Value(widget.eventID),
                  personnelId: db.Value(widget.controller.nameIDCtr),
                ),
              );
              ref.invalidate(collPersonnelProvider);
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: widget.controller.roleCtr,
            decoration: const InputDecoration(
              labelText: 'Role',
              hintText: 'Enter a role',
            ),
            items: collRoles
                .map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    ))
                .toList(),
            onChanged: (String? value) {
              widget.controller.roleCtr = value;

              CollectingPersonnelQuery(ref.read(databaseProvider))
                  .updateCollectingPersonnelEntry(
                widget.controller.id!,
                CollectingPersonnelCompanion(
                  eventID: db.Value(widget.eventID),
                  role: db.Value(widget.controller.roleCtr),
                ),
              );
              ref.invalidate(collPersonnelProvider);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            CollectingPersonnelQuery(ref.read(databaseProvider))
                .deleteCollectingPersonnel(widget.controller.id!);
            ref.invalidate(collPersonnelProvider);
          },
        ),
      ],
    );
  }
}
