import 'package:drift/drift.dart' as db;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/indicators.dart';
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
  final List<CollPersonnelCtrModel> controllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ref.watch(collPersonnelProvider(widget.eventID)).when(
                data: (personnel) {
                  if (personnel.isNotEmpty) {
                    for (var person in personnel) {
                      setState(() {
                        controllers.add(_addPersonnel(
                          person.id,
                          person.personnelId,
                          person.role,
                        ));
                      });
                    }
                  }
                  return CollPersonnelField(
                    eventID: widget.eventID,
                    controllers: controllers,
                  );
                },
                loading: () => const Center(
                  child: CommonProgressIndicator(),
                ),
                error: (error, stack) => Text(error.toString()),
              ),
        ),
        PrimaryButton(
          text: 'Add Personnel',
          onPressed: () async {
            int value =
                await CollectingPersonnelQuery(ref.read(databaseProvider))
                    .createCollectingPersonnel(
                        const CollectingPersonnelCompanion());
            setState(() {
              controllers.add(_addPersonnel(value, null, null));
            });
          },
        )
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
    required this.controllers,
  });

  final int eventID;
  final List<CollPersonnelCtrModel> controllers;

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
    return ListView.builder(
      itemCount: widget.controllers.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: widget.controllers[index].nameIDCtr,
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
                  setState(() {
                    widget.controllers[index].nameIDCtr = value ?? '';
                    CollectingPersonnelQuery(ref.read(databaseProvider))
                        .updateCollectingPersonnelEntry(
                      widget.eventID,
                      CollectingPersonnelCompanion(
                        personnelId: db.Value(value),
                      ),
                    );
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                // value: widget.controllers[index].roleCtr.text,
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
                onChanged: (value) {
                  widget.controllers[index].roleCtr = value ?? '';
                  CollectingPersonnelQuery(ref.read(databaseProvider))
                      .updateCollectingPersonnelEntry(
                    widget.eventID,
                    CollectingPersonnelCompanion(
                      role: db.Value(value),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.controllers.removeAt(index);
                });
              },
            )
          ],
        );
      },
    );
  }
}
