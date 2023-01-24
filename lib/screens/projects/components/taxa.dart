import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/form.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/services/database.dart';
import 'package:drift/drift.dart' as db;

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({super.key});

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Taxon registry',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const TaxonRegistryInfo()),
          Wrap(
            spacing: 10,
            children: [
              SecondaryButton(
                  text: 'Show',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TaxonRegistryList(),
                      ),
                    );
                  }),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TaxonEntryForm(),
                    ),
                  );
                },
                text: 'Add taxon',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaxonRegistryInfo extends ConsumerWidget {
  const TaxonRegistryInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: const []);
  }
}

class TaxonEntryForm extends ConsumerStatefulWidget {
  const TaxonEntryForm({super.key});

  @override
  TaxonEntryFormState createState() => TaxonEntryFormState();
}

class TaxonEntryFormState extends ConsumerState<TaxonEntryForm> {
  late TaxonRegistryCtrModel _ctr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon entry'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _ctr.taxonClassCtr,
                  decoration: const InputDecoration(
                    labelText: 'Class',
                    hintText: 'Enter a class',
                  ),
                ),
                TextFormField(
                  controller: _ctr.taxonOrderCtr,
                  decoration: const InputDecoration(
                    labelText: 'Order',
                    hintText: 'Enter an order',
                  ),
                ),
                TextFormField(
                  controller: _ctr.taxonFamilyCtr,
                  decoration: const InputDecoration(
                    labelText: 'Family',
                    hintText: 'Enter a family',
                  ),
                ),
                TextFormField(
                  controller: _ctr.genusCtr,
                  decoration: const InputDecoration(
                    labelText: 'Genus',
                    hintText: 'Enter a genus',
                  ),
                ),
                TextFormField(
                  controller: _ctr.specificEpithetCtr,
                  decoration: const InputDecoration(
                    labelText: 'Specific epithet',
                    hintText: 'Enter specific epithet',
                  ),
                ),
                TextFormField(
                  controller: _ctr.commonNameCtr,
                  decoration: const InputDecoration(
                    labelText: 'Common name',
                    hintText: 'Enter a common name',
                  ),
                ),
                TextFormField(
                  controller: _ctr.noteCtr,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Enter notes',
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    SecondaryButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                    ),
                    PrimaryButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Save',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveTaxon() async {
    final taxon = TaxonomyCompanion(
      taxonClass: db.Value(_ctr.taxonClassCtr.text),
      taxonOrder: db.Value(_ctr.taxonOrderCtr.text),
      taxonFamily: db.Value(_ctr.taxonFamilyCtr.text),
      genus: db.Value(_ctr.genusCtr.text),
      specificEpithet: db.Value(_ctr.specificEpithetCtr.text),
      commonName: db.Value(_ctr.commonNameCtr.text),
      note: db.Value(_ctr.noteCtr.text),
    );
    await ref.read(databaseProvider).createTaxon(taxon);
  }
}

class TaxonRegistryList extends ConsumerStatefulWidget {
  const TaxonRegistryList({super.key});

  @override
  TaxonRegistryListState createState() => TaxonRegistryListState();
}

class TaxonRegistryListState extends ConsumerState<TaxonRegistryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon registry'),
      ),
      body: ref.watch(projectTaxonProvider).when(
            data: (taxonList) {
              return TaxonList(taxonList: taxonList);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text(error.toString()),
          ),
    );
  }
}

class TaxonList extends ConsumerWidget {
  const TaxonList({super.key, required this.taxonList});

  final List<TaxonomyData> taxonList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: taxonList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taxonList[index].taxonFamily ?? 'Unknown family'),
          subtitle: Text(
              '${taxonList[index].genus} ${taxonList[index].specificEpithet}'),
          onTap: () {},
        );
      },
    );
  }
}
