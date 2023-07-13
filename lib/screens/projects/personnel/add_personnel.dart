import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/personnel/new_personnel.dart';
import 'package:nahpu/screens/projects/personnel/select_personnel.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';

enum PersonnelSelection { newPersonnel, selectPersonnel }

const Map<PersonnelSelection, String> addPersonnelOptions = {
  PersonnelSelection.selectPersonnel: 'Select from database',
  PersonnelSelection.newPersonnel: 'Create new personnel',
};

class AddPersonnel extends ConsumerStatefulWidget {
  const AddPersonnel({super.key});

  @override
  AddPersonnelState createState() => AddPersonnelState();
}

class AddPersonnelState extends ConsumerState<AddPersonnel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add personnel'),
        automaticallyImplyLeading: false,
      ),
      body: ScrollableConstrainedLayout(
          child: ref.watch(allPersonnelProvider).when(
                data: (data) {
                  if (data.isNotEmpty) {
                    return AddWithOptions(data: data);
                  } else {
                    return const NewPersonnel();
                  }
                },
                loading: () => const CommonProgressIndicator(),
                error: (error, stack) => Text(
                  error.toString(),
                ),
              )),
    );
  }
}

class AddWithOptions extends ConsumerStatefulWidget {
  const AddWithOptions({super.key, required this.data});

  final List<PersonnelData> data;

  @override
  AddWithOptionsState createState() => AddWithOptionsState();
}

class AddWithOptionsState extends ConsumerState<AddWithOptions> {
  PersonnelSelection _personnelSelection = PersonnelSelection.selectPersonnel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
          value: _personnelSelection,
          isExpanded: true,
          items: addPersonnelOptions.entries
              .map((e) => DropdownMenuItem<PersonnelSelection>(
                    value: e.key,
                    child: Text(e.value),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _personnelSelection = value;
                ref.invalidate(personnelListProvider);
              });
            }
          },
        ),
        const SizedBox(height: 24),
        _personnelSelection == PersonnelSelection.newPersonnel
            ? const NewPersonnel()
            : SelectPersonnel(selectedPersonnel: widget.data)
      ],
    );
  }
}
