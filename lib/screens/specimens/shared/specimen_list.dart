import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:nahpu/services/personnel_services.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

class SpecimenListPage extends StatefulWidget {
  const SpecimenListPage({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  State<SpecimenListPage> createState() => _SpecimenListPageState();
}

class _SpecimenListPageState extends State<SpecimenListPage> {
  List<SpecimenData> _filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specimen List'),
      ),
      body: SafeArea(
          child: Center(
        child: ScreenLayout(
            child: Column(
          children: [
            SearchButtonField(onChanged: (String value) {
              setState(() {
                _filteredData = widget.data
                    .where((element) => element.fieldNumber
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            }),
            SpecimenList(
              data: _filteredData.isEmpty ? widget.data : _filteredData,
            ),
          ],
        )),
      )),
    );
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
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
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
              onTap: () {},
            );
          },
        ));
  }

  IconData _getLeadingIcon(String? taxonGroup) {
    CatalogFmt fmt = matchTaxonGroupToCatFmt(taxonGroup);
    return matchCatFmtToIcon(fmt, false);
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
          return const Text('Loading...');
        }
      },
      future: _getPersonnelName(catalogerID, ref),
    );
  }

  Future<String> _getPersonnelName(String? catalogerID, WidgetRef ref) async {
    if (catalogerID != null) {
      PersonnelData data =
          await PersonnelServices(ref).getPersonnelByUuid(catalogerID);
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
      TaxonomyData data = await TaxonomyService(ref).getTaxonById(taxonId);
      return _createTaxonInfo(data);
    } else {
      return '';
    }
  }

  String _createTaxonInfo(TaxonomyData data) {
    String order =
        data.taxonOrder != null ? '${data.taxonOrder}$listSeparator' : '';
    String family =
        data.taxonFamily != null ? '${data.taxonFamily}$listSeparator' : '';
    String species = '${data.genus ?? ''} ${data.specificEpithet ?? ''}';

    return '$order$family$species';
  }
}
