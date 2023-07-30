import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/shared/features.dart';
import 'package:nahpu/screens/specimens/specimen_form.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/specimens.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

class SpecimenListPage extends ConsumerStatefulWidget {
  const SpecimenListPage({
    super.key,
  });

  @override
  SpecimenListPageState createState() => SpecimenListPageState();
}

class SpecimenListPageState extends ConsumerState<SpecimenListPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedValue = 0;
  bool _isSearching = false;
  bool _isSearchOptionVisible = false;
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
    final specimenEntry = ref.watch(specimenEntryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen Records'),
      ),
      body: SafeArea(
          child: ScrollableConstrainedLayout(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonSearchBar(
              controller: _searchController,
              focusNode: _focus,
              hintText: 'Search specimens',
              trailing: [
                _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            ref.invalidate(specimenEntryProvider);
                          });
                        },
                        icon: const Icon(Icons.clear_rounded))
                    : const SizedBox.shrink(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearchOptionVisible = !_isSearchOptionVisible;
                      });
                    },
                    icon: const Icon(Icons.tune_rounded)),
              ],
              onChanged: (String value) async {
                setState(() {
                  _isSearching = true;
                });
                ref
                    .read(specimenEntryProvider.notifier)
                    .search(value, SpecimenSearchOption.values[_selectedValue]);
              },
            ),
            const SizedBox(height: 4),
            Visibility(
                visible: _isSearchOptionVisible,
                child: SpecimenSearchChips(
                  selectedValue: _selectedValue,
                  onSelected: (int index) {
                    setState(() {
                      _selectedValue = index;
                    });
                  },
                )),
            const SizedBox(height: 8),
            specimenEntry.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Text('No specimens found');
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !_isSearching
                            ? const SizedBox.shrink()
                            : Text(
                                'Specimen found: ${data.length}',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                        SpecimenList(
                          data: data,
                          additionalHeight: _isSearchOptionVisible ? 0 : 86,
                        ),
                      ],
                    );
                  }
                },
                error: (error, stackTrace) {
                  return Text('Error: $error');
                },
                loading: () => const CommonProgressIndicator()),
          ],
        ),
      )),
    );
  }
}

class SpecimenList extends StatelessWidget {
  const SpecimenList({
    super.key,
    required this.data,
    required this.additionalHeight,
  });

  final List<SpecimenData> data;
  final int additionalHeight;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.7 + additionalHeight,
        ),
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
