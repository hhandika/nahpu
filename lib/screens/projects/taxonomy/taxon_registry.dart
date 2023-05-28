import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/providers/taxa.dart';
import 'package:nahpu/screens/projects/taxonomy/import_taxa.dart';
import 'package:nahpu/services/types/controllers.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/providers/specimens.dart';
import 'package:nahpu/screens/shared/buttons.dart';
import 'package:nahpu/screens/shared/fields.dart';
import 'package:nahpu/screens/shared/forms.dart';
import 'package:nahpu/screens/shared/common.dart';
import 'package:nahpu/screens/shared/layout.dart';
import 'package:nahpu/screens/specimens/shared/specimen_list.dart';
import 'package:nahpu/services/database/database.dart';
import 'package:drift/drift.dart' as db;
import 'package:nahpu/services/statistics/captures.dart';
import 'package:nahpu/services/taxonomy_services.dart';
import 'package:nahpu/services/utility_services.dart';

class TaxonRegistryViewer extends ConsumerStatefulWidget {
  const TaxonRegistryViewer({
    super.key,
  });

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
              constraints: const BoxConstraints(maxWidth: 450, maxHeight: 250),
              padding: const EdgeInsets.all(10),
              child: const RegistryInfo(),
            ),
            const SizedBox(height: 25),
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

class RegistryInfo extends ConsumerWidget {
  const RegistryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(taxonRegistryProvider).when(
          data: (data) {
            return data.isEmpty
                ? const Center(
                    child: Text(
                      'No taxon found!\n'
                      'Add a new taxon to get started.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : TaxonRegistryLayout(
                    children: [
                      RegisteredTaxa(taxonData: data),
                      const RecordedTaxa(),
                    ],
                  );
          },
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CountText(
                text: '${taxonData.length} species',
              ),
              CountText(
                text: '${_countFamily(taxonData)} families',
              ),
            ],
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
          data: (data) => RecordedTaxaView(data: data),
          loading: () => const CommonProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}

class RecordedTaxaView extends ConsumerWidget {
  const RecordedTaxaView({
    super.key,
    required this.data,
  });

  final List<SpecimenData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaxonDataContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recorded',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          data.isEmpty
              ? const Text('No specimens found!')
              : const FittedBox(
                  fit: BoxFit.fill,
                  child: RecordedCounts(),
                ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SpecimenListPage(
                    data: data,
                  ),
                ),
              );
            },
            child: const Text('View all'),
          )
        ],
      ),
    );
  }
}

class RecordedCounts extends ConsumerWidget {
  const RecordedCounts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CountText(
                  text: '${snapshot.data!.specimenCount} specimens',
                ),
                CountText(
                  text: '${snapshot.data!.speciesCount.length} species',
                ),
                CountText(
                  text: '${snapshot.data!.familyCount.length} families',
                ),
              ],
            );
          } else {
            return const CommonProgressIndicator();
          }
        },
        future: _getStats(ref));
  }

  Future<CaptureRecordStats> _getStats(WidgetRef ref) async {
    CaptureRecordStats stats = CaptureRecordStats.empty();
    await stats.count(ref);
    return stats;
  }
}

class CountText extends StatelessWidget {
  const CountText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
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
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 200,
          width: 180,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: child,
        ));
  }
}

class TaxonRegistryLayout extends StatelessWidget {
  const TaxonRegistryLayout({
    super.key,
    required this.children,
  });
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool viewRow = constraints.maxWidth > 400;
      return viewRow
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
    });
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
    return ScrollableLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String?>(
              decoration: const InputDecoration(
                labelText: 'Class',
                hintText: 'Select a taxon class',
              ),
              value: widget.ctr.taxonClassCtr,
              items: supportedTaxonClass
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: CommonDropdownText(text: e),
                      ))
                  .toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    widget.ctr.taxonClassCtr = value;
                  });
                }
              }),
          TextField(
              controller: widget.ctr.taxonOrderCtr,
              decoration: const InputDecoration(
                labelText: 'Order',
                hintText: 'Enter an order',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z]+'),
                ),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  widget.ctr.taxonOrderCtr.value = TextEditingValue(
                    text: value.toSentenceCase(),
                    selection: widget.ctr.taxonOrderCtr.selection,
                  );
                }
              }),
          TextField(
            controller: widget.ctr.taxonFamilyCtr,
            decoration: const InputDecoration(
              labelText: 'Family',
              hintText: 'Enter a family',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z]+'),
              ),
            ],
            onChanged: (String? value) {
              if (value != null) {
                widget.ctr.taxonFamilyCtr.value = TextEditingValue(
                  text: value.toSentenceCase(),
                  selection: widget.ctr.taxonFamilyCtr.selection,
                );
              }
            },
          ),
          TextField(
            controller: widget.ctr.genusCtr,
            decoration: const InputDecoration(
              labelText: 'Genus',
              hintText: 'Enter a genus',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z]+'),
              ),
            ],
            onChanged: (String? value) {
              if (value != null) {
                widget.ctr.genusCtr.value = TextEditingValue(
                  text: value.toSentenceCase(),
                  selection: widget.ctr.genusCtr.selection,
                );
              }
            },
          ),
          TextField(
            controller: widget.ctr.specificEpithetCtr,
            decoration: const InputDecoration(
              labelText: 'Specific epithet',
              hintText: 'Enter specific epithet',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z]+'),
              ),
            ],
            onChanged: (String? value) {
              if (value != null) {
                widget.ctr.specificEpithetCtr.value = TextEditingValue(
                  text: value.toLowerCase(),
                  selection: widget.ctr.specificEpithetCtr.selection,
                );
              }
            },
          ),
          TextField(
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
          TextField(
            controller: widget.ctr.noteCtr,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Enter notes',
            ),
            maxLines: 3,
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
      taxonClass: db.Value(widget.ctr.taxonClassCtr),
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
      child: ScrollableLayout(
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
      ),
    );
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
            '$listTileSeparator'
            '${taxonList[index].taxonOrder}'
            '$listTileSeparator'
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
