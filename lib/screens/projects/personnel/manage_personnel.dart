import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/personnel.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';

class ManagePersonnel extends ConsumerStatefulWidget {
  const ManagePersonnel({super.key, required this.listedInProjectPersonnel});

  final List<String> listedInProjectPersonnel;

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
      body: ScrollableConstrainedLayout(
          child: ManagePersonnelList(
              listedInProjectPersonnel: widget.listedInProjectPersonnel)),
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
    required this.listedInProjectPersonnel,
  });

  final List<String> listedInProjectPersonnel;

  @override
  ManagePersonnelListState createState() => ManagePersonnelListState();
}

class ManagePersonnelListState extends ConsumerState<ManagePersonnelList> {
  final TextEditingController _searchController = TextEditingController();
  List<PersonnelData> _filteredData = [];
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
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
                                    _focus.requestFocus();
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : const SizedBox.shrink(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _filteredData = data
                                .where((element) => element.name!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        }),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7),
                    child: ListView.builder(
                      itemCount: _searchController.text.isNotEmpty
                          ? _filteredData.length
                          : data.length,
                      itemBuilder: (context, index) {
                        final personnel = _searchController.text.isNotEmpty
                            ? _filteredData[index]
                            : data[index];
                        return ListTile(
                            title: Text(personnel.name ?? ''),
                            subtitle: Text(personnel.role ?? ''),
                            leading: ListCheckBox(
                                isDisabled: widget.listedInProjectPersonnel
                                    .contains(personnel.uuid),
                                value: widget.listedInProjectPersonnel
                                    .contains(personnel.uuid),
                                onChanged: (value) {}));
                      },
                    ),
                  ),
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
