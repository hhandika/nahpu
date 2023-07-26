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
import 'package:nahpu/services/personnel_services.dart';

class SelectPersonnel extends ConsumerStatefulWidget {
  const SelectPersonnel({
    super.key,
    required this.addedPersonnel,
  });

  final List<PersonnelData> addedPersonnel;

  @override
  SelectPersonnelState createState() => SelectPersonnelState();
}

class SelectPersonnelState extends ConsumerState<SelectPersonnel> {
  final TextEditingController _searchController = TextEditingController();
  List<PersonnelData> _filteredData = [];

  @override
  Widget build(BuildContext context) {
    return ref.watch(allPersonnelProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return const Flexible(child: Center(child: Text('No personnel')));
            } else {
              return Column(
                children: [
                  CommonPadding(
                    child: SearchButtonField(
                        controller: _searchController,
                        onChanged: (query) {
                          setState(() {
                            _filteredData = _filterPersonnelList(
                              data,
                              query.toLowerCase(),
                            );
                          });
                        }),
                  ),
                  PersonnelSelection(
                    data: _filteredData.isEmpty ? data : _filteredData,
                    addedPersonnel: widget.addedPersonnel,
                  )
                ],
              );
            }
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => const Center(
            child: Text('Error'),
          ),
        );
  }

  List<PersonnelData> _filterPersonnelList(
      List<PersonnelData> data, String query) {
    return PersonnelFilterService(data: data).filterPersonnelList(query);
  }
}

class PersonnelSelection extends ConsumerStatefulWidget {
  const PersonnelSelection({
    super.key,
    required this.data,
    required this.addedPersonnel,
  });

  final List<PersonnelData> data;
  final List<PersonnelData> addedPersonnel;

  @override
  PersonnelSelectionState createState() => PersonnelSelectionState();
}

class PersonnelSelectionState extends ConsumerState<PersonnelSelection> {
  final ScrollController _scrollController = ScrollController();
  final List<PersonnelData> _selectedPersonnel = [];

  @override
  Widget build(BuildContext context) {
    return CommonPadding(
        child: Column(
      children: [
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
                child: const Text('Clear')),
            TextButton(
                // if list is empty or all personnel are already selected, disable button
                onPressed: _filteredNotInProjectPersonnel().isEmpty ||
                        _selectedPersonnel.length ==
                            _filteredNotInProjectPersonnel().length
                    ? null
                    : () {
                        List<PersonnelData> allowedPersonnel =
                            _filteredNotInProjectPersonnel();
                        if (allowedPersonnel.isNotEmpty) {
                          setState(() {
                            _selectedPersonnel.clear();
                            _selectedPersonnel.addAll(allowedPersonnel);
                          });
                        }
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
                    leading: ListCheckBox(
                        isDisabled:
                            widget.addedPersonnel.contains(widget.data[index]),
                        value: _selectedPersonnel.contains(widget.data[index]),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _selectedPersonnel.add(widget.data[index]);
                            } else {
                              _selectedPersonnel.remove(widget.data[index]);
                            }
                          });
                        }));
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
                      try {
                        await _addSelectedPersonnelToProject();
                        ref.invalidate(personnelListProvider);
                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
            ),
          ],
        ),
      ],
    ));
  }

  Future<void> _addSelectedPersonnelToProject() async {
    await PersonnelServices(ref: ref)
        .addMultiplePersonnelToProject(_selectedPersonnel);
  }

  List<PersonnelData> _filteredNotInProjectPersonnel() {
    List<PersonnelData> personnel = [];

    for (final person in widget.data) {
      if (!widget.addedPersonnel.contains(person)) {
        personnel.add(person);
      }
    }
    return personnel;
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
