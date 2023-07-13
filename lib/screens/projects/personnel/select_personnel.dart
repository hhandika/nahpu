import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';

class SelectPersonnel extends ConsumerStatefulWidget {
  const SelectPersonnel({
    super.key,
    required this.selectedPersonnel,
  });

  final List<PersonnelData> selectedPersonnel;

  @override
  SelectPersonnelState createState() => SelectPersonnelState();
}

class SelectPersonnelState extends ConsumerState<SelectPersonnel> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(allPersonnelProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return const Flexible(child: Center(child: Text('No personnel')));
            } else {
              return PersonnelSelection(
                data: data,
                selectedPersonnel: widget.selectedPersonnel,
              );
            }
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => const Center(
            child: Text('Error'),
          ),
        );
  }
}

class PersonnelSelection extends ConsumerStatefulWidget {
  const PersonnelSelection({
    super.key,
    required this.data,
    required this.selectedPersonnel,
  });

  final List<PersonnelData> data;
  final List<PersonnelData> selectedPersonnel;

  @override
  PersonnelSelectionState createState() => PersonnelSelectionState();
}

class PersonnelSelectionState extends ConsumerState<PersonnelSelection> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonPadding(
            child: Column(
          children: [
            CommonPadding(
                child: SearchButtonField(
                    controller: _searchController, onChanged: (value) {})),
            Text(
              'Selected: ${widget.data.length}',
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isSelected = !_isSelected;
                      });
                    },
                    child: Text(_isSelected ? 'Select' : 'Deselect all')),
                TextButton(onPressed: () {}, child: const Text('Select all'))
              ],
            ),
            CommonScrollbar(
              scrollController: _scrollController,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.data.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.data[index].name ?? ''),
                    subtitle: Text(widget.data[index].role ?? ''),
                    leading: _isSelected
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.circle_outlined),
                            onPressed: widget.selectedPersonnel
                                    .contains(widget.data[index])
                                ? null
                                : () {},
                          ),
                  );
                },
              ),
            ),
          ],
        ))
      ],
    );
  }
}

class PersonnelSelected extends StatefulWidget {
  const PersonnelSelected({super.key});

  @override
  State<PersonnelSelected> createState() => _PersonnelSelectedState();
}

class _PersonnelSelectedState extends State<PersonnelSelected> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleForm(text: 'Selected Personnel'),
      ],
    );
  }
}
