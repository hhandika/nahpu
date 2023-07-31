import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/projects/personnel/new_personnel.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';

class ManagePersonnel extends ConsumerStatefulWidget {
  const ManagePersonnel({super.key});

  @override
  ManagePersonnelState createState() => ManagePersonnelState();
}

class ManagePersonnelState extends ConsumerState<ManagePersonnel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage personnel'),
      ),
      body: const ScrollableConstrainedLayout(child: ManagePersonnelList()),
    );
  }
}

class PersonnelEmpty extends StatelessWidget {
  const PersonnelEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No personnel found'));
  }
}

class ManagePersonnelList extends ConsumerStatefulWidget {
  const ManagePersonnelList({
    super.key,
  });

  @override
  ManagePersonnelListState createState() => ManagePersonnelListState();
}

class ManagePersonnelListState extends ConsumerState<ManagePersonnelList> {
  final TextEditingController _searchController = TextEditingController();
  List<PersonnelData> _filteredData = [];
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.requestFocus();
  }

  @override
  void dispose() {
    _focus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(allPersonnelProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(child: Text('No personnel'));
            } else {
              return Column(
                children: [
                  CommonPadding(
                    child: CommonSearchBar(
                        controller: _searchController,
                        focusNode: _focus,
                        hintText: 'Search personnel',
                        trailing: [
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : const SizedBox.shrink(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _filteredData = PersonnelSearchService(data: data)
                                .search(value.toLowerCase());
                          });
                        }),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      child: data.isEmpty
                          ? const PersonnelEmpty()
                          : PersonnelListView(
                              personnelList:
                                  _filteredData.isEmpty ? data : _filteredData,
                            ))
                ],
              );
            }
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text(
            error.toString(),
          ),
        );
  }
}

class PersonnelListView extends ConsumerStatefulWidget {
  const PersonnelListView({
    super.key,
    required this.personnelList,
  });

  final List<PersonnelData> personnelList;

  @override
  PersonnelListViewState createState() => PersonnelListViewState();
}

class PersonnelListViewState extends ConsumerState<PersonnelListView> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _selectedPersonnel = [];
  List<String> _allowedPersonnel = [];
  List<String> _listedInProjectPersonnel = [];
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Visibility(
              visible: _isSelecting,
              child: TextButton(
                onPressed: _selectedPersonnel.isEmpty
                    ? null
                    : () {
                        setState(() {
                          _selectedPersonnel.clear();
                        });
                      },
                child: const Text('Clear'),
              ),
            ),
            Visibility(
              visible: _isSelecting,
              child: TextButton(
                onPressed: widget.personnelList.length ==
                            _listedInProjectPersonnel.length ||
                        _selectedPersonnel.length == _allowedPersonnel.length
                    ? null
                    : () {
                        setState(() {
                          _selectedPersonnel.clear();
                          _selectedPersonnel.addAll(_allowedPersonnel);
                        });
                      },
                child: const Text('Select all'),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                _listedInProjectPersonnel = await _getListedInProject();
                _allowedPersonnel = _getAllowedPersonnel();

                setState(() {
                  _isSelecting = !_isSelecting;
                  _selectedPersonnel.clear();
                });
              },
              child: Text(_isSelecting ? 'Cancel' : 'Select'),
            ),
          ],
        ),
        Flexible(
            child: CommonScrollbar(
                scrollController: _scrollController,
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: widget.personnelList.length,
                    itemBuilder: (context, index) {
                      return SelectPersonnelTile(
                        data: widget.personnelList[index],
                        listedPersonnel: _listedInProjectPersonnel,
                        selectedPersonnel: _selectedPersonnel,
                        isSelecting: _isSelecting,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedPersonnel
                                  .add(widget.personnelList[index].uuid);
                            } else {
                              _selectedPersonnel
                                  .remove(widget.personnelList[index].uuid);
                            }
                          });
                        },
                      );
                    }))),
        const SizedBox(height: 8),
        _isSelecting
            ? DelectePersonnelButton(
                selectedPersonnel: _selectedPersonnel,
                onPressed: () async {
                  try {
                    await PersonnelServices(ref: ref)
                        .deletePersonnelFromList(_selectedPersonnel);
                    setState(() {
                      _isSelecting = false;
                    });
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Error deleting personnel')));
                  }
                },
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  List<String> _getAllowedPersonnel() {
    final List<String> allowedPersonnel = [];
    for (final personnel in widget.personnelList) {
      if (!_listedInProjectPersonnel.contains(personnel.uuid)) {
        allowedPersonnel.add(personnel.uuid);
      }
    }
    return allowedPersonnel;
  }

  Future<List<String>> _getListedInProject() async {
    return await PersonnelServices(ref: ref).getAllPersonnelListedInProjects();
  }
}

class DelectePersonnelButton extends StatelessWidget {
  const DelectePersonnelButton({
    super.key,
    required this.selectedPersonnel,
    required this.onPressed,
  });

  final List<String> selectedPersonnel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: Theme.of(context).colorScheme.error,
          onPressed: selectedPersonnel.isEmpty
              ? null
              : () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete personnel'),
                          content: const Text(
                              'Are you sure you want to delete the selected personnel?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: onPressed,
                              child: Text('Delete',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  )),
                            ),
                          ],
                        );
                      });
                },
          icon: const Icon(Icons.delete_outlined),
        ),
        Visibility(
            visible: selectedPersonnel.isNotEmpty,
            child: Text('Delete ${selectedPersonnel.length} personnel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ))),
      ],
    );
  }
}

class SelectPersonnelTile extends StatelessWidget {
  const SelectPersonnelTile({
    super.key,
    required this.data,
    required this.listedPersonnel,
    required this.selectedPersonnel,
    required this.onChanged,
    required this.isSelecting,
  });

  final PersonnelData data;
  final List<String> listedPersonnel;
  final List<String> selectedPersonnel;
  final bool isSelecting;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(data.name ?? ''),
        subtitle: Text(data.role ?? ''),
        leading: isSelecting
            ? ListCheckBox(
                isDisabled: listedPersonnel.contains(data.uuid),
                value: selectedPersonnel.contains(data.uuid),
                onChanged: onChanged,
              )
            : const SizedBox.shrink(),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPersonnelForm(
                          personnelData: data,
                        )));
          },
        ));
  }
}
