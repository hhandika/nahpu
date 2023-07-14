import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/personnel/new_personnel.dart';
import 'package:nahpu/screens/projects/personnel/select_personnel.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';

enum PersonnelSelection { selectPersonnel, newPersonnel }

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
                    return const AddWithOptions();
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
  const AddWithOptions({super.key});

  @override
  AddWithOptionsState createState() => AddWithOptionsState();
}

class AddWithOptionsState extends ConsumerState<AddWithOptions> {
  PersonnelSelection _personnelSelection = PersonnelSelection.selectPersonnel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.start,
          children: addPersonnelOptions.entries
              .map(
                (e) => ChoiceChip(
                    index: e.key.index,
                    selectedValue: _personnelSelection.index,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          _personnelSelection = e.key;
                          ref.invalidate(personnelListProvider);
                        });
                      }
                    }),
              )
              .toList(),
        ),
        // DropdownButton(
        //   value: _personnelSelection,
        //   isExpanded: true,
        //   items: addPersonnelOptions.entries
        //       .map((e) => DropdownMenuItem<PersonnelSelection>(
        //             value: e.key,
        //             child: Text(e.value),
        //           ))
        //       .toList(),
        //   onChanged: (value) {
        //     if (value != null) {
        //       setState(() {
        //         _personnelSelection = value;
        //         ref.invalidate(personnelListProvider);
        //       });
        //     }
        //   },
        // ),
        const SizedBox(height: 24),
        _personnelSelection == PersonnelSelection.newPersonnel
            ? const NewPersonnel()
            : ref.watch(personnelListProvider).when(
                  data: (data) {
                    return SelectPersonnel(selectedPersonnel: data);
                  },
                  loading: () => const CommonProgressIndicator(),
                  error: (error, stack) => Text(error.toString()),
                ),
      ],
    );
  }
}

class ChoiceChip extends StatelessWidget {
  const ChoiceChip({
    super.key,
    required this.index,
    required this.selectedValue,
    required this.onSelected,
  });

  final int index;
  final int selectedValue;
  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return CommonChip(
      index: index,
      label: Text(addPersonnelOptions.values.elementAt(index)),
      selectedValue: selectedValue,
      onSelected: onSelected,
    );
  }
}
