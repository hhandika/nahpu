import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/database/taxonomy_queries.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({super.key});

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Taxon Registry',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const TaxonRegistryInfo(),
                )),
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
                        builder: (context) => const TaxonRegistryForm(),
                      ),
                    );
                  },
                  text: 'Add taxon',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaxonRegistryInfo extends ConsumerWidget {
  const TaxonRegistryInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(taxonRegistryProvider).when(
          data: (data) => data.isEmpty
              ? const Text('No taxon found')
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Taxon registered: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: '${data.length} taxa',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class TaxonRegistryForm extends ConsumerStatefulWidget {
  const TaxonRegistryForm({super.key});

  @override
  TaxonRegistryFormState createState() => TaxonRegistryFormState();
}

class TaxonRegistryFormState extends ConsumerState<TaxonRegistryForm> {
  final TaxonRegistryCtrModel _ctr = TaxonRegistryCtrModel.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxon Registry'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Class',
                            hintText: 'Select a taxon class',
                          ),
                          items: supportedTaxonClass
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            _ctr.taxonClassCtr.text = value ?? '';
                          }),
                      TextFormField(
                          controller: _ctr.taxonOrderCtr,
                          decoration: const InputDecoration(
                            labelText: 'Order',
                            hintText: 'Enter an order',
                          ),
                          onChanged: (String? value) {
                            if (value != null) {
                              _ctr.taxonOrderCtr.value = TextEditingValue(
                                text: value.toSentenceCase(),
                                selection: _ctr.taxonOrderCtr.selection,
                              );
                            }
                          }),
                      TextFormField(
                        controller: _ctr.taxonFamilyCtr,
                        decoration: const InputDecoration(
                          labelText: 'Family',
                          hintText: 'Enter a family',
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            _ctr.taxonFamilyCtr.value = TextEditingValue(
                              text: value.toSentenceCase(),
                              selection: _ctr.taxonFamilyCtr.selection,
                            );
                          }
                        },
                      ),
                      TextFormField(
                        controller: _ctr.genusCtr,
                        decoration: const InputDecoration(
                          labelText: 'Genus',
                          hintText: 'Enter a genus',
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            _ctr.genusCtr.value = TextEditingValue(
                              text: value.toSentenceCase(),
                              selection: _ctr.genusCtr.selection,
                            );
                          }
                        },
                      ),
                      TextFormField(
                        controller: _ctr.specificEpithetCtr,
                        decoration: const InputDecoration(
                          labelText: 'Specific epithet',
                          hintText: 'Enter specific epithet',
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            _ctr.specificEpithetCtr.value = TextEditingValue(
                              text: value.toLowerCase(),
                              selection: _ctr.specificEpithetCtr.selection,
                            );
                          }
                        },
                      ),
                      TextFormField(
                        controller: _ctr.commonNameCtr,
                        decoration: const InputDecoration(
                          labelText: 'Common name',
                          hintText: 'Enter a common name',
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
                            _ctr.commonNameCtr.value = TextEditingValue(
                              text: value.toSentenceCase(),
                              selection: _ctr.commonNameCtr.selection,
                            );
                          }
                        },
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
                              _saveTaxon();
                              ref.invalidate(taxonRegistryProvider);
                              Navigator.of(context).pop();
                            },
                            text: 'Add',
                          ),
                        ],
                      ),
                    ],
                  )),
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
      notes: db.Value(_ctr.noteCtr.text),
    );
    await TaxonomyQuery(ref.read(databaseProvider)).createTaxon(taxon);
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
      body: ref.watch(taxonRegistryProvider).when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text('No taxon found'),
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

class TaxonList extends ConsumerWidget {
  const TaxonList({super.key, required this.taxonList});

  final List<TaxonomyData> taxonList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: taxonList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              '${taxonList[index].genus} ${taxonList[index].specificEpithet}'),
          subtitle: Text(
            '${taxonList[index].taxonClass} '
            '${taxonList[index].taxonOrder} '
            '${taxonList[index].taxonFamily}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await TaxonomyQuery(ref.read(databaseProvider))
                  .deleteTaxon(taxonList[index].id);
              ref.invalidate(taxonRegistryProvider);
            },
          ),
          onTap: () {},
        );
      },
    );
  }
}
