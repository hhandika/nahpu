import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

const List<String> specimenSearchOptions = [
  'Field number',
  'Cataloger',
  'Preparator',
  'Collector',
  'Condition',
  'Taxon',
];

class SpecimenListPage extends ConsumerStatefulWidget {
  const SpecimenListPage({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  SpecimenListPageState createState() => SpecimenListPageState();
}

class SpecimenListPageState extends ConsumerState<SpecimenListPage> {
  List<SpecimenData> _filteredData = [];
  final TextEditingController _searchController = TextEditingController();
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen Records'),
      ),
      body: SafeArea(
          child: Center(
        child: ScrollableConstrainedLayout(
            child: Column(
          children: [
            CommonSearchBar(
              controller: _searchController,
              hintText: 'Search specimens',
              trailing: [
                _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _filteredData.clear();
                          });
                        },
                        icon: const Icon(Icons.clear))
                    : const SizedBox.shrink()
              ],
              onChanged: (String value) async {
                await _filterResults(value);
                setState(() {});
              },
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              alignment: WrapAlignment.center,
              children: List.generate(specimenSearchOptions.length, (index) {
                return SearchType(
                  index: index,
                  selectedValue: _selectedValue,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        _selectedValue = index;
                        _searchController.clear();
                        _filteredData = [];
                      });
                    }
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            _filteredData.isEmpty || widget.data.length == _filteredData.length
                ? const SizedBox.shrink()
                : Text('Results: ${_filteredData.length}'),
            SpecimenList(
              data: _filteredData.isEmpty ? widget.data : _filteredData,
            ),
          ],
        )),
      )),
    );
  }

  Future<void> _filterResults(String query) async {
    switch (_selectedValue) {
      case 0:
        _filterByFieldNumber(query);
        break;
      case 1:
        await _filterByCataloger(query);
        break;
      case 2:
        await _filterByPreparator(query);
        break;
      case 3:
        await _filterByCollector(query);
        break;
      case 4:
        _filterByCondition(query);
        break;
      case 5:
        await _filterByTaxon(query);
        break;
    }
  }

  void _filterByFieldNumber(String query) {
    _filteredData = widget.data
        .where((element) => element.fieldNumber
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  Future<void> _filterByTaxon(String query) async {
    List<SpecimenData> filteredData = [];
    List<int> taxonIDs = await TaxonomyServices(ref: ref).searchTaxa(query);
    for (int taxonID in taxonIDs) {
      filteredData.addAll(widget.data
          .where((element) => element.speciesID == taxonID)
          .toList());
    }
    _filteredData = filteredData;
  }

  Future<void> _filterByCataloger(String query) async {
    List<SpecimenData> filteredData = [];
    List<String> catalogerIDs = await _searchPersonnel(query);
    for (String catalogerID in catalogerIDs) {
      filteredData.addAll(widget.data
          .where(
              (element) => element.catalogerID.toString().contains(catalogerID))
          .toList());
    }
    _filteredData = filteredData;
  }

  Future<void> _filterByPreparator(String query) async {
    List<SpecimenData> filteredData = [];
    List<String> preparatorIDs = await _searchPersonnel(query);
    for (String preparatorID in preparatorIDs) {
      filteredData.addAll(widget.data
          .where((element) =>
              element.preparatorID.toString().contains(preparatorID))
          .toList());
    }
    _filteredData = filteredData;
  }

  Future<void> _filterByCollector(String query) async {
    List<SpecimenData> filteredData = [];
    List<int> collectorIDs =
        await CollEvenPersonnelServices(ref: ref).searchPersonnel(query);
    for (int collectorID in collectorIDs) {
      filteredData.addAll(widget.data
          .where((element) => element.collPersonnelID == collectorID)
          .toList());
    }
    _filteredData = filteredData;
  }

  Future<void> _filterByCondition(String query) async {
    _filteredData = widget.data
        .where((element) => element.condition != null)
        .where((element) =>
            element.condition!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<String>> _searchPersonnel(String search) async {
    return await PersonnelServices(ref: ref).searchPersonnel(search);
  }
}

class SearchType extends StatefulWidget {
  const SearchType({
    super.key,
    required this.index,
    required this.selectedValue,
    required this.onSelected,
  });

  final int index;
  final int selectedValue;
  final void Function(bool) onSelected;

  @override
  State<SearchType> createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        child: CommonChip(
          index: widget.index,
          label: Text(specimenSearchOptions[widget.index]),
          selectedValue: widget.selectedValue,
          onSelected: widget.onSelected,
        ));
  }
}

class SpecimenList extends StatelessWidget {
  const SpecimenList({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 370),
        child: CommonScrollbar(
          scrollController: scrollController,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(_getLeadingIcon(data[index].taxonGroup)),
                title: SpecimenListTitle(
                    catalogerID: data[index].catalogerID,
                    fieldNumber: data[index].fieldNumber),
                subtitle: SpecimenListSubtitle(
                  data: data[index],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SpecimenPageView(data: data[index])),
                  );
                },
              );
            },
          ),
        ));
  }

  IconData _getLeadingIcon(String? taxonGroup) {
    CatalogFmt fmt = matchTaxonGroupToCatFmt(taxonGroup);
    return matchCatFmtToIcon(fmt, false);
  }
}

class SpecimenPageView extends StatefulWidget {
  const SpecimenPageView({super.key, required this.data});

  final SpecimenData data;

  @override
  State<SpecimenPageView> createState() => _SpecimenPageViewState();
}

class _SpecimenPageViewState extends State<SpecimenPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen Record'),
      ),
      body: SafeArea(
          child: Center(
              child: SpecimenForm(
        specimenUuid: widget.data.uuid,
        catalogFmt: matchTaxonGroupToCatFmt(widget.data.taxonGroup),
        specimenCtr: _updateController(widget.data),
      ))),
    );
  }

  SpecimenFormCtrModel _updateController(SpecimenData specimenData) {
    return SpecimenFormCtrModel.fromData(specimenData);
  }
}

class SpecimenListTitle extends ConsumerWidget {
  const SpecimenListTitle({
    super.key,
    required this.catalogerID,
    required this.fieldNumber,
  });

  final String? catalogerID;
  final int? fieldNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            '${snapshot.data} ${fieldNumber ?? ''}',
            style: Theme.of(context).textTheme.titleMedium,
          );
        } else {
          return const CommonProgressIndicator();
        }
      },
      future: _getPersonnelName(catalogerID, ref),
    );
  }

  Future<String> _getPersonnelName(String? catalogerID, WidgetRef ref) async {
    if (catalogerID != null) {
      PersonnelData data =
          await PersonnelServices(ref: ref).getPersonnelByUuid(catalogerID);
      return data.name ?? '';
    } else {
      return '';
    }
  }
}

class SpecimenListSubtitle extends ConsumerWidget {
  const SpecimenListSubtitle({
    super.key,
    required this.data,
  });

  final SpecimenData? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          );
        } else {
          return const Text('Loading...');
        }
      },
      future: _getTaxonData(data?.speciesID, ref),
    );
  }

  Future<String> _getTaxonData(int? taxonId, WidgetRef ref) async {
    if (taxonId != null) {
      TaxonomyData data =
          await TaxonomyServices(ref: ref).getTaxonById(taxonId);
      return _createTaxonInfo(data);
    } else {
      return '';
    }
  }

  String _createTaxonInfo(TaxonomyData data) {
    String order =
        data.taxonOrder != null ? '${data.taxonOrder}$listTileSeparator' : '';
    String family =
        data.taxonFamily != null ? '${data.taxonFamily}$listTileSeparator' : '';
    String species = '${data.genus ?? ''} ${data.specificEpithet ?? ''}';

    return '$order$family$species';
  }
}
