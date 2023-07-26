import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/screens/projects/taxonomy/new_taxa.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/utility_services.dart';

import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/taxonomy_services.dart';

class TaxonRegistryPage extends ConsumerStatefulWidget {
  const TaxonRegistryPage({super.key});

  @override
  TaxonRegistryPageState createState() => TaxonRegistryPageState();
}

class TaxonRegistryPageState extends ConsumerState<TaxonRegistryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon registry'),
      ),
      body: ref.watch(taxonRegistryProvider).when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text(
                    'No taxon found',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return TaxonList(taxonList: data);
            },
            loading: () => const CommonProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
    );
  }
}

class TaxonList extends StatefulWidget {
  const TaxonList({
    super.key,
    required this.taxonList,
  });

  final List<TaxonomyData> taxonList;

  @override
  State<TaxonList> createState() => _TaxonListState();
}

class _TaxonListState extends State<TaxonList> {
  List<TaxonomyData> _filteredTaxonList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollableConstrainedLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchButtonField(
              controller: _searchController,
              onChanged: (String value) {
                String searchValue = value.toLowerCase();
                setState(() {
                  _filteredTaxonList = TaxonFilterServices()
                      .filterTaxonList(widget.taxonList, searchValue);
                });
              },
            ),
            const SizedBox(height: 8),
            _filteredTaxonList.isEmpty
                ? const SizedBox.shrink()
                : Text('Results: ${_filteredTaxonList.length}'),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TaxonListView(
                  taxonList: _filteredTaxonList.isNotEmpty
                      ? _filteredTaxonList
                      : widget.taxonList,
                ))
          ],
        ),
      ),
    );
  }
}

class TaxonListView extends ConsumerStatefulWidget {
  const TaxonListView({
    super.key,
    required this.taxonList,
  });

  final List<TaxonomyData> taxonList;

  @override
  TaxonListViewState createState() => TaxonListViewState();
}

class TaxonListViewState extends ConsumerState<TaxonListView> {
  final ScrollController _scrollController = ScrollController();
  List<int> _selectedTaxon = [];
  List<int> _usedTaxon = [];
  bool _isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Visibility(
            visible: _isSelecting,
            child: TextButton(
              onPressed: _selectedTaxon.isEmpty
                  ? null
                  : () {
                      setState(() {
                        _selectedTaxon = [];
                      });
                    },
              child: const Text('Clear'),
            ),
          ),
          Visibility(
              visible: _isSelecting,
              child: TextButton(
                onPressed: _selectedTaxon.length == widget.taxonList.length
                    ? null
                    : () {
                        setState(() {
                          _selectedTaxon = widget.taxonList
                              .map((e) => e.id)
                              .toList()
                              .cast<int>();
                        });
                      },
                child: const Text('Select all'),
              )),
          const Spacer(),
          TextButton(
            onPressed: () async {
              _usedTaxon = await _getUsedTaxa();
              setState(() {
                _isSelecting = !_isSelecting;
              });
            },
            child: Text(_isSelecting ? 'Cancel' : 'Select'),
          ),
        ]),
        Expanded(
          child: CommonScrollbar(
            scrollController: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: widget.taxonList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${widget.taxonList[index].genus} ${widget.taxonList[index].specificEpithet}'),
                  subtitle: Text(
                    '${widget.taxonList[index].taxonClass}'
                    '$listTileSeparator'
                    '${widget.taxonList[index].taxonOrder}'
                    '$listTileSeparator'
                    '${widget.taxonList[index].taxonFamily}',
                  ),
                  leading: _isSelecting
                      ? ListCheckBox(
                          isDisabled:
                              _usedTaxon.contains(widget.taxonList[index].id),
                          value: _selectedTaxon
                              .contains(widget.taxonList[index].id),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedTaxon.add(widget.taxonList[index].id);
                              } else {
                                _selectedTaxon
                                    .remove(widget.taxonList[index].id);
                              }
                            });
                          },
                        )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditTaxon(
                            taxonId: widget.taxonList[index].id,
                            ctr: TaxonRegistryCtrModel.fromData(
                                widget.taxonList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        _isSelecting
            ? DeleteTaxonButton(selectedTaxon: _selectedTaxon)
            : const SizedBox.shrink(),
      ],
    );
  }

  Future<List<int>> _getUsedTaxa() async {
    return await TaxonomyService(ref: ref).getUsedTaxa();
  }
}

class DeleteTaxonButton extends StatelessWidget {
  const DeleteTaxonButton({super.key, required this.selectedTaxon});

  final List<int> selectedTaxon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: selectedTaxon.isEmpty
          ? null
          : () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete taxon'),
                      content: const Text(
                          'Are you sure you want to delete the selected taxon?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // await TaxonomyService().deleteTaxon(selectedTaxon);
                            // Navigator.of(context).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  });
            },
      child: Text('Delete ${_taxonCount()}',
          style: TextStyle(color: Theme.of(context).colorScheme.error)),
    );
  }

  String _taxonCount() {
    return selectedTaxon.length == 1
        ? '1 taxon'
        : '${selectedTaxon.length} taxa';
  }
}
