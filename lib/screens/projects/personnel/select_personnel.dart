import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/dashboard.dart';
import 'package:nahpu/screens/shared/buttons.dart';
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
  final List<PersonnelData> _selectedPersonnel = [];

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
                    onPressed: _selectedPersonnel.isEmpty
                        ? null
                        : () {
                            setState(() {
                              _selectedPersonnel.clear();
                            });
                          },
                    child: const Text('Deselect all')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPersonnel.clear();
                        _selectedPersonnel.addAll(widget.data);
                      });
                    },
                    child: const Text('Select all'))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CommonScrollbar(
                scrollController: _scrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.data[index].name ?? ''),
                      subtitle: Text(widget.data[index].role ?? ''),
                      leading: _selectedPersonnel.contains(widget.data[index])
                          ? IconButton(
                              icon: const Icon(Icons.check_circle),
                              onPressed: () {
                                setState(() {
                                  _selectedPersonnel.remove(widget.data[index]);
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.circle_outlined),
                              onPressed: widget.selectedPersonnel
                                      .contains(widget.data[index])
                                  ? null
                                  : () {
                                      setState(() {
                                        _selectedPersonnel
                                            .add(widget.data[index]);
                                      });
                                    },
                            ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: [
                SecondaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                PrimaryButton(
                  label: 'Add ${_selectedPersonnel.length} personnel',
                  icon: Icons.add,
                  onPressed: _selectedPersonnel.isEmpty
                      ? null
                      : () async {
                          _addSelectedPersonnel();
                          ref.invalidate(personnelListProvider);
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                          }
                        },
                ),
              ],
            ),
          ],
        ))
      ],
    );
  }

  void _addSelectedPersonnel() {}
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
