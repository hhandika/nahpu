import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/controllers.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/catalogs.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/file_operation.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({
    super.key,
    required this.useHorizontalLayout,
  });

  final bool useHorizontalLayout;

  @override
  TaxonRegistryViewerState createState() => TaxonRegistryViewerState();
}

class TaxonRegistryViewerState extends ConsumerState<TaxonRegistryViewer> {
  @override
  Widget build(BuildContext context) {
    return FormCard(
      title: 'Taxon Registry',
      mainAxisAlignment: MainAxisAlignment.start,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxHeight: 250),
              padding: const EdgeInsets.all(10),
              child: TaxonRegistryInfo(
                useHorizontalLayout: widget.useHorizontalLayout,
              ),
            ),
            Wrap(
              spacing: 10,
              children: [
                SecondaryButton(
                    text: 'Import',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TaxonImportForm(),
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
  const TaxonRegistryInfo({super.key, required this.useHorizontalLayout});

  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(taxonRegistryProvider).when(
          data: (data) => data.isEmpty
              ? const Text('No taxon found')
              : TaxonInfoContainer(
                  taxonData: data,
                  useHorizontalLayout: useHorizontalLayout,
                ),
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class TaxonInfoContainer extends StatelessWidget {
  const TaxonInfoContainer({
    super.key,
    required this.taxonData,
    required this.useHorizontalLayout,
  });

  final bool useHorizontalLayout;
  final List<TaxonomyData> taxonData;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: useHorizontalLayout ? 2 : 1,
          children: [
            RegisteredTaxa(taxonData: taxonData),
            const RecordedTaxa(),
          ],
        ));
  }
}

class RegisteredTaxa extends StatelessWidget {
  const RegisteredTaxa({
    super.key,
    required this.taxonData,
  });

  final List<TaxonomyData> taxonData;

  @override
  Widget build(BuildContext context) {
    return TaxonDataContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Registered",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
              '${_countFamily(taxonData)} families\n'
              '${taxonData.length} taxa',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TaxonRegistryPage(),
                ),
              );
            },
            child: const Text('View all'),
          )
        ],
      ),
    );
  }

  int _countFamily(List<TaxonomyData> data) {
    return data.fold(<String, int>{}, (Map<String, int> map, e) {
      if (e.taxonFamily != null) {
        map[e.taxonFamily!] = (map[e.taxonFamily!] ?? 0) + 1;
      }
      return map;
    }).length;
  }
}

class RecordedTaxa extends ConsumerWidget {
  const RecordedTaxa({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(specimenEntryProvider).when(
          data: (data) => data.isEmpty
              ? const Text('No taxon found')
              : RegisteredTaxaView(data: data),
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class RecordedTaxaPage extends StatefulWidget {
  const RecordedTaxaPage({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  State<RecordedTaxaPage> createState() => _RecordedTaxaPageState();
}

class _RecordedTaxaPageState extends State<RecordedTaxaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorded Taxa'),
      ),
      body: SafeArea(
          child: Center(
        child: RecordedTaxaList(data: widget.data),
      )),
    );
  }
}

class RecordedTaxaList extends StatelessWidget {
  const RecordedTaxaList({super.key, required this.data});

  final List<SpecimenData> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${data[index].fieldNumber ?? ''}',
              style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text('${data[index].speciesID ?? ''}'),
          onTap: () {},
        );
      },
    );
  }
}

class RegisteredTaxaView extends StatelessWidget {
  const RegisteredTaxaView({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  Widget build(BuildContext context) {
    return TaxonDataContainer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recorded',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '${data.length} specimens',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RecordedTaxaPage(
                  data: data,
                ),
              ),
            );
          },
          child: const Text('View all'),
        )
      ],
    ));
  }
}

class TaxonDataContainer extends StatelessWidget {
  const TaxonDataContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: child,
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

class TaxonImportForm extends StatefulWidget {
  const TaxonImportForm({super.key});

  @override
  State<TaxonImportForm> createState() => _TaxonImportFormState();
}

class _TaxonImportFormState extends State<TaxonImportForm> {
  TaxonImportFmt _fmt = TaxonImportFmt.csv;
  String _dirPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Taxon'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ScreenLayout(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Input Format',
                  ),
                  value: _fmt,
                  items: taxonImportFmtList
                      .map((e) => DropdownMenuItem(
                            value: TaxonImportFmt
                                .values[taxonImportFmtList.indexOf(e)],
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _fmt = value;
                      });
                    }
                  },
                ),
                SelectDirField(
                    dirPath: _dirPath,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _dirPath = value;
                        });
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                FormButton(
                  isEditing: false,
                  onSubmitted: () {},
                ),
              ],
            ),
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
    return ScreenLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Class',
                hintText: 'Select a taxon class',
              ),
              value: widget.ctr.taxonClassCtr.text,
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
              await TaxonomyService(ref).deleteTaxon(widget.taxonId!);
              ref.invalidate(taxonRegistryProvider);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            onSubmitted: () async {
              widget.isEditing ? await _updateTaxon() : await _createTaxon();
              ref.invalidate(taxonRegistryProvider);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _createTaxon() async {
    final taxon = _getForm();
    await TaxonomyService(ref).createTaxon(taxon);
  }

  Future<void> _updateTaxon() async {
    final taxon = _getForm();
    await TaxonomyService(ref).updateTaxonEntry(widget.taxonId!, taxon);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 480,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Enter a search term',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
            onChanged: (String value) {
              String searchValue = value.toLowerCase();
              setState(() {
                _filteredTaxonList = widget.taxonList
                    .where((taxon) =>
                        _getSpecies(taxon).contains(searchValue) ||
                        _getFamily(taxon).contains(searchValue) ||
                        _getOrder(taxon).contains(searchValue))
                    .toList();
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: TaxonListView(
                taxonList: _filteredTaxonList.isNotEmpty
                    ? _filteredTaxonList
                    : widget.taxonList,
              ))
        ],
      ),
    )));
  }

  String _getSpecies(TaxonomyData taxon) {
    return '${taxon.genus ?? ''} ${taxon.specificEpithet ?? ''}'.toLowerCase();
  }

  String _getFamily(TaxonomyData taxon) {
    return (taxon.taxonFamily ?? '').toLowerCase();
  }

  String _getOrder(TaxonomyData taxon) {
    return (taxon.taxonOrder ?? '').toLowerCase();
  }
}

class TaxonListView extends StatelessWidget {
  const TaxonListView({
    super.key,
    required this.taxonList,
  });

  final List<TaxonomyData> taxonList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taxonList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
              '${taxonList[index].genus} ${taxonList[index].specificEpithet}'),
          subtitle: Text(
            '${taxonList[index].taxonClass}'
            '$listSubtitleSeparator'
            '${taxonList[index].taxonOrder}'
            '$listSubtitleSeparator'
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
