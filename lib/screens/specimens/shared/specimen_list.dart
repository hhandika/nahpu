import 'package:flutter/material.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';

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
  const SpecimenList({super.key, required this.data});

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
              title: Text('${data[index].fieldNumber ?? ''}',
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text('${data[index].speciesID ?? ''}'),
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
