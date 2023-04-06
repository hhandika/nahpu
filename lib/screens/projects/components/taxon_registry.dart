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
import 'package:nahpu/services/taxonomy_services.dart';

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
                        builder: (context) => const NewTaxon(),
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

class NewTaxon extends StatelessWidget {
  const NewTaxon({super.key});

  @override
  Widget build(BuildContext context) {
    final TaxonRegistryCtrModel ctr = TaxonRegistryCtrModel.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Taxon'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: TaxonRegistryForm(
            taxonId: null,
            ctr: ctr,
            isEditing: false,
          ),
        ),
      ),
    );
  }
}

class EditTaxon extends StatelessWidget {
  const EditTaxon({
    super.key,
    required this.taxonId,
    required this.ctr,
  });

  final int taxonId;
  final TaxonRegistryCtrModel ctr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Taxon'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: TaxonRegistryForm(
            taxonId: taxonId,
            ctr: ctr,
            isEditing: true,
          ),
        ),
      ),
    );
  }
}

class TaxonRegistryForm extends ConsumerStatefulWidget {
  const TaxonRegistryForm(
      {super.key,
      required this.taxonId,
      required this.ctr,
      required this.isEditing});

  final int? taxonId;
  final TaxonRegistryCtrModel ctr;
  final bool isEditing;

  @override
  TaxonRegistryFormState createState() => TaxonRegistryFormState();
}

class TaxonRegistryFormState extends ConsumerState<TaxonRegistryForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    widget.ctr.taxonClassCtr.text = value ?? '';
                  }),
              TextFormField(
                  controller: widget.ctr.taxonOrderCtr,
                  decoration: const InputDecoration(
                    labelText: 'Order',
                    hintText: 'Enter an order',
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      widget.ctr.taxonOrderCtr.value = TextEditingValue(
                        text: value.toSentenceCase(),
                        selection: widget.ctr.taxonOrderCtr.selection,
                      );
                    }
                  }),
              TextFormField(
                controller: widget.ctr.taxonFamilyCtr,
                decoration: const InputDecoration(
                  labelText: 'Family',
                  hintText: 'Enter a family',
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    widget.ctr.taxonFamilyCtr.value = TextEditingValue(
                      text: value.toSentenceCase(),
                      selection: widget.ctr.taxonFamilyCtr.selection,
                    );
                  }
                },
              ),
              TextFormField(
                controller: widget.ctr.genusCtr,
                decoration: const InputDecoration(
                  labelText: 'Genus',
                  hintText: 'Enter a genus',
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    widget.ctr.genusCtr.value = TextEditingValue(
                      text: value.toSentenceCase(),
                      selection: widget.ctr.genusCtr.selection,
                    );
                  }
                },
              ),
              TextFormField(
                controller: widget.ctr.specificEpithetCtr,
                decoration: const InputDecoration(
                  labelText: 'Specific epithet',
                  hintText: 'Enter specific epithet',
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    widget.ctr.specificEpithetCtr.value = TextEditingValue(
                      text: value.toLowerCase(),
                      selection: widget.ctr.specificEpithetCtr.selection,
                    );
                  }
                },
              ),
              TextFormField(
                controller: widget.ctr.commonNameCtr,
                decoration: const InputDecoration(
                  labelText: 'Common name',
                  hintText: 'Enter a common name',
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    widget.ctr.commonNameCtr.value = TextEditingValue(
                      text: value.toSentenceCase(),
                      selection: widget.ctr.commonNameCtr.selection,
                    );
                  }
                },
              ),
              TextFormField(
                controller: widget.ctr.noteCtr,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter notes',
                ),
              ),
              const SizedBox(height: 20),
              FormButtonWithDelete(
                isEditing: widget.isEditing,
                onDeleted: () async {
                  await TaxonomyQuery(ref.read(databaseProvider))
                      .deleteTaxon(widget.taxonId!);
                  ref.invalidate(taxonRegistryProvider);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                onSubmitted: () async {
                  widget.isEditing
                      ? await _updateTaxon()
                      : await _createTaxon();
                  ref.invalidate(taxonRegistryProvider);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createTaxon() async {
    final taxon = _getForm();
    await TaxonomyService(ref).createTaxon(taxon);
  }

  Future<void> _updateTaxon() async {
    final taxon = _getForm();
    await TaxonomyQuery(ref.read(databaseProvider))
        .updateTaxonEntry(widget.taxonId!, taxon);
  }

  TaxonomyCompanion _getForm() {
    return TaxonomyCompanion(
      taxonClass: db.Value(widget.ctr.taxonClassCtr.text),
      taxonOrder: db.Value(widget.ctr.taxonOrderCtr.text),
      taxonFamily: db.Value(widget.ctr.taxonFamilyCtr.text),
      genus: db.Value(widget.ctr.genusCtr.text),
      specificEpithet: db.Value(widget.ctr.specificEpithetCtr.text),
      commonName: db.Value(widget.ctr.commonNameCtr.text),
      notes: db.Value(widget.ctr.noteCtr.text),
    );
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
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTaxon(
                    taxonId: taxonList[index].id,
                    ctr: TaxonRegistryCtrModel.fromData(taxonList[index]),
                  ),
                ),
              );
            },
          ),
          onTap: () {},
        );
      },
    );
  }
}
