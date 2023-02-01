import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';

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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CollPersonnelField(
              eventID: widget.eventID,
              controllers: controllers,
              onPressed: () {
                setState(() {
                  controllers.removeLast();
                });
              }),
        ),
        PrimaryButton(
          text: 'Add Personnel',
          onPressed: () {
            setState(() {
              controllers.add(addPersonnel());
            });
          },
        )
      ],
    );
  }

  CollPersonnelCtrModel addPersonnel() {
    final CollPersonnelCtrModel newPersonnel = CollPersonnelCtrModel(
      nameCtr: TextEditingController(),
      roleCtr: TextEditingController(),
    );
    return newPersonnel;
  }
}

class CollPersonnelField extends ConsumerWidget {
  const CollPersonnelField({
    super.key,
    required this.eventID,
    required this.controllers,
    required this.onPressed,
  });

  final int eventID;
  final List<CollPersonnelCtrModel> controllers;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> collRoles = [
      'Leader',
      'Field Assistant',
      'Observer',
      'Driver',
    ];

    return ListView.builder(
        itemCount: controllers.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
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
                        error: (e, s) => const [],
                      ),
                  onChanged: (String? newValue) {
                    controllers[index].nameCtr.text = newValue ?? '';
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Collecting Role',
                  hintText: 'Enter a collecting role',
                ),
                items: collRoles
                    .map(
                      (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  controllers[index].roleCtr.text = newValue ?? '';
                },
              )),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.delete),
              )
            ],
          );
        });
  }
}
